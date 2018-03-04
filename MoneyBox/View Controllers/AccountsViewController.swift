//
//  AccountsViewController.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let disableView = DisableView()
    var accountsArray:NSArray?
    let accounts = Accounts.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountsArray = accounts.getAccounts()
        tableView.delegate = self
        tableView.dataSource = self
        
        // changes Back button to Logout button
        let newBackButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AccountsViewController.logout(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func logout(sender: UIBarButtonItem) {
        disableView.disable(view: self.view)
        NetworkRequest().logOut { (success) in
            if success { _ = self.navigationController?.popViewController(animated: true)
            } else { _ = Alert(title: "Logout failed", message: "Please try again", view: self) }
            self.disableView.enable(view: self.view)
        } 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (accountsArray != nil) ? (accountsArray?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsCell", for: indexPath) as! AccountsTableViewCell
        cell.prepareForReuse()
        if let item = accountsArray![indexPath.row] as? NSDictionary,  let product = item["Product"] as? NSDictionary, let friendlyName = product["FriendlyName"] as? String {
            cell.nameLabel.text = friendlyName + " >"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" ,
            let nextScene = segue.destination as? DetailViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            nextScene.indexNumber = indexPath.row
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
