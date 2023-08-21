//
//  CharacterResponseModel.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import Foundation

struct Origin: Decodable {
    let name: String
    let url: String
}
struct  CharacterResponseModel: Decodable {
    let results: [Character]
}
struct  Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Origin
    let image: String
    let episode: [String]
    
   
}
