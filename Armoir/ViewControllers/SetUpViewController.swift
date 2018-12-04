//
//  SetUpViewController.swift
//  Armoir
//
//  Created by Cisco Vlahakis on 12/3/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var saveDataButton: UIButton!
    @IBOutlet var bio: UITextView!
    @IBOutlet var address: UITextField!
    @IBOutlet var addProfileImage: UIButton!
    
    var imagePickerVC = UIImagePickerController()
   
    
    //init functions
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set imagePickerVC delegate (first responder)
        imagePickerVC.delegate = self

        // Do any additional setup after loading the view.
        saveDataButton.addTarget(self, action: #selector(SetUpViewController.moveForward), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.addTarget(self, action: #selector(SetUpViewController.shouldSelectImageFromImagePickerView))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        
        
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.borderWidth = 1.5
        profileImageView.layer.backgroundColor = UIColor.orange.cgColor
        
        saveDataButton.addTarget(self, action: #selector(SetUpViewController.saveAndPresentMainVC), for: .touchUpInside)
        
        
        
    }
    
    @objc func saveAndPresentMainVC()
    {
        //validate data
        guard didUpdateProfile() else{return}
        
        //save to firebase
        
        //serialize image from profileImageView
        let serializedImage = profileImageView.image!.convertImageToBase64()
        
        let dirKeys = Const.db.userKeys.createUser.inDirectory
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        //example clothing object
//        let clothingInfo = [
//            dirKeys.clothingInfoKey.sizeForTopKey : "",
//            dirKeys.clothingInfoKey.sizeForBottomKey : ""
//        ]
        
        // confirm that the upload of information has actually submitted into firebase
        let email = appDel.fireAuth.currentUser!.email!
        let encodedImage = profileImageView.image!.convertImageToBase64()
        
        // **** update the UIConstraints in UIStoryboard to see the textfields in the SetUpViewController ****
        let userInfoDict : [String : Any] = [
            dirKeys.usernameKey : appDel.armoirUsername,
            dirKeys.bioKey : bio.text!,
            dirKeys.addressKey : address.text!,
            dirKeys.emailKey : email,
            dirKeys.encodedImageKey : encodedImage,
            dirKeys.clothingInfoKey : ""
        ]
        
        let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef!
        
        dbRef.child(Const.db.userKeys.usersDirectoryKey).observeSingleEvent(of: .value, with: {
            snapshot in
            
            //temp print
            print(snapshot.value)
            
            // *** armoirUsername property has to have a username ***
            dbRef.child("\(Const.db.userKeys.usersDirectoryKey)/\(appDel.armoirUsername)").setValue(userInfoDict)
            
        })
    
    }
     func didUpdateProfile() -> Bool
    {
        //validate text field data & imageView...
        return true
    }
    @objc func shouldSelectImageFromImagePickerView()
    {
        //logic to decide if imagePickerVC should be displayed (replace true with cond. statement)
        
        guard true else{return}
        self.present(imagePickerVC, animated: true, completion: nil)
    }

    
    @objc func moveForward()
    {
        guard let bio = bio.text, let address = address.text else {
            
            self.view.reportError(withText: "Error Message", withDuration: 1.0)
            return
        }
    }
    
//    ---- DELEGATE METHODS ---
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image found!")
            return
        }
        
        profileImageView.image = image
            imagePickerVC.dismiss(animated: true, completion: nil)
    }


}
