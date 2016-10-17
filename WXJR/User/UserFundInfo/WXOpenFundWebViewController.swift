//
//  WXOpenFundWebViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 10/12/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXOpenFundWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var hud: WXHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openFundRequest()
        self.navigationItem.title = "开通汇付帐号"
        webView.delegate = self
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)

    }
    
    func openFundRequest() {
        let url = "\(baseUrl)payment/account/open/request"
        let params = ["userId": (WXAccountManager.shareInstance().accountDetail?.userId)!, "pageType": 2];
        hud = WXHUD()
        hud?.showHUDInView(self.view)
        WXNetworkingAPI.POST(url, params: params as [NSObject : AnyObject]) { (responseObject, error) in
            self.hud?.hideHUD()
            
            if let retData = responseObject as? NSDictionary {
                if let successDic = retData.objectForKey("data") as? NSDictionary {
                    let request = NSMutableURLRequest()
                    request.HTTPMethod = "POST"
                    let bodyData = WXNetworkingAPI.enCodeHttpRequestBody(successDic as [NSObject : AnyObject])
                    request.HTTPBody = bodyData
                    request.URL = NSURL(string: huifuRequestUrl)
                    self.webView.loadRequest(request)
                } else {
                    self.view.makeToast("请求失败，请重试")
                }
            } else {
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let urlStr = request.URL?.absoluteString {
            if urlStr.containsString("/payment/ios/myiosFunction") {
                self.dismissViewControllerAnimated(true, completion: nil)
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
