//
//  CustomExtensions.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/3/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    func reportError(withText: String, withDuration: Double)
    {
        //        let errorWindow = UIView()
        
        //        errorWindow.layer.backgroundColor = UIColor.green.cgColor
        //        self.view.addSubview(errorWindow)
        let fadeInDuration = 0.3
        let fadeOutDuration = 0.3
        
        let errorTextView = UILabel(frame: CGRect(x: self.layer.bounds.width/6, y: self.layer.bounds.height/3, width: self.layer.bounds.width/1.5, height:self.layer.bounds.height/4))
        
        errorTextView.numberOfLines = 0
        errorTextView.layer.backgroundColor = UIColor.red.cgColor
        errorTextView.layer.borderWidth = 2
        errorTextView.layer.cornerRadius = errorTextView.layer.bounds.width/20
        
        //fix attributes later. Change text to white color
        //        let attributes : [NSAttributedStringKey : Any] = [
        //            NSForegroundColorAttributeName : UIColor.red,
        //            NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
        //            NSStrokeWidthAttributeName : 3.0
        //        ]
        //        let attrText = NSAttributedString(string: withText, attributes: attributes)
        
        errorTextView.contentMode = .center
        errorTextView.textAlignment = .center
        errorTextView.text = withText
        
        
        //reduce opacity to 0
        errorTextView.layer.opacity = 0
        
        //add to parent view
        self.addSubview(errorTextView)
        
        //animate window into view
        UIView.animate(withDuration: fadeInDuration, delay: 0, options: .curveEaseIn, animations: {
            errorTextView.layer.opacity = 1
            
        }, completion: {
            isDone in
            
            //animate window out of view
            UIView.animate(withDuration: fadeOutDuration, delay: withDuration, options: .curveEaseOut, animations: {
                
                errorTextView.layer.opacity = 0
                
            }, completion: {
                isDone in
                errorTextView.removeFromSuperview()
            })
            
        })
        
        self.addSubview(errorTextView)
        
    }
    
    
    
  
}


extension UIImage {
    
    
    //
    // Convert UIImage to a base64 representation
    //
    func convertImageToBase64() -> String {
        let imageData = self.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
   
}

extension String {
    
    //
    // Convert a base64 representation to a UIImage
    //
    func convertBase64ToImage() -> UIImage? {
        let imageData = Data(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)
    }
}
