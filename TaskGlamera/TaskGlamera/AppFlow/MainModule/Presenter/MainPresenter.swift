//
//  MainPresenter.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//


import Foundation
import UIKit

class MainPresenter:ViewToPresenterMainProtocol{
    
    
 
    var mainView: PresenterToViewMainProtocol?
   
    
    var interactor: PresenterToInteractorMainProtocol?
    
    
    var router: PresenterToRouterMainProtocol?
    
    
    func startFetchingMain(search: String, offset: Int) {
        
        interactor = MainInteractor(mainView: self.mainView)
        print("I'm Here - presenter")
        var parameters:[String:String] = [:]
        parameters.updateValue("5ee698a054741846a270709d1a8cb7ab", forKey: "apikey")
        parameters.updateValue("1711525685", forKey: "ts")
        parameters.updateValue("c62ad68e34bd77476479a8803fab9cd1", forKey: "hash")
        if search.count != 0
        {
            parameters.updateValue(search, forKey: "nameStartsWith")
        }else{
            
           
            if offset == -1
            {
                //initial State
                
            }else{
                //pagination works here
                parameters.updateValue("\(offset)", forKey: "offset")
                parameters.updateValue("20", forKey: "limit")
            }
        }
        

        interactor?.fetchCharacters(parameters: parameters)
    }
    
    init(mainView: PresenterToViewMainProtocol?) {
            self.mainView = mainView
        }
    
    
}

extension MainPresenter:InteractorToPresenterMainProtocol{
    
    func characterFetchSuccess(characterList: CharacterModel) {
        print("Back to Presenter")
        
        mainView?.onCharacterResponseSuccess(mainModelArrayList: characterList)
        
        
    }
    
    func characterFetchFailed() {
        
        mainView?.onCharacterResponseFailed(error: "Some Error message from api response")
    }
    
}



