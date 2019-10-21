//
//  AppDelegate.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//
//  Branch - Development

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Tint tab bar color
        UITabBar.appearance().tintColor = UIColor.init(displayP3Red: 99/255.0, green: 55/255.0, blue: 142/255.0, alpha: 1.0)
        
        //Tint Navigation Bar
        UINavigationBar.appearance().barTintColor = UIColor.init(displayP3Red: 99/255.0, green: 55/255.0, blue: 142/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = .white
        
        return true
    }
    
    
    private func setuoDefaultSettings() {
        
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "category") == nil {
            userDefaults.set(Category.topRated.rawValue, forKey: "category")
        }
        
    }
    
}

