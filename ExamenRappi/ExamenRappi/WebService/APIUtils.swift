//
//  APIUtils.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AdSupport

class APIUtils {
    
    /* Creates a correctly formatted NSMutableURLRequest for use with Alamofire */
    static func createRequestMyAPI(_ path: String, content_Type: String, body: String?, typeRequest: TypeRequest, authorization : String? = nil, urlBase : String? = nil) -> NSMutableURLRequest {
        //no country code, no dice
        //url building
        let _urlBase = urlBase != nil ? urlBase! : Constants.UrlServices.urlBase
        let apiURL = URL(string: _urlBase)!
        let mutableURLRequest = NSMutableURLRequest(url: apiURL.appendingPathComponent(path))
        
        //set method and content type
        mutableURLRequest.httpMethod = typeRequest.rawValue
        mutableURLRequest.setValue(content_Type, forHTTPHeaderField: "Content-Type")
        
        if content_Type == Constants.UrlServices.Content_Type {
            mutableURLRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        }
        
        //set body
        switch typeRequest {
        case .POST:
            if let dataBody = body {
                print("\(dataBody)")
                mutableURLRequest.httpBody = dataBody.data(using: String.Encoding.utf8)
            }
            else {
                mutableURLRequest.httpBody = "{}".data(using: String.Encoding.utf8)
            }
        case .GET, .DELETE:
            print("sendrequest get/delete")
            guard let urlString = mutableURLRequest.url?.absoluteString else {
                return mutableURLRequest
            }
            
            let urlComplete = urlString + "\(body ?? "")"
            print("urlComplete: \(urlComplete)")
            mutableURLRequest.url = URL(string: urlComplete)
        case .PUT:
            print("sendrequest Put")
            if let dataBody = body {
                mutableURLRequest.httpBody = dataBody.data(using: String.Encoding.utf8)
            }
            else {
                mutableURLRequest.httpBody = "{}".data(using: String.Encoding.utf8)
            }
        }
        
        
        return mutableURLRequest
    }
    
    static func checkForCriticalError(_ response: HTTPURLResponse) -> (Bool, String?) {
        if response.statusCode == 401 {
            return (true, "Non-authenticated user, please log in again.")
        }
        else if response.statusCode == 403 {
            return (true, "Resource cannot be accessed by this client.")
        }
        else if response.statusCode == 400 {
            return (true, "Bad request sent by the application")
        }
        else {
            return (false, nil)
        }
    }
    
}
