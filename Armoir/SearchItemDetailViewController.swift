//
//  SearchItemDetailViewController.swift
//  Armoir
//
//  Created by alex weitzman on 12/6/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

class SearchItemDetailViewController: UIViewController {
        
        @IBOutlet weak var priceDetail: UILabel!
        @IBOutlet weak var userName: UILabel!
        @IBOutlet weak var profPic: UIImageView!
        @IBOutlet weak var distanceText: UILabel!
        @IBOutlet weak var itemImage: UIImageView!
        @IBOutlet weak var itemDescrip: UILabel!
    
    @IBAction func borrowItemButton(_ sender: Any) {
        // set as borrowed
            //alex way
            //chosenItem["borrowed"].bool = true;
          //  chosenItem["borrowed_by"].int = currUser.user_ID
        
            //rhea way
            for var i in currArray {
                if (i.item_id == currItem) {
                    i.borrowed = true
                    i.borrowed_by = currUser.user_ID
                    currUser.borrowed.append(i)  //add to the borrowers borrowed array
                }
            }
        
    }
    

        override func viewDidLoad() {
            super.viewDidLoad()
           
            print(chosenItem)
            itemDescrip.text = chosenItem["name"].string
            if let imageStr = chosenItem["image"].string {
                itemImage.image = UIImage(named:  imageStr)
            }
            if let currPrice = chosenItem["price"].int {
                priceDetail.text = "$" + String(currPrice) + "/day";
            }
            distanceText.text = chosenItem["distance"].string! + " mi"
            itemImage.clipsToBounds = true;
            for (_,user) in readableJSON {
                if (user["user_ID"].int == chosenItem["owner"].int) {
                    if let imageStr = user["profPic"].string {
                        profPic.image = UIImage(named: imageStr)
                        profPic.layer.cornerRadius = self.profPic.frame.size.width / 2;
                        profPic.clipsToBounds = true;
                    }
                    userName.text = user["owner"].string
                }
            }
            
            /*for i in currArray {
                if (i.item_id == chosenItem["item_id"].int) {
                    print("success")

                    itemDescrip.text = i.name;
                    var userID = i.owner;
                    if (i.borrowed) {
                        userID = i.borrowed_by;
                        distanceText.text = "Borrowed";
                        
                    } else {
                        distanceText.text = "Currently available";
                    }
                    var user: a_User;
                    var myStructArray:[a_User] = [];
                    do {
                        try myStructArray = JSONDecoder().decode([a_User].self, from: json);
                    }
                    catch {
                        print("array didn't work");
                    }
                    for stru in myStructArray {
                        if stru.user_ID == userID {
                            user = stru;
                            if (i.borrowed) {
                                userName.text = user.name;
                                
                            } else {
                                userName.text = "Owned by you";
                                
                                
                            }

                        }
                    }
                    
                    
                    
                }
            }*/
        }
    
        
}
