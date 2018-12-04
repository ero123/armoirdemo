//
//  ClosetViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/30/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

<<<<<<< HEAD:Armoir/ClosetViewController.swift
struct Item: Decodable {
    enum Sizes: String, Decodable {
        case XS, S, M, L, XL
    }
    enum Category: String, Decodable {
        case shirt,pants,skirt,shorts,dress,none
    }
    enum Color: String, Decodable {
        case red, orange, yellow, green, blue, purple, white, black, grey, pink, navy, mixed, none
    }
    
    let item_id: Int
    var name: String
    var owner: Int
    var borrowed: Bool
    var borrowed_by: Int
    var imgURL: String
    var color: String //Color
    var size: String //Sizes
    var price: Double
    var category: String //Category
    
    init(item_id: Int, name: String, owner: Int, borrowed:Bool, borrowed_by: Int, imgURL: String, color: String, size: String, price: Double, category: String) {
        self.item_id = item_id;
        self.name = name;
        self.owner = owner;
        self.borrowed = borrowed;
        self.borrowed_by = borrowed_by;
        self.imgURL="images/" + imgURL;
        self.color = color ;//Color.none;
        self.size = size ;//Sizes.M;
        self.price = price;
        self.category = category ;//Category.none;
        
    }
}



struct a_User {
    let user_ID: Int
    var profPic: String
    var name: String
    var borrowed: [Item]
    var closet: [Item]
    init(user_ID: Int, profPic: String, name: String, borrowed:[Item], closet: [Item]) {
        self.user_ID = user_ID;
        self.profPic = "images/" + profPic;
        self.name = name;
        self.borrowed = borrowed;
        self.closet = closet;
    }
}
=======
class SetUpVC: UIViewController {
>>>>>>> parent of b48a35a... Merge remote-tracking branch 'refs/remotes/origin/master':Armoir/SetUpVC.swift

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
