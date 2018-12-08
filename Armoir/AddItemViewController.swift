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
    
    @IBOutlet weak var Category: UITextField!
    
    @IBOutlet weak var Color: UITextField!
    
    @IBOutlet weak var Description: UITextField!
    
    @IBOutlet weak var Price: UITextField!
    
    
    @IBOutlet weak var Size: UITextField!
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let category: String = Category.text!
        let color: String = Color.text!
        let description: String = Description.text!
        let size: String = Size.text!
        //needs to be a double based on what they enter
        let price = 3.0
        var numItems = 0
        for u in all_users {
            for i in u.closet {
                numItems += 1
            }
        }
        let new_item = Item(item_id: numItems+1, name: description, owner: currUser.user_ID, borrowed: false, borrowed_by: 0, imgURL: "jeanJacketFinal", color: color, size: size, price: price, category: category)
        
        currUser.closet.append(new_item)
        
    }
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
