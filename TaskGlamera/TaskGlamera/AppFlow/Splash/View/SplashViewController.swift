//
//  SplashViewController.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import UIKit

class SplashViewController: UIViewController {

    //outlets
    @IBOutlet weak var LogoBGView: UIView!
    
    //variables
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyleForScreen()
        setAnimationForLogo()
        
  
        navigateToMainView()
    }

    func setStyleForScreen()
    {
        LogoBGView.layer.cornerRadius = 40
        LogoBGView.clipsToBounds = true
    }
}


//animation
extension SplashViewController
{
    func setAnimationForLogo()
    {
        UIView.animate(withDuration: 0.5, animations: {
                    // Set the desired scale (e.g., 1.5 for 150% scale)
                    self.LogoBGView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }) { _ in
                    // Optional: You can add additional code to be executed after the animation completes
                    // For example, you might want to reset the scale to 1.0
                    UIView.animate(withDuration: 0.5) {
                        self.LogoBGView.transform = CGAffineTransform.identity
                    }
                }
    }
}

//navigation
extension SplashViewController
{
    private func navigateToMainView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            BGNavigator.rootNavigation(newViewController:  MainRouter.createCharacterModule())
            
          
            
        }
    }
}
