//
//  WXUserLoanSettingViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 24/10/2016.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserLoanSettingViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.title = "自动投标"
        //        self.setupLoanSetting()
                self.loadUserLoanSetting()
        self.tableView.registerNib(UINib(nibName: "WXUserLoanSettingOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "loanSettingOpen")
        self.tableView.registerNib(UINib(nibName: "WXUserLoanSettingDateTableViewCell", bundle: nil), forCellReuseIdentifier: "userLoanSettingDate")
        self.tableView.registerNib(UINib(nibName: "WXUserLoanSettingRateTableViewCell", bundle: nil), forCellReuseIdentifier: "userLoanSettingRate")
        self.tableView.registerNib(UINib(nibName: "WXUserLoanSettingMoneyTableViewCell", bundle: nil), forCellReuseIdentifier: "userLoanSettingMoney")

        self.tableView.separatorColor = COLOR_LINE
        
        /*
        WXUserManager.openHuifuLoanSetting((WXAccountManager.shareInstance().accountDetail?.userId)!, isActive: true, autoBidAmount: 1000) { (isSuccess, retData) in
            if isSuccess {
                let ctl = WXUserLoanSettingProofWebViewController()
                ctl.htmlData = retData
                self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: {
                    
                })
            }
        }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupLoanSetting() {
        WXUserManager.setupUserLoanSetting((WXAccountManager.shareInstance().accountDetail?.userId)!, isActive: true, autoBidAmount: 1000, autoBidRemainAmount: 100, annualRateFrom: 100, annualRateTo: 3200, durationFrom: 1, durationTo: 48) { (isSuccess) in
            
        }
    }
    
    func loadUserLoanSetting() {
        WXUserManager.loadUserLoanSetting((WXAccountManager.shareInstance().accountDetail?.userId)!) { (isSuccess) in
            
        }
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("loanSettingOpen", forIndexPath: indexPath) as! WXUserLoanSettingOpenTableViewCell
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("userLoanSettingRate", forIndexPath: indexPath) as! WXUserLoanSettingRateTableViewCell
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("userLoanSettingDate", forIndexPath: indexPath) as! WXUserLoanSettingDateTableViewCell
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("userLoanSettingMoney", forIndexPath: indexPath) as! WXUserLoanSettingMoneyTableViewCell
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("userLoanSettingMoney", forIndexPath: indexPath) as! WXUserLoanSettingMoneyTableViewCell
            return cell
        }
        let cell = UITableViewCell()
        return cell
    }
}
