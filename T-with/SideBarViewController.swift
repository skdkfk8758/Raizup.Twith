//
//  SideBarViewController.swift
//  Twith
//
//  Created by 김동현 on 2017. 9. 21..
//  Copyright © 2017년 Raizup. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuNameArr:Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuNameArr = ["MY INFO", "BUY LIST", "CART", "WISH LIST", "LOG OUT", "CUSTOMER CENTER", "FAQ"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        cell.menuLabel.text! = menuNameArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        if cell.menuLabel.text! != nil {
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            
            callSideMenu(title: cell.menuLabel.text!)
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let buttonId = sender as! UIButton
        callSideMenu(title: buttonId.restorationIdentifier!)
    }
    
    func callSideMenu(title:String){
        
        self.performSegue(withIdentifier: "goToWebView", sender: title)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! WebViewController
        destination.targerTitle = sender as? String
    }
   
}
