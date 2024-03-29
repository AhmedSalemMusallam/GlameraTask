//
//  TaskGlameraTests.swift
//  TaskGlameraTests
//
//  Created by Ahmed Salem on 26/03/2024.
//

import XCTest
import Moya
import PromiseKit

@testable import TaskGlamera

final class TaskGlameraTests: XCTestCase {

    private let characterService = MoyaProvider<CharacterService>()
    private let loading = BGLoading()
    var parameters:[String:String] = [:]
    override func setUpWithError() throws {
        
        parameters.updateValue("5ee698a054741846a270709d1a8cb7ab", forKey: "apikey")
        parameters.updateValue("1711525685", forKey: "ts")
        parameters.updateValue("c62ad68e34bd77476479a8803fab9cd1", forKey: "hash")
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func APITest() throws {
        fetchCharacters(parameters: parameters)
        func fetchCharacters(parameters: [String : String]) {
            print("I'm Here - interactor")
    
            firstly { () -> Promise<Any> in
                loading.showLoading()
                return BGServices.manger.CallApi(self.characterService,CharacterService.GetCharacterData(paramters: parameters))
            }.done({ [self] response in
                let result = response as! Response
                guard BGNetworkHelper.validateResponse(response: result) else{return}
                let respone : CharacterModel = try BGDecoder.decode(data: result.data)
                //success
                guard let safeCode = respone.code else { return }
                
                //Test Comes Here
                XCTAssertNotNil(respone, "The variable should not be nil")
                
            }).ensure { [weak self] in
                guard let self = self else{return}
                self.loading.dismissLoading()
            }.catch { (error) in
                print(error)
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
