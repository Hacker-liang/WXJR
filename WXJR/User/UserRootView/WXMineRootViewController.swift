//
//  WXMineRootViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXMineRootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    
    var tableView: UITableView!
    var totalIncomeLabel: UILabel!
    var totalInvestLabel: UILabel!
    var expectedIncomeLabel: UILabel!
    var remainingLabel: UILabel!
    
    var navigationView: UIView!

    let iconDatasource = [["icon_minehome_invest", "icon_minehome_moneyrecord", "icon_minehome_account", "icon_minehome_bank", "icon_minehome_lottery"], ["icon_minehome_setting"]]
    let dataSource = [["投资记录", "资金记录", "资金托管账户", "银行卡信息", "我的奖券"], ["帐号设置"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = APP_PAGE_COLOR
        
        let bgView = UIImageView(frame:CGRectMake(0, 0, kWindowWidth, 320))
        bgView.image = UIImage(named: "icon_mine_bg")
        self.view.addSubview(bgView)
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, kWindowWidth, kWindowHeight), style: .Grouped)
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "WXMineHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "mineHomeCell")
        self.view.addSubview(self.tableView)
        self.setupTableViewHeaderView()
        
        navigationView = UIView(frame: CGRectMake(0,0,kWindowWidth,64))
        navigationView.backgroundColor = APP_THEME_COLOR
        let titleLabel = UILabel(frame: CGRectMake(0, 20, kWindowWidth, 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(17.0)
        titleLabel.text = WXAccountManager.shareInstance().accountDetail?.nickname
        titleLabel.textAlignment = .Center
        navigationView.addSubview(titleLabel)
        
        self.view.addSubview(navigationView)
        navigationView.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
        if WXAccountManager.shareInstance().userIsLoginIn() {
            WXAccountManager.shareInstance().updateUserFundDate { (isSuccess) in
                if isSuccess {
                    self.updateUserFundPanel()
                }
            }
            WXAccountManager.shareInstance().updateUserInvestDate { (isSuccess) in
                if isSuccess {
                    self.updateUserFundPanel()
                }
            }
        } else {
            self.updateUserFundPanel()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
    
    func setupTableViewHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, kWindowWidth, 235))
        headerView.backgroundColor = UIColor.clearColor()
        
        let tempLabel1 = UILabel(frame: CGRectMake(0, 50, kWindowWidth, 20))
        tempLabel1.textColor = UIColor.whiteColor()
        tempLabel1.font = UIFont.systemFontOfSize(15.0)
        tempLabel1.text = "总收益"
        tempLabel1.textAlignment = .Center
        headerView.addSubview(tempLabel1)
        
        totalIncomeLabel = UILabel(frame: CGRectMake(0, 75, kWindowWidth, 40))
        totalIncomeLabel.textColor = UIColor.whiteColor()
        totalIncomeLabel.font = UIFont.boldSystemFontOfSize(38.0)
        totalIncomeLabel.textAlignment = .Center
        headerView.addSubview(totalIncomeLabel)
        
        let tempLabel2 = UILabel(frame: CGRectMake(0, 135, kWindowWidth/3, 20))
        tempLabel2.textColor = UIColor.whiteColor()
        tempLabel2.font = UIFont.systemFontOfSize(13.0)
        tempLabel2.text = "总投资产"
        tempLabel2.textAlignment = .Center
        headerView.addSubview(tempLabel2)
        
        totalInvestLabel = UILabel(frame: CGRectMake(0, 155, kWindowWidth/3, 20))
        totalInvestLabel.textColor = UIColor.whiteColor()
        totalInvestLabel.font = UIFont.systemFontOfSize(14.0)
        totalInvestLabel.textAlignment = .Center
        headerView.addSubview(totalInvestLabel)
        
        let tempLabel3 = UILabel(frame: CGRectMake(kWindowWidth/3, 135, kWindowWidth/3, 20))
        tempLabel3.textColor = UIColor.whiteColor()
        tempLabel3.font = UIFont.systemFontOfSize(13.0)
        tempLabel3.text = "预计收益"
        tempLabel3.textAlignment = .Center
        headerView.addSubview(tempLabel3)
        
        expectedIncomeLabel = UILabel(frame: CGRectMake(kWindowWidth/3, 155, kWindowWidth/3, 20))
        expectedIncomeLabel.textColor = UIColor.whiteColor()
        expectedIncomeLabel.font = UIFont.systemFontOfSize(14.0)
        expectedIncomeLabel.textAlignment = .Center
        headerView.addSubview(expectedIncomeLabel)
        
        let tempLabel4 = UILabel(frame: CGRectMake(kWindowWidth/3*2, 135, kWindowWidth/3, 20))
        tempLabel4.textColor = UIColor.whiteColor()
        tempLabel4.font = UIFont.systemFontOfSize(13.0)
        tempLabel4.text = "可用余额"
        tempLabel4.textAlignment = .Center
        headerView.addSubview(tempLabel4)
        
        remainingLabel = UILabel(frame: CGRectMake(kWindowWidth/3*2, 155, kWindowWidth/3, 20))
        remainingLabel.textColor = UIColor.whiteColor()
        remainingLabel.font = UIFont.systemFontOfSize(14.0)
        remainingLabel.textAlignment = .Center
        headerView.addSubview(remainingLabel)
        
        let tempBgView = UIView(frame: CGRectMake(0,190,kWindowWidth,45))
        headerView.addSubview(tempBgView)
        
        let rechargeButton = UIButton(frame: CGRectMake(0,0,kWindowWidth/2,45))
        rechargeButton.setTitle("充值", forState: .Normal)
        rechargeButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        rechargeButton.backgroundColor = UIColor.whiteColor()
        rechargeButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        rechargeButton.addTarget(self, action: #selector(rechargeAction), forControlEvents: .TouchUpInside)
        tempBgView.addSubview(rechargeButton)
        
        let withdrawButton = UIButton(frame: CGRectMake(kWindowWidth/2,0,kWindowWidth/2,45))
        withdrawButton.setTitle("提现", forState: .Normal)
        withdrawButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        withdrawButton.backgroundColor = UIColor.whiteColor()
        withdrawButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        withdrawButton.addTarget(self, action: #selector(withdrawAction), forControlEvents: .TouchUpInside)
        tempBgView.addSubview(withdrawButton)
        
        let spaceView = UIView(frame: CGRectMake(kWindowWidth/2, 5, 0.5, 35))
        spaceView.backgroundColor = COLOR_LINE
        tempBgView.addSubview(spaceView)
        
        let spaceView1 = UIView(frame: CGRectMake(0, 44.5, kWindowWidth, 0.5))
        spaceView1.backgroundColor = COLOR_LINE
        tempBgView.addSubview(spaceView1)

        self.tableView.tableHeaderView = headerView
    }
    
    func gotoLogin() {
        let ctl = WXUserLoginViewController()
        self.presentViewController(UINavigationController(rootViewController: ctl), animated: true) {
            ctl.view.makeToast("请先登录")
        }
    }
    
    func updateUserFundPanel() {
        let totalIncome = WXAccountManager.shareInstance().accountDetail?.userInvestDetail?.investInterestAmount ?? 0
        totalIncomeLabel.text = "\(totalIncome)"
        
        let totalInvest = WXAccountManager.shareInstance().accountDetail?.userInvestDetail?.investingPrincipalAmount ?? 0
        totalInvestLabel.text = "\(totalInvest)"
        
        let exceptedIncome = WXAccountManager.shareInstance().accountDetail?.userInvestDetail?.investingInterestAmount ?? 0
        expectedIncomeLabel.text = "\(exceptedIncome)"
        
        let totalRemaing = WXAccountManager.shareInstance().accountDetail?.userFundDetail?.availableAmount ?? 0
        remainingLabel.text = "\(totalRemaing)"
    }
    
    func rechargeAction() {
        if !WXAccountManager.shareInstance().userIsLoginIn() {
            self.gotoLogin()
            return
        }
        self.checkUserHuifuAccount { (isActive) in
            if isActive {
                let ctl = WXRechargeViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: nil)
            }
        }
    }
    
    func withdrawAction() {
        if !WXAccountManager.shareInstance().userIsLoginIn() {
            self.gotoLogin()
            return
        }
        self.checkUserHuifuAccount { (isActive) in
            if isActive {
                let ctl = WXWithdrawViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: nil)
            }
        }
        
    }
    
    func checkUserHuifuAccount(completionBlock:(isActive: Bool) -> ()) {
        let hud = WXHUD()
        hud.showHUDInView(self.view)
        WXUserManager.loadUserFundsTrusteeshipAccount(WXAccountManager.shareInstance().accountDetail!.userId) { (isSuccess, accountInfo) in
            completionBlock(isActive: isSuccess)
            hud.hideHUD()
            if isSuccess {
                
            } else {
                let alertView = UIAlertView(title: "您未开通托管帐号,请立即开通", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "开通")
                alertView.showAlertViewWithBlock({ (index) in
                    if index == 1 {
                        let ctl = WXOpenFundWebViewController()
                        ctl.hidesBottomBarWhenPushed = true
                        self.presentViewController(UINavigationController(rootViewController: ctl), animated: true, completion: nil)
                    }
                })
                
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,20))
        headerView.backgroundColor = APP_PAGE_COLOR
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0,0,kWindowWidth,20))
        footerView.backgroundColor = APP_PAGE_COLOR
        return footerView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:WXMineHomeTableViewCell = tableView.dequeueReusableCellWithIdentifier("mineHomeCell", forIndexPath: indexPath) as! WXMineHomeTableViewCell
        cell.headerImageView.image = UIImage(named: self.iconDatasource[indexPath.section][indexPath.row])
        cell.contentLabel.text = self.dataSource[indexPath.section][indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if !WXAccountManager.shareInstance().userIsLoginIn() {
            self.gotoLogin()
            return
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let ctl = WXUserInvestRecordViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctl, animated: true)
            }
            
            if indexPath.row == 1 {
                let ctl = WXUserFundRecordViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctl, animated: true)
            }
            
            if indexPath.row == 2 {
                let ctl = WXUserFundsTrusteeshipInfoViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctl, animated: true)
            }
            
            if indexPath.row == 3 {
                let ctl = WXUserBankInfoViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctl, animated: true)
            }
            
            if indexPath.row == 4 {
                let ctl = WXUserCouponListViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctl, animated: true)
            }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let ctl = WXUserInfoViewController()
                ctl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctl, animated: true)
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let alpha = scrollView.contentOffset.y/100
        self.navigationView.alpha = alpha
        
        if scrollView.contentOffset.y < -120 {
            scrollView.contentOffset = CGPointMake(0, -120)
        }
    }
}







