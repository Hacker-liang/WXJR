//
//  WXUserSignupViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/5/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserSignupViewController: UIViewController, UIActionSheetDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var inviteCodeTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        
        let leftView1 = UIView(frame: CGRectMake(0, 0, 10, 40))
        nicknameTF.leftView = leftView1
        nicknameTF.leftViewMode = .Always
        nicknameTF.delegate = self
        
        let leftView2 = UIView(frame: CGRectMake(0, 0, 10, 40))
        passwordTF.leftView = leftView2
        passwordTF.leftViewMode = .Always
        passwordTF.delegate = self
        
        let leftView3 = UIView(frame: CGRectMake(0, 0, 10, 40))
        inviteCodeTF.leftView = leftView3
        inviteCodeTF.leftViewMode = .Always
        inviteCodeTF.delegate = self
        
        
        nextButton.layer.cornerRadius = 5.0
        nextButton.clipsToBounds = true
        
        nicknameTF.layer.cornerRadius = 5.0
        nicknameTF.clipsToBounds = true
        
        passwordTF.layer.cornerRadius = 5.0
        passwordTF.clipsToBounds = true

        inviteCodeTF.layer.cornerRadius = 5.0
        inviteCodeTF.clipsToBounds = true
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func getInviteCodeAction(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: "获取邀请码", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "免费联系未馨客服")
        actionSheet.showInView(self.view)
    }
    
    @IBAction func nextstepAction(sender: AnyObject) {
        self.view.endEditing(true)
        if nicknameTF.text?.characters.count == 0 {
            self.view.makeToast("请输入用户名")
            return
        }
        if passwordTF.text?.characters.count == 0 {
            self.view.makeToast("请输入密码")
            return
        }
        WXUserManager.userGroupIsExist(inviteCodeTF.text ?? "") { (isExist) in
            if isExist {
                let checkUserPhoneCtl = WXCheckUserPhoneViewController()
                self.navigationController?.pushViewController(checkUserPhoneCtl, animated: true)
                checkUserPhoneCtl.loginName = self.nicknameTF.text
                checkUserPhoneCtl.password = self.passwordTF.text
                checkUserPhoneCtl.inviteCode = self.inviteCodeTF.text
                
            } else {
                self.view.makeToast("无效邀请码")
            }
        }
        
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let loginCtl = WXUserLoginViewController()
        var subCtls = self.navigationController?.viewControllers
        subCtls?.removeLast()
        subCtls?.append(loginCtl)
        self.navigationController?.setViewControllers(subCtls!, animated: false)
    }
    
    //MARK: UIActionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            UIApplication.sharedApplication().openURL(NSURL(string :"tel://400-998-6623")!)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == " "{
            return false
        }
        if string == "\n" {
            textField.endEditing(true)
        }
        return true
    }
    
}






