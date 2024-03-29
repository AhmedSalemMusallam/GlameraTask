//
//  MainProtocols.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import Foundation
import UIKit

protocol ViewToPresenterMainProtocol:AnyObject{
   
    var mainView: PresenterToViewMainProtocol? {get set}
    var interactor: PresenterToInteractorMainProtocol? {get set}
    var router: PresenterToRouterMainProtocol? {get set}
    func startFetchingMain(search:String,offset:Int)

}

protocol PresenterToViewMainProtocol:AnyObject {
    
    func onCharacterResponseSuccess(mainModelArrayList:CharacterModel)
    func onCharacterResponseFailed(error:String)
    
}

protocol PresenterToRouterMainProtocol:AnyObject {
    
    static func createCharacterModule()->MainViewController
    static func showCharactersDetails(characterDetails:CharacterModelResult?) -> DetailsViewController
    static func showSearchView() -> SearchViewController
    static var mainstoryboard: UIStoryboard { get }
    static var detailsstoryboard: UIStoryboard { get }
    static var searchstoryboard: UIStoryboard { get }

}

protocol PresenterToInteractorMainProtocol:AnyObject {
    
    var presenter:PresenterToViewMainProtocol? {get set}
    func fetchCharacters(parameters:[String:String])
    
}

protocol InteractorToPresenterMainProtocol:AnyObject {
    
    func characterFetchSuccess(characterList:CharacterModel)
    func characterFetchFailed()
    
}
