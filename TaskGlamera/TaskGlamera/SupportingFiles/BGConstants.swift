//
//  BGConstants.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
struct BGConstants {
    // MARK: - Network response status
    static var success:Int {return 200}
    static var added:Int {return 202}
    static var failed:Int {return 400}
    static var created:Int {return 201}
    static var unprocessableEntity : Int {return 401}
    static var notActive : Int {return 405}
    static var unauthenticated : Int {return 403}
    static var notAcceptable : Int {return 422}
    static var notFound : Int {return 404}
    static var userType : Int {return 1}
    static var mapKey : String {return "AIzaSyDLeBgEzU5MNHomDdwOtgbC2NCqlrfIrMI"}
    static var mapStyle : String {return "&zoom=11&style=feature:transit.line%7Cvisibility:simplified%7Ccolor:0xbababa&style=feature:road.highway%7Celement:labels.text.stroke%7Cvisibility:on%7Ccolor:0xb06eba&style=feature:road.highway%7Celement:labels.text.fill%7Cvisibility:on%7Ccolor:0xffffff&maptype=terrain&scale=2&size=400x400&"}
  
    
    
}
