//
//  WXCheckUserPhoneViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/6/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXCheckUserPhoneViewController: WXViewController {

    @IBOutlet weak var captchaTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var captchaButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var loginName: String!
    var password: String!
    var inviteCode: String!
    
    var timer: NSTimer?
    var count = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "验证手机"
        
        let leftView1 = UIView(frame: CGRectMake(0, 0, 10, 40))
        captchaTF.leftView = leftView1
        captchaTF.leftViewMode = .Always

        let leftView2 = UIView(frame: CGRectMake(0, 0, 10, 40))
        phoneTF.leftView = leftView2
        phoneTF.leftViewMode = .Always
        
        captchaTF.layer.cornerRadius = 5.0
        captchaTF.clipsToBounds = true
        
        phoneTF.layer.cornerRadius = 5.0
        phoneTF.clipsToBounds = true
        
        registerButton.layer.cornerRadius = 5.0
        registerButton.clipsToBounds = true
        
        captchaButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        captchaButton.setTitleColor(COLOR_TEXT_II, forState: .Disabled)
        captchaButton.titleLabel?.adjustsFontSizeToFitWidth = true
        captchaButton.addTarget(self, action: #selector(sendCaptchaAction), forControlEvents: .TouchUpInside)
    }
    
    func startCountdown() {
        captchaButton.enabled = false
        self.stopTimer()
        captchaButton.setTitle("\(count)s重新获取", forState: .Disabled)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(countdowning), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func countdowning() {
        if count == 0 {
            captchaButton.enabled = true
            captchaButton.setTitle("发送验证码", forState: .Normal)
            count = 60
            return
        }
        captchaButton.setTitle("\(count)s重新获取", forState: .Disabled)
        count -= 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func signupAction(sender: AnyObject) {
        self.view.endEditing(true)
        if !WXCommonMethods.isCorrectPhoneNumber(phoneTF.text) {
            self.view.makeToast("请输入正确的手机号")
            return
        }
        if self.inviteCode.characters.count == 0 {
            self.view.makeToast("请输入验证码")
            return
        }
        self.checkUserInviteCode()
        
    }
    
    func sendCaptchaAction() {
        self.view.endEditing(true)
        let url = "\(baseUrl)users/smsCaptcha"
        let params = ["mobile": phoneTF.text!];
        WXNetworkingAPI.GET(url, params: params) { (responseObject, error) in
            if let resp = responseObject as? NSDictionary {
                let success = resp.objectForKey("success") as! Bool
                if success {
                    self.view.makeToast("验证码发送成功")
                    self.startCountdown()
                } else {
                    self.view.makeToast("验证码发送失败")
                }
                
            }  else {
                self.view.makeToast("验证码发送失败")
            }
        }
    }
    
    func checkUserInviteCode() {
        let url = "\(baseUrl)users/smsCaptcha"
        let params = ["smsCaptcha": captchaTF.text!];
        WXNetworkingAPI.POST(url, params: params) { (responseObject, error) in
            if let resp = responseObject as? NSDictionary {
                let success = resp.objectForKey("success") as! Bool
                if success {
                    WXAccountManager.shareInstance().userSignup(self.loginName, password: self.password, mobile: self.phoneTF.text!, captcha: self.captchaTF.text!, inviteCode: self.inviteCode) { (isSuccess) in
                        if isSuccess {
                            self.view.makeToast("注册成功")
                            self.gotoLogin(self.loginName, password: self.password)
                        } else {
                            self.view.makeToast("注册失败，请重试！")

                        }
                    }
                } else {
                    self.view.makeToast("验证码输入错误")
                }
            } else {
                self.view.makeToast("网络错误,请重试")
            }
        }
    }
    
    func gotoLogin(loginName: String, password: String) {
        let loginCtl = WXUserLoginViewController()
        var subCtls = self.navigationController?.viewControllers
        subCtls?.removeAll()
        subCtls?.append(loginCtl)
        self.navigationController?.setViewControllers(subCtls!, animated: false)
        loginCtl.autoLogin(loginName, password: password)
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



