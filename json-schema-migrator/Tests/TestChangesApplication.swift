import Testing
@testable import JsonSchemaMigratorKit

@Test
func testPropertyRemoval() {
    var originalJson = JsonValue.object(["firstProperty": .integer(123)])

    let change = Change(path: [], kind: .deletedProperty("firstProperty"))
    apply(change, to: &originalJson)

    #expect(originalJson["firstProperty"] == nil)
}
