//
//  BGNetworkHelper.swift
//  Womaniz
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import Moya
import SystemConfiguration

// Define a Codable struct to represent the message response
struct MessageResponse: Codable {
    let error: String
}

struct MessageResponseV2: Codable {
    let code: Int
    let data:ErrorResponse
}
struct ErrorResponse: Codable {
    
    let error:String
}
struct BGNetworkHelper {
    
    
    // MARK: - print response
    fileprivate static func printResponse(_ response: Response) {
        // print request data
        print("URL:")
        print(response.request?.urlRequest ?? "")
        print("Header:")
        print((response.request?.headers ?? nil) as Any)
        print("STATUS:")
        print(response.statusCode)
        print("Response: \(response.data)")
        if let json = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) {
            print(json)
        } else {
            let response = String(data: response.data, encoding: .utf8)!
            print(response)
        }
    }
    
    // MARK: - validate all APIs responses
    static func validateResponse (response:Response) ->Bool {
        printResponse(response)
        
        if response.statusCode == BGConstants.success
        {
            return true
        }else{
            let decoder = JSONDecoder()
            do {
                let responseModel = try decoder.decode(ResponseModel.self, from: response.data)
                switch responseModel.code {
                case BGConstants.success? :
                    return true
                case BGConstants.added? , BGConstants.created?:
                    BGAlertPresenter.displayToast(title: "",message: responseModel.data?.message ?? "")
                    return true
                case BGConstants.unprocessableEntity?:
                    BGAlertPresenter.displayToast(title: "",message: responseModel.data?.message ?? "")
                    return false
                case BGConstants.notFound?:
                    BGAlertPresenter.displayToast(title: "",message: responseModel.data?.message ?? "")
                    return false
                case BGConstants.unauthenticated?:
                    BGAlertPresenter.displayToast(title: "",message: responseModel.data?.message ?? "")
                    //BGAuth.manger.logout()
                    return false
                case BGConstants.notAcceptable?:
                    BGAlertPresenter.displayToast(title: "",message: responseModel.data?.message ?? "")
                    print("I'm here -> \(responseModel.data?.message ?? "")")
                    return false
                case BGConstants.notActive?:
                    BGAlertPresenter.displayToast(title: "",message: responseModel.data?.message ?? "")
                    return  true
                default:
                    return false
                }
            } catch {
                print(error.localizedDescription)
                return false
            }
        }
        
        
        
    }
    
}
