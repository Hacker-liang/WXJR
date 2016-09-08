//
//  WXLoarnListTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/8/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoarnListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bugButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4.0
        bgView.clipsToBounds = true
        
        bugButton.layer.cornerRadius = 4.0
        bugButton.clipsToBounds = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
