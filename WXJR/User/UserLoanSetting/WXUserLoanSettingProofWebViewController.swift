//
//  WXOpenFundWebViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 10/12/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserLoanSettingProofWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var hud: WXHUD?
    
    var htmlData: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        if let dic = htmlData as? [NSObject : AnyObject] {
            let bodyData = WXNetworkingAPI.enCodeHttpRequestBody(dic)
            request.HTTPBody = bodyData
        }
        
        request.URL = NSURL(string: huifuRequestUrl)
        
        webView.loadRequest(request)
        webView.delegate = self
        self.navigationItem.title = "开通自动投标"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
