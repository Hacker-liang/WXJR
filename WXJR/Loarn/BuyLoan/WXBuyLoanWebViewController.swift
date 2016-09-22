//
//  WXBuyLoanWebViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/22/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXBuyLoanWebViewController: UIViewController {
    
    var htmlData: NSData?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadData(htmlData!, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: NSURL(string: "http://mertest.chinapnr.com/muser")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
