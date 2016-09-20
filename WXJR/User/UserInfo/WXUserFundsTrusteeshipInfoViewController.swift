//
//  WXUserFundsTrusteeshipInfoViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/6/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserFundsTrusteeshipInfoViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "托管帐号"
        contentView.layer.cornerRadius = 5.0
        contentView.clipsToBounds = true
        
        WXUserManager.loadUserFundsTrusteeshipAccount(WXAccountManager.shareInstance().accountDetail!.userId) { (isSuccess, accountInfo) in
            if isSuccess {
                self.accountLabel.text = accountInfo?.accountId
                self.nicknameLabel.text = accountInfo?.accountName
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
