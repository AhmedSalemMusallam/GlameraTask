//
//  BGServicesManager.swift
//  Womaniz
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import PromiseKit
import Moya


class BGServices {
    
    static let manger = BGServices()
    
    // MARK: - CAll API with promiseKit
    func CallApi<T: TargetType>(_ provider:MoyaProvider<T>,_ target: T) -> Promise<Any> {
        
        return Promise<Any> { seal in
            provider.request(target, completion: { (result) in
                switch result {
                case let .success(moyaResponse):
                    // http status code is now 200 from here on
                    if moyaResponse.statusCode == 200{
                        seal.fulfill(moyaResponse)
                    }else{
                        seal.fulfill(moyaResponse)
                    }
                case let .failure(error):
                    BGAlertPresenter.displayToast(message:"غير متصل بالإنترنت")
                    seal.reject(error)
                }
            })
        }
    }
}



