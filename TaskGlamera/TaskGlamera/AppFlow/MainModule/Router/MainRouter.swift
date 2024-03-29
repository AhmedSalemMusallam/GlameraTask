//
//  MainRouter.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import Foundation
import UIKit
class MainRouter:PresenterToRouterMainProtocol{
    
    static func createCharacterModule() -> MainViewController {
        let view = MainRouter.mainstoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        return view
    }
    
    
    static func showCharactersDetails(characterDetails:CharacterModelResult?) -> DetailsViewController {
        let view = MainRouter.detailsstoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        view.characterDetails = characterDetails
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static var detailsstoryboard: UIStoryboard{
        return UIStoryboard(name:"Details",bundle: Bundle.main)
    }
    
    static func showSearchView() -> SearchViewController {
        let view = MainRouter.searchstoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        return view
    }
    
   
    static var searchstoryboard: UIStoryboard{
        return UIStoryboard(name:"Search",bundle: Bundle.main)
    }
    
}
