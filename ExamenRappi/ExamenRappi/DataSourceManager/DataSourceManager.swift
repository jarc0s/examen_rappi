//
//  DataSourceManager.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import ObjectMapper

final class DataSourceManager {
    // Get String model of Realm
    static func requestDataFromCache(realName: String, cacheManagerName: String) -> String? {
        var stringValue: String?
        //print("Reading Data from cache")
        
        if let cacheManager = try? RealmCacheManager(realmName: cacheManagerName ) {
            if let cacheObject = cacheManager.get(realName) {
                stringValue = cacheObject.value
            }
        }
        else {
            print("Data NOT read")
        }
        
        return stringValue
    }
    
    // Save String model of Realm
    static func saveCacheModel(_ urlString: String, value: String) -> ManagerResult {
        print("Saving CacheModel to cache")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.add(urlString, value: value)
            print("CacheModel saved to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    // Remove Entity from REalm
    static func removeCacheModel(_ urlString: String) -> ManagerResult {
        print("Saving CacheModel to cache")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.remove(urlString)
            print("CacheModel delete to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    // Remove All DB
    static func removeAllData() -> ManagerResult {
        print("Remove AllData from DB")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.removeAll()
            print("CacheModel delete All DB to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    static func addMoviesToCategory(_ urlString: String, value: String) -> ManagerResult {
        var currentData: [ResultMovieModel] = [ResultMovieModel]()
        let settingsVM = SettingsViewModel()
        currentData.append(contentsOf: getMoviesByType(category: settingsVM.selectedCategory))
        
        guard let modelResponse = Mapper<MoviesListModel>().map(JSONString: value) else {
            return .failure(message: "Error al guardar Dato en DB")
        }
        if let results = modelResponse.results {
            currentData.append(contentsOf: results)
        }
        modelResponse.results = currentData
        
        //Update current Page
        if let lastPage = modelResponse.page {
            var settingsVM = SettingsViewModel()
            settingsVM.currentPage = lastPage + 1
        }
        
        return saveCacheModel(urlString, value: modelResponse.toJSONString() ?? "")
    }
    
    static func getMoviesByType(category: Category) -> [ResultMovieModel] {
        guard let userDataJson = DataSourceManager.requestDataFromCache(realName: category.keyRealmValue, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return [ResultMovieModel]()
        }
        
        guard let model: MoviesListModel  = Mapper<MoviesListModel>().map(JSONString: userDataJson) else {
            return [ResultMovieModel]()
        }
        
        return model.results ?? [ResultMovieModel]()
    }
    
    static func getMovieVideosById(id: String, category: Category) -> VideosModel{
        guard let userDataJson = DataSourceManager.requestDataFromCache(realName: category.keyRealmValue + "_\(id)", cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return VideosModel()
        }
        
        guard let model: VideosModel = Mapper<VideosModel>().map(JSONString: userDataJson) else {
            return VideosModel()
        }
        
        return model
    }
    
    static func getTvsByType(typeTv: TypeTvsEnum) -> [ResultTvModel] {
        guard let userDataJson = DataSourceManager.requestDataFromCache(realName: typeTv.keyRealmValue, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return [ResultTvModel]()
        }
        
        guard let model: TvsListModel  = Mapper<TvsListModel>().map(JSONString: userDataJson) else {
            return [ResultTvModel]()
        }
        
        return model.results ?? [ResultTvModel]()
    }
    
    static func getTvVideosById(id: String, typeTv: TypeTvsEnum) -> VideosModel{
        guard let userDataJson = DataSourceManager.requestDataFromCache(realName: typeTv.keyRealmValue + "_\(id)", cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return VideosModel()
        }
        
        guard let model: VideosModel = Mapper<VideosModel>().map(JSONString: userDataJson) else {
            return VideosModel()
        }
        
        return model
    }
    
    static func getVideoTrailerIdByMovieId(id: String, category: Category) -> String{
        
        let model = self.getMovieVideosById(id: id, category: category)
        
        if let videos = model.results {
            let video = videos.filter({ $0.type == "Trailer" })
            return video.first?.key ?? ""
        }
        
        return ""
    }
    
    
    static func getVideoTrailerIdByTvId(id: String, typeTv: TypeTvsEnum) -> String{
        
        let model = self.getTvVideosById(id: id, typeTv: typeTv)
        
        if let videos = model.results {
            let video = videos.filter({ $0.type == "Trailer" })
            return video.first?.key ?? ""
        }
        
        return ""
    }
    
}
