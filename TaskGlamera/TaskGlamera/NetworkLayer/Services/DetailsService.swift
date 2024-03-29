//
//  DetailsService.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 29/03/2024.
//

import Foundation
import Moya

enum DetailsService {
    case GetDetailsData(parameters: [String : String],type:String,characterID:String)
}

extension DetailsService: URLRequestBuilder {
    
    var path: String {
        switch self {
        case .GetDetailsData(let parameters,let type, let characterID):
            
            return "\(EndPoints.GetCharacterData.rawValue)/\(characterID)/\(type)"
        }

    }
    var method: Moya.Method {
        switch self {
        case .GetDetailsData:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        
        case .GetDetailsData(let parameters,let type, let characterID):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
