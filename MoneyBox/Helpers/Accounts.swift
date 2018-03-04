//
//  Accounts.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

// singleton to fetch and access users accounts from anywhere in the app
class Accounts {
    
    static let sharedInstance: Accounts = Accounts()
    private var accountsArray:NSArray?
    
    func fetchAccounts(completionHandler: @escaping (_ returnedArray: NSArray) -> Void) -> Void{
        let thisWeek = "https://api-test00.moneyboxapp.com/investorproduct/thisweek"
        NetworkRequest().getRequest(url: thisWeek, completionHandler: { (thisWeekDict) in
            if let thisWeekasDict = thisWeekDict as? NSDictionary, let array = thisWeekasDict["Products"] as? NSArray {
                self.accountsArray = array
                completionHandler(self.accountsArray!)
            }
        })
    }
    
    func getAccounts() -> NSArray? {
        return accountsArray
    }
    
    
}
