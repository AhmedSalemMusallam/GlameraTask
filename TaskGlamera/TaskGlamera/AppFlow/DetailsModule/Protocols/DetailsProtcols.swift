//
//  DetailsProtcols.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 28/03/2024.
//

import Foundation
import UIKit

protocol PresenterToRouterDetailsProtocol:AnyObject {
    
    static func GoBackToMainScreen()->MainViewController
    
    
    static func showCharacterPopUpView(ComicItem:DetailsModelResult?) -> CharacterPopUpViewController
    static var characterPopUpstoryboard: UIStoryboard{get}

}




protocol ViewToPresenterDetailsProtocol:AnyObject{
   
    var detailView: PresenterToViewDetailsProtocol? {get set}
    var interactor: PresenterToInteractorDetailsProtocol? {get set}
    var router: PresenterToRouterDetailsProtocol? {get set}
    func startFetchingDetails(characterID:String,type:String)

}

protocol PresenterToViewDetailsProtocol:AnyObject {
    
    func onCharacterResponseSuccess(mainModelArrayList:DetailsModel,type:String)
    func onCharacterResponseFailed(error:String)
    
}



protocol PresenterToInteractorDetailsProtocol:AnyObject {
    
    var presenter:PresenterToViewDetailsProtocol? {get set}
    func fetchCharacters(parameters: [String : String],type:String,characterID:String)
    
}

