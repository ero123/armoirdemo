//
//  NewsViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/30/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {


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


    @IBAction func newsSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "newsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load_data()
        let image = UIImage(named:"dress")
        //print(data)
        data = [Cell(productImage: image, profileImage: image, profile: "Jesse", distance: "0.8 mi", message: "You have 3 dats left to return 'Free People Dress' to Jesse"),Cell(productImage: image, profileImage: image, profile: "Jesse", distance: "0.8 mi", message: "You have 3 dats left to return 'Free People Dress' to Jesse")]
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count


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
