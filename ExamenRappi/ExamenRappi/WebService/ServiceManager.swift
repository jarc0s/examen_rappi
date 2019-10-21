//
//  ServiceManager.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

enum ServicesManagerResult {
    case success
    case failure(message : String)
    // for Detail response
    case failureData( errorModel : ErrorModel)
}

enum ServicesDefualtResult {
    case success
    case failure(message : String)
}

final class ServicesManager: NSObject {
    
    static var manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            Constants.UrlServices.urlBase: .disableEvaluation,
            ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    // this function validate error Data and return error string message
    static func validateErrorData(errorData: ErrorResponseModel?) -> String {
        if let modelError = errorData {
            return modelError.message
        }
        
        return Constants.GlobalMessage.WebServiceError.wsError
    }
    
    
    
    //Mark: - Movies
    
    static func getMoviesByType( _ category : Category, page: Int, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        self.manager.request(ApiRouterMovies.getMoviesByType(category: category, apiKey: Constants.Headers.ApiKey, page: page))
            .validate(statusCode: 1...501)
            .responseString { response in
                switch response.result {
                case .success:
                    print("success")
                    if let responseStr = response.result.value {
                        print(responseStr)
                        if let modelResponse = Mapper<MoviesListModel>().map(JSONString: responseStr) {
                            print("modelResponse :\(String(describing: modelResponse.results?.first?.original_title))")
                            
                            //let result = DataSourceManager.saveCacheModel(category.keyRealmValue, value: modelResponse.toJSONString() ?? "")
                            let result = DataSourceManager.addMoviesToCategory(category.keyRealmValue, value: modelResponse.toJSONString() ?? "")
                            switch result {
                            case .success:
                                completion(.success)
                            case .failure(let message):
                                completion(.failure(message: message))
                            }
                        }
                    }else {
                        completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                    }
                case .failure:
                    print("failure")
                    completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                }
        }
        
    }
    
    static func getMovieById( _ id : String, category : Category, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        self.manager.request(ApiRouterMovies.getMovieById(category: category, id: id, apiKey: Constants.Headers.ApiKey))
            .validate(statusCode: 1...501)
            .responseString { response in
                switch response.result {
                case .success:
                    print("success")
                    if let responseStr = response.result.value {
                        print(responseStr)
                        if let modelResponse = Mapper<VideosModel>().map(JSONString: responseStr){
                            let result = DataSourceManager.saveCacheModel(category.keyRealmValue + "_\(id)", value: modelResponse.toJSONString() ?? "")
                            switch result {
                            case .success:
                                completion(.success)
                            case .failure(let message):
                                completion(.failure(message: message))
                            }
                        }else{
                            completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                        }
                    }else {
                        completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                    }
                case .failure:
                    print("failure")
                    completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                }
        }
        
    }
    
    
    //MARK: - TV
    
    static func getTvsByType( _ type : TypeTvsEnum, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        self.manager.request(ApiRouterTvs.getTvsByType(type: type, apiKey: Constants.Headers.ApiKey))
            .validate(statusCode: 1...501)
            .responseString { response in
                switch response.result {
                case .success:
                    print("success")
                    if let responseStr = response.result.value {
                        print(responseStr)
                        if let modelResponse = Mapper<TvsListModel>().map(JSONString: responseStr) {
                            print("modelResponse :\(String(describing: modelResponse.results?.first?.original_name))")
                            let result = DataSourceManager.saveCacheModel(type.keyRealmValue, value: modelResponse.toJSONString() ?? "")
                            switch result {
                            case .success:
                                completion(.success)
                            case .failure(let message):
                                completion(.failure(message: message))
                            }
                        }
                    }else {
                        completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                    }
                case .failure:
                    print("failure")
                    completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                }
        }
        
    }
    
    static func getTvById( _ id : String, type : TypeTvsEnum, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        self.manager.request(ApiRouterTvs.getTvById(type: type, id: id, apiKey: Constants.Headers.ApiKey))
            .validate(statusCode: 1...501)
            .responseString { response in
                switch response.result {
                case .success:
                    print("success")
                    if let responseStr = response.result.value {
                        print(responseStr)
                        if let modelResponse = Mapper<VideosModel>().map(JSONString: responseStr){
                            let result = DataSourceManager.saveCacheModel(type.keyRealmValue + "_\(id)", value: modelResponse.toJSONString() ?? "")
                            switch result {
                            case .success:
                                completion(.success)
                            case .failure(let message):
                                completion(.failure(message: message))
                            }
                        }else{
                            completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                        }
                    }else {
                        completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                    }
                case .failure:
                    print("failure")
                    completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                }
        }
        
    }
    
}
