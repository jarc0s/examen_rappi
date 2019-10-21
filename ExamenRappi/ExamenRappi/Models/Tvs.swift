//
//  Tvs.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import ObjectMapper

public class TvsListModel : Mappable, CustomStringConvertible {
    
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [ResultTvModel]?
    
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

public enum TypeTvsEnum : String {
    
    case Popular
    case TopRated
    case Videos
    
    
    var apiMethods : String {
        switch self {
        case .Popular:
            return Constants.UrlMethods.popular
        case .TopRated:
            return Constants.UrlMethods.topRated
        case .Videos:
            return Constants.UrlMethods.videos
        }
    }
    
    var keyRealmValue : String {
        switch self {
        case .Popular:
            return Constants.KeysRealmObject.RealmTvPopular
        case .TopRated:
            return Constants.KeysRealmObject.RealmTvTopRated
        case .Videos:
            return Constants.KeysRealmObject.RealmTvVideos
        }
    }
    
    var title : String {
        switch self {
        case .Popular:
            return "Popular Tvs"
        case .TopRated:
            return "Top Rated Tvs"
        case .Videos:
            return "Video"
        }
    }
}
