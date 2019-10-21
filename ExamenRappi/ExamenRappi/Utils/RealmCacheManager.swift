//
//  RealmCacheManager.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCacheManager {
    
    var realm: Realm! = nil
    
    init(realmName: String) throws {
        self.realm = try RealmHelper.getRealmNamed(realmName)
    }
    
    func add(_ key: String, value: String) {
        let cacheObject = RealmCacheEntryModel(key: key, value: value)
        
        try! self.realm.write({
            self.realm.add(cacheObject, update: true)
        })
    }
    
    func get(_ key: String) -> RealmCacheEntryModel? {
        let list = self.realm.objects(RealmCacheEntryModel.self).filter("key == '\(key)'")
        
        if !list.isEmpty {
            return list.first
        }
        
        return nil
    }
    
    func get(_ key: String, timeout: Int) -> RealmCacheEntryModel? {
        //if cache object is defined and valid (within time limite) then use it
        if let cacheObject = get(key) {
            let objectDate = cacheObject.date
            
            if Date().minutesFrom(objectDate) <= timeout {
                //stil valid, return it
                print("Returning value for key \(key) from cache - time difference is \(Date().minutesFrom(objectDate))")
                return cacheObject
            }
            else {
                print("Cache is expired \(objectDate), " +
                    "timeout \(timeout)," +
                    "now \(Date())")
            }
        }
        
        return nil
    }
    
    func remove(_ key: String) {
        if let object = get(key) {
            try! self.realm.write({
                self.realm.delete(object)
            })
        }
    }
    
    func removeAll() {
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
}
