//
//  ViewController.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let disableView = DisableView()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoundBorder(outlet: passwordField, colour: UIColor.black)
        RoundBorder(outlet: emailField, colour: UIColor.black)
        RoundBorder(outlet: loginButton, colour: UIColor.clear)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        setupTestAccount() // only in place for testing purposes, please delete for live use
    }
    
    func setupTestAccount() {
        emailField.text = "test+env12@moneyboxapp.com"
        passwordField.text = "Money$$box@107"
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            disableView.disable(view: view)
            Login().loginAndNewAuthKey(email: email, password: password, completionHandler: { 
                self.loadAccounts()
            })
        } else {
            disableView.enable(view: view)
            _ = Alert(title: "Login failed", message: "Please try again", view: self)
        }
    }
    
    func loadAccounts() {
        let accounts = Accounts.sharedInstance
        accounts.fetchAccounts(completionHandler: { (accounts) in
            self.disableView.enable(view: self.view)
            self.performSegue(withIdentifier: "ListView", sender: nil)
        })
    }
    
    // reusable border method
    func RoundBorder(outlet:UIControl, colour:UIColor) {
        outlet.layer.cornerRadius = 7.0
        outlet.layer.borderWidth = 1.0
        outlet.layer.borderColor = colour.cgColor
        outlet.layer.masksToBounds = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

