//
//  RealmHelper.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    //creates realm with a given name
    static func getRealmNamed(_ realmName: String) throws -> Realm {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        //let realmPath = NSURL.fileURLWithPath(config.path!)
        let realmPath = config.fileURL!
            .deletingLastPathComponent().appendingPathComponent("\(realmName).realm")
        //.path
        
        // create realm for the first time in this thread
        // so cannot use try!
        let newRealm = try Realm(fileURL: realmPath)
        
        return newRealm
    }
    
    //delete realm file
    static func removeRealm(_ pathName: String) {
        let fileManager:FileManager = FileManager.default
        
        _ = try? fileManager.removeItem(atPath: pathName)
    }
}
