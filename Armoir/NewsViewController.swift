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
    
    var data = [Cell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load_data()
        let bow_shirt = UIImage(named:"images/c_img1.png")
        let formal_shirt = UIImage(named:"images/r_img1.png")
        let profimg1 = UIImage(named: "chloe")
        let profimg2 = UIImage(named: "jesse")
        
        data = [Cell(productImage: bow_shirt, profileImage: profimg1, profile: "Chloe", distance: "0.8 mi", message: "You have 2 days left to return \"bow shirt\"",borrowed: true),Cell(productImage: formal_shirt, profileImage: profimg2, profile: "Jesse", distance: "1 mi", message: "You have 1 day left until \"Free People Dress\" is returned", borrowed: false)]
        
        
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
        if(data[indexPath.row].borrowed!){
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
