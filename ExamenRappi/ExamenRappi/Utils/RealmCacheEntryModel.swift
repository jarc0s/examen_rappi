//
//  RealmCacheEntryModel.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import RealmSwift

class RealmCacheEntryModel : Object {
    
    @objc dynamic var key: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var date: Date = Date()
    
    convenience init(key: String, value: String) {
        self.init()
        self.key = key
        self.value = value
    }
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
}
