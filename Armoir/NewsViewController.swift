//
//  NewsViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/30/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

struct Cell{
    let productImage : UIImage?
    let profileImage : UIImage?
    let profile : String?
    let distance : String?
    let message : String?
    let borrowed: Bool?
    
    /*init(productImage: UIImage, profileImage: UIImage, profile: String, distance: String, message: String) {
     self.productImage = productImage;
     self.profileImage = profileImage;
     self.profile = profile;
     self.distance = distance;
     self.message = message;
     }*/
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var settingsViewController: UIViewController!
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBAction func pressedSettings(_ sender: UIButton) {
        performSegue(withIdentifier: "newsSegue", sender: self)
    }
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    //var prodImg : UIImage?
    
    var data:[Cell] = [];
    let rand_names = ["Chloe", "Cynthia", "Liz", "Jesse"];
    let dist = ["1.2 mi","0.8 mi","2 mi","2.4 mi"];
    let profimageURL = ["chloe","cynthia","liz","jesse"];
    
    func load_data(){
        var users:[a_User] = [];
        do {
            try users = JSONDecoder().decode([a_User].self, from: json);
        }
        catch {
            print("array didn't work");
        }
        for user_instance in users {
            if user_instance.user_ID == user_num {
                currUser = user_instance;
            }
        }
        var i = 0
        for item in currUser.borrowed {
            let productimg = UIImage(named: item.imgURL)
            let profileimg = UIImage(named: profimageURL[i])
            let prof = rand_names[i]
            let dst = dist[i]
            let msg = "You have 2 days left to return "+item.name+" "+item.category;
            data.append(Cell(productImage: productimg, profileImage: profileimg, profile: prof, distance: dst, message: msg, borrowed: true))
            i+=1
        }
        for item in currUser.closet {
            if(item.borrowed){
                let productimg = UIImage(named: item.imgURL)
                let profileimg = UIImage(named: profimageURL[i])
                let prof = rand_names[i]
                let dst = dist[i]
                let msg = "You have 2 days left to return "+"\""+item.name+"\""+" "+item.category;
                data.append(Cell(productImage: productimg, profileImage: profileimg, profile: prof, distance: dst, message: msg, borrowed: false))
                i+=1
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_data()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        cell.productImg?.image =  data[indexPath.row].productImage
        cell.profileImg?.image =  data[indexPath.row].profileImage
        cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width / 2;
        cell.profileImg.clipsToBounds = true;
        cell.profile?.text = data[indexPath.row].profile
        cell.distance?.text = data[indexPath.row].distance
        cell.message?.text = data[indexPath.row].message
        if(!data[indexPath.row].borrowed!){
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
}

class NewsTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var profile: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
}
