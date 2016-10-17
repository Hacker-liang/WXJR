//
//  WXOpenFundWebViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 10/12/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserResetPasswordWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var hud: WXHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "重置密码"
        webView.delegate = self
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "http://wxfintech.com/h5/password")
        self.webView.loadRequest(request)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let urlStr = request.URL?.absoluteString {
            if urlStr.containsString("/h5/dashboard") {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        if hud != nil {
            hud?.hideHUD()
            
        }
        hud = WXHUD()
        hud?.showHUDInView(self.view)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if hud != nil {
            hud?.hideHUD()
        }
    }

}
