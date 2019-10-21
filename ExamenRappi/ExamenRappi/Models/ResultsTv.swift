//
//  ResultsTv.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

public class ResultTvModel : Mappable, CustomStringConvertible {
    
    var original_name : String?
    var genre_ids : [Int]?
    var name : String?
    var popularity : Double?
    var origin_country : [String]?
    var vote_count : Int?
    var first_air_date : String?
    var backdrop_path : String?
    var original_language : String?
    var id : Int?
    var vote_average : Double?
    var overview : String?
    var poster_path : String?
    
    
    init() {}
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        original_name <- map["original_name"]
        genre_ids <- map["genre_ids"]
        name <- map["name"]
        popularity <- map["popularity"]
        origin_country <- map["origin_country"]
        vote_count <- map["vote_count"]
        first_air_date <- map["first_air_date"]
        backdrop_path <- map["backdrop_path"]
        original_language <- map["original_language"]
        id <- map["id"]
        vote_average <- map["vote_average"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
    }
    
    public var description: String {
        return "ResultTvModel: {original_name : \(String(describing:original_name)), genre_ids : \(String(describing:genre_ids)), name : \(String(describing:name)), popularity : \(String(describing:popularity)), origin_country : \(String(describing:origin_country)), vote_count : \(String(describing:vote_count)), first_air_date : \(String(describing:first_air_date)), backdrop_path : \(String(describing:backdrop_path)), original_language : \(String(describing:original_language)), id : \(String(describing:id)), vote_average : \(String(describing:vote_average)), overview : \(String(describing:overview)), poster_path : \(String(describing:poster_path)) }"
    }
    
}
