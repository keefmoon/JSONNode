import Foundation

// MARK: - JSON Node

enum JSONNode {
    case string(String)
    case integer(Int)
    case floatingPoint(Double)
    case boolean(Bool)
    indirect case array([JSONNode])
    indirect case dictionary([String: JSONNode])
    
    init?(JSON: Any) {
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
                if let node = JSONNode(JSON: value) {
                    dictionary[key] = node
                }
            }
            self = .dictionary(dictionary)
        default:
            return nil
        }
    }
    
    init?(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return nil }
        guard let node = JSONNode(JSON: json) else { return nil }
        self = node
    }
}

extension JSONNode: CustomDebugStringConvertible {
    
    var debugDescription: String {
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
        }
    }
}

extension JSONNode {
    
    var string: String? {
        guard case .string(let stringValue) = self else { return nil }
        return stringValue
    }
    
    var integer: Int? {
        guard case .integer(let intValue) = self else { return nil }
        return intValue
    }
    
    var floatingPoint: Double? {
        guard case .floatingPoint(let doubleValue) = self else { return nil }
        return doubleValue
    }
    
    var boolean: Bool? {
        guard case .boolean(let boolValue) = self else { return nil }
        return boolValue
    }
    
    var array: [JSONNode]? {
        guard case .array(let nodeArray) = self else { return nil }
        return nodeArray
    }
    
    var dictionary: [String: JSONNode]? {
        guard case .dictionary(let nodeDictionary) = self else { return nil }
        return nodeDictionary
    }
}

// MARK: Test JSON

var testJSON = [String: Any]()
let names: [[String: Any]] = [["name": "Keith Moon", "age": 36], ["name": "Alissa Moon", "age": 31]]
testJSON["people"] = names
testJSON["company"] = "Data Ninjitsu"
testJSON["cool"] = true
testJSON["coolness"] = 5.5
testJSON["rating"] = 5

// MARK: Swiftify

let swiftJSON = JSONNode(JSON: testJSON)!
swiftJSON.debugDescription

// MARK: Ugly way to get values

if case .dictionary(let dict) = swiftJSON, let people = dict["people"], case .array(let peopleArray) = people, let firstPerson = peopleArray.first, case .dictionary(let personDict) = firstPerson, let firstName = personDict["name"], case .string(let nameString) = firstName  {
    print("Person: \(nameString)")
}

// MARK: Cool way to get values

let myName = swiftJSON.dictionary?["people"]?.array?[0].dictionary?["name"]?.string
let myAge = swiftJSON.dictionary?["people"]?.array?[0].dictionary?["age"]?.integer
let myCompany = swiftJSON.dictionary?["company"]?.string
