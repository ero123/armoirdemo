//
//  MainViewController.swift
//  Armoir
//
//  Created by alex weitzman on 11/30/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var browseViewController: UIViewController!
    
    var closetViewController: UIViewController!
    
    var newsViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    
    var viewArray: [UIView]!
    
    var selectedIndex: Int = 1
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var closetView: UIView!
    
    @IBOutlet weak var newsView: UIView!
    
    override func viewDidLoad() {
        viewArray = [searchView, closetView, newsView]
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        browseViewController = storyboard.instantiateViewController(withIdentifier: "BrowseViewController")
        
        closetViewController = storyboard.instantiateViewController(withIdentifier: "ClosetViewController")
        
        newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController")
        
        viewControllers = [browseViewController, closetViewController, newsViewController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
    }
    
    @IBAction func didPressTab(_ sender: UIButton) {
        
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        viewArray[previousIndex].backgroundColor = UIColor(hue: 0.0778, saturation: 0.17, brightness: 0.81, alpha: 1.0)
        viewArray[selectedIndex].backgroundColor = UIColor(hue: 0.075, saturation: 0.19, brightness: 0.76, alpha: 1.0)
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
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
