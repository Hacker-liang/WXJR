//
//  WXUserLoginViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserLoginViewController: WXViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var loginName: String?
    var password: String?
    var autoLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        nicknameTF.layer.cornerRadius = 5.0
        nicknameTF.clipsToBounds = true
        
        let leftView1 = UIView(frame: CGRectMake(0, 0, 10, 40))
        nicknameTF.leftView = leftView1
        nicknameTF.leftViewMode = .Always
        nicknameTF.delegate = self
        
        passwordTF.layer.cornerRadius = 5.0
        passwordTF.clipsToBounds = true
        let leftView2 = UIView(frame: CGRectMake(0, 0, 10, 40))
        passwordTF.leftView = leftView2
        passwordTF.leftViewMode = .Always
        passwordTF.delegate = self
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5.0
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
        if autoLogin {
            self.nicknameTF.text = loginName
            self.passwordTF.text = password
            self.loginButton.sendActionsForControlEvents(.TouchUpInside)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func resetPasswordAction(sender: AnyObject) {
        let ctl = WXUserResetPasswordWebViewController()
        self.navigationController?.pushViewController(ctl, animated: true)
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        let signupCtl = WXUserSignupViewController()
        var subCtls = self.navigationController?.viewControllers
        subCtls?.removeLast()
        subCtls?.append(signupCtl)
        self.navigationController?.setViewControllers(subCtls!, animated: false)
    }
    
    @IBAction func gotoLogin(sender: AnyObject) {
        self.view.endEditing(true)
        let hud = WXHUD()
        hud.showHUDInView(self.view)
        WXAccountManager.shareInstance().userLogin(nicknameTF.text!, password: passwordTF.text!) { (isSuccess, errorStr) in
            hud.hideHUD()
            if isSuccess {
                self.view.makeToast("登录成功")

                self.dismissCtl()
            } else {
                self.view.makeToast("登录失败")
            }
        }
    }
    
    func autoLogin(loginName: String, password: String) {
        autoLogin = true
        self.loginName = loginName
        self.password = password
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
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
