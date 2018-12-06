//
//  CameraViewController.swift
//  Armoir
//
//  Created by alex weitzman on 12/4/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBAction func clickedPhotoButton(_ sender: UIButton) {
        cameraImageView.image = (UIImage(named:"jeanJacketFlash"))
        Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    @IBAction func pressedExit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func timeToMoveOn() {
        //Put your segue identifier instead of gotoMainUi
        itemImage = UIImage(named:"jeanJacketFinal")!
        self.performSegue(withIdentifier: "toAddItemPage", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
