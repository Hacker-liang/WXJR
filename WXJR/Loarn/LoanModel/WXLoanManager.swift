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
        let set = NSMutableSet()
        set.addObject("OPENED")
        set.addObject("SCHEDULED")
        WXNetworkingAPI.GET(url, params: ["status":set]) { (retObj, error) in
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
    
    /**
     获取标的详情
     
     - parameter loanId:
     - parameter completionBlock: 
     */
    class func loadLoanDetail(loanId: String, completionBlock :(isSuccess: Bool, loanDetail: WXLoanDetailModel?) -> ()) {
        let url = "\(baseUrl)loan/\(loanId)"
        WXNetworkingAPI.GET(url, params: nil) { (retObj, error) in
            if let retDic = retObj as? NSDictionary {
                let loan = WXLoanDetailModel(json: retDic as! [String : AnyObject])
                completionBlock(isSuccess: true, loanDetail: loan)
            } else {
                completionBlock(isSuccess: true, loanDetail: nil)
            }
        }
    }
    
    //获取标的的投资列表
    class func loadInvestOfLoan(loanId: String, completionBlock :(isSuccess: Bool, investList: [WXInvestModel]!) -> ()) {
        let url = "\(baseUrl)loan/\(loanId)/invests"
        WXNetworkingAPI.GET(url, params: nil) { (retObj, error) in
            if let retDic = retObj as? NSArray {
                var retList = [WXInvestModel]()
                for dic in retDic {
                    let investModel = WXInvestModel(json: dic as! NSDictionary)
                    retList.append(investModel)
                }
                completionBlock(isSuccess: true, investList: retList)
            } else {
                completionBlock(isSuccess: true, investList: nil)
            }
        }
    }

    
    /**
     获取标的的资料
     
     - parameter loanId:
     - parameter completionBlock:
     */
    class func loadLoanProof(loanRequestId: String, completionBlock :(isSuccess: Bool, imageList: [String]?) -> ()) {
        let url = "\(hostUrl)loan/\(loanRequestId)/proof"
        WXNetworkingAPI.GET(url, params: nil) { (retObj, error) in
            if let retDic = retObj as? NSDictionary {
                let array = retDic.allValues
                var retArray: [String] = []
                for dic in array {
                    retArray.append((dic as! Dictionary)["src"]!)
                }
                completionBlock(isSuccess: true, imageList: retArray)
                
            } else {
                completionBlock(isSuccess: false, imageList: nil)
            }
        }
    }
    
    class func buyLoan(loanId: String, amount: Int, placementId: String?, completionBlock :(isSuccess: Bool, retData: NSDictionary?) -> ()) {
        let url = "\(baseUrl)payment/tender/request"
        WXNetworkingAPI.POST(url, params: ["amount": amount, "loanId": loanId, "placementId" :placementId ?? "",  "userId": (WXAccountManager.shareInstance().accountDetail?.userId)!]) { (retObj, error) in
            if let ret = retObj as? NSDictionary {
               completionBlock(isSuccess: true, retData: ret)
            } else {
                completionBlock(isSuccess: false, retData: nil)
            }
        }
    }
    
    class func buyLoanInHUTX(data: NSDictionary, completionBlock :(isSuccess: Bool, retData: NSData?) -> ()) {
        let url = "http://mertest.chinapnr.com/muser/publicRequest"
        let type =  "application/x-www-form-urlencoded"
        WXNetworkingAPI.POST(url, params: data as [NSObject : AnyObject], contentType: type) { (retObj, error) in
            completionBlock(isSuccess: true, retData: (retObj as! NSData))
        }
    }
    
    
}











