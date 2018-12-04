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
    
    /*init(productImage: UIImage, profileImage: UIImage, profile: String, distance: String, message: String) {
        self.productImage = productImage;
        self.profileImage = profileImage;
        self.profile = profile;
        self.distance = distance;
        self.message = message;
    }*/
}

<<<<<<< HEAD:Armoir/ViewControllers/NewsViewController.swift
    @IBAction func newsSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "newsSegue", sender: self)
        
=======
class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    //var prodImg : UIImage?
    
    var data = [Cell]()
    
    func load_data(){
        let num_data = 5
        var i = 0
        let image = UIImage(named:"dress")
        
        while i < num_data{
            let c = Cell(productImage: image!, profileImage: image!, profile: "Jesse", distance: "0.8 mi", message: "You have 3 dats left to return 'Free People Dress' to Jesse");
            data.append(c);
            i-=1
        }
>>>>>>> master:Armoir/NewsViewController.swift
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD:Armoir/ViewControllers/NewsViewController.swift

        // Do any additional setup after loading the view.
        
=======
        //load_data()
        let image = UIImage(named:"dress")
        //print(data)
        data = [Cell(productImage: image, profileImage: image, profile: "Jesse", distance: "0.8 mi", message: "You have 3 dats left to return 'Free People Dress' to Jesse"),Cell(productImage: image, profileImage: image, profile: "Jesse", distance: "0.8 mi", message: "You have 3 dats left to return 'Free People Dress' to Jesse")]
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
>>>>>>> master:Armoir/NewsViewController.swift
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
