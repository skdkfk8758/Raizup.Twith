//
//  IntroViewController.swift
//  twith
//
//  Created by 김동현 on 2017. 9. 11..
//  Copyright © 2017년 carpdm. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class IntroViewController: UIViewController {
    
    @IBOutlet weak var introButton: UIButton!
    
    let defaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introButton.layer.cornerRadius = 10
        introButton.clipsToBounds = true
        
        defaults.string(forKey: "email")
        
//        print(defaults.string(forKey: "email"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.string(forKey: "email") != nil && defaults.string(forKey: "password") != nil {
          self.performSegue(withIdentifier: "goToWebView", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
