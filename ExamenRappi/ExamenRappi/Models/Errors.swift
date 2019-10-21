//
//  Errors.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import ObjectMapper

public class ErrorsModel : Mappable, CustomStringConvertible {
    
    var mError : [String]?
    var statusCode : Int?
    var statusMessage : String?
    var success : Bool?
    
    init() {}
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        mError <- map["mError"]
        statusCode <- map["statusCode"]
        statusMessage <- map["statusMessage"]
        success <- map["success"]
    }
    
    public var description: String {
        return "ErrorsModel: {mError : \(String(describing: mError)), statusCode : \(String(describing: statusCode)), statusMessage : \(String(describing: statusMessage)), success : \(String(describing: success)) } "
    }
    
    
}
