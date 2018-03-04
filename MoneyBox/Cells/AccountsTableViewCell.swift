//
//  AccountsTableViewCell.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit
import Foundation

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RoundBorder(view: borderView, colour: UIColor.black)
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
    }
    
    func RoundBorder(view:UIView, colour:UIColor) {
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1.5
        view.layer.borderColor = colour.cgColor
        view.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
