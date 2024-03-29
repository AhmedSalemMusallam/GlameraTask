//
//  ResponseModel.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
struct ResponseModel : Codable{
    
    let code : Int?
    let data : ResposeErrorModel?
    
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
    }
}
struct ResposeErrorModel : Codable{
    
    let message : String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

