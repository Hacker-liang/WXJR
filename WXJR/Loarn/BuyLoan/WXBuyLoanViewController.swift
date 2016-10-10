//
//  WXBuyLoanViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/21/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXBuyLoanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WXBuyLoanBuyTableViewCellDelegate, LCActionSheetDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var loanDetail: WXLoanDetailModel?
    var incomeValueLabel: UILabel?
    var buyAmount: Int = 0
    var couponList: [WXUserCouponModel]?
    var selectedCoupon: WXUserCouponModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "WXBuyLoanBuyTableViewCell", bundle: nil), forCellReuseIdentifier: "buyLoanInputCell")
        tableView.registerNib(UINib(nibName: "WXBuyLoanTableViewCell", bundle: nil), forCellReuseIdentifier: "buyLoanCell")
        tableView.registerNib(UINib(nibName: "WXBuyLoanSelectCouponTableViewCell", bundle: nil), forCellReuseIdentifier: "buyCouponCell")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = COLOR_LINE
        tableView.backgroundColor = APP_PAGE_COLOR
        self.navigationItem.title = "立即购买"
        self.setupFooterView()
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        WXAccountManager.shareInstance().updateUserFundDate { (isSuccess) in
            if isSuccess {
                self.tableView.reloadData()
            }
        }
        
        WXUserManager.loadUserCouponList((WXAccountManager.shareInstance().accountDetail?.userId)!, userMonths: (loanDetail?.duration?.totalMonths) ?? 0, page: 0, pageSize: 10000) { (isSuccess, couponsList) in
            self.couponList = couponsList
        }
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupFooterView() {
        let footerView = UIView(frame: CGRectMake(0,0,kWindowWidth,100))
        let buyButton = UIButton(frame: CGRectMake(15,20,kWindowWidth-30,45))
        buyButton.backgroundColor = APP_THEME_COLOR
        buyButton.layer.cornerRadius = 4.0
        buyButton.clipsToBounds = true
        buyButton.setTitle("确认购买", forState: .Normal)
        buyButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        buyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buyButton.addTarget(self, action: #selector(buyAction), forControlEvents: .TouchUpInside)
        footerView.addSubview(buyButton)
    
        self.tableView.tableFooterView = footerView
    }
    
    func buyAction() {
        if self.buyAmount < self.loanDetail!.loanRequest!.minInvestAmount! {
            self.view.makeToast("投资金额低于最低起投金额")
            return
        }
        WXLoanManager.buyLoan(self.loanDetail!.loanId!, amount: buyAmount, placementId: self.selectedCoupon?.id) { (isSuccess, retData) in
            let webCtl = WXBuyLoanWebViewController()
            webCtl.htmlData = retData
            self.navigationController?.pushViewController(webCtl, animated: true)
        }
    }
    
    func chargeMoneyAction() {
        let ctl = WXRechargeViewController()
        ctl.hidesBottomBarWhenPushed = true
        self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
            
        } else if section == 1 {
            return 1
            
        } else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 55
        }
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 0.01
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,50))
            
            let whiteBgView = UIView(frame: CGRectMake(0,20,kWindowWidth,30))
            whiteBgView.backgroundColor = UIColor.whiteColor()
            headerView.addSubview(whiteBgView)
            
            let titleLabel = UILabel(frame: CGRectMake(12,0,70,30))
            titleLabel.text = "预期收益: "
            titleLabel.textColor = COLOR_TEXT_II
            titleLabel.font = UIFont.systemFontOfSize(13.0)
            whiteBgView.addSubview(titleLabel)
            
            let valueLabel = UILabel(frame: CGRectMake(80,0,80,30))
            incomeValueLabel = valueLabel
            valueLabel.textColor = APP_THEME_COLOR
            valueLabel.font = UIFont.systemFontOfSize(13.0)
            whiteBgView.addSubview(valueLabel)
            
            let days = Float((self.loanDetail?.duration?.totalDays)!)/365.0
            let perRate = Float((self.loanDetail!.rate)!)/10000.0
            let total = (days * perRate) * Float(buyAmount)
            let str = String(format: "%.2f", total)
            incomeValueLabel!.text = "\(str)元"
            return headerView
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell: WXBuyLoanBuyTableViewCell = tableView.dequeueReusableCellWithIdentifier("buyLoanInputCell", forIndexPath: indexPath) as! WXBuyLoanBuyTableViewCell
            cell.loanDetail = loanDetail
            let str = "\(self.loanDetail!.loanRequest!.minInvestAmount!)元起投"
            cell.contentTF.placeholder = str        
            cell.delegate = self
            cell.accessoryType = .None

            return cell
            
        } else if indexPath.section == 0 {
            if indexPath.row == 1 {
                let cell: WXBuyLoanTableViewCell = tableView.dequeueReusableCellWithIdentifier("buyLoanCell", forIndexPath: indexPath) as! WXBuyLoanTableViewCell
                cell.typeLabel.text = "可购金额:"
                cell.actionButton.hidden = true
                cell.contentLabel.text = "\(loanDetail!.balance!)元"
                cell.accessoryType = .None
                return cell
                
            } else {
                let cell: WXBuyLoanTableViewCell = tableView.dequeueReusableCellWithIdentifier("buyLoanCell", forIndexPath: indexPath) as! WXBuyLoanTableViewCell
                cell.typeLabel.text = "账户余额:"
                cell.actionButton.hidden = false
                let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
                cell.accessoryType = .None
                cell.contentLabel.text = "\(totalRemaing)元"
                cell.actionButton.addTarget(self, action: #selector(chargeMoneyAction), forControlEvents: .TouchUpInside)
                return cell
            }
            
        } else {
            let cell: WXBuyLoanSelectCouponTableViewCell = tableView.dequeueReusableCellWithIdentifier("buyCouponCell", forIndexPath: indexPath) as! WXBuyLoanSelectCouponTableViewCell
            
            if let coupon = self.selectedCoupon {
                var str = coupon.friendlyParValue!
                str += coupon.typeDesc
                if let de = coupon.desc {
                    if de.characters.count > 0 {
                        str += " -- "
                    }
                    str += de
                }
                cell.couponTitleLabel.text = str

            } else {
                cell.couponTitleLabel.text = ""
            }
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 2 {
            self.view.endEditing(true)
            var couponTitles: [String] = []
            if let coupons = self.couponList {
                for coupon in coupons {
                    var str = coupon.friendlyParValue!
                    str += coupon.typeDesc
                    if let amount = coupon.minimumInvest {
                        str += " -- 投资满\(amount)可用"
                    }
                    couponTitles.append(str)
                }
            }
            couponTitles.append("暂不使用")
            let actionSheet = LCActionSheet(title: "选择红包", buttonTitles: couponTitles, redButtonIndex: -1, clicked: { (index) in
                if index == self.couponList?.count {
                    self.selectedCoupon = nil
                } else if index > self.couponList?.count {
                    
                } else {
                    let coupon = self.couponList![index]
                    if coupon.minimumInvest > self.buyAmount {
                        self.view.makeToast("投资金额低于红包最低使用金额")
                        
                    } else {
                        self.selectedCoupon = coupon
                    }
                }
                self.tableView.reloadData()
            })

            actionSheet.show()
        }
    }
    
    func updateBuyValue(value: NSString) {
        if let v = Float(value as String) {
            buyAmount = Int(v)
            
            let days = Float((self.loanDetail?.duration?.totalDays)!)/365.0
            let perRate = Float((self.loanDetail!.rate)!)/10000.0
            let total = (days * perRate) * Float(buyAmount)
            let str = String(format: "%.2f", total)
            incomeValueLabel!.text = "\(str)元"
            if selectedCoupon?.minimumInvest > buyAmount {
                self.selectedCoupon = nil
                self.tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: .None)
            }
        }
    }
}






