//
//  Alert.swift
//  MoneyBox
//
//  Created by Cerebro on 03/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import UIKit

// reusable UIAlert
class Alert {
    
    init(title:String, message:String, view:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        view.present(alertController, animated: true, completion: nil)
    }
   
}
