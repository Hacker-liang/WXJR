//
//  WXBuyLoanWebViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/22/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXBuyLoanWebViewController: UIViewController, UIWebViewDelegate {
    
    var htmlData: NSDictionary?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        if let dic = htmlData?.objectForKey("data") as? [NSObject : AnyObject] {
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
                NSNotificationCenter.defaultCenter().postNotificationName("buyLoanOver", object: nil)
            }
        }
        return true
    }

}
