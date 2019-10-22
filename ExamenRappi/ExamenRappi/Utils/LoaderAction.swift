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

struct ShowMessage {
    static func showToastMessage(message : String, type : Theme, slideFrom : SwiftMessages.PresentationStyle ) {
        SwiftMessages.show {
            let mssgView = MessageView.viewFromNib(layout: .cardView)
            // ... configure the view
            mssgView.configureTheme(type)
            mssgView.configureDropShadow()
            mssgView.configureContent(title: "", body: message)
            mssgView.button?.isHidden = true
            var config = SwiftMessages.Config()
            config.interactiveHide = true
            config.duration = .seconds(seconds: 3.5)
            config.presentationStyle = slideFrom
            
            return mssgView
        }
    }
}
