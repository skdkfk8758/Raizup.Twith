//
//  RegisterViewController.swift
//  Twith
//
//  Created by 김동현 on 2017. 9. 19..
//  Copyright © 2017년 Raizup. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var registerWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage()
    }
    
    func loadWebPage() {
        let url = "http://www.t-with.com/bbs/register.php"
        let req = URLRequest(url: URL(string: url)!)
        
        self.registerWebView.loadRequest(req)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
