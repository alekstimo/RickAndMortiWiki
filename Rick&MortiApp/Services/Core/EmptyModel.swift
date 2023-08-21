//
//  EmptyModel.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import Foundation
struct EmptyModel: Encodable {
    let page = String(Int.random(in: 1...42))
}
