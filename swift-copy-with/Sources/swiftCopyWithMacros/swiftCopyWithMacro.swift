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

    private static func getProperties(of declaration: some DeclGroupSyntax) -> [VariableDeclSyntax] {
        declaration
            .memberBlock
            .members
            .compactMap { $0.decl.as(VariableDeclSyntax.self) }
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let lastThing = getProperties(of: declaration).last!
        return [
            DeclSyntax(
                FunctionDeclSyntax(
                    name: "copyWith",
                    signature: FunctionSignatureSyntax(
                        parameterClause: FunctionParameterClauseSyntax(
                            parameters: FunctionParameterListSyntax(
                                getProperties(of: declaration)
                                    .dropLast()
                                    .map { variable in
                                        FunctionParameterSyntax(
                                            firstName: variable.bindings.first!.pattern.as(IdentifierPatternSyntax.self)!.identifier,
                                            type: OptionalTypeSyntax(
                                                wrappedType: variable.bindings.first!.typeAnnotation!.type
                                            ),
                                            defaultValue: InitializerClauseSyntax(value: NilLiteralExprSyntax()),
                                            trailingComma: .commaToken()
                                        )
                                    }
                                + [

                                    FunctionParameterSyntax(
                                        firstName: lastThing.bindings.first!.pattern.as(IdentifierPatternSyntax.self)!.identifier,
                                        type: OptionalTypeSyntax(
                                            wrappedType: lastThing.bindings.first!.typeAnnotation!.type
                                        ),
                                        defaultValue: InitializerClauseSyntax(value: NilLiteralExprSyntax())
                                    )
                                ]
                            )
                        ),
                        returnClause: ReturnClauseSyntax(type: IdentifierTypeSyntax(name: "Animal"))
                    ),
                    body: CodeBlockSyntax  {
                        FunctionCallExprSyntax(
                            calledExpression: DeclReferenceExprSyntax(baseName: "Animal"),
                            leftParen: .leftParenToken(),
                            arguments: LabeledExprListSyntax {
                                getProperties(of: declaration)
                                    .map { variable in
                                        LabeledExprSyntax(label: variable.bindings.first!.pattern.as(IdentifierPatternSyntax.self)!.identifier,
                                                          colon: .colonToken(),
                                                          expression: SequenceExprSyntax {
                                            DeclReferenceExprSyntax(baseName: variable.bindings.first!.pattern.as(IdentifierPatternSyntax.self)!.identifier)
                                            BinaryOperatorExprSyntax(operator: "??")
                                            MemberAccessExprSyntax(
                                                base: DeclReferenceExprSyntax(
                                                    baseName: .keyword(SwiftSyntax.Keyword.`self`)
                                                ),
                                                period: .periodToken(),
                                                declName: DeclReferenceExprSyntax(
                                                    baseName: variable.bindings.first!.pattern.as(IdentifierPatternSyntax.self)!.identifier
                                                )
                                            )
                                        })
                                    }
                            },
                            rightParen: .rightParenToken()
                        )
                    }
                )
            )
        ]
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
