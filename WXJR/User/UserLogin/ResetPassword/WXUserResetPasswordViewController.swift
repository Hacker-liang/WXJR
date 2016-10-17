//
//  WXUserLoginViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var telTF: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    var loginName: String?
    var password: String?
    var autoLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "重置密码"
        nicknameTF.layer.cornerRadius = 5.0
        nicknameTF.clipsToBounds = true
        
        let leftView1 = UIView(frame: CGRectMake(0, 0, 10, 40))
        nicknameTF.leftView = leftView1
        nicknameTF.leftViewMode = .Always
        nicknameTF.delegate = self
        
        telTF.layer.cornerRadius = 5.0
        telTF.clipsToBounds = true
        let leftView2 = UIView(frame: CGRectMake(0, 0, 10, 40))
        telTF.leftView = leftView2
        telTF.leftViewMode = .Always
        telTF.delegate = self
        
        resetButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 5.0
        
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
    
    @IBAction func gotoReset(sender: AnyObject) {
        self.view.endEditing(true)
        let hud = WXHUD()
        hud.showHUDInView(self.view)
        WXUserManager.userResetPassword(nicknameTF.text!, tel: telTF.text!) { (isSuccess) in
            
        }
       
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
