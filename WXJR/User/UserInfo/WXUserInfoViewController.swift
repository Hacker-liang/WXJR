//
//  WXUserInfoViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [["用户名", "手机号", "重设密码"], ["分享应用", "去评分"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "个人信息"

        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "WXUserInfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "userInfoDetailCell")
        self.setupFooterView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupFooterView() {
        let footerView = UIView(frame: CGRectMake(0,0,kWindowWidth,100))
        let signoutButton = UIButton(frame: CGRectMake(0,20,kWindowWidth,45))
        signoutButton.backgroundColor = UIColor.whiteColor()
        signoutButton.setTitle("退出登录", forState: .Normal)
        signoutButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        signoutButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        footerView.addSubview(signoutButton)
        
        self.tableView.tableFooterView = footerView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,20))
        headerView.backgroundColor = APP_PAGE_COLOR
        return headerView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WXUserInfoDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier("userInfoDetailCell", forIndexPath: indexPath) as! WXUserInfoDetailTableViewCell

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.titleLabel.text = "用户名"
                cell.contentLabel.text = "heheceo"
                cell.accessoryType = .None
                
            }
            if indexPath.row == 1 {
                cell.titleLabel.text = "手机号"
                cell.contentLabel.text = "18600441776"
                cell.accessoryType = .None
                
            }
            if indexPath.row == 2 {
                cell.titleLabel.text = "重设密码"
                cell.accessoryType = .DisclosureIndicator
                
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.titleLabel.text = "分享应用"
                cell.accessoryType = .DisclosureIndicator
            }
            if indexPath.row == 1 {
                cell.titleLabel.text = "去评分"
                cell.accessoryType = .DisclosureIndicator
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    
    
    
    
    
}
