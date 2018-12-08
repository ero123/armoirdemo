//
//  BorrowedItemDetailViewController.swift
//  Armoir
//
//  Created by rhea krtr on 06/12/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit


class BorrowedItemDetailViewController: UIViewController {
    
    @IBOutlet weak var priceDetail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var distanceText: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescrip: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in currArray {
            if (i.item_id == currItem) {
                priceDetail.text = "$" + String(i.price) + "/day";
                let imageI = UIImage(named: i.image);
                self.itemImage.image = imageI;
                self.itemImage.clipsToBounds = true;
                itemDescrip.text = i.name;
                var userID = i.owner;
                if (i.borrowed) {
                    userID = i.borrowed_by;
                    distanceText.text = "Borrowed by";

                } else {
                    distanceText.text = "Currently available";
                }
                var user: a_User;
                /*var myStructArray:[a_User] = [];
                do {
                    try myStructArray = JSONDecoder().decode([a_User].self, from: json);
                }
                catch {
                    print("array didn't work");
                }
                for stru in myStructArray { */
                for stru in all_users {
                    if stru.user_ID == userID {
                        user = stru;
                        if (i.borrowed) {
                            userName.text = user.owner;

                        } else {
                            userName.text = "Owned by you";


                        }
                        let image = UIImage(named: user.profPic);
                        self.profPic.image = image;
                        self.profPic.layer.cornerRadius = self.profPic.frame.size.width / 2;
                        self.profPic.clipsToBounds = true;
                    }
                }
                
                
                
            }
        }
        
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
