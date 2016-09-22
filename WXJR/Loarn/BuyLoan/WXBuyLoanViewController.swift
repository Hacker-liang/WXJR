//
//  WXBuyLoanViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/21/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXBuyLoanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WXBuyLoanBuyTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var loanDetail: WXLoanDetailModel?
    var incomeValueLabel: UILabel?
    var buyAmount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "WXBuyLoanBuyTableViewCell", bundle: nil), forCellReuseIdentifier: "buyLoanInputCell")
        tableView.registerNib(UINib(nibName: "WXBuyLoanTableViewCell", bundle: nil), forCellReuseIdentifier: "buyLoanCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = COLOR_LINE
        tableView.backgroundColor = APP_PAGE_COLOR
        self.navigationItem.title = "立即购买"
        self.setupFooterView()
        
        WXAccountManager.shareInstance().updateUserFundDate { (isSuccess) in
            if isSuccess {
                self.tableView.reloadData()
            }
        }
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
        WXLoanManager.buyLoan(self.loanDetail!.loanId!, amount: buyAmount!, placementId: nil) { (isSuccess, retData) in
            let webCtl = WXBuyLoanWebViewController()
            webCtl.htmlData = retData
            self.navigationController?.pushViewController(webCtl, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else {
            return 2
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
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
            valueLabel.text = "0.0元"
            whiteBgView.addSubview(valueLabel)
            
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
            return cell
            
        } else  {
            if indexPath.row == 1 {
                let cell: WXBuyLoanTableViewCell = tableView.dequeueReusableCellWithIdentifier("buyLoanCell", forIndexPath: indexPath) as! WXBuyLoanTableViewCell
                cell.typeLabel.text = "可购金额:"
                cell.actionButton.hidden = true
                cell.contentLabel.text = "\(loanDetail!.balance!)元"
                return cell
                
            } else {
                let cell: WXBuyLoanTableViewCell = tableView.dequeueReusableCellWithIdentifier("buyLoanCell", forIndexPath: indexPath) as! WXBuyLoanTableViewCell
                cell.typeLabel.text = "账户余额:"
                cell.actionButton.hidden = false
                let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
                
                cell.contentLabel.text = "\(totalRemaing)元"
                return cell
                
            }
            
        }
    }
    
    func updateBuyValue(value: NSString) {
        if let value = Float(value as String) {
            buyAmount = Int(value)
            let total = Float(value * Float((loanDetail?.duration?.totalDays)!)/365 * Float((loanDetail?.rate)!)/10000)
            let str = String(format: "%.2f", total)
            incomeValueLabel!.text = "\(str)元"
        }
    }
}






