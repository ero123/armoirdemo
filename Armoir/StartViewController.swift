//
//  StartViewController.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/3/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UITextField!
    var gradient: CAGradientLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let prefs:UserDefaults = UserDefaults.standard
        let isLoggedIn:Int = prefs.integer(forKey: "ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegue(withIdentifier: "goto_login", sender: self)
        } else {
            self.usernameLabel.text = prefs.value(forKey: "USERNAME") as! NSString as String
        }
    }
    func addGradient() {
        gradient = CAGradientLayer()
        let startColor = UIColor(red: 3/255, green: 196/255, blue: 190/255, alpha: 1)
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        gradient?.colors = [startColor.cgColor,endColor.cgColor]
        gradient?.startPoint = CGPoint(x: 0, y: 0)
        gradient?.endPoint = CGPoint(x: 0, y:1)
        gradient?.frame = view.frame
        self.view.layer.insertSublayer(gradient!, at: 0)
    }
}

