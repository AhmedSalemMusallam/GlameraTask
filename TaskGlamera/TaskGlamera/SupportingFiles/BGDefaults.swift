//
//  BGDefaults.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import MOLH
import UIKit

protocol BGDefultsDelegate {
    func appStoreLink() -> String
    func appLanguage() -> String
    func changeAppLang(language: String)
    func getAppLang()-> String
    func getBoldFont(size:CGFloat) -> UIFont
    func getRegularFont(size:CGFloat) -> UIFont
    func getMediumFont(size:CGFloat) -> UIFont
    func getLightFont(size:CGFloat) -> UIFont
}
struct BGDefults: BGDefultsDelegate {
    static let manger : BGDefultsDelegate = BGDefults()
    
    func appStoreLink() -> String {
        return "https://apps.apple.com/"
    }
    
    func appLanguage() -> String {
        return MOLHLanguage.currentAppleLanguage()
    }
    
    func changeAppLang(language: String) {
        MOLH.setLanguageTo(language)
        MOLH.reset(transition: .transitionCrossDissolve)
    }
    
    func getAppLang()-> String {
        MOLHLanguage.currentLocaleIdentifier()
    }
    
    func getBoldFont(size:CGFloat) -> UIFont
    {
        return  UIFont(name: "DINNextLTArabic-Bold", size: size)!
    }
    func getRegularFont(size:CGFloat) -> UIFont
    {
        return  UIFont(name: "DINNextLTArabic-Regular", size: size)!
    }
    func getMediumFont(size:CGFloat) -> UIFont
    {
        return  UIFont(name: "DINNextLTArabic-Medium", size: size)!
    }
    func getLightFont(size:CGFloat) -> UIFont
    {
        return  UIFont(name: "DINNEXTLTARABIC-LIGHT", size: size)!
    }
}
