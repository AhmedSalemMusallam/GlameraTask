//
//  DetailsRouter.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 28/03/2024.
//

import Foundation
import UIKit
class DetailsRouter:PresenterToRouterDetailsProtocol{
    
    static func GoBackToMainScreen() -> MainViewController {
        let view = MainRouter.mainstoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        return view
    } 
    
    
    static func showCharacterPopUpView(ComicItem:DetailsModelResult?) -> CharacterPopUpViewController {
        let view = DetailsRouter.characterPopUpstoryboard.instantiateViewController(withIdentifier: "CharacterPopUpViewController") as! CharacterPopUpViewController
        view.comicItem = ComicItem
        return view
    }
    
    static var characterPopUpstoryboard: UIStoryboard
    {
        return UIStoryboard(name:"CharacterPopUp",bundle: Bundle.main)
    }
}
