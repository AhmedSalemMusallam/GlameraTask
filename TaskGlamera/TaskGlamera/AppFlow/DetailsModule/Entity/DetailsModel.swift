//
//  DetailsModel.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 29/03/2024.
//

import Foundation

struct DetailsModel : Codable {
    let code : Int?
    let status : String?
    let copyright : String?
    let attributionText : String?
    let attributionHTML : String?
    let etag : String?
    let data : DetailsModelData?

    
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

struct DetailsModelData : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [DetailsModelResult?]
    
    enum CodingKeys: String, CodingKey {

        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}

struct DetailsModelResult : Codable {
    let thumbnail : DetailsModelThumbnail?
    let title : String?
   
    
    enum CodingKeys: String, CodingKey {

        case thumbnail = "thumbnail"
        case title = "title"
       
    }
}

struct DetailsModelThumbnail : Codable {
    let path : String?
    let Extension : String?
   
    
    enum CodingKeys: String, CodingKey {

        case path = "path"
        case Extension = "extension"
       
    }
}
