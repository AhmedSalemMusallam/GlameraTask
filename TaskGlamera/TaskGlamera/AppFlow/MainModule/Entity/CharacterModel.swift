//
//  CharacterModel.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import Foundation

struct CharacterModel : Codable {
    let code : Int?
    let status : String?
    let copyright : String?
    let attributionText : String?
    let attributionHTML : String?
    let etag : String?
    let data : CharacterModelData?

    
    enum CodingKeys: String, CodingKey {

        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case etag = "etag"
        case data = "data"
    }
}

struct CharacterModelData : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [CharacterModelResult?]
    
    enum CodingKeys: String, CodingKey {

        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}

struct CharacterModelResult : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let thumbnail : ThumbnailData?
    let resourceURI : String?
    let comics : ComicsData?
    let series : SeriesData?
    let stories : StoriesData?
    let events : EventsData?
    
   
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
        case resourceURI = "resourceURI"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"
    }
}

struct ThumbnailData : Codable {
    let path : String?
    let Extension : String?
    
    enum CodingKeys: String, CodingKey {

        case path = "path"
        case Extension = "extension"
        
    }
}


struct ComicsData : Codable {
    let available : Int?
    let collectionURI : String?
    let items : [ComicItems?]
    let returned : Int?
    
    enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct ComicItems : Codable {
    let resourceURI : String?
    let name : String?
   
    
    enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
    }
}


struct SeriesData : Codable {
    let available : Int?
    let collectionURI : String?
    let items : [SeriesItems?]
    let returned : Int?
    
    enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct SeriesItems : Codable {
    let resourceURI : String?
    let name : String?
   
    
    enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
    }
}
struct StoriesData : Codable {
    let available : Int?
    let collectionURI : String?
    let items : [StoriesItems?]
    let returned : Int?
    
    enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct StoriesItems : Codable {
    let resourceURI : String?
    let name : String?
    let type : String?
   
    
    enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }
}

struct EventsData : Codable {
    let available : Int?
    let collectionURI : String?
    let items : [EventsItems?]
    let returned : Int?
    
    enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct EventsItems : Codable {
    let resourceURI : String?
    let name : String?
   
    
    enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
    }
}
          
                
