//
//  ImageRetriever.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/8/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import Foundation
import UIKit

var numImgSaved = 0

class ImageRetriever {
    /*var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }*/

    @discardableResult
    public func save(image: UIImage) -> String? {
        let fileName = "SavedImage" + String(numImgSaved)
        let fileURL = documentsURL.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            print("saved image file: " + fileURL.absoluteString)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }

    public func loadStr(fileName: String) -> String {
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.absoluteString
    }
    
    public func loadImg(fileURL: URL) -> UIImage? {
        //let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    public func fileIsURL(fileName: String) -> Bool {
        let firstFourLetters = fileName.prefix(4)
        //print(firstFourLetters)
        if (firstFourLetters == "file") {
            return true
        }
        return false
    }
}
