//
//  ClosetViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/30/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import Foundation

var itemImage: UIImage = UIImage()
var startWithCamera: Bool = Bool()
var currItem: Int = 0
var user_num = 123;
var currUser = a_User(user_ID: 123, profPic: "", name: "", borrowed: [], closet: []);
var currArray: [Item] = [];


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
    var imgURL: String
    var color: String //Color
    var size: String //Sizes
    var price: Double
    var category: String //Category
    var distance: String
    
    init(item_id: Int, name: String, owner: Int, borrowed:Bool, borrowed_by: Int, imgURL: String, color: String, size: String, price: Double, category: String) {
        self.item_id = item_id;
        self.name = name;
        self.owner = owner;
        self.borrowed = borrowed;
        self.borrowed_by = borrowed_by;
        self.imgURL = imgURL;
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
    var name: String
    var distance: String
    var borrowed: [Item]
    var closet: [Item]
    
    init(user_ID: Int, profPic: String, name: String, borrowed:[Item], closet: [Item]) {
        self.user_ID = user_ID;
        self.profPic = profPic;
        self.name = name;
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
        case name = "owner"
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
        case imgURL="image";
        case color = "color_tag";
        case size = "size";
        case price = "price";
        case category = "category";
        case distance = "distance";
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: userStructKeys.self) // defining our (keyed) container
        let user_ID: Int = try container.decode(Int.self, forKey: .user_ID) // extracting the data
        let profPic: String = try container.decode(String.self, forKey: .profPic) // extracting the data
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        var borrowed_array = try container.nestedUnkeyedContainer(forKey: userStructKeys.borrowed);
        var borrowed: [Item] = [];
        while (!borrowed_array.isAtEnd) {
            let item_container = try borrowed_array.nestedContainer(keyedBy: itemStructKeys.self)
            let i_name: String = try item_container.decode(String.self, forKey: itemStructKeys.name)
            let item_id: Int = try item_container.decode(Int.self, forKey: itemStructKeys.item_id) // extracting the data
            let owner: Int = try item_container.decode(Int.self, forKey: itemStructKeys.owner)
            let borrowed_b: Bool = try item_container.decode(Bool.self, forKey: itemStructKeys.borrowed)
            let borrowed_by: Int = try item_container.decode(Int.self, forKey: itemStructKeys.borrowed_by)
            let img_url: String = try item_container.decode(String.self, forKey: itemStructKeys.imgURL)
            let color: String = try item_container.decode(String.self, forKey: itemStructKeys.color)
            let size: String = try item_container.decode(String.self, forKey: itemStructKeys.size)
            let price: Double = try item_container.decode(Double.self, forKey: itemStructKeys.price)
            let category: String = try item_container.decode(String.self, forKey: itemStructKeys.category)
            let item = Item(item_id: item_id, name: i_name, owner: owner, borrowed: borrowed_b, borrowed_by: borrowed_by, imgURL: img_url, color: color, size: size, price: price, category: category);
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
            let img_url: String = try item_container.decode(String.self, forKey: itemStructKeys.imgURL)
            let color: String = try item_container.decode(String.self, forKey: itemStructKeys.color)
            let size: String = try item_container.decode(String.self, forKey: itemStructKeys.size)
            let price: Double = try item_container.decode(Double.self, forKey: itemStructKeys.price)
            let category: String = try item_container.decode(String.self, forKey: itemStructKeys.category)
            let item = Item(item_id: item_id, name: i_name, owner: owner, borrowed: borrowed_b, borrowed_by: borrowed_by, imgURL: img_url, color: color, size: size, price: price, category: category);
            closet.append(item);
        }
        self.init(user_ID: user_ID,profPic: profPic, name: name, borrowed: borrowed, closet: closet) // initializing our struct
        
    }
}

//TILL HERE

var all_users:[a_User] = []



/*
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let data = try encoder.encode()
print(String(data: data, encoding: .utf8)!)*/
/*
let json = """
[{
   "user_ID": 123,
   "owner": "Chloe Imaginary",
   "profPic": "chloe.png",
   "borrowed": [{
       "item_id": 54321,
       "name": "Formal shirt",
       "owner": 321,
       "borrowed": true,
       "borrowed_by": 123,
       "image": "r_img1.png",
       "color_tag": "blue",
       "size": "M",
       "price": 35,
       "category": "shirt"
   }, {
       "item_id": 54322,
       "name": "frilly shirt",
       "owner": 321,
       "borrowed": true,
       "borrowed_by": 123,
       "image": "r_img2.png",
       "color_tag": "red",
       "size": "S",
       "price": 65,
       "category": "shirt"
   },
{
       "item_id": 54324,
       "name": "fun, flared skirt",
       "owner": 321,
       "borrowed": true,
       "borrowed_by": 123,
       "image": "r_img4.png",
       "color_tag": "yellow",
       "size": "S",
       "price": 76,
       "category": "skirt"
   }
],
   "closet": [{
       "item_id": 12345,
       "name": "Formal shirt",
       "owner": 123,
       "borrowed": true,
       "borrowed_by": 321,
       "image": "c_img1.png",
       "color_tag": "red",
       "size": "M",
       "price": 70,
       "category": "shirt"
   }, {
       "item_id": 14445,
       "name": "Formal shirt","Fun shirt",
       "owner": 123,
       "borrowed":false,
       "borrowed_by": 0,
       "image": "c_img2.png",
       "color_tag": "red",
       "size": "M",
       "price": 50,
       "category": "shirt"
   }, {
       "item_id": 16645,
       "name": "Formal shirt","Fun shirt","Superhero shirt",
       "owner": 123,
       "borrowed": false,
       "borrowed_by": 0,
       "image": "c_img3.png",
       "color_tag": "green",
       "size": "M",
       "price": 40,
       "category": "shirt"
   }, {
       "item_id": 17745,
       "name": "Formal shirt","Fun shirt","Superhero shirt","bright shirt",
       "owner": 123,
       "borrowed": false,
       "borrowed_by": 0,
       "image": "c_img4.png",
       "color_tag": "red",
       "size": "M",
       "price": 30,
       "category": "shirt"
   }, {
       "item_id": 17845,
       "name": "Formal shirt","Fun shirt","Superhero shirt","bright shirt","frayed jeans",
       "owner": 123,
       "borrowed": false,
       "borrowed_by": 0,
       "image": "c_img5.png",
       "color_tag": "blue",
       "size": "S",
       "price": 80,
       "category": "pant"
   }]
}, {
   "user_ID": 321,
   "owner": "Rhea Karuturi",
   "profPic": "rhea.png",
   "borrowed": [{
       "item_id": 12345,
       "name": "Formal shirt",
       "owner": 123,
       "borrowed": true,
       "borrowed_by": 321,
       "image": "c_img1.png",
       "color_tag": "red",
       "size": "M",
       "price": 70,
       "category": "shirt"
   }],
   "closet": [{
       "item_id": 54321,
       "name": "Formal shirt",
       "owner": 321,
       "borrowed": true,
       "borrowed_by": 123,
       "image": "r_img1.png",
       "color_tag": "blue",
       "size": "M",
       "price": 35,
       "category": "shirt"
   }, {
       "item_id": 54322,
       "name": "frilly shirt",
       "owner": 321,
       "borrowed": true,
       "borrowed_by": 123,
       "image": "r_img2.png",
       "color_tag": "red",
       "size": "S",
       "price": 65,
       "category": "shirt"
   }, {
       "item_id": 54323,
       "name": "summer tank top",
       "owner": 321,
       "borrowed": false,
       "borrowed_by": 0,
       "image": "r_img3.png",
       "color_tag": "white",
       "size": "S",
       "price": 55,
       "category": "shirt"
   }, {
       "item_id": 54324,
       "name": "fun, flared skirt",
       "owner": 321,
       "borrowed": true,
       "borrowed_by": 123,
       "image": "r_img4.png",
       "color_tag": "yellow",
       "size": "S",
       "price": 76,
       "category": "skirt"
   }, {
       "item_id": 54325,
       "name": "ripped jeans",
       "owner": 321,
       "borrowed": false,
       "borrowed_by": 0,
       "image": "r_img5.png",
       "color_tag": "black",
       "size": "S",
       "price": 90,
       "category": "pant"
   }]
}]
""".data(using: .utf8)! */

class ClosetViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    let itemsPerRow: CGFloat = 2.0
    var status_lending = true

    @IBOutlet weak var tabPicker: UISegmentedControl!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var viewOfItems: UICollectionView!
   @IBOutlet weak var profileName: UILabel!
    

    //Replace with the uploadItemButton
    @IBAction func uploadItemButton(_ sender: UIButton) {
        self.showActionSheet();
    }
    
    @objc func showActionSheet() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Import Image", message: "Take a picture or select one from your library.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            startWithCamera = true
            self.performSegue(withIdentifier: "toCameraPage", sender: self)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            startWithCamera = false
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            itemImage = selectedImage!
            dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "toAddItemPage", sender: self)
            })
        } else if let originalImage = info[.originalImage] as? UIImage{
            selectedImage = originalImage
            itemImage = selectedImage!
            dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "toAddItemPage", sender: self)
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        let userIds = [123, 234,345,456,567,789]
        let profPic = ["rhea.png", "cisco.png", "rachel.png", "alex.png", "kendall.png", "kim.png"]
        let userNames = ["Rhea Karuturi", "Cisco Vlahakis", "Rachel Hyon", "Alex Weitzman", "Kendall Jenner", "Kim Kardashian"]
        let itemIds = [ 10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40]
        let itemNames = ["Formal shirt", "frilly shirt", "summer tank top","fun, flared skirt","ripped jeans", "Formal shirt","Fun shirt","Superhero shirt","bright shirt","frayed jeans", "White tie top", "Pink off shoulder", "Peach off shoulder", "Plaid skirt", "Ripped Jeans" , "White tie Detail top", "Gray off shoulder" , "Red strappy party dress" , "Red flare Dress", "Black tight jeans", "Red slit dress" , "Patch work jeans", "high waisted jeans", "Polka dress", "Casual cream-colored","Nude pants",  "Jewelled skirt", "Nude Yeezy dress" , "Jean shorts", "Hot pink body-con"]
        let itemOwners = [userIds[0], userIds[0], userIds[0],userIds[0],userIds[0],userIds[1],userIds[1],userIds[1],userIds[1],userIds[1],userIds[2],userIds[2],userIds[2],userIds[2],userIds[2],userIds[3],userIds[3],userIds[3],userIds[3],userIds[3], userIds[4],userIds[4],userIds[4],userIds[4],userIds[4], userIds[5],userIds[5],userIds[5],userIds[5],userIds[5]]
        let borrowedStatus = [true, true, false, false, false]
        let borrowed_by = [userIds[1], userIds[2], userIds[2], userIds[3], userIds[3],userIds[4],userIds[4], userIds[5], userIds[5], userIds[0], userIds[0], userIds[1], 0]
        let imgUrl = ["r_img1.png","r_img2.png", "r_img3.png","r_img4.png","r_img5.png","c_img1.png","c_img2.png", "c_img3.png","c_img4.png","c_img5.png", "rachel_img1.png","rachel_img2.png", "rachel_img3.png","rachel_img4.png","rachel_img5.png","alex_img1.png", "alex_img2.png","alex_img3.png","alex_img4.png","alex_img5.png", "kendall_img1.png", "kendall_img2.png", "kendall_img3.png", "kendall_img4.png", "kendall_img5.png", "kimk_img1.png", "kimk_img2.png", "kimk_img3.png","kimk_img4.png","kimk_img5.png"]
        
        let colors = ["blue","red","white","yellow", "black", "red","red","green","red","blue","white","pink","pink","blue","blue", "white","grey","red","red","black", "red","blue","blue","white","white", "brown", "white", "brown", "blue", "pink" ]
        let sizes_all = ["XS", "S", "M", "L", "XL", "M" , "M" , "M" , "M" , "S", "S" , "S" , "S" , "M" , "M", "S" , "S" , "S" , "S" , "S", "XS" , "XS" , "XS" , "XS" , "XS", "L", "L", "L", "M", "M"]
        let prices = [2.0, 3.0, 5.0, 7.5, 5.5, 7.0, 5.0, 4.0, 3.0, 8.5, 5.0, 5.0, 5.0, 7.5, 9.5, 7.0, 8.0, 7.0, 8.5, 7.5, 105.0, 38.0, 35.0, 30.5, 34.5, 100.0, 100.0, 100.0, 100.0, 100.0]
        let category = ["shirt", "shirt", "shirt", "skirt", "pant", "shirt", "shirt", "shirt", "shirt", "pant", "shirt", "shirt", "shirt", "skirt", "pant", "shirt", "dress", "dress", "dress", "pant", "dress", "pant", "pant", "dress", "pant", "pant" , "skirt" , "dress" , "pant" , "dress"]
        
        var borrowed1:[Item] = [];
        var borrowed2:[Item] = [];
        var borrowed3:[Item] = [];
        var borrowed4:[Item] = [];
        var borrowed5:[Item] = [];
        var borrowed6:[Item] = [];
        var closet1:[Item] = [];
        var closet2:[Item] = [];
        var closet3:[Item] = [];
        var closet4:[Item] = [];
        var closet5:[Item] = [];
        var closet6:[Item] = [];
        
        var item_num = 0;
        while (item_num < 30) {
            let multiple = item_num/5;
            let positionOfFive = item_num % 5;
            var borrowedNum = 12;
            if (positionOfFive == 0) {
                borrowedNum = multiple*2
            } else if (positionOfFive == 1) {
                borrowedNum = multiple*2 + 1
            }
            let ex_item = Item(item_id: Int(itemIds[item_num]), name: itemNames[item_num], owner: userIds[multiple], borrowed: Bool(borrowedStatus[positionOfFive]), borrowed_by: borrowed_by[borrowedNum], imgURL: imgUrl[item_num] , color: colors[item_num], size: sizes_all[item_num] , price: prices[item_num], category: category[item_num])
            
            if (multiple == 0) {
            
                closet1.append(ex_item)
                if (positionOfFive == 0) {
                    borrowed2.append(ex_item)
                }
                if (positionOfFive == 1) {
                    borrowed3.append(ex_item)
                }
            }
            if (multiple == 1) {
                closet2.append(ex_item)
                if (positionOfFive == 0) {
                    borrowed3.append(ex_item)
                }
                if (positionOfFive == 1) {
                    borrowed4.append(ex_item)
                }
            }
            if (multiple == 2) {
                closet3.append(ex_item)
                if (positionOfFive == 0) {
                    borrowed4.append(ex_item)
                }
                if (positionOfFive == 1) {
                    borrowed5.append(ex_item)
                }
            }
            if (multiple == 3) {
                closet4.append(ex_item)
                if (positionOfFive == 0) {
                    borrowed5.append(ex_item)
                }
                if (positionOfFive == 1) {
                    borrowed6.append(ex_item)
                }
            }
            if (multiple == 4) {
                closet5.append(ex_item)
                if (positionOfFive == 0) {
                    borrowed6.append(ex_item)
                }
                if (positionOfFive == 1) {
                    borrowed1.append(ex_item)
                }
            }
            if (multiple == 5) {
                closet6.append(ex_item)
                if (positionOfFive == 0) {
                    borrowed1.append(ex_item)
                }
                if (positionOfFive == 1) {
                    borrowed2.append(ex_item)
                }
            }
            item_num += 1
        }
        
        let b_array: [[Item]] = [borrowed1, borrowed2,borrowed3,borrowed4,borrowed5,borrowed6]
        let c_array: [[Item]] = [closet1, closet2, closet3, closet4, closet5, closet6]
        var num_user = 5;
        while (num_user > -1) {
            let user1 = a_User(user_ID: userIds[num_user], profPic: profPic[num_user], name: userNames[num_user], borrowed: b_array[num_user], closet: c_array[num_user]);
            all_users.append(user1);
            num_user -= 1
        }
        
        let url = Bundle.main.url(forResource: "search", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            try all_users = JSONDecoder().decode([a_User].self, from: jsonData);
        }
        catch {
            print(error)
        }
        //1. read json from file: DONE
        //2. when adding, add to the all_users array: to do
        //3. then, encode it to be in json
        //4. write to search.json with new encoded string
        
        let path = "test" //this is the file. we will write to and read from it
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(all_users)
            print(String(data: data, encoding: .utf8)!)
            print("DONE ENCODING")
        }
        catch {
            print("array didn't work");
        }
        
        print("continuing");
        let text = "some text" //just a text
        if let fileURL = Bundle.main.url(forResource: path, withExtension: "json") {
            //print(fileURL)
            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                print("tried to write")
            }
            catch {
                print ("oh no");
            }
            
        }
        
        for user_instance in all_users {
           // print(user_instance)
            if user_instance.user_ID == user_num {
                currUser = user_instance;
            }
        }
    }
    
    func loadProfImage() {
        let image = UIImage(named: currUser.profPic);
        self.profilePicture.image = image;
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        self.profilePicture.clipsToBounds = true;
    }
    
    func showUserName() {
        let userName = currUser.name;
       self.profileName.text = userName;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currArray.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //for clothes you are lending
        if (status_lending) {
            let cell = viewOfItems.dequeueReusableCell(withReuseIdentifier: "lendingCell",for: indexPath) as! ItemCell
            let i = currArray[indexPath.row]
            cell.itemName.text = i.name;
            cell.img_display.image = UIImage(named: i.imgURL);
            cell.img_display.contentMode = .scaleToFill;
            cell.img_display.layer.borderWidth = 1;
            if (i.borrowed) {
                cell.backgroundColor = UIColor(hue: 0.0028, saturation: 0, brightness: 0.82, alpha: 1.0)
                cell.due_display.text = "1 day left";
                cell.due_display.textColor = UIColor(hue: 0.0028, saturation: 0.97, brightness: 0.65, alpha: 1.0);
            } else {
                cell.backgroundColor = UIColor.white
                cell.due_display.text = "not borrowed";
                cell.due_display.textColor = UIColor.black;
            }
            return cell
        } // for borrowing clothes
        else {
            let cell = viewOfItems.dequeueReusableCell(withReuseIdentifier: "borrowingCell",for: indexPath) as! BorrowedCell
            let i = currArray[indexPath.row]
            cell.img_display.image = UIImage(named: i.imgURL);
            cell.img_display.contentMode = .scaleToFill;
            cell.img_display.layer.borderWidth = 1;
            cell.dist_display.text = "1.2 mi";
            cell.due_display.text = "Due in 2 days";
            cell.due_display.textColor = UIColor.black;
            cell.price_display.text = String(i.price);
            cell.backgroundColor = UIColor.white
            return cell
        }

    }
    


    func loadLending() {
        currArray = currUser.closet;
        status_lending = true;
    }
    
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        switch tabPicker.selectedSegmentIndex
        {
        case 0:
            loadLending();
        case 1:
            currArray = currUser.borrowed;
            status_lending = false;
        default:
            break
        }
       self.viewOfItems.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currItem = currArray[indexPath.row].item_id;

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData();
        loadProfImage();
        showUserName();
        loadLending();
        uploadButton.imageView?.contentMode = .scaleAspectFit;
        uploadButton.layer.cornerRadius = 5;
        viewOfItems.contentInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        //let availableWidth = viewOfItems.frame.size.width-(10*6.5);
        //let widthPerItem = availableWidth / 2;
        let widthPerItem = (UIScreen.main.bounds.width / 2) - 3
        let layout = UICollectionViewFlowLayout()
        //let layout = viewOfItems.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.minimumInteritemSpacing = 1;
        layout.itemSize = CGSize( width: widthPerItem, height: widthPerItem*1.3)
    
        viewOfItems.collectionViewLayout = layout

        
    }
   

}


