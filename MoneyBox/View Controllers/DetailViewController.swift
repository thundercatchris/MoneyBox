//
//  DetailViewController.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let disableView = DisableView()
    var indexNumber:Int?
    let accounts = Accounts.sharedInstance
    var product:NSDictionary?
    var maximumDeposit:Int?
    var investorProductId:Int?
    var moneybox:Int?
    let depositAmount = 10
    
    @IBOutlet weak var addDepositView: UIView!
    @IBOutlet weak var addDepositLabel: UILabel!
    @IBOutlet weak var moneyBoxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButton()
    }
    
    func setupView() {
        if let item = accounts.getAccounts()![indexNumber!] as? NSDictionary,  let accountProduct = item["Product"] as? NSDictionary, let friendlyName = accountProduct["FriendlyName"] as? String, let planValue = item["PlanValue"] {
            product = item
            
            // limit characters in title. length affects the animation of the Nav bar if too long
            var friendlyNameLimited = String(friendlyName)
            if friendlyName.count >= 20 {
                friendlyNameLimited = "\(String(friendlyName).prefix(17))..."
            }
            self.title = "\(friendlyNameLimited) £\(String(describing: planValue))"
            
            if let money = item["Moneybox"] as? Int {
                moneybox = money
                moneyBoxLabel.text = "your moneybox £\(String(describing: money))"
            }
            if let max = item["MaximumDeposit"] as? Int {
                maximumDeposit = max
            }
            if let id = item["InvestorProductId"] as? Int {
                investorProductId = id
            }
        }
    }
    
    func setupButton() {
        RoundBorder(view: addDepositView, colour: UIColor.clear)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.addDepositButtonAction))
        addDepositView.addGestureRecognizer(gesture)
        addDepositLabel.text = "Add £\(depositAmount) to my moneybox"
    }
    
    @objc func addDepositButtonAction() {
        if let id = investorProductId, let box = moneybox, let max = maximumDeposit {
            if (box + depositAmount) <= max { // can only deposit if still less than maximum deposit
                let parameters:[String : Any] = [
                    "Amount": depositAmount,
                    "InvestorProductId": id]
                let url = "https://api-test00.moneyboxapp.com/oneoffpayments"
                self.disableView.disable(view: self.view)
                NetworkRequest().postRequest(url: url, parameters: parameters, useAuthKey: true) { (_) in
                    self.reLoadAccounts()
                }
            } else {
                _ = Alert(title: "Maximum reached", message: "This deposit would put you over your yearly limit", view: self)
            }
        }
    }
    
    // Reloading all acounts here. Normally would reload just one if the call was available, or use persistance to update the new value on the view
    func reLoadAccounts() {
        let accounts = Accounts.sharedInstance
        accounts.fetchAccounts(completionHandler: { (accounts) in
            self.setupView()
            self.disableView.enable(view: self.view)
        })
    }
    
    func RoundBorder(view:UIView, colour:UIColor) {
        view.layer.cornerRadius = 7.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = colour.cgColor
        view.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
