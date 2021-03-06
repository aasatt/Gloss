//
//  EncoderTests.swift
//  GlossExample
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Gloss
import UIKit
import XCTest

class EncoderTests: XCTestCase {
    
    var testNestedModel1: TestNestedModel? = nil
    var testNestedModel2: TestNestedModel? = nil
    
    override func setUp() {
        super.setUp()
        
        testNestedModel1 = TestNestedModel(json: [ "id" : 1, "name" : "nestedModel1" ])
        testNestedModel2 = TestNestedModel(json: ["id" : 2, "name" : "nestedModel2"])
    }
    
    override func tearDown() {
        testNestedModel1 = nil
        testNestedModel2 = nil
        
        super.tearDown()
    }
    
    func testInvalidValue() {
        let notAnyObject: URL? = nil
        let result: JSON? = Encoder.encode("invalid")(notAnyObject)
        
        XCTAssertTrue((result == nil), "Encode should return nil for invalid value");
    }
    
    func testEncodeBool() {
        let bool: Bool? = true
        let result: JSON? = Encoder.encode("bool")(bool)
        
        XCTAssertTrue((result!["bool"] as! Bool == true), "Encode Bool should return correct value")
    }
    
    func testEncodeBoolArray() {
        let boolArray: [Bool]? = [true, false, true]
        let result: JSON? = Encoder.encode("boolArray")(boolArray)
        
        XCTAssertTrue((result!["boolArray"] as! [Bool] == [true, false, true]), "Encode Bool array should return correct value")
    }
    
    func testEncodeBoolLArrayReturnsNilIfModelInvalid() {
        let invalidModel = ["1", "2", "3"]
        let result: JSON? = Encoder.encode("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [Bool], "Encode bool array should return nil if model is invalid")
    }
    
    func testEncodeInt() {
        let integer: Int? = 1
        let result: JSON? = Encoder.encode("integer")(integer)
        
        XCTAssertTrue((result!["integer"] as! Int == 1), "Encode Int should return correct value")
    }
    
    func testEncodeIntArray() {
        let integerArray: [Int]? = [1, 2, 3]
        let result: JSON? = Encoder.encode("integerArray")(integerArray)
        
        XCTAssertTrue((result!["integerArray"] as! [Int] == [1, 2, 3]), "Encode Int array should return correct value")
    }

    func testEncodeIntLArrayReturnsNilIfModelInvalid() {
        let invalidModel = ["1", "2", "3"]
        let result: JSON? = Encoder.encode("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [Int], "Encode int array should return nil if model is invalid")
    }
    
    func testEncodeFloat() {
        let float: Float? = 1.0
        let result: JSON? = Encoder.encode("float")(float)
        
        XCTAssertTrue((result!["float"] as! Float == 1.0), "Encode Float should return correct value")
    }
    
    func testEncodeFloatArray() {
        let floatArray: [Float]? = [1.0, 2.0, 3.0]
        let result: JSON? = Encoder.encode("floatArray")(floatArray)
        
        XCTAssertTrue((result!["floatArray"] as! [Float] == [1.0, 2.0, 3.0]), "Encode Float array should return correct value")
    }
    
    func testEncodeFloatLArrayReturnsNilIfModelInvalid() {
        let invalidModel = ["1", "2", "3"]
        let result: JSON? = Encoder.encode("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [Float], "Encode float array should return nil if model is invalid")
    }
    
    func testEncodeDouble() {
        let double: Double? = 4.0
        let result: JSON? = Encoder.encode("double")(double)
        
        XCTAssertTrue((result!["double"] as! Double == 4.0), "Encode Double should return correct value")
    }
    
    func testEncodeDoubleArray() {
        let doubleArray: [Double]? = [4.0, 5.0, 6.0]
        let result: JSON? = Encoder.encode("doubleArray")(doubleArray)
        
        XCTAssertTrue((result!["doubleArray"] as! [Double] == [4.0, 5.0, 6.0]), "Encode Double array should return correct value")
    }
    
    func testEncodeDoubleLArrayReturnsNilIfModelInvalid() {
        let invalidModel = ["1", "2", "3"]
        let result: JSON? = Encoder.encode("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [Double], "Encode double array should return nil if model is invalid")
    }
    
    func testEncodeEncodableDictionary() {
        let result: JSON? = Encoder.encodeEncodableDictionary("dictionary")(["model1" : testNestedModel1!])
        let dictionary = result!["dictionary"] as! [String : [String : AnyObject]]
        
        XCTAssertTrue(dictionary["model1"]!["id"] as! Int == 1, "Encode Dictionary should return correct value")
        XCTAssertTrue(dictionary["model1"]!["name"] as! String == "nestedModel1", "Encode Dictionary should return correct value")
    }
    
    func testEncodeEncodableDictionaryWithArray() {
        let result: JSON? = Encoder.encodeEncodableDictionary("dictionaryWithArray")(["models" : [testNestedModel1!, testNestedModel2!]])
        let dictionary = result!["dictionaryWithArray"] as! [String : [AnyObject]]
        let json1 = dictionary["models"]![0] as! JSON
        let json2 = dictionary["models"]![1] as! JSON
        
        XCTAssertTrue(json1["id"] as! Int == 1, "Encode Dictionary should return correct value")
        XCTAssertTrue(json1["name"] as! String == "nestedModel1", "Encode Dictionary should return correct value")
        XCTAssertTrue(json2["id"] as! Int == 2, "Encode Dictionary should return correct value")
        XCTAssertTrue(json2["name"] as! String == "nestedModel2", "Encode Dictionary should return correct value")
    }

    func testEncodeString() {
        let string: String? = "abc"
        let result: JSON? = Encoder.encode("string")(string)
        
        XCTAssertTrue((result!["string"] as! String == "abc"), "Encode String should return correct value")
    }
    
    func testEncodeStringArray() {
        let stringArray: [String]? = ["def", "ghi", "jkl"]
        let result: JSON? = Encoder.encode("stringArray")(stringArray)
        
        XCTAssertTrue((result!["stringArray"] as! [String] == ["def", "ghi", "jkl"]), "String array should return correct value")
    }
    
    func testEncodeStringLArrayReturnsNilIfModelInvalid() {
        let invalidModel = [1, 2, 3]
        let result: JSON? = Encoder.encode("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [String], "Encode string array should return nil if model is invalid")
    }
    
    func testEncodeNestedModel() {
        let result: JSON? = Encoder.encodeEncodable("nestedModel")(testNestedModel1)
        let modelJSON: JSON = result!["nestedModel"] as! JSON
        
        XCTAssertTrue((modelJSON["id"] as! Int == 1), "Encode nested model should return correct value")
        XCTAssertTrue((modelJSON["name"] as! String == "nestedModel1"), "Encode nested model should return correct value")
    }
    
    func testEncodeNestedModelArray() {
        let model1: TestNestedModel = testNestedModel1!
        let model2: TestNestedModel = testNestedModel2!
        let result: JSON? = Encoder.encodeEncodableArray("nestedModelArray")([model1, model2])
        let modelsJSON: [JSON] = result!["nestedModelArray"] as! [JSON]
        let model1JSON: JSON = modelsJSON[0]
        let model2JSON: JSON = modelsJSON[1]
        
        XCTAssertTrue((model1JSON["id"] as! Int == 1), "Encode nested model array should return correct value")
        XCTAssertTrue((model1JSON["name"] as! String == "nestedModel1"), "Encode nested model array should return correct value")
        XCTAssertTrue((model2JSON["id"] as! Int == 2), "Encode nested model array should return correct value")
        XCTAssertTrue((model2JSON["name"] as! String == "nestedModel2"), "Encode nested model array should return correct value")
    }
    
    func testEncodeEnumValue() {
        let enumValue: TestModel.EnumValue? = TestModel.EnumValue.A
        let result: JSON? = Encoder.encodeEnum("enumValue")(enumValue)
        
        XCTAssertTrue((result!["enumValue"] as! TestModel.EnumValue.RawValue == "A"), "Encode enum value should return correct value")
    }
    
    func testEncodeEnumArray() {
        let enumArray: [TestModel.EnumValue]? = [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]
        let result: JSON? = Encoder.encodeEnumArray("enumValueArray")(enumArray)
        
        XCTAssertTrue((result!["enumValueArray"] as! [TestModel.EnumValue.RawValue] == ["A", "B", "C"]), "Encode enum value array should return correct value")
    }
    
    func testEncodeEnumArrayReturnsNilIfModelInvalid() {
        let invalidModel = ["1", "2", "3"]
        let result: JSON? = Encoder.encode("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [TestModel.EnumValue], "Encode enum array should return nil if model is invalid")
    }
    
    func testEncodeDate() {
        let date: Date? = TestModel.dateFormatter.date(from: "2015-08-16T20:51:46.600Z")
        let result: JSON? = Encoder.encodeDate("date", dateFormatter: TestModel.dateFormatter)(date)
        
        XCTAssertTrue(result!["date"] as! String == "2015-08-16T20:51:46.600Z", "Encode NSDate should return correct value")
    }
    
    func testEncodeDateArray() {
        let date: Date? = TestModel.dateFormatter.date(from: "2015-08-16T20:51:46.600Z")
        let dateArray: [Date]? = [date!, date!]
        let result: JSON? = Encoder.encodeDateArray("dateArray", dateFormatter: TestModel.dateFormatter)(dateArray)
        
        XCTAssertTrue(result!["dateArray"] as! [String] == ["2015-08-16T20:51:46.600Z", "2015-08-16T20:51:46.600Z"], "Encode NSDate array should return correct value")
    }
    
    func testEncodeDateArrayReturnsNilIfModelInvalid() {
        let invalidModel = [NSDate(timeIntervalSince1970: 1), NSDate(timeIntervalSince1970: 2), NSDate(timeIntervalSince1970: 3)]
        let result: JSON? = Encoder.encodeDateArray("array", dateFormatter: TestModel.dateFormatter)(invalidModel)
        
        XCTAssertNil(result?["array"] as? [NSDate], "Encode date array should return nil if model is invalid")
    }
    
    func testEncodeDateISO8601() {
        let dateISO8601: Date? = Date(timeIntervalSince1970: 1439071033)
        let result: JSON? = Encoder.encodeDateISO8601("dateISO8601")(dateISO8601!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate = dateFormatter.date(from: result!["dateISO8601"] as! String)
        
        XCTAssertTrue(resultDate?.timeIntervalSince1970 == 1439071033, "Encode ISO8601 NSDate should return correct value")
    }
    
    func testEncodeDateISO8601Array() {
        let dateISO8601: Date? = Date(timeIntervalSince1970: 1439071033)
        let dateISO8601Array: [Date]? = [dateISO8601!, dateISO8601!]
        let result: JSON? = Encoder.encodeDateISO8601Array("dateISO8601Array")(dateISO8601Array!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let resultArray: [String] = result!["dateISO8601Array"] as! [String]
        let resultDate1 = dateFormatter.date(from: resultArray[0])
        let resultDate2 = dateFormatter.date(from: resultArray[1])
        
        XCTAssertTrue(resultDate1?.timeIntervalSince1970 == 1439071033, "Encode ISO8601 NSDate array should return correct value")
        XCTAssertTrue(resultDate2?.timeIntervalSince1970 == 1439071033, "Encode ISO8601 NSDate array should return correct value")
    }
    
    func testEncodeDateISO8601ArrayReturnsNilIfModelInvalid() {
        let invalidModel = [NSDate(timeIntervalSince1970: 1), NSDate(timeIntervalSince1970: 2), NSDate(timeIntervalSince1970: 3)]
        let result: JSON? = Encoder.encodeDateISO8601Array("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [NSDate], "Encode date array should return nil if model is invalid")
    }
    
    func testEncodeInt32() {
        let int32: Int32? =  100000000
        let result: JSON? = Encoder.encodeInt32("int32")(int32)
        
        XCTAssertTrue(((result!["int32"] as! NSNumber).intValue == 100000000), "Encode Int32 should return correct value")
    }
    
    func testEncodeInt32Array() {
        let int32Array: [Int32]? =  [100000000, -2147483648, 2147483647]
        let result: JSON? = Encoder.encodeInt32Array("int32Array")(int32Array)
        
        XCTAssertTrue(((result!["int32Array"] as! [NSNumber]).map { $0.intValue } == [100000000, -2147483648, 2147483647]), "Encode Int32 array should return correct value")
    }

	func testEncodeUInt32() {
		let uInt32: UInt32? =  4294967295
		let result: JSON? = Encoder.encodeUInt32("uInt32")(uInt32)

		XCTAssertTrue(((result!["uInt32"] as! NSNumber).uint32Value == 4294967295), "Encode UInt32 should return correct value")
	}

	func testEncodeUInt32Array() {
		let uInt32Array: [UInt32]? =  [100000000, 2147483648, 4294967295]
		let result: JSON? = Encoder.encodeUInt32Array("uInt32Array")(uInt32Array)

		XCTAssertTrue(((result!["uInt32Array"] as! [NSNumber]).map { $0.uint32Value } == [100000000, 2147483648, 4294967295]), "Encode UInt32 array should return correct value")
	}

    func testEncodeInt64() {
        let int64: Int64? =  300000000
        let result: JSON? = Encoder.encodeInt64("int64")(int64)
        
        XCTAssertTrue(((result!["int64"] as! NSNumber).int64Value == 300000000), "Encode Int64 should return correct value")
    }
    
    func testEncodeInt64Array() {
        let int64Array: [Int64]? =  [300000000, -9223372036854775808, 9223372036854775807]
        let result: JSON? = Encoder.encodeInt64Array("int64Array")(int64Array)
        
        XCTAssertTrue(((result!["int64Array"] as! [NSNumber]).map { $0.int64Value } == [300000000, -9223372036854775808, 9223372036854775807]), "Encode Int64 array should return correct value")
    }

	func testEncodeUInt64() {
		let uInt64: UInt64? =  18446744073709551615
		let result: JSON? = Encoder.encodeUInt64("uInt64")(uInt64)

		XCTAssertTrue(((result!["uInt64"] as! NSNumber).uint64Value == 18446744073709551615), "Encode UInt64 should return correct value")
	}

	func testEncodeUInt64Array() {
		let uInt64Array: [UInt64]? =  [300000000, 9223372036854775808, 18446744073709551615]
		let result: JSON? = Encoder.encodeUInt64Array("uInt64Array")(uInt64Array)

		XCTAssertTrue(((result!["uInt64Array"] as! [NSNumber]).map { $0.uint64Value } == [300000000, 9223372036854775808, 18446744073709551615]), "Encode UInt64 array should return correct value")
	}

    func testEncodeURL() {
        let url: URL? = URL(string: "http://github.com")
        let result: JSON? = Encoder.encodeURL("url")(url)
        
        XCTAssertTrue((result!["url"] as! String == "http://github.com"), "Encode NSURL should return correct value")
    }
    
    func testEncodeURLArray() {
        let urls: [URL]? = [URL(string: "http://github.com")!, URL(string: "http://github.com")!]
        let result: JSON? = Encoder.encodeArray("urlArray")(urls)
        
        let test = result!["urlArray"] as! [URL]
        
        XCTAssertTrue(test.map { url in url.absoluteString } == ["http://github.com", "http://github.com"], "Encode NSURL array should return correct value")
    }
    
    func testEncodeURLArrayReturnsNilIfModelInvalid() {
        let invalidModel = ["1", "2", "3"]
        let result: JSON? = Encoder.encodeArray("array")(invalidModel)
        
        XCTAssertNil(result?["array"] as? [NSURL], "Encode url array should return nil if model is invalid")
    }

}
