//
//  WXUserBankInfoViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserBankInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [WXUserBankInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.registerNib(UINib(nibName: "WXUserBankInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "userBankInfoCell")
        self.navigationItem.title = "我的银行卡"
        
        self.loadUserBankInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
       
    func loadUserBankInfo() {
        WXUserManager.loadUserBankInfoList(WXAccountManager.shareInstance().accountDetail!.userId) { (isSuccess, bankInfoList) in
            if isSuccess {
                for bankInfo in bankInfoList! {
                    if bankInfo.defaultAccount! {
                        self.dataSource.append(bankInfo)
                        self.tableView.reloadData()
                        break
                    }
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,20))
        headerView.backgroundColor = APP_PAGE_COLOR
        
        let titleLabel = UILabel(frame: CGRectMake(12, 15, 200, 20))
        titleLabel.textColor = COLOR_TEXT_II
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.text = "您绑定的提现银行卡信息如下:"
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WXUserBankInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("userBankInfoCell", forIndexPath: indexPath) as! WXUserBankInfoTableViewCell
        let bankInfo = dataSource[indexPath.row]
        cell.titleLabel.text = bankInfo.typeDesc
        cell.iconImageView.image = UIImage(named: "\(bankInfo.type!).png")
        cell.numberLabel.text = bankInfo.accountNo
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
