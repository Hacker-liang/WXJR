//
//  WXRechargeViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/27/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXRechargeViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var valueTF: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "充值"
        self.view.backgroundColor = APP_PAGE_COLOR
        confirmButton.layer.cornerRadius = 4.0
        
        let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
        amountLabel.text = "账户余额: \(totalRemaing)元"
        valueTF.delegate = self
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func rechargeAction(sender: AnyObject) {
        self.view.endEditing(true)
        let hud = WXHUD()
        hud.showHUDInView(self.view)
        let value = Int(self.valueTF.text ?? "0") ?? 0
        WXUserManager.userRecharge((WXAccountManager.shareInstance().accountDetail?.userId)!, amount: value) { (isSuccess, rechargeInfo) in
            hud.hideHUD()
            if isSuccess {
                let ctl = WXRechargeWebViewController()
                ctl.htmlData = rechargeInfo
                self.navigationController?.pushViewController(ctl, animated: true)
            } else {
                self.view.makeToast("网络请求失败，请重试")
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        return true
    }
}












