//
//  HelperMethods.swift
//  
//
//  Created by Basem El-Gendy on 3/4/18.
//  Copyright © 2018 Basem El-Gendy. All rights reserved.
//

import UIKit


class BGUtilities{
    
    // MARK: - Get App Version
    public func getVersion() -> String {
        if let AppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"){
            return AppVersion as! String
        }
        return "0.0"
        
    }
}
