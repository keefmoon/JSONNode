# JSONNode

A simple, Swifty way to interact with JSON.

JSONNode is simple, useful, and under 150 lines of code.

## Advantage over traditional JSON handling

Let's take the response from the ImgFlip Meme API

```JSON
{
    "success": true,
    "data": {
        "memes": [
              {
                  "id": "61579",
                  "name": "One Does Not Simply",
                  "url": "http://i.imgflip.com/1bij.jpg",
                  "width": 568,
                  "height": 335
              },
              {
                  "id": "101470",
                  "name": "Ancient Aliens",
                  "url": "http://i.imgflip.com/26am.jpg",
                  "width": 500,
                  "height": 437
              }
          ]
    }
}
```

To retrieve the name for the first meme, you would do the following:

```Swift
var jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments])

guard
    let jsonDictionary = jsonObject as? [String: Any],
    let dataDictionary = jsonDictionary["data"] as? [String: Any],
    let memesArray = dataDictionary["memes"] as? [[String: Any]],
    let firstMeme = memesArray.first,
    let memeName = firstMeme["name"] as? String else {

        fatalError()
}

print(memeName)
```

With JSONNode this becomes the following:

```Swift
var jsonNode = JSONNode(data: jsonData)!
guard let name = jsonNode["data"]["memes"][0]["name"].string else { fatalError() }

print(name)
```

## How it works

Typically when JSON is deserialised, it is turned into nested arrays and dictionary, and since these collections need a type and the JSON could contain any of multiple types, the non-specific `Any` protocol is used.

This is not a true representation of the situation though. There can't be "anything" in the collection. Each node in the JSON structure can only be one of the following:
- String
- Boolean
- Integer
- Floating point number
- Array containing something in this list
- Dictionary with a string key and value as something in this list

With this finite list of possible values for a JSON node, a enum is the best way to represent that. Inspiration was taken from the way that Swift Playgrounds passes information been the playground page and the live view.

## Requirements

- iOS 8.0+ | macOS 10.7+ | tvOS 9.0+ | watchOS 2.0+
- Swift 3
- Xcode 8

## Integration

#### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `JSONNode`by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod 'JSONNode'
end
```

Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:


#### Manually (iOS 8+, OS X 10.9+)

To use this library in your project manually you may:  

1. for Projects, just drag JSONNode.swift to the project tree
2. for Workspaces, include the whole JSONNode.xcodeproj
