//
//  WXUserInvestRecordTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserFundRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var userFundDetail: WXUserFundRecordModel? {
        didSet {
            self.renderViewContent()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func renderViewContent() {
        amountLabel.text = "\(userFundDetail!.amount!)元"
        orderNumberLabel.text = userFundDetail?.orderId
        titleLabel.text = userFundDetail?.typeDesc
        statusLabel.text = userFundDetail?.statusDesc
        if let date = userFundDetail?.timeRecorded {
            timeLabel.text = "\(Constants.Y_M_D_H_M_S_DateFormatWithLongValue(date))"
        } else {
            timeLabel.text = "-"
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
