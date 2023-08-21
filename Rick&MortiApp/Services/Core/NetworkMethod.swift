//
//  NetworkMethod.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import Foundation

enum NetworkMethod: String {
    
    case get
}
extension NetworkMethod {
    
    var method: String {
        rawValue.uppercased()
    }
}
