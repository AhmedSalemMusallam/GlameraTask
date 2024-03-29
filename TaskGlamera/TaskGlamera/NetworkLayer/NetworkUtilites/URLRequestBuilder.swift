//
//  URLRequestBuilder.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import Moya

protocol URLRequestBuilder: TargetType {
    
    var baseURL: URL { get }
    
    var requestURL: URL { get }
    
    // MARK: - Path
    var path: String { get }
    
    var headers: [String: String]? { get }
    
    // MARK: - Methods
    var method: Moya.Method { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
    var deviceId: String { get }
}
// MARK: - application constants

extension URLRequestBuilder {
    // MARK: - BASE URL

    var baseURL: URL {
//        print("the base url is -> \(Constants.manger.apiURL())")
        return URL(string: Constants.shared.APIBaseURL)!
    }
    // MARK: - Request URL
    var requestURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    // MARK: - application headers
    var headers: [String: String]? {
        var header = [String: String]()
        header["Content-Type"] = "application/json"
        header["Accept"] = "application/json"
        header["platform"] = "2"
        header["localization"] = BGDefults.manger.appLanguage()
//        header["Authorization"] = "Bearer \(UserData.shared.getUserToken() ?? "")"
//        print("user token -> \(UserData.shared.getUserToken() ?? "")")
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {return header}
//        print("the UUID is \(uuid)")
//        header["device"] = uuid //"bb46226a5b13f228"//
        return header
    }
    
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        return request
    }
    
    var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    

    
}
