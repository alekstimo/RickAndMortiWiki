//
//  MainModel.swift
//  Rick&MortiApp
//
//  Created by Кирилл Зезюков on 20.08.2023.
//

import SwiftUI

final class MainModel {
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Properties
    
    let characterService = CharacterService()
    var items: [DetailItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    //MARK: - Methods
    
    func loadPosts()  {
        
        characterService.loadPictures { [weak self] result in
                switch result {
                case .success(let pictures):
                    self?.items = pictures.results.map { pictureModel in
                        DetailItemModel(image: pictureModel.image,
                                        name: pictureModel.name,
                                        status: pictureModel.status,
                                        species: pictureModel.species,
                                        type: pictureModel.type,
                                        gender: pictureModel.gender,
                                        origin: (pictureModel.origin.name,pictureModel.origin.url),
                                        episode: pictureModel.episode
                            
                        )
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                    
                    // TODO: - Implement error state there
                   
                }
            }
        
        }
    
    func reloadData()  {
        loadPosts()
    }
    
}
