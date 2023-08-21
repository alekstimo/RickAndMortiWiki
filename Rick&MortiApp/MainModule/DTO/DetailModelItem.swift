//
//  DetailModelItem.swift
//  Rick&MortiApp
//
//  Created by Кирилл Зезюков on 20.08.2023.
//

import Foundation
import UIKit

struct DetailItemModel {
    // MARK: - Internal Properties
        let imageUrlInString: String
        let name: String
        var status: String
        let species: String
        let type: String
    let gender: String
    let origin: (name: String,url: String)
    let episode: [String]

        // MARK: - Initialization
    internal init(image: String, name: String, status: String, species: String, type: String?,gender: String, origin: (String,String),episode: [String]) {
            self.imageUrlInString = image
            self.name = name
            self.status = status
            self.species = species
        if (type != nil) && !type!.isEmpty {
            self.type = type!
        } else {
            self.type = "None"
        }
            self.gender = gender
            self.origin = origin
            self.episode = episode
        }
    
    static func createDefault() -> DetailItemModel {
        .init(
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: ("Earth (C-137)", "https://rickandmortyapi.com/api/location/1"),
            episode: ["https://rickandmortyapi.com/api/episode/1","https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/3","https://rickandmortyapi.com/api/episode/4"])
             }
    
}
