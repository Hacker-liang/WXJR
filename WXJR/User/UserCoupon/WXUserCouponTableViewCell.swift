//
//  WXUserCouponTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserCouponTableViewCell: UITableViewCell {

    @IBOutlet weak var typeDescLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var expireDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var userCouponDetail: WXUserCouponModel? {
        didSet {
            self.renderViewContent()
        }
    }
    
    func renderViewContent() {
        typeDescLabel.text = self.userCouponDetail?.typeDesc
        if let expireDate = self.userCouponDetail?.timeExpire {
            expireDateLabel.text = "(过期时间: \(Constants.Y_M_D_DateFormatWithLongValue(NSTimeInterval(expireDate))))"
        } else {
            expireDateLabel.text = "(过期时间: 永久可用)"
        }
        if self.userCouponDetail?.status == "EXPIRED" {
            statusLabel.textColor = UIColor.lightGrayColor()
        } else {
            statusLabel.textColor = APP_THEME_COLOR
        }
        statusLabel.text = self.userCouponDetail?.statusDesc
        if let desc = self.userCouponDetail?.desc {
            descLabel.text = "说明: \(desc)"
        } else {
            descLabel.text = "说明: 暂无描述"

        }
        valueLabel.text = self.userCouponDetail?.friendlyParValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 5.0
        bgView.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
