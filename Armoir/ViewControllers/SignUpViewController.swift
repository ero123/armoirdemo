//
//  SignUpViewController.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/3/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.addTarget(self, action: #selector(goBackToSignIn), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(SignUpViewController.signUp), for: .touchUpInside)
    }
    
    @objc func goBackToSignIn()
    {
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func signUp()
    {
        
        //get dbRef from appDel
        let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef!
        
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {return}
        
       
        //check if username is avail
        isUsernameAvailable(username: username) {
            isAvail in
            
            //if avail, signUp
            if(isAvail)
            {
                Auth.auth().createUser(withEmail: email, password: password, completion: {
                    authResult, error in
                    
                    
                    dbRef.child(Const.dbConst.usersQuickListKey).observeSingleEvent(of: .value, with: {
                        snapshot in
                        
                        print("snapshot value: \(snapshot.value)")
                        
                        //get uid on usersList & add username to list
                        dbRef.child(Const.dbConst.usersQuickListKey).childByAutoId().setValue(username)
                        
                        //return to root view controller
                        print("signUp Success!")
                       // self.navigationController!.popViewController(animated: true)
                    })
                    
                })
            }else{
                print("username: \(username) is not available")
            }
            
            
        }
        
       
        
    }
    

   
    
    
    func isUsernameAvailable(username : String, doSignUp: @escaping (Bool) -> Void )
    {
        
        //isUsernameAvail flag
        var isUsernameAvail : Bool = false
        
        //get dbref from appDel
        let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef!
        
        //check username list prior to allowing signup, see if usename is avail.
        dbRef.child(Const.dbConst.usersQuickListKey).observeSingleEvent(of: .value, with: {
            snapshot in
            print(snapshot.value)
            
            if let usernameList : [String] = snapshot.value as? [String]
            {
                for usernameFromDB in usernameList
                {
                    if(usernameFromDB == username)
                    {
                        isUsernameAvail = false
                    }
                }
                 isUsernameAvail = true
            }else{
                print("There are no users in this list, username is available")
                isUsernameAvail = true
            }
               doSignUp(isUsernameAvail)
        })
        
     
        
    }
}
