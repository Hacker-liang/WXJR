//
//  WXCheckUserPhoneViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/6/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXCheckUserPhoneViewController: UIViewController {

    @IBOutlet weak var captchaTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var captchaButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
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
        captchaButton.addTarget(self, action: #selector(startCountdown), forControlEvents: .TouchUpInside)
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
    
}



