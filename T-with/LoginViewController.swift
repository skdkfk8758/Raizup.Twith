//
//  LoginViewController.swift
//
//
//  Created by 김동현 on 2017. 9. 11..
//
//

import UIKit
import Alamofire
import Kanna
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let defaults:UserDefaults = UserDefaults.standard
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        self.checkAccount(email:userEmailTextField.text!, password: userPasswordTextField.text!)
        
    }
    func checkAccount(email:String, password:String) {
        let url = "http://www.t-with.com/bbs/login_check.php"
        let header = ["Content-Type":"application/x-www-form-urlencoded"]
        let parameter = ["mb_id":email, "mb_password":password]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseString { (response) in
                
                if let doc = Kanna.HTML(html: String(describing: response), encoding: .utf8) {
                    
                    var check = 0
                    
                    // Search for nodes by XPath
                    for link in doc.xpath("//div[@id='hd_login_msg']") {
                        
                        let authCheck = link.text
                        
                        check = 1
                        
                        if authCheck != nil {
                            let userEmail = email
                            let userPassword = password
                            
                            // 자동로그인 설정을위해 계정정보 저장
                            self.defaults.set(userEmail, forKey: "email")
                            self.defaults.set(userPassword, forKey: "password")
                            
                            self.performSegue(withIdentifier: "goToWebView", sender: nil)
                            
                            // 쿠키저장
                            HTTPCookieStorage.save()
//                            print(HTTPCookieStorage.restore())
                        }
                    }
                    if check == 0 {
                        //error message in case of invalid credential
                        let msg = "Login Fail"
                        let dialogMessage = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
                        
                        let ok = UIAlertAction(title: "OK", style: .default)
                        
                        dialogMessage.addAction(ok)
                        
                        self.present(dialogMessage, animated: true, completion: nil)
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        
        registerButton.layer.cornerRadius = 5
        registerButton.clipsToBounds = true
        registerButton.layer.borderWidth = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HTTPCookieStorage {
    static func clear(){
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    static func save(){
        var cookies = [Any]()
        if let newCookies = HTTPCookieStorage.shared.cookies {
            for newCookie in newCookies {
                var cookie = [HTTPCookiePropertyKey : Any]()
                cookie[.name] = newCookie.name
                cookie[.value] = newCookie.value
                cookie[.domain] = newCookie.domain
                cookie[.path] = newCookie.path
                cookie[.version] = newCookie.version
                if let date = newCookie.expiresDate {
                    cookie[.expires] = date
                }
                cookies.append(cookie)
            }
            UserDefaults.standard.setValue(cookies, forKey: "cookies")
            UserDefaults.standard.synchronize()
        }
        
    }
    static func restore(){
        if let cookies = UserDefaults.standard.value(forKey: "cookies") as? [[HTTPCookiePropertyKey : Any]] {
            for cookie in cookies {
                if let oldCookie = HTTPCookie(properties: cookie) {
                    print("cookie loaded:\(oldCookie)")
                    HTTPCookieStorage.shared.setCookie(oldCookie)
                }
            }
        }
    }
}
