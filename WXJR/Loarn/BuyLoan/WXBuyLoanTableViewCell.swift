//
//  WXBuyLoanTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/21/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXBuyLoanTableViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
