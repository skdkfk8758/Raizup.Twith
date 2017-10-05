//
//  UserViewController.swift
//  twith
//
//  Created by 김동현 on 2017. 9. 11..
//  Copyright © 2017년 carpdm. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class WebViewController: UIViewController, UIWebViewDelegate{
    
    @IBOutlet weak var userWebView: UIWebView!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    
    var targerTitle:String?
    
    let defaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        sideBar()
        
        // 사이드메뉴 누르면 이동하는 부분
        if targerTitle != nil {
            switch targerTitle {
            case "logo"?:
                loadSidemenuPage(url:"http://www.t-with.com/?device=mobile")
                break
            case "location"?:
                loadSidemenuPage(url:"http://www.t-with.com/shop/list.php/?device=mobile")
                break
            case "activity"?:
                loadSidemenuPage(url:"http://www.t-with.com/shop/list.php?device=mobile")
                break
            case "MY INFO"?:
                loadSidemenuPage(url:"http://www.t-with.com/bbs/member_confirm.php?url=register_form.php?device=mobile")
                break
            case "BUY LIST"?:
                loadSidemenuPage(url:"http://www.t-with.com/shop/orderinquiry.php?device=mobile")
                break
            case "CART"?:
                loadSidemenuPage(url:"http://www.t-with.com/shop/cart.php?device=mobile")
                break
            case "WISH LIST"?:
                loadSidemenuPage(url:"http://www.t-with.com/shop/wishlist.php?device=mobile")
                break
            case "LOG OUT"?:
                logout()
                break
            case "CUSTOMER CENTER"?:
                loadSidemenuPage(url:"http://www.t-with.com/bbs/qalist.php?device=mobile")
                break
            case "FAQ"?:
                loadSidemenuPage(url:"http://www.t-with.com/bbs/faq.php?device=mobile")
                break
            case .none:
                print("asd")
            case .some(_):
                print("asd")
            }
        }
        else {
            // 기본 login page
            loadLoginPage()
        }
        
        let swipeLeftRecongnizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(recongnizer:)))
        let swipeRightRecongnizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(recongnizer:)))
        swipeLeftRecongnizer.direction = .left
        swipeRightRecongnizer.direction = .right
            
        userWebView.addGestureRecognizer(swipeLeftRecongnizer)
        userWebView.addGestureRecognizer(swipeRightRecongnizer)
        
    }
    
    // Webview Swipe 제스처
    @objc private func handleSwipe(recongnizer:UISwipeGestureRecognizer){
        // 앞으로가기 (사이드메뉴때문에 실행한됨)
//        if (recongnizer.direction == .left) {
//            if userWebView.canGoForward {
//                userWebView.goForward()
//            }
//        }
        if (recongnizer.direction == .right) {
            if userWebView.canGoBack {
                userWebView.goBack()
            }
        }
    }
    
    func sideBar() {
        if self.revealViewController() != nil {
            sideMenu.target = self.revealViewController()
            sideMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
//            sideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func loadLoginPage() {
        
        let url = "http://www.t-with.com/bbs/login_check.php?device=mobile"
        let header = ["Content-Type":"application/x-www-form-urlencoded"]
        let email = defaults.string(forKey: "email")
        let password = defaults.string(forKey: "password")
        
        let parameter = ["mb_id":email!, "mb_password":password!]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseString { (response) in
        
        let req = response.request
        self.userWebView.loadRequest(req!)

        }
    }
    
    // 사이드메뉴 누르면 이동
    func loadSidemenuPage(url:String) {
        let req = URLRequest(url:URL(string:url)!)
        self.userWebView.loadRequest(req)
    }
    
    func logout() {
    
        // 로그아웃버튼 누르면 실행 로그인때 사용했던 계정정보 삭제
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "password")
        
        // 쿠키 초기화
        HTTPCookieStorage.clear()
        
        self.performSegue(withIdentifier: "goToIntroView", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
