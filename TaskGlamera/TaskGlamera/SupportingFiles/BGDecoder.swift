//
//  BGDecoder.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
struct BGDecoder {
    
    static func decode<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

}
