//
//  LoginViewController.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/3/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController
{

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
    }
    
    
    
   @objc func login()
    {
        //if fields are not empty sign-in else tell user to enter valid input
        guard let emailAdr = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        //sign-in with firebase auth
        Auth.auth().signIn(withEmail: emailAdr, password: password, completion: {
            authResult, error in
            
            if let thisError = error
            {
                print(thisError.localizedDescription)
            }else{
                    print("signIn Success!")
            }
            
            let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef
            
            //get quickList of users
            dbRef!.child(Const.db.userKeys.usersQuickListKey).observe(.value, with: {
                snapshot in
                print("quickList from login: \(snapshot.value)")
            })
            
            //set appUsername in appDel
//            (UIApplication.shared.delegate as! AppDelegate).armoirUsername =
           //load mainVC
            self.loadRootVC()
        })
        
    }
    
    
    func loadRootVC()
    {
        let mainVC = self.storyboard!.instantiateViewController(withIdentifier: "setupVC")
        self.navigationController!.isNavigationBarHidden = true
        
        self.navigationController!.pushViewController(mainVC, animated: true)
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
