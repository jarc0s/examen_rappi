//
//  Results.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import ObjectMapper

public class ResultMovieModel : Mappable, CustomStringConvertible {
    
    var vote_count : Int?
    var id : Int?
    var video : Bool?
    var vote_average : Double?
    var title : String?
    var popularity : Double?
    var poster_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : [Int]?
    var backdrop_path : String?
    var adult : Bool?
    var overview : String?
    var release_date : String?
    
    init() {}
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        vote_count <- map["vote_count"]
        id <- map["id"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        title <- map["title"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        genre_ids <- map["genre_ids"]
        backdrop_path <- map["backdrop_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        release_date <- map["release_date"]
    }
    
    public var description: String {
        return "ResultModel : {vote_count : \(String(describing: vote_count)), id : \(String(describing: id)), video : \(String(describing: video)), vote_average : \(String(describing: vote_average)), title : \(String(describing: title)), popularity : \(String(describing: popularity)), poster_path : \(String(describing: poster_path)), original_language : \(String(describing: original_language)), original_title : \(String(describing: original_title)), genre_ids : \(String(describing: genre_ids)), backdrop_path : \(String(describing: backdrop_path)), adult : \(String(describing: adult)), overview : \(String(describing: overview)), release_date : \(String(describing: release_date))}"
    }
    
}
