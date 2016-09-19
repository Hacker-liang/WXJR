//
//  WXUserInvestRecordTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserInvestRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var investModel: WXInvestModel? {
        didSet {
            self.renderViewContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func renderViewContent() {
        titleLabel.text = investModel!.loan.title
        statusLabel.text = investModel!.loan.statusDesc!
        totalMoneyLabel.text = "\(investModel!.amount!)元"
        incomeLabel.text = "\(investModel!.totalIncome)元"
        
        if let date = investModel!.endDate {
            dateLabel.text = "\(Constants.Y_M_D_DateFormatWithLongValue(date))"
        } else {
            dateLabel.text = "-"
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
