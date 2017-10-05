//
//  SideBarTableViewController.swift
//  Twith
//
//  Created by 김동현 on 2017. 9. 23..
//  Copyright © 2017년 Raizup. All rights reserved.
//

import UIKit

class SideBarTableViewController: UITableViewController{
    
    @IBOutlet weak var logoCell: UIView!
    @IBOutlet weak var locationCell: UITableViewCell!
    @IBOutlet weak var activityCell: UITableViewCell!
    @IBOutlet weak var myinfoCell: UITableViewCell!
    @IBOutlet weak var buylistCell: UITableViewCell!
    @IBOutlet weak var cartCell: UITableViewCell!
    @IBOutlet weak var wishlistCell: UITableViewCell!
    @IBOutlet weak var logoutCell: UITableViewCell!
    @IBOutlet weak var faqCell: UITableViewCell!
    @IBOutlet weak var qnaCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! WebViewController
        destination.targerTitle = sender as! String
    }

}
