//
//  LoaderAction.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import SwiftMessages
import NVActivityIndicatorView

struct ActivityIndicator {
    
    static func showLoader(_ message: String? = nil) {
        let msgLoader = message ?? ""
        let activityData = ActivityData(message: msgLoader, type: .ballGridPulse)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    static func hiddenLoader(_ message: String?, closure: @escaping (Bool) -> Void) {
        
        if let textMessage = message {
            self.changeTextLoader(textMessage)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            closure(true)
        }
    }
    
    static func changeTextLoader(_ message: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
        }
    }
}
