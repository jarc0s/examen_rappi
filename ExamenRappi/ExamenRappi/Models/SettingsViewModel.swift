//
//  SettingsViewModel.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    case popular
    case topRated
    case upcoming
    case videos
}


struct SettingsViewModel {
    let categories = Category.allCases
    private var _selectedCategory: Category = Category.topRated
    
    var selectedCategory: Category {
        get {
            let userDefaults = UserDefaults.standard
            
            if let value = userDefaults.value(forKey: "category") as? String {
                return Category(rawValue: value)!
            }
            return _selectedCategory
        }
        
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "category")
        }
    }
}

extension Category {
    
    var displayName: String {
        get {
            switch self {
            case .popular:
                return "Popular"
            case .topRated:
                return "Top Rated"
            case .upcoming:
                return "Upcoming"
            case .videos:
                return "Videos"
            }
        }
    }
    
    var apiMethods : String {
        
        get {
            switch self {
            case .popular:
                return Constants.UrlMethods.popular
            case .topRated:
                return Constants.UrlMethods.topRated
            case .upcoming:
                return Constants.UrlMethods.upcoming
            case .videos:
                return Constants.UrlMethods.videos
            }
        }
    }
    
    var keyRealmValue : String {
        get {
            switch self {
            case .popular:
                return Constants.KeysRealmObject.RealmMoviePopular
            case .topRated:
                return Constants.KeysRealmObject.RealmMovieTopRated
            case .upcoming:
                return Constants.KeysRealmObject.RealmMovieUpcoming
            case .videos:
                return Constants.KeysRealmObject.RealmMovieVideoId
            }
        }
    }
}
