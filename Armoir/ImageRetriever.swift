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
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    @discardableResult
    public func save(image: UIImage) -> String? {
        let fileName = "SavedImage" + String(numImgSaved)
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }

    public func load(fileName: String) -> String {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            print("TESTINGGG " + fileURL.absoluteString)
            return fileURL.absoluteString
//            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return ""
    }
}
