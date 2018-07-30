import XCTest
@testable import ExtraEncodable
#if canImport(BSON)
import BSON
#endif

final class ExtraEncodableTests: XCTestCase {
    
    struct Foo: Codable, Equatable {
        var string: String? = "Hoi"
        var int: Int? = 4
        var array: [String]? = ["a", "b", "c"]
        
        init() {}
    }
    
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    #if canImport(BSON)
    let bsonEncoder = BSONEncoder()
    let bsonDecoder = BSONDecoder()
    #endif
    
    func expect<A: Encodable, B: Decodable & Equatable>(_ value: A, toDecodeAs expected: B, file: StaticString = #file, line: UInt = #line) {
        // Test with JSON Encoder
        do {
            let encodedJSON = try jsonEncoder.encode(value)
            let decodedFromJSON = try jsonDecoder.decode(B.self, from: encodedJSON)
            XCTAssertEqual(decodedFromJSON, expected, "Decode from JSON did not give the expected result", file: file, line: line)
        } catch {
            XCTFail("Error while trying to decode from JSON: \(error)", file: file, line: line)
        }
        
        #if canImport(BSON)
        // Test with BSON Encoder
        do {
            let encodedBSON = try bsonEncoder.encode(value)
            let decodedFromBSON = try bsonDecoder.decode(B.self, from: encodedBSON)
            XCTAssertEqual(decodedFromBSON, expected, "Decode from BSON did not give the expected result", file: file, line: line)
        } catch {
            XCTFail("Error while trying to decode from BSON: \(error)", file: file, line: line)
        }
        #endif
    }
    
    func testFieldHiding() {
        let foo = Foo()
        let helper = ExtraEncodable(base: foo, hiddenFields: ["int"])
        var expected = foo
        expected.int = nil
        
        expect(helper, toDecodeAs: expected)
    }
    
    func testFieldAdding() {
        let foo = Foo()
        let helper = ExtraEncodable(base: foo, extraData: ["extra": "hello"])
    }
    
    func testFieldAddingAndHiding() {
        let foo = Foo()
        let helper = ExtraEncodable(base: foo, extraData: ["extra": "hello", "extraHidden": "bar"], hiddenFields: ["int", "array", "extraHidden"])
        let expected: [String:String] = ["string": "Hoi", "extra": "hello"]
        
        expect(helper, toDecodeAs: expected)
    }
    
    func testNestedFieldHiding() {
        let fooArray = [Foo(), Foo(), Foo()]
        let helper = ExtraEncodable(base: fooArray, hiddenFields: ["int", "array"])
        let expected: [[String:String]] = [["string": "Hoi"], ["string": "Hoi"], ["string": "Hoi"]]
        
        expect(helper, toDecodeAs: expected)
    }
    
}
