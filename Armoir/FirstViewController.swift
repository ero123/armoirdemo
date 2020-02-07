//
//  FirstViewController.swift
//  Armoir
//
//  Created by alex weitzman on 12/8/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBLoginButton()
        //loginButton.delegate = self as! LoginButtonDelegate
        loginButton.center = view.center
        view.addSubview(loginButton)
        //let loginButton = FBLoginButton(readPermissions: [ .publicProfile ])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedFB(_ sender: Any) {
       // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: "navigationVC") as! UINavigationController
        self.performSegue(withIdentifier: "toBegin", sender: self)
        //        self.present(nextViewController, animated:true, completion:nil)
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
