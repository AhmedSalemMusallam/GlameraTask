//
//  MainInteractor.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import Foundation
import Moya
import PromiseKit

class MainInteractor:PresenterToInteractorMainProtocol{
    
    init(mainView: PresenterToViewMainProtocol?) {
        self.presenter = mainView
        }
    var presenter: PresenterToViewMainProtocol?
    
    private let characterService = MoyaProvider<CharacterService>()
    private let loading = BGLoading()
    
    func fetchCharacters(parameters: [String : String]) {
        print("I'm Here - interactor")
//        presenter = MainPresenter(mainView: nil)
        firstly { () -> Promise<Any> in
            loading.showLoading()
            return BGServices.manger.CallApi(self.characterService,CharacterService.GetCharacterData(paramters: parameters))
        }.done({ [self] response in
            let result = response as! Response
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let respone : CharacterModel = try BGDecoder.decode(data: result.data)
            //success
            guard let safeCode = respone.code else { return }
            if safeCode == BGConstants.success
            {
                presenter?.onCharacterResponseSuccess(mainModelArrayList: respone)

            }else{
                self.presenter?.onCharacterResponseFailed(error: "")
                BGAlertPresenter.displayToast(message: "Loading process was failed".localized)
            }
            
        }).ensure { [weak self] in
            guard let self = self else{return}
            self.loading.dismissLoading()
        }.catch { (error) in
            print(error)
            self.presenter?.onCharacterResponseFailed(error: "")
        }
    }
    
}
