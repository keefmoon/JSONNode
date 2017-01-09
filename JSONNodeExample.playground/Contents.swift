import JSONNode

// MARK: Test JSON

/*
 From https://api.imgflip.com/
 
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
             // probably a lot more memes here..
         ]
     }
}
 */
let jsonDataURL = Bundle.main.url(forResource: "meme", withExtension: "json")!
let jsonData = try! Data(contentsOf: jsonDataURL)

// MARK: The traditional way

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

// MARK: Using JSONNode

var jsonNode = try! JSONNode(data: jsonData)
print(jsonNode.debugDescription)
guard let name = jsonNode["data"]["memes"][0]["name"].string else { fatalError() }

//print(name)
