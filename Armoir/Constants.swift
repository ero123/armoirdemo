//
//  Constants.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/3/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import Foundation
import UIKit


struct Const {
   public static let db = database()
}


struct clothingInfoKeys {
    public let sizeForTopKey = "sizeForTop"
    public let sizeForBottomKey = "sizeForBottom"
}

//var encodedImage = "" {
//
//    didSet{
//        if(encodedImage.convertBase64ToImage() == nil)
//        {
//            print("*** THIS IS NOT ANO IMAGE!!!! ***")
//        }
//    }
//}

struct createUserInDirectoryKeys {
    public let emailKey = "email"
    public let usernameKey = "username"
    public let bioKey = "bio"
    public let addressKey = "address"
    public let encodedImageKey = "encodedImageKey"
    public let clothingInfoKey = "clothingInfoKey"
    public let clothingInfo = clothingInfoKeys()
    
}

struct createUserInQuickListKeys {
    public let emailKey = "email"
    public let usernameKey = "username"
}

struct createUsers  {
    
    public let inDirectory = createUserInDirectoryKeys()
    public let inQuickList = createUserInQuickListKeys()
    
    
}

struct _userKeys {
    //used to retrieve list of usernames for quick iteration/verification
    public let usersQuickListKey = "UsersQuickList"
    //used to retrieve full users objects
    public let usersDirectoryKey = "UsersDirectory"
    //create users
    public let createUser = createUsers()
    
}
struct database {
   public let userKeys = _userKeys()
    
    
    
    
}
