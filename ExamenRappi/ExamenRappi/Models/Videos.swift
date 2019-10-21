//
//  Videos.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import ObjectMapper

public class VideosModel : Mappable, CustomStringConvertible {
    
    var id : Int?
    var results : [VideoModel]?
    
    init() {}
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        results <- map["results"]
    }
    
    public var description: String {
        return "VideosModel { id : \(String(describing: id)), results: \(String(describing: results)) }"
    }
    
}


public class VideoModel : Mappable, CustomStringConvertible {
    
    var id : String?
    var iso_639_1 : String?
    var iso_3166_1 : String?
    var key : String?
    var name : String?
    var site : String?
    var size : Int?
    var type : String?
    
    init() {}
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        iso_639_1 <- map["iso_639_1"]
        iso_3166_1 <- map["iso_3166_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        size <- map["size"]
        type <- map["type"]
    }
    
    public var description: String {
        return " VideoModel { id : \(String(describing: id)), iso_639_1 : \(String(describing: iso_639_1)), iso_3166_1 : \(String(describing: iso_3166_1)), key : \(String(describing: key)), name : \(String(describing: name)), site : \(String(describing: site)), size : \(String(describing: size)), type : \(String(describing: type)) }"
    }
}
