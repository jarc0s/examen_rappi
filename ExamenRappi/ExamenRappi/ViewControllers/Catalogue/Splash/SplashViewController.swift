//
//  SplashViewController.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import UIKit
import SwiftyGif

class SplashViewController: UIViewController {
    
    @IBOutlet weak var viewGif: UIView!
    
    let logoGifImageView = UIImageView(gifImage: UIImage(gifName: "splash.gif"), loopCount: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.viewGif.addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.topAnchor.constraint(equalTo: self.viewGif.topAnchor).isActive = true
        logoGifImageView.bottomAnchor.constraint(equalTo: self.viewGif.bottomAnchor).isActive = true
        logoGifImageView.leadingAnchor.constraint(equalTo: self.viewGif.leadingAnchor).isActive = true
        logoGifImageView.trailingAnchor.constraint(equalTo: self.viewGif.trailingAnchor).isActive = true
        
        logoGifImageView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoGifImageView.startAnimating()
    }
    
}

extension SplashViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        viewGif.isHidden = true
        self.performSegue(withIdentifier: "segueNextView", sender: nil)
    }
}

