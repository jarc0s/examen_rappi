//
//  ApiRouterTvs.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum ApiRouterTvs: URLRequestConvertible {
    
    // content Type
    static let contentType = Constants.UrlServices.Content_Type
    
    
    // Cases ApiRouterGrades
    case getTvsByType(type : TypeTvsEnum, apiKey : String)
    case getTvById(type : TypeTvsEnum, id : String, apiKey : String)
    
    public func asURLRequest() throws -> URLRequest {
        let contentType = ApiRouterTvs.contentType
        var typeMethod: TypeRequest = .POST
        
        let result: (path: String, body: String?) = {
            switch self {
            case .getTvsByType(let typeTv, let apiKey):
                typeMethod = .GET
                return ("tv/\(typeTv.apiMethods)", "?api_key=\(apiKey)")
            case .getTvById(let typeTv, let id, let apiKey):
                typeMethod = .GET
                return ("tv/\(id)/\(typeTv.apiMethods)","?api_key=\(apiKey)")
            }
        }()
        
        let request = APIUtils.createRequestMyAPI(result.path, content_Type: contentType,
                                                  body: result.body, typeRequest: typeMethod);
        
        return request as URLRequest
    }
    
}

