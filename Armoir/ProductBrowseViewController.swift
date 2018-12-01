//
//  ProductBrowseViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/29/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

var productImageURLs:[String] = [String]()

class ProductBrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let array:[String] = ["1", "2", "3", "4"]
    
    func loadData() {
        var numImages = 10
    
        let imageURL = "https://i.imgur.com/JOPiokr.png"
        
        while(numImages > 0) {
            productImageURLs.append(imageURL)
            numImages -= 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return array.count
        return productImageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        
        if let imgURL = URL(string: productImageURLs[indexPath.row]) {
            
            URLSession.shared.dataTask(with: imgURL, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                let image = UIImage(data: data!)
            
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
            }).resume()
        }

       /* if let imgURL = URL(string: "https://i.imgur.com/JOPiokr.png") {
            
            URLSession.shared.dataTask(with: imgURL, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
            }).resume()
        }*/
        
        //cell.productImage.image = UIImage(named: "NewsScreenshot")
        cell.productPrice.text = "$5/day"
        //cell.productDistance.text = "1.2 mi"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        let itemSize = UIScreen.main.bounds.width / 2 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize*1.2)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 7
        
        myCollectionView.collectionViewLayout = layout
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
