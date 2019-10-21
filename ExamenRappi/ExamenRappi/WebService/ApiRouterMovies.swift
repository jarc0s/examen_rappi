//
//  ApiRouterMovies.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum ApiRouterMovies: URLRequestConvertible {
    
    // content Type
    static let contentType = Constants.UrlServices.Content_Type
    
    
    // Cases ApiRouterGrades
    case getMoviesByType(category : Category, apiKey : String)
    case getMovieById(category : Category, id : String, apiKey : String)
    
    public func asURLRequest() throws -> URLRequest {
        let contentType = ApiRouterMovies.contentType
        var typeMethod: TypeRequest = .POST
        
        let result: (path: String, body: String?) = {
            switch self {
            case .getMoviesByType(let category, let apiKey):
                typeMethod = .GET
                return ("movie/\(category.apiMethods)", "?api_key=\(apiKey)")
            case .getMovieById(let category, let id, let apiKey):
                typeMethod = .GET
                return ("movie/\(id)/\(category.apiMethods)","?api_key=\(apiKey)")
            }
        }()
        
        let request = APIUtils.createRequestMyAPI(result.path, content_Type: contentType,
                                                  body: result.body, typeRequest: typeMethod);
        
        return request as URLRequest
    }
    
}
