//
//  MainViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/30/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import Foundation
import Firebase

var itemImage: UIImage = UIImage()
var startWithCamera: Bool = Bool()
var currItem: Int = 0
var user_num = 123;
var currUser = a_User(user_ID: 123, profPic: "", owner: "", borrowed: [], closet: []);
var currArray: [Item] = [];
var longJsonData: String = ""
var fullDestPathString: String = ""
var fullDestPath: URL = NSURLComponents().url!

struct Item: Codable {
    enum Sizes: String, Decodable {
        case XS, S, M, L, XL
    }
    enum Category: String, Decodable {
        case shirt,pants,skirt,shorts,dress,outerwear,none
    }
    enum Color: String, Decodable {
        case red, orange, yellow, green, blue, purple, white, black, grey, pink, navy, mixed, none
    }
    
    let item_id: Int
    var name: String
    var owner: Int
    var borrowed: Bool
    var borrowed_by: Int
    var image: String
    var color: String //Color
    var size: String //Sizes
    var price: Double
    var category: String //Category
    var distance: String
    
    init(item_id: Int, name: String, owner: Int, borrowed:Bool, borrowed_by: Int, image: String, color: String, size: String, price: Double, category: String) {
        self.item_id = item_id;
        self.name = name;
        self.owner = owner;
        self.borrowed = borrowed;
        self.borrowed_by = borrowed_by;
        self.image = image;
        self.color = color ;//Color.none;
        self.size = size ;//Sizes.M;
        self.price = price;
        self.category = category ;//Category.none;
        self.distance = "1.2 mi";
        
    }
}



struct a_User {
    let user_ID: Int
    var profPic: String
    var owner: String
    var distance: String
    var borrowed: [Item]
    var closet: [Item]
    
    init(user_ID: Int, profPic: String, owner: String, borrowed:[Item], closet: [Item]) {
        self.user_ID = user_ID;
        self.profPic = profPic;
        self.owner = owner;
        self.borrowed = borrowed;
        self.closet = closet;
        self.distance = "1.2 mi";
    }
}
//DONT WORRY ABOUT THIS
extension a_User: Codable {
    enum userStructKeys: String, CodingKey { // declaring our keys
        case user_ID = "user_ID"
        case profPic = "profPic"
        case owner = "owner"
        case borrowed = "borrowed"
        case closet = "closet"
        case distance = "distance"
    }
    
    enum itemStructKeys: String, CodingKey { // declaring our keys
        case item_id = "item_id";
        case name = "name";
        case owner = "owner";
        case borrowed = "borrowed";
        case borrowed_by = "borrowed_by";
        case image="image";
        case color = "color";
        case size = "size";
        case price = "price";
        case category = "category";
        case distance = "distance";
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: userStructKeys.self) // defining our (keyed) container
        let user_ID: Int = try container.decode(Int.self, forKey: .user_ID) // extracting the data
        let profPic: String = try container.decode(String.self, forKey: .profPic) // extracting the data
        let owner: String = try container.decode(String.self, forKey: .owner) // extracting the data
        var borrowed_array = try container.nestedUnkeyedContainer(forKey: userStructKeys.borrowed);
        var borrowed: [Item] = [];
        while (!borrowed_array.isAtEnd) {
            let item_container = try borrowed_array.nestedContainer(keyedBy: itemStructKeys.self)
            let i_name: String = try item_container.decode(String.self, forKey: itemStructKeys.name)
            let item_id: Int = try item_container.decode(Int.self, forKey: itemStructKeys.item_id) // extracting the data
            let owner: Int = try item_container.decode(Int.self, forKey: itemStructKeys.owner)
            let borrowed_b: Bool = try item_container.decode(Bool.self, forKey: itemStructKeys.borrowed)
            let borrowed_by: Int = try item_container.decode(Int.self, forKey: itemStructKeys.borrowed_by)
            let image: String = try item_container.decode(String.self, forKey: itemStructKeys.image)
            let color: String = try item_container.decode(String.self, forKey: itemStructKeys.color)
            let size: String = try item_container.decode(String.self, forKey: itemStructKeys.size)
            let price: Double = try item_container.decode(Double.self, forKey: itemStructKeys.price)
            let category: String = try item_container.decode(String.self, forKey: itemStructKeys.category)
            let item = Item(item_id: item_id, name: i_name, owner: owner, borrowed: borrowed_b, borrowed_by: borrowed_by, image: image, color: color, size: size, price: price, category: category);
            borrowed.append(item);
        }
        var closet_array = try container.nestedUnkeyedContainer(forKey: userStructKeys.closet);
        var closet: [Item] = [];
        while (!closet_array.isAtEnd) {
            let item_container = try closet_array.nestedContainer(keyedBy: itemStructKeys.self)
            let i_name: String = try item_container.decode(String.self, forKey: itemStructKeys.name)
            let item_id: Int = try item_container.decode(Int.self, forKey: itemStructKeys.item_id) // extracting the data
            let owner: Int = try item_container.decode(Int.self, forKey: itemStructKeys.owner)
            let borrowed_b: Bool = try item_container.decode(Bool.self, forKey: itemStructKeys.borrowed)
            let borrowed_by: Int = try item_container.decode(Int.self, forKey: itemStructKeys.borrowed_by)
            let image: String = try item_container.decode(String.self, forKey: itemStructKeys.image)
            let color: String = try item_container.decode(String.self, forKey: itemStructKeys.color)
            let size: String = try item_container.decode(String.self, forKey: itemStructKeys.size)
            let price: Double = try item_container.decode(Double.self, forKey: itemStructKeys.price)
            let category: String = try item_container.decode(String.self, forKey: itemStructKeys.category)
            let item = Item(item_id: item_id, name: i_name, owner: owner, borrowed: borrowed_b, borrowed_by: borrowed_by, image: image, color: color, size: size, price: price, category: category);
            closet.append(item);
        }
        self.init(user_ID: user_ID,profPic: profPic, owner: owner, borrowed: borrowed, closet: closet) // initializing our struct
        
    }
}

//TILL HERE

var all_users:[a_User] = []

class MainViewController: UIViewController {

    var browseViewController: UIViewController!
    
    var closetViewController: UIViewController!
    
    var newsViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    
    var viewArray: [UIView]!
    
    var selectedIndex: Int = 1
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var closetView: UIView!
    
    @IBOutlet weak var newsView: UIView!
    

//    override func viewDidAppear(_ animated: Bool) {
//        //1. read json from file: DONE
//        var longJsonData = ""
//        let url = Bundle.main.url(forResource: "search", withExtension: "json")!
//        do {
//            let jsonData = try Data(contentsOf: url)
//            try all_users = JSONDecoder().decode([a_User].self, from: jsonData);
//            
//        }
//        catch {
//            print(error)
//        }
//        
//        let encoder = JSONEncoder()
//               encoder.outputFormatting = .prettyPrinted
//               do {
//                   let data = try encoder.encode(all_users)
//                   longJsonData = String(data: data, encoding: .utf8)!
//                   //print(String(data: data, encoding: .utf8)!)
//                   print("DONE ENCODING")
//               }
//               catch {
//                   print("array didn't work");
//               }
//               print(longJsonData)
//    }
    
    override func viewDidLoad() {
        viewArray = [searchView, closetView, newsView]
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        browseViewController = storyboard.instantiateViewController(withIdentifier: "BrowseViewController")
        
        closetViewController = storyboard.instantiateViewController(withIdentifier: "ClosetViewController")
        
        newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController")
        
        viewControllers = [browseViewController, closetViewController, newsViewController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
    }
    
    @IBAction func didPressTab(_ sender: UIButton) {
        
        let previousIndex = selectedIndex
        if selectedIndex == 0 {
            Analytics.logEvent("search_tab_pressed", parameters: [
              "tab": (view)
            ])
        } else if selectedIndex == 1 {
            Analytics.logEvent("closet_tab_pressed", parameters: [
              "tab": (view)
            ])
        } else {
            Analytics.logEvent("news_tab_pressed", parameters: [
              "tab": (view)
            ])
        }
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        viewArray[previousIndex].backgroundColor = UIColor(hue: 0.0778, saturation: 0.17, brightness: 0.81, alpha: 1.0)
        viewArray[selectedIndex].backgroundColor = UIColor(hue: 0.075, saturation: 0.19, brightness: 0.76, alpha: 1.0)
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
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

