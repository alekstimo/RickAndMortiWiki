//
//   CharacterService.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import Foundation

struct CharacterService {

    let dataTask = BaseNetworkTask<EmptyModel, CharacterResponseModel>(
        method: .get,
        path: "character" 
        
    )

    func loadPictures(_ onResponseWasReceived: @escaping (_ result: Result<CharacterResponseModel, Error>) -> Void) {
        dataTask.perfomRequest(onResponseWasReceived)
    }

}
