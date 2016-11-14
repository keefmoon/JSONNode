//
//  JSONNode.swift
//  JSONNode
//
//  Created by Keith Moon on 09/11/2016.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

public enum JSONNode {
    case null
    case string(String)
    case integer(Int)
    case floatingPoint(Double)
    case boolean(Bool)
    indirect case array([JSONNode])
    indirect case dictionary([String: JSONNode])
    
    public init(JSON: Any) {
        switch JSON {
        case let jsonString as String:
            self = .string(jsonString)
        case let jsonInt as Int:
            self = .integer(jsonInt)
        case let jsonDouble as Double:
            self = .floatingPoint(jsonDouble)
        case let jsonBool as Bool:
            self = .boolean(jsonBool)
        case let jsonArray as Array<Any>:
            self = .array(jsonArray.flatMap { JSONNode(JSON: $0) })
        case let jsonDictionary as Dictionary<String, Any>:
            var dictionary = [String: JSONNode]()
            for (key, value) in jsonDictionary {
                dictionary[key] = JSONNode(JSON: value)
            }
            self = .dictionary(dictionary)
        default:
            self = .null
        }
    }
    
    public init(data: Data) throws {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        self = JSONNode(JSON: json)
    }
}

extension JSONNode: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .string(let stringNode):
            return stringNode
            
        case .integer(let intNode):
            return String(intNode)
            
        case .floatingPoint(let doubleNode):
            return String(doubleNode)
            
        case .boolean(let boolNode):
            return String(boolNode)
            
        case .array(let arrayNode):
            var returnString = "["
            for node in arrayNode {
                returnString += "\(node.debugDescription), "
            }
            returnString += "]"
            return returnString
            
        case .dictionary(let dictionaryNode):
            var returnString = "{"
            for (key, value) in dictionaryNode.enumerated() {
                returnString += "\(key): \(value), "
            }
            returnString += "}"
            return returnString
            
        case .null:
            return "NULL"
        }
    }
}

extension JSONNode {
    
    public var string: String? {
        guard case .string(let stringValue) = self else { return nil }
        return stringValue
    }
    
    public var integer: Int? {
        guard case .integer(let intValue) = self else { return nil }
        return intValue
    }
    
    public var floatingPoint: Double? {
        guard case .floatingPoint(let doubleValue) = self else { return nil }
        return doubleValue
    }
    
    public var boolean: Bool? {
        guard case .boolean(let boolValue) = self else { return nil }
        return boolValue
    }
    
    public var array: [JSONNode]? {
        guard case .array(let nodeArray) = self else { return nil }
        return nodeArray
    }
    
    public var dictionary: [String: JSONNode]? {
        guard case .dictionary(let nodeDictionary) = self else { return nil }
        return nodeDictionary
    }
}

extension JSONNode {
    
    public subscript(_ index: Int) -> JSONNode {
        get { return array?[index] ?? .null }
    }
    
    public subscript(_ key: String) -> JSONNode {
        get { return dictionary?[key] ?? .null }
    }
}
