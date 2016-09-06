//
//  WXUserLoginViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserLoginViewController: UIViewController {

    
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        nicknameTF.layer.cornerRadius = 5.0
        nicknameTF.clipsToBounds = true
        
        let leftView1 = UIView(frame: CGRectMake(0, 0, 10, 40))
        nicknameTF.leftView = leftView1
        nicknameTF.leftViewMode = .Always
        
        passwordTF.layer.cornerRadius = 5.0
        passwordTF.clipsToBounds = true
        let leftView2 = UIView(frame: CGRectMake(0, 0, 10, 40))
        passwordTF.leftView = leftView2
        passwordTF.leftViewMode = .Always
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5.0
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
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
    
    
    @IBAction func registerAction(sender: AnyObject) {
        let signupCtl = WXUserSignupViewController()
        var subCtls = self.navigationController?.viewControllers
        subCtls?.removeLast()
        subCtls?.append(signupCtl)
        self.navigationController?.setViewControllers(subCtls!, animated: false)
    }
    
    @IBAction func gotoLogin(sender: AnyObject) {
        
        let loginUrl = "\(BASE_URL)ajaxLogin"
        let params = NSMutableDictionary()
        params.setObject(nicknameTF.text!, forKey: "loginName")
        params.setObject(passwordTF.text!, forKey: "password")

        WXNetworkingAPI.POST(loginUrl, params: params as [NSObject : AnyObject]) { (isSuccess, responseObject, error) in
            
        }
    }
}
