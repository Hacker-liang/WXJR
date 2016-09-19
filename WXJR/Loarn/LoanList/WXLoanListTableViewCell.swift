//
//  WXLoanListTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/8/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanListTableViewCell: UITableViewCell {

    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bugButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeCostLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var remainPriceLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var loanDetail: WXLoanDetailModel? {
        didSet {
            self.renderView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4.0
        bgView.clipsToBounds = true
        
        bugButton.layer.cornerRadius = 4.0
        bugButton.clipsToBounds = true

    }
    
    func renderView() {
        titleLabel.text = loanDetail?.title
        totalPriceLabel.text = "总结额: \(loanDetail!.amount!)元"
        remainPriceLabel.text = "可投金额: \(loanDetail!.balance!)元"
        typeLabel.text = loanDetail!.payMethodDesc
        let rateValue: Float = Float((loanDetail?.rate)!/100)
        rateLabel.text = "\(rateValue)%"
        timeCostLabel.text = loanDetail?.duration?.durationDesc
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
