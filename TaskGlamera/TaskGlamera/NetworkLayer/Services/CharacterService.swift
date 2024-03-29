//
//  CharacterService.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import Foundation
import Moya

enum CharacterService {
    case GetCharacterData(paramters:[String:String])
}

extension CharacterService: URLRequestBuilder {
    
    var path: String {
        switch self {
        case .GetCharacterData(let parameters):
            return EndPoints.GetCharacterData.rawValue
            
       
        }

    }
    var method: Moya.Method {
        switch self {
        case .GetCharacterData:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        
        case .GetCharacterData(let paramters):
            return .requestParameters(parameters: paramters, encoding: URLEncoding.default)
        }
    }
}
