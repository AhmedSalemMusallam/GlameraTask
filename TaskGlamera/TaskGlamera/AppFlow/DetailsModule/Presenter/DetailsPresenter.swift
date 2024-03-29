//
//  DetailsPresenter.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 29/03/2024.
//

import Foundation
import Foundation
import UIKit

class DetailsPresenter:ViewToPresenterDetailsProtocol{
    
    
    var detailView: (any PresenterToViewDetailsProtocol)?
    
    var interactor: (any PresenterToInteractorDetailsProtocol)?
    
    var router: (any PresenterToRouterDetailsProtocol)?
    
    func startFetchingDetails(characterID: String, type: String) {
        interactor = DetailsInteractor(detailView: detailView)
        print("I'm Here - presenter")
        var parameters:[String:String] = [:]
        parameters.updateValue("5ee698a054741846a270709d1a8cb7ab", forKey: "apikey")
        parameters.updateValue("1711525685", forKey: "ts")
        parameters.updateValue("c62ad68e34bd77476479a8803fab9cd1", forKey: "hash")
        interactor?.fetchCharacters(parameters: parameters, type: type, characterID: characterID)
    }
    
    
    init(detailView: PresenterToViewDetailsProtocol?) {
            self.detailView = detailView
        }
    
    
}

extension DetailsPresenter:PresenterToViewDetailsProtocol{
    func onCharacterResponseSuccess(mainModelArrayList: DetailsModel, type: String) {
        detailView?.onCharacterResponseSuccess(mainModelArrayList: mainModelArrayList,type: type)
    }
    
    
    
    func onCharacterResponseFailed(error: String) {
        detailView?.onCharacterResponseFailed(error: "Some Error message from api response")
    }
    
}



