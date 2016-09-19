//
//  WXLoanManager.swift
//  WXJR
//
//  Created by liangpengshuai on 9/9/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanManager: NSObject {
    
    class func loadRecommendLoanLis(completionBlock:(isSuccess: Bool, error: String?, retLoans: [WXLoanDetailModel]?)->()) {
        let url = "\(baseUrl)loans/summary"
        WXNetworkingAPI.GET(url, params: ["status":"OPENED"]) { (retObj, error) in
            if let retDic = retObj as? NSDictionary {
                var retArray: [WXLoanDetailModel] = []
                if let loans = retDic.objectForKey("open") as? NSArray {
                    for loanDic in loans {
                        retArray.append(WXLoanDetailModel(json: (loanDic as! Dictionary)))
                    }
                }
                completionBlock(isSuccess: true, error: nil, retLoans: retArray)
            } else {
                completionBlock(isSuccess: true, error: "", retLoans: nil)
            }
        }
    }
    
    class func loadAllLoanList(page: Int!, pageSize: Int!, completionBlock:(isSuccess: Bool, error: String?, retLoans: [WXLoanDetailModel]?)->()) {
        let url = "\(baseUrl)loans/getLoanWithPage"
        WXNetworkingAPI.GET(url, params: ["pageSize": pageSize, "currentPage": page, "status": "SCHEDULED"]) { (retObj, error) in
            if let retDic = retObj as? NSDictionary {
                var retArray: [WXLoanDetailModel] = []
                if let loans = retDic.objectForKey("results") as? NSArray {
                    for loanDic in loans {
                        retArray.append(WXLoanDetailModel(json: (loanDic as! Dictionary)))
                    }
                }
                completionBlock(isSuccess: true, error: nil, retLoans: retArray)
            } else {
                completionBlock(isSuccess: true, error: "", retLoans: nil)
            }
        }
    }
}
