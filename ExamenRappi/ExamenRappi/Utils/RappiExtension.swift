//
//  RappiExtension.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

//MARK: - UIButton
extension UIButton {
    func makeAnimation( color : UIColor ){
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = color.cgColor
        colorAnimation.duration = 0.5
        self.layer.add(colorAnimation, forKey: "ColorPulse")
    }
}


extension UIImageView {
    func getImageWithUrl(url: String, cache: Bool? = nil, applyMaskColor : UIColor? = nil) {
        
        if let c = cache, c == true {
            self.af_setImage(withURL: URL(string: url)!, placeholderImage: nil, filter: nil, progress: nil, runImageTransitionIfCached: true) { (response) in
                if let image = response.result.value {
                    if let color = applyMaskColor {
                        self.image = image.maskWithColor(color: color)
                    }else {
                        self.image = image
                    }
                }
            }
        }
        else {
            Alamofire.request(url).responseImage { response in
                if let image = response.result.value {
                    if let color = applyMaskColor {
                        self.image = image.maskWithColor(color: color)
                    }else {
                        self.image = image
                    }
                }
            }
        }
    }
    
    func applyBlurFilterToImage() {
        if let imageNormal = self.image {
            self.image = imageNormal.getImageWithBlurFilter()
        }
    }
    
    func applySaturateColorToImage( color : UIColor) {
        if let imageNormal = self.image {
            if let imageSaturate = imageNormal.setImageSaturateToColor(color: color){
                self.image = imageSaturate
            }
        }
    }
    
    func applyMaskColor ( color : UIColor ){
        if let imageNormal = self.image {
            self.image = imageNormal.maskWithColor(color: color)
        }
    }
    
    
}

extension UIImage {
    
    func getImageWithBlurFilter() -> UIImage {
        
        let inputCIImage = CIImage(image: self)
        
        //Blur Efect
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(inputCIImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(8, forKey: kCIInputRadiusKey)
        
        let outputImage = blurFilter?.outputImage
        
        return UIImage(ciImage: outputImage!)
    }
    
    func setImageSaturateToColor( color : UIColor ) -> UIImage?{
        
        guard let currentCGImage = self.cgImage else { return nil }
        let currentCIImage = CIImage(cgImage: currentCGImage)
        
        let filter = CIFilter(name: "CIColor")
        filter?.setValue(currentCIImage, forKey: "inputImage")
        
        filter?.setValue(color.ciColor, forKey: "inputColor")
        
        filter?.setValue(0.8, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return nil }
        
        let context = CIContext()
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
        }
        
        return nil
        
    }
    
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

//MARK : UITableView
extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}
