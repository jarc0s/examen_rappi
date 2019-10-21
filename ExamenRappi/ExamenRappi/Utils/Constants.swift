//
//  Constants.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation

struct Constants {
    
    struct UrlServices {
        static let urlBase = "https://api.themoviedb.org/3/"
        static let Content_Type = "application/json; charset=utf-8"
        static let ImagePath = "https://image.tmdb.org/t/p/w500"
    }
    
    struct UrlMethods {
        static let popular = "popular"
        static let topRated = "top_rated"
        static let upcoming = "upcoming"
        static let videos = "videos"
    }
    
    struct Headers {
        static let ApiKey = "ba4dbd670c9386f7dbc9ed8cf9613894"
    }
    
    struct GlobalMessage {
        struct Error {
            static let errorMessage = "Inténtalo en un momento."
            static let errorAvailable = "Servicio no disponible"
        }
        
        struct WebServiceError {
            static let wsError = "Inténtalo en un momento."
            static let wsSendEmilOk = "E-mail enviado"
            static let wsSendEmilError = "Error al enviar E-mail"
            static let wsSendSMSOk = "Mensaje enviado"
            static let wsSendSMSError = "Error al enviar mensaje"
            static let wsServicioNo = "Servicio no disponible"
        }
    }
    
    struct KeysRealmObject {
        static let CacheManagerRealm = "CacheManager"
        
        static let RealmMoviePopular = "MoviesPopular"
        static let RealmMovieTopRated = "MoviesTopRated"
        static let RealmMovieUpcoming = "MoviewUpcoming"
        static let RealmMovieVideoId = "MovieVideoId"
        static let RealmTvPopular = "TvsPopular"
        static let RealmTvTopRated = "TvsTopRated"
        static let RealmTvVideos = "TvsVideos"
        
    }
    
    
}

enum TypeContentList : String {
    case movies
    case tvs
}


enum TypeRequest: String {
    case POST
    case GET
    case DELETE
    case PUT
}


// MARK: Enums App
enum ManagerResult {
    case success
    case failure(message:String)
}
