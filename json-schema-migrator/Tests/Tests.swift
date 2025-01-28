//
//  Tests.swift
//  json-schema-migrator
//
//  Created by Mike S. on 28/01/2025.
//

import Testing
import XCTest
@testable import JsonSchemaMigratorKit


@Test
func testAddedProperty() {
    let oldSchema = JsonSchema(properties: [
        "existingProperty": .init(type: .string)
    ])

    let newSchema = JsonSchema(properties: [
        "existingProperty": .init(type: .string),
        "newProperty": .init(type: .integer)
    ])

    let changes = compareProperties(oldSchema.properties, newSchema.properties, path: [])

    let expectedChanges = [Change(path: [], kind: .addedProperty("newProperty", .init(type: .integer)))]

    #expect(changes == expectedChanges)
}

@Test
func testDeletingProperty() {
    let oldSchema = JsonSchema(properties: [
        "existingProperty": .init(type: .string)
    ])

    let newSchema = JsonSchema(properties: [:])

    let changes = compareProperties(oldSchema.properties, newSchema.properties, path: [])

    let expectedChanges = [Change(path: [], kind: .deletedProperty("existingProperty"))]

    #expect(changes == expectedChanges)
}

@Test
func testAddingPropertyToChild() {
    let oldSchema = JsonSchema(properties: [
        "existingProperty": .init(type: .string),
        "existingChild": .init(type: .object, properties: [:])
    ])

    let newSchema = JsonSchema(properties: [
        "existingProperty": .init(type: .string),
        "existingChild": .init(type: .object, properties: [
            "newChildProperty": .init(type: .string)
        ])
    ])

    let changes = compareProperties(oldSchema.properties, newSchema.properties, path: [])

    let expectedChanges = [Change(path: ["existingChild"], kind: .addedProperty("newChildProperty", .init(type: .string)))]

    #expect(changes == expectedChanges)
}

@Test
func testChanginFromADictionaryToAnArray() {
    let oldSchema = JsonSchema(properties: [
        "existingDict": .init(type: .object, properties: ["title": .init(type: .string)])
    ])

    let newSchema = JsonSchema(properties: [
        "existingDict": .init(
            type: .array,
            item: .init(
                type: .object,
                properties: [
                    "title": .init(type: .string)]))
    ])

    let changes = compareProperties(oldSchema.properties, newSchema.properties, path: [])

    let expectedChanges = [Change(path: ["existingChild"], kind: .addedProperty("newChildProperty", .init(type: .string)))]

    #expect(changes == expectedChanges)
}
