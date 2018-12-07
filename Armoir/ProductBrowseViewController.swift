//
//  ProductBrowseViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/29/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import SwiftyJSON
import DropDown

var clickedIndex:Int = Int()
var productImageURLs:[String] = [String]()
var readableJSON:JSON = JSON()
var itemData:[JSON] = [JSON]()
var otherUsers:[a_User] = [];
var currCategory:Int = Int()
var categories:[String] = [String]()
let categoryDropDown:DropDown = DropDown()
let filterDropDown:DropDown = DropDown()
let sortByDropDown:DropDown = DropDown()
var categorySet:Bool = Bool()
var currUser2:Int = Int()
var chosenItem:JSON = JSON()

class ProductBrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var fullArray: [Item] = [];
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var sortByButton: UIButton!
    
    
    @IBAction func categoryClicked(_ sender: Any) {
        categoryDropDown.show()
    }
    
    
    @IBAction func filterClicked(_ sender: Any) {
        filterDropDown.show()
        
    }
    
    @IBAction func sortByClicked(_ sender: Any) {
        sortByDropDown.show()
    }
    
    func getData() {
        if let path = Bundle.main.path(forResource: "search", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                readableJSON = try JSON(data: data)
            } catch {
                print("Error reading json file")
            }
        }
    }


    func reloadData() {
        itemData = []
        for (_,user) in readableJSON {
            if (user["user_ID"].int != currUser2) {
                for (_,item) in user["closet"] {
                    if (categorySet) {
                        if (item["category"].string! == categories[currCategory]) {
                            itemData.append(item)
                
                        }
                    } else {
                        itemData.append(item)
                        print(item)
                    }
                }
            }
        }
        
        for item in itemData {
           print(item["name"])
        }
    }
    
    func loadData() {

        var myStructArray:[a_User] = [];
        do {
            try myStructArray = JSONDecoder().decode([a_User].self, from: json);
        }
        catch {
            print("array didn't work");
        }
        for stru in myStructArray {
            if stru.user_ID != user_num {
                otherUsers.append(stru);
            }
        }
        
        // add all the items
        for u in otherUsers {
            let cl = u.closet;
            for i in cl {
                if !(i.borrowed) {
                    fullArray.append(i);
                }
            }
        }
    }
    
    @IBOutlet weak var showingLabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath) as! ProductCell
        
        let currItem = itemData[indexPath.row]
        print(currItem)
        cell.productImage.image = UIImage(named: currItem["image"].string!)
        if let imageStr = currItem["image"].string {
            cell.productImage.image = UIImage(named: "images/" + imageStr)
        }
        if let currPrice = currItem["price"].int {
            cell.productPrice.text = "$" + String(currPrice) + "/day";
        }

        cell.productImage.contentMode = .scaleToFill;
        cell.productImage.layer.borderWidth = 1;
        cell.productDistance.text = "0.8 mi"
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    /*let category = DropDown()
    let filter = DropDown()
    let sortby = DropDown()
    
    func initCategory(){
        category.dataSource = ["All", "Shirt", "Pants", "Shorts", "Dresses", "Skirts", "Outerwear", "Shoes", "Accessories", "Other" ]
        
        category.selectionAction = {[weak self] (index: Int, item: String) in
            
            print("Selected item: \(item) at index: \(index)")
        }
        category.cellNib = UINib(nibName: "cell”, bundle: nil)
    }
    
    func initFilter(){
        filter.dataSource = ["??"]
        filter.bottomOffset = CGPoint(x: 0, y:(filter.anchorView?.plainView.bounds.height)!)
    }
    
    func initSortBy(){
        sortby.dataSource = ["Price: low->high","Price: high->low", "Distance"]
        sortby.bottomOffset = CGPoint(x: 0, y:(sortby.anchorView?.plainView.bounds.height)!)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currUser2 = 321
        categorySet = false
        categories = ["shirt", "pants", "skirt", "shorts", "dress", "none"]
        getData()
        loadData()
        reloadData()
        
        initDropDowns()
        initCategoryDropDown()
        initFilterDropDown()
        initSortByDropDown()
        
        let itemSize = (UIScreen.main.bounds.width / 2) - 3
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: itemSize*1.3)
        
        layout.minimumInteritemSpacing = 1
        //layout.minimumLineSpacing = 7
        
        myCollectionView.collectionViewLayout = layout
    }
    
    func initDropDowns() {
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont(name: "Alike-Regular", size: 17)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 60
        //shadeDropDown.width = 154
        
        categoryDropDown.anchorView = categoryButton
        filterDropDown.anchorView = filterButton
        sortByDropDown.anchorView = sortByButton
        
        categoryDropDown.direction = .bottom
        filterDropDown.direction = .bottom
        sortByDropDown.direction = .bottom
        
        categoryDropDown.dismissMode = .automatic
        filterDropDown.dismissMode = .automatic
        sortByDropDown.dismissMode = .automatic
        
        categoryDropDown.bottomOffset = CGPoint(x: 0, y:(categoryDropDown.anchorView?.plainView.bounds.height)!)
        filterDropDown.bottomOffset = CGPoint(x: 0, y:(filterDropDown.anchorView?.plainView.bounds.height)!)
        sortByDropDown.bottomOffset = CGPoint(x: 0, y:(sortByDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    func initSortByDropDown() {
        sortByDropDown.dataSource = ["Low to high", "High to low"]
        //selectShadeRow()
        
        sortByDropDown.selectionAction = { [weak self] (index: Int, selectedShade: String) in
            /*currShade = selectedShade
            currMaxPrice = 10000
            self?.reloadBrands()
            self?.reloadData()
            self?.reloadSlider()*/
        }
    }
    
    func initCategoryDropDown() {
        categoryDropDown.dataSource = ["Shirts", "Pants", "Skirts", "Shorts", "Dresses", "No category"]
        //selectShadeRow()
        
        categoryDropDown.selectionAction = { [weak self] (index: Int, selectedShade: String) in
            /*currShade = selectedShade
            currMaxPrice = 10000
            self?.reloadBrands()
            self?.reloadData()
            self?.reloadSlider()*/
        }
    }
    
    func initFilterDropDown() {
        filterDropDown.dataSource = [""]
        //selectShadeRow()
        
        filterDropDown.selectionAction = { [weak self] (index: Int, selectedShade: String) in
            /*currShade = selectedShade
            currMaxPrice = 10000
            self?.reloadBrands()
            self?.reloadData()
            self?.reloadSlider()*/
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenItem = itemData[indexPath.row]
        self.performSegue(withIdentifier: "toItemDetail", sender: self)
    }
    
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //currItem = fullArray[indexPath.row].item_id;
        currItem = itemData[indexPath.row]["item_id"].int!
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

