//
//  EpisodeResponseModel.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import Foundation


struct  EpisodeResponseModel: Decodable {
    let name: String
    let air_date: String
    let episode: String
}
