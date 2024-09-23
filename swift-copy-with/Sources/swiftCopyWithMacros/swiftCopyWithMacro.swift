import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "(\(argument), \(literal: argument.description))"
    }
}

public struct CopyWithMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        return [
            DeclSyntax(
                FunctionDeclSyntax(
                    name: "copyWith",
                    signature: FunctionSignatureSyntax(
                        parameterClause: FunctionParameterClauseSyntax(
                            parameters: FunctionParameterListSyntax([
                                FunctionParameterSyntax(
                                    firstName: "name",
                                    type: OptionalTypeSyntax(
                                        wrappedType: IdentifierTypeSyntax(
                                            name: "String"
                                        )
                                    ),
                                    defaultValue: InitializerClauseSyntax(value: NilLiteralExprSyntax()),
                                    trailingComma: .commaToken()
                                ),
                                FunctionParameterSyntax(
                                    firstName: "gender",
                                    type: OptionalTypeSyntax(
                                        wrappedType: IdentifierTypeSyntax(
                                            name: "Gender"
                                        )
                                    ),
                                    defaultValue: InitializerClauseSyntax(value: NilLiteralExprSyntax())
                                )
                            ])
                        ),
                        returnClause: ReturnClauseSyntax(type: IdentifierTypeSyntax(name: "Animal"))
                    ),

                    body: CodeBlockSyntax  {
                        FunctionCallExprSyntax(
                            calledExpression: DeclReferenceExprSyntax(baseName: "Animal"),
                            leftParen: .leftParenToken(),
                            arguments: LabeledExprListSyntax {
                                LabeledExprSyntax(label: "name", expression: SequenceExprSyntax {
                                    DeclReferenceExprSyntax(baseName: "name")
                                    BinaryOperatorExprSyntax(operator: "??")
                                    MemberAccessExprSyntax(
                                        base: DeclReferenceExprSyntax(
                                            baseName: .keyword(SwiftSyntax.Keyword.`self`)
                                        ),
                                        period: .periodToken(),
                                        declName: DeclReferenceExprSyntax(
                                            baseName: .identifier("name")
                                        )
                                    )
                                })
                                LabeledExprSyntax(label: "gender", expression: SequenceExprSyntax {
                                    DeclReferenceExprSyntax(baseName: "gender")
                                    BinaryOperatorExprSyntax(operator: "??")
                                    MemberAccessExprSyntax(
                                        base: DeclReferenceExprSyntax(
                                            baseName: .keyword(SwiftSyntax.Keyword.`self`)
                                        ),
                                        period: .periodToken(),
                                        declName: DeclReferenceExprSyntax(
                                            baseName: .identifier("gender")
                                        )
                                    )
                                })
                            },
                            rightParen: .rightParenToken()
                        )
                    }
                )
            )
        ]
    }
}

@main
struct swift_copy_withPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CopyWithMacro.self,
    ]
}
