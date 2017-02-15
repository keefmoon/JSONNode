//
//  JSONNodeTests.swift
//  JSONNodeTests
//
//  Created by Keith Moon on 09/11/2016.
//  Copyright © 2016 Keith Moon. All rights reserved.
//

import XCTest
@testable import JSONNode

class JSONNodeTests: XCTestCase {
    
    var rootJSON: JSONNode!
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: JSONNodeTests.self)
        let dataURL = bundle.url(forResource: "Test", withExtension: "json")!
        let jsonData = try! Data(contentsOf: dataURL)
        rootJSON = try! JSONNode(data: jsonData)
    }
    
    override func tearDown() {
        rootJSON = nil
        super.tearDown()
    }
    
    func testCanReadString() {
        
        let node = rootJSON["string"]
        
        guard let string = node.string else {
            XCTFail()
            return
        }
        XCTAssertEqual(string, "This is a string")
    }
    
    func testCanReadInteger() {
        
        let node = rootJSON["int"]
        
        guard let int = node.integer else {
            XCTFail()
            return
        }
        XCTAssertEqual(int, 5)
    }
    
    func testCanReadFloatingPoint() {
        
        let node = rootJSON["floatingPoint"]
        
        guard let floatingPoint = node.floatingPoint else {
            XCTFail()
            return
        }
        XCTAssertEqual(floatingPoint, 3.14)
    }
    
    func testCanReadBool() {
        
        let node = rootJSON["bool"]
        
        guard let bool = node.boolean else {
            XCTFail()
            return
        }
        XCTAssertEqual(bool, true)
    }
    
    func testCanReadArray() {
        
        let node = rootJSON["array"]
        
        guard let array = node.array else {
            XCTFail()
            return
        }
        
        let expected: [JSONNode] = [.string("arrayValue1"), .string("arrayValue2"), .string("arrayValue3")]
        XCTAssertEqual(array, expected)
    }
    
    func testCanReadDictionary() {
        
        let node = rootJSON["dictionary"]
        
        guard let dictionary = node.dictionary else {
            XCTFail()
            return
        }
        
        let expected: [String: JSONNode] = ["key1": .string("value1"), "key2": .string("value2"), "key3": .string("value3")]
        XCTAssertEqual(dictionary, expected)
    }
    
    // Test Int types
    
    func testCanReadInt() {
        
        let someJSON = ["int": NSNumber(value: Int(12345))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 12345)
    }
    
    func testCanReadUInt() {
        
        let someJSON = ["int": NSNumber(value: UInt(12345))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 12345)
    }
    
    func testCanReadInt8() {
        
        let someJSON = ["int": NSNumber(value: Int8(2))]
        let node = JSONNode(JSON: someJSON)
        
        // https://twitter.com/keefmoon/status/831900139837124608
        
        // 32-bit behaviour
        if let intValue = node["int"].integer {
            XCTAssertEqual(intValue, 2)
            return
        }
        // 64-bit behaviour
        else if let boolValue = node["int"].boolean {
            XCTAssertTrue(boolValue)
        } else {
            XCTFail()
        }
    }
    
    func testCanReadUInt8() {
        
        let someJSON = ["int": NSNumber(value: UInt8(1))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 1)
    }
    
    func testCanReadInt16() {
        
        let someJSON = ["int": NSNumber(value: Int16(12))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 12)
    }
    
    func testCanReadUInt16() {
        
        let someJSON = ["int": NSNumber(value: UInt16(12345))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 12345)
    }
    
    func testCanReadInt32() {
        
        let someJSON = ["int": NSNumber(value: Int32(1234567890))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 1234567890)
    }
    
    func testCanReadUInt32() {
        
        let someJSON = ["int": NSNumber(value: UInt32(1234567890))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 1234567890)
    }
    
    func testCanReadInt64() {
        
        let someJSON = ["int": NSNumber(value: Int64(1234567890))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 1234567890)
    }
    
    func testCanReadUInt64() {
        
        let someJSON = ["int": NSNumber(value: UInt64(1234567890))]
        let node = JSONNode(JSON: someJSON)
        
        guard let intValue = node["int"].integer else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(intValue, 1234567890)
    }
    
    
    func testCanReadIntOver64bit() {
        
        let jsonData = "{\"largeInt\": 12345678901234567890}".data(using: .utf8)!
        let node = try! JSONNode(data: jsonData)
        
        guard let floatValue = node["largeInt"].floatingPoint else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(floatValue, 12345678901234567890)
    }
}
