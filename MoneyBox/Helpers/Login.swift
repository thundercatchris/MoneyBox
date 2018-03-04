//
//  Login.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

// logs in, retrieves an authorisation key and stores it in user defaults for future http requests
class Login {
    
    func loginAndNewAuthKey(email:String, password: String, completionHandler: @escaping () -> Void) -> Void{
        let loginUrl = "https://api-test00.moneyboxapp.com/users/login"
        
        let parameters = [
            "Email": email,
            "Password": password,
            "Idfa": "the idfa of the ios device"]
        
        NetworkRequest().postRequest(url: loginUrl, parameters: parameters, useAuthKey: false) { (dict) in
            if let session = dict["Session"] as? NSDictionary, let tokenReturned = session["BearerToken"] as? String {
                let newAuthKey = "Bearer " + tokenReturned
                let defaults = UserDefaults.standard
                defaults.set(newAuthKey, forKey: "authKey")
               
                completionHandler()
            }
        }
      
    }
    
}
