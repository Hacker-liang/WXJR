//
//  WXUserFundsTrusteeshipInfoViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/6/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserFundsTrusteeshipInfoViewController: WXViewController, UIAlertViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "托管帐号"
        contentView.layer.cornerRadius = 5.0
        contentView.clipsToBounds = true
        self.contentView.hidden = true
        self.titleLabel.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let hud = WXHUD()
        hud.showHUDInView(self.view)
        WXUserManager.loadUserFundsTrusteeshipAccount(WXAccountManager.shareInstance().accountDetail!.userId) { (isSuccess, accountInfo) in
            hud.hideHUD()
            if isSuccess {
                self.contentView.hidden = false
                self.titleLabel.hidden = false
                self.accountLabel.text = accountInfo?.accountId
                self.nicknameLabel.text = accountInfo?.accountName
                
            } else {
                self.contentView.hidden = true
                self.titleLabel.hidden = true
                let alertView = UIAlertView(title: "您未开通托管帐号,请立即开通", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "开通")
                alertView.showAlertViewWithBlock({ (index) in
                    if index == 1 {
                        let ctl = WXOpenFundWebViewController()
                        ctl.hidesBottomBarWhenPushed = true
                        self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: nil)
                    }
                })
                
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
