//
//  WXWithdrawWebViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/28/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXWithdrawWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var htmlData: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        if let dic = htmlData as? [NSObject : AnyObject] {
            let bodyData = WXNetworkingAPI.enCodeHttpRequestBody(dic)
            request.HTTPBody = bodyData
        }
        
        request.URL = NSURL(string: "http://mertest.chinapnr.com/muser/publicRequests")
        //        request.URL = NSURL(string: "https://lab.chinapnr.com/muser/publicRequests")
        
        webView.loadRequest(request)
        webView.delegate = self
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
    
    
}
