//
//  Movies.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import ObjectMapper

public class MoviesListModel : Mappable, CustomStringConvertible {
    
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [ResultMovieModel]?
    
    init() {}
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        page <- map["page"]
        total_results <- map["total_results"]
        total_pages <- map["total_pages"]
        results <- map["results"]
    }
    
    public var description: String {
        return "MoviesListModel : {page : \(String(describing: page)), total_results : \(String(describing: total_results)), total_pages : \(String(describing: total_pages)), results : \(String(describing: results)) }"
    }
}

public struct ErrorModel {
    var errorcode: String?
    
    public init (errorcode : String?) {
        self.errorcode = errorcode
    }
}


public class ErrorResponseModel: Mappable, CustomStringConvertible {
    var message:    String   = ""
    var logid:      Int      = 0
    var detail:     String   = ""
    
    init() { }
    
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        message <- map["message"]
        logid <- map["logid"]
        detail <- map["detail"]
    }
    
    public var description: String {
        return "ErrorResponseModel: {\(message), \(logid), \(detail)}"
    }
    
}
