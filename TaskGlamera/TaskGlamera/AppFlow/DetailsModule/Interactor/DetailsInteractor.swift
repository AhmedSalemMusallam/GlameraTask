//
//  DetailsInteractor.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 29/03/2024.
//

import Foundation
import Moya
import PromiseKit

class DetailsInteractor:PresenterToInteractorDetailsProtocol{
    
    
    
    var presenter: PresenterToViewDetailsProtocol?
    
    init(detailView: PresenterToViewDetailsProtocol?) {
        self.presenter = detailView
        }
    
    
    private let detailsService = MoyaProvider<DetailsService>()
    private let loading = BGLoading()
    
    func fetchCharacters(parameters: [String : String],type:String,characterID:String) {
        print("I'm Here - interactor")
//        presenter = MainPresenter(mainView: nil)
        firstly { () -> Promise<Any> in
            loading.showLoading()
            return BGServices.manger.CallApi(self.detailsService,DetailsService.GetDetailsData(parameters: parameters, type: type, characterID: characterID))
        }.done({ [self] response in
            let result = response as! Response
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let respone : DetailsModel = try BGDecoder.decode(data: result.data)
            //success
            guard let safeCode = respone.code else { return }
            if safeCode == BGConstants.success
            {
                presenter?.onCharacterResponseSuccess(mainModelArrayList: respone,type: type)

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
