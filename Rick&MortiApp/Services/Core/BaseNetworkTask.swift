//
//  BaseNetworkTask.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//


import Foundation
var isLoadedSucces = false
struct BaseNetworkTask<AbstractInput: Encodable, AbstractOutput: Decodable>: NetworkTask {
    var completedURL: URL?
    
    
    //MARK: - NetworkTask
    typealias Input = AbstractInput
    typealias Output = AbstractOutput
    
    var baseURL: URL? {
        URL(string: "https://rickandmortyapi.com/api")
    }
    
    let path: String
    let method: NetworkMethod
    let session: URLSession = URLSession(configuration: .default)
    var urlCache: URLCache {
        URLCache.shared
    }
    
    
    //MARK: - Initilization
    
    init( method: NetworkMethod, path: String) {
        self.path = path
        self.method = method
    }
    
    //MARK: - NetworkTask
    
    func perfomRequest(_ input: AbstractInput, _ onResponseReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        
        do {
            
            let request = try getRequest(with: input)
           
            isLoadedSucces = false
            session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    onResponseReceived(.failure(error))
                    
                } else if let data = data {
                    
                    do {
                       
                        let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                        onResponseReceived(.success(mappedModel))
                        isLoadedSucces = true
                            
                    } catch {
                        print(error)
                        onResponseReceived(.failure(error))
                        
                    }
                    
                } else {
                    onResponseReceived(.failure(NetworkTaskErorr.unknownError))
                   
                }
                
            }
            
            .resume()
            if(isLoadedSucces) {
                return
            }
            
       
        } catch {
            onResponseReceived(.failure(error))
            isLoadedSucces = false
        }
        
    }
        
}

//MARK: - Empty Model

extension BaseNetworkTask where Input == EmptyModel {
    
    func perfomRequest(_ onResponseReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        perfomRequest(EmptyModel(), onResponseReceived)
    }
    
}

//MARK: - Cache //Нужен ли?

private extension BaseNetworkTask {
    
    func getCachedResponseFromCache( by request: URLRequest) throws -> CachedURLResponse? {
        
        return urlCache.cachedResponse(for: request)
    }
    
    func saveResponseToCache(_ response: URLResponse?, cachedData: Data?, by request: URLRequest) {
        
        guard let response = response, let cachedData = cachedData else {
            return
        }
        let cachedResponse = CachedURLResponse(response: response,data: cachedData)
        urlCache.storeCachedResponse(cachedResponse, for: request)

        
    }
    
}

//MARK: - PrivateNethods

private extension BaseNetworkTask {
    enum NetworkTaskErorr: Error {
        case unknownError
        case urlWasNotFound
        case urlComponentWasNotCreated
        case parametersIsNotValidJSONObject
    }
    func getRequest(with parameters: AbstractInput) throws -> URLRequest {
        guard let url = comlitedURL else {
            throw NetworkTaskErorr.urlWasNotFound
        }
       
        var request: URLRequest
        switch method {
        case .get:
            let  newUrl = try getUrlWithQueryParameters(for: url, parameters: parameters)
            request = URLRequest(url: newUrl)
//        case .post:
//            request = URLRequest(url: url)
//            request.httpBody = try getParametersforBody(from: parameters)
        }
        request.httpMethod = method.method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func getParametersforBody(from encodebleParameters: AbstractInput) throws -> Data {
        return try JSONEncoder().encode(encodebleParameters)
    }
    
    func getUrlWithQueryParameters(for url: URL, parameters: AbstractInput) throws -> URL {
        guard var urlCompinents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkTaskErorr.urlComponentWasNotCreated
        }
        let parametersInDataRepresentation = try JSONEncoder().encode(parameters)
        let parametersInDictionaryRepresentation = try  JSONSerialization.jsonObject(with: parametersInDataRepresentation)
        
        guard let parametersInDictionaryRepresentation = parametersInDictionaryRepresentation as? [String: Any] else {
            throw NetworkTaskErorr.parametersIsNotValidJSONObject
        }
        
        let queryItems = parametersInDictionaryRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
            
        }
        if !queryItems.isEmpty {
            
            urlCompinents.queryItems = queryItems
            
        }
        
        guard let newUrlWithquery = urlCompinents.url else {
            throw NetworkTaskErorr.urlWasNotFound
        }
       
        return newUrlWithquery
    }
    
    
    
}

