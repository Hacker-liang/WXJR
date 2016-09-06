//
//  WXUserSignupViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/5/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserSignupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func loginAction(sender: AnyObject) {
        let loginCtl = WXUserLoginViewController()
        var subCtls = self.navigationController?.viewControllers
        subCtls?.removeLast()
        subCtls?.append(loginCtl)
        self.navigationController?.setViewControllers(subCtls!, animated: false)

        
    }
}
