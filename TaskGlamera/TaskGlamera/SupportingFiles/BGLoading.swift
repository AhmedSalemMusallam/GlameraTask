//
//  BGLoading.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import UIKit
import Lottie

class BGLoading: NSObject {
    
     var overlayView: UIView!
     var animationView: LottieAnimationView?
    
    func dismissLoading(){
        DispatchQueue.main.async{ [self] in
              animationView?.stop()
              animationView?.removeFromSuperview()
             guard  overlayView != nil else {return}
              overlayView.removeFromSuperview()
        }
    }
 
    private func currentViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }else{
            return nil
        }

    }
     func showLoading(){
        dismissLoading()
         DispatchQueue.main.async{ [self] in
            
             overlayView = UIView(frame: UIScreen.main.bounds)
             overlayView.tag = 24111994
             overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            guard let vc =  currentViewController() else {return}
            vc.view.addSubview( overlayView)
             animationView = .init(name: "global_loading")
             animationView!.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
             animationView?.center =  overlayView.center
             animationView!.contentMode = .scaleAspectFit
             animationView!.loopMode = .loop
             animationView!.animationSpeed = 1
             overlayView.addSubview( animationView!)
             animationView!.play()
        }
    }
    
    

}


