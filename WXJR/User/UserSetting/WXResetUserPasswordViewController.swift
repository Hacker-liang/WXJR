//
//  WXResetUserPasswordViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/23/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXResetUserPasswordViewController: WXViewController {

    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "重设密码"
        self.view.backgroundColor = APP_PAGE_COLOR
        
        let leftView1 = UIView(frame: CGRectMake(0, 0, 10, 40))
        oldPasswordTF.leftView = leftView1
        oldPasswordTF.leftViewMode = .Always
        
        let leftView2 = UIView(frame: CGRectMake(0, 0, 10, 40))
        newPasswordTF.leftView = leftView2
        newPasswordTF.leftViewMode = .Always
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
