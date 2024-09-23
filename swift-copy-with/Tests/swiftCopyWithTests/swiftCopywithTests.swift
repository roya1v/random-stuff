import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(swiftCopyWithMacros)
import swiftCopyWithMacros

let testMacros: [String: Macro.Type] = [
    "CopyWith": CopyWithMacro.self,
]
#endif

final class swift_copy_withTests: XCTestCase {
    func testMacro() throws {
#if canImport(swiftCopyWithMacros)
        assertMacroExpansion(
            """
            enum Gender {
                case male, female, other
            }

            @CopyWith()
            struct Animal {
                let name: String
                let gender: Gender
            }
            """,
            expandedSource: """
            enum Gender {
                case male, female, other
            }
            @CopyWith()
            struct Animal {
                let name: String
                let gender: Gender

                func copyWith(name: String? = nil, gender: Gender? = nil) -> Animal {
                    Animal(name: name ?? self.name, gender: gender ?? self.gender)
                }
            }
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
