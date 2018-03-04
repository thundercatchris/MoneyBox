//
//  DisableView.swift
//  MoneyBox
//
//  Created by Cerebro on 03/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import UIKit

// creates an Acitivity indicator in the view whilst disabling user interraction
class DisableView {
    
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    func disable(view:UIView) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.red
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func enable(view:UIView) {
        activityIndicator.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
    
}
