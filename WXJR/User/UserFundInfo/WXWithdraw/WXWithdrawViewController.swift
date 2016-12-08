//
//  WXWithdrawViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/27/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXWithdrawViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var withdrawTypes = ["普通取现", "快速取现", "及时取现"]
    
    var withdrawTypeSelectedIndex = 0
    var cardNumber: String?
    var amount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "WXWithdrawSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "withdrawSelectionCell")
        tableView.registerNib(UINib(nibName: "WXWithdrawInputTableViewCell", bundle: nil), forCellReuseIdentifier: "withdrawInputCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "提现"
        
        let cancelButton = UIButton(frame:CGRectMake(0,0,40,40))
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        cancelButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        cancelButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
        self.setupFooterView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        WXUserManager.loadUserBankInfoList(WXAccountManager.shareInstance().accountDetail!.userId) { (isSuccess, bankInfoList) in
            if isSuccess {
                if bankInfoList?.count == 0 {
                    let alertView = UIAlertView(title: "您未绑定银行卡,请立即绑定", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "绑定")
                    alertView.showAlertViewWithBlock({ (index) in
                        if index == 1 {
                            let ctl = WXBindBankWebViewController()
                            ctl.hidesBottomBarWhenPushed = true
                            self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: nil)
                        }
                    })
                    return
                }
                for bankInfo in bankInfoList! {
                    if bankInfo.valid! {
                        self.cardNumber = bankInfo.accountNo
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func dismissCtl() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupFooterView() {
        let footerView = UIView(frame: CGRectMake(0,0,kWindowWidth,100))
        let confirmButton = UIButton(frame: CGRectMake(15,20,kWindowWidth-30,45))
        confirmButton.backgroundColor = APP_THEME_COLOR
        confirmButton.layer.cornerRadius = 4.0
        confirmButton.clipsToBounds = true
        confirmButton.setTitle("确认提现", forState: .Normal)
        confirmButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        confirmButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction), forControlEvents: .TouchUpInside)
        footerView.addSubview(confirmButton)
        
        self.tableView.tableFooterView = footerView
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func confirmButtonAction() {
        self.view.endEditing(true)
        WXUserManager.userWithdraw((WXAccountManager.shareInstance().accountDetail?.userId)!, amount: self.amount, bankAccount: self.cardNumber!, type: "GENERAL") { (isSuccess, withdrawInfo) in
            if isSuccess {
                let ctl = WXWithdrawWebViewController()
                ctl.htmlData = withdrawInfo
                self.navigationController?.pushViewController(ctl, animated: true)
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: WXWithdrawSelectionTableViewCell = tableView.dequeueReusableCellWithIdentifier("withdrawSelectionCell", forIndexPath: indexPath) as! WXWithdrawSelectionTableViewCell
            cell.titleLabel.text = "账户余额:"
            let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
            cell.contentLabel.text = "\(totalRemaing)元"
            cell.accessoryType = .None
            return cell
            
        } else {
            if indexPath.row == 0 {
                let cell: WXWithdrawInputTableViewCell = tableView.dequeueReusableCellWithIdentifier("withdrawInputCell", forIndexPath: indexPath) as! WXWithdrawInputTableViewCell
                cell.amountTF.delegate = self
                cell.selectionStyle = .None
                return cell
                
            } else if indexPath.row == 1 {
                let cell: WXWithdrawSelectionTableViewCell = tableView.dequeueReusableCellWithIdentifier("withdrawSelectionCell", forIndexPath: indexPath) as! WXWithdrawSelectionTableViewCell
                cell.titleLabel.text = "提现银行卡:"
//                print("card: \(self.cardNumber)")
                if let number = self.cardNumber {
                    cell.contentLabel.text = number
                }
                cell.selectionStyle = .None
                cell.accessoryType = .None
                return cell
                
            } else if indexPath.row == 2 {
                let cell: WXWithdrawSelectionTableViewCell = tableView.dequeueReusableCellWithIdentifier("withdrawSelectionCell", forIndexPath: indexPath) as! WXWithdrawSelectionTableViewCell
                cell.titleLabel.text = "提现方式:"
                let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
                cell.contentLabel.text = "\(totalRemaing)元"
                cell.selectionStyle = .Default
                cell.contentLabel.text = self.withdrawTypes[withdrawTypeSelectedIndex]
                cell.accessoryType = .DisclosureIndicator
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            if indexPath.row == 2 {
                let actionSheet = LCActionSheet(title: "提现方式", buttonTitles: withdrawTypes, redButtonIndex: -1, clicked: { (index) in
                    if index != self.withdrawTypes.count {
                        self.withdrawTypeSelectedIndex = index
                        self.tableView.reloadData()
                    }
                })
                actionSheet.show()
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return true
        }
        
        if let str: NSString = textField.text! {
            let newString =  str.stringByReplacingCharactersInRange(range, withString: string)
            if let value =  Double(newString) {
                let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
    
                if value > totalRemaing {
                    print("您没有那么多钱可以提现")
                    return false
                }
                
                self.amount = value
            } else if newString.characters.count != 0 {
                print("金额输入错误")
                return false
            }   
        }
        return true
    }
}







