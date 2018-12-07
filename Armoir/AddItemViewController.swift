//
//  AddItemViewController.swift
//  Armoir
//
//  Created by alex weitzman on 12/4/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    
    /*func load_json(){
        let item_id = 23234 //uhm???
        let name = "jean jacket" //obtain from input
        let owner = 321
        let borrowed_by = 0
        let imgURL = "jeanJacketFinal"
        let color = "blue"
        let size = "S"
        let price = 20
        let category = "jacket"
        
        let new_item = Item.init(item_id: item_id, name: name, owner: owner, borrowed: false, borrowed_by: borrowed_by, imgURL: imgURL, color: color, size: size, price: price, category: category)
        
        let enoded  = encoder.codingPath
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImageView.image = itemImage
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.hidesBackButton = false;
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if (startWithCamera) {
            print("true")
        // Go back two ViewControllers
            _ = navigationController?.popViewControllers(viewsToPop: 2)
        } else {
            _ = navigationController?.popViewControllers(viewsToPop: 1)
        }
        
    }

}

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}
