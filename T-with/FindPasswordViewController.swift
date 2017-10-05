//
//  FindPasswordViewController.swift
//  Twith
//
//  Created by 김동현 on 2017. 9. 29..
//  Copyright © 2017년 Raizup. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var findPasswordWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebPage()

        // Do any additional setup after loading the view.
    }

    func loadWebPage() {
        let url = "http://www.t-with.com/bbs/password_lost.php"
        let req = URLRequest(url: URL(string: url)!)
        
        self.findPasswordWebView.loadRequest(req)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
