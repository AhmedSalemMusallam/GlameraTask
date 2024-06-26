//
//  BGNavigator.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import UIKit

class BGNavigator {
    
    static func rootNavigation(newViewController: UIViewController){
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                let mySceneDelegate = topController.view.window?.windowScene?.delegate as! SceneDelegate
                mySceneDelegate.window?.rootViewController = newViewController
            }
        }
    }
    
    
    
    static func present(newViewController: UIViewController){
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(newViewController, animated: true)
            }
        }
    }
    
    static func pushNavigation(storyboardName: String , withIdentifier : String , from : UIViewController){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: withIdentifier)
        newViewController.hidesBottomBarWhenPushed = true
        from.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    

    static func presentNavigation(storyboardName: String , withIdentifier : String , from : UIViewController){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: withIdentifier)
        from.present(newViewController, animated: true, completion: nil)
        
    }
    
    static func backNavigation(from : UIViewController){
        from.navigationController?.popViewController(animated: true)
    }
    
    static func backNavigation(storyboardName: String , withIdentifier : String ,from : UIViewController){
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: withIdentifier)
        from.navigationController?.popToViewController(newViewController, animated: true)
    }
    
    static func dismissNavigation(from : UIViewController , completion : (() -> Void)?){
        from.dismiss(animated: true, completion: completion)
    }
}
