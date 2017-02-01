#
#  Be sure to run `pod spec lint JSONNode.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "JSONNode"
  s.version      = "1.2.4"
  s.summary      = "A simple, Swifty way to interact with JSON"

  s.description  = <<-DESC

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
var jsonNode = try! JSONNode(data: jsonData)
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

                   DESC

  s.homepage     = "http://github.com/keefmoon/JSONNode"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license    = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.authors            = { "Keith Moon" => "keef@keefmoon.com" }
  s.social_media_url   = "http://twitter.com/keefmoon"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/keefmoon/JSONNode.git", :tag => "1.2.4" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "JSONNode", "JSONNode/JSONNode/*.{swift}"

  # ――― Swift Version ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

end
