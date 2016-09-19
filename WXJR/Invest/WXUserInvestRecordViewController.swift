//
//  WXUserInvestRecordViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/6/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserInvestRecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [WXInvestModel] = Array()
    
    var page: Int = 0
    var pageSize: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "WXUserInvestRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "userInvestRecordCell")
        self.navigationItem.title = "投资记录"
        self.tableView.hidden = true
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 0
            WXUserManager.loadUserInvestList(WXAccountManager.shareInstance().accountDetail!.userId, page: self.page, pageSize: self.pageSize) { (isSuccess, investList) in
                self.tableView.hidden = false
                if isSuccess {
                    self.dataSource.removeAll()
                    for invest in investList! {
                        self.dataSource.append(invest)
                    }
                    self.page += 1
                    self.tableView.reloadData()
                }
                self.tableView.mj_header.endRefreshing()
            }
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreInvestData))
        
        self.tableView.mj_header.beginRefreshing()
    }

    func loadMoreInvestData()  {
        WXUserManager.loadUserInvestList(WXAccountManager.shareInstance().accountDetail!.userId, page: self.page, pageSize: self.pageSize) { (isSuccess, investList) in
            if isSuccess {
                for invest in investList! {
                    self.dataSource.append(invest)
                }
                self.page += 1
                self.tableView.reloadData()
                if investList!.count  < self.pageSize {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer.endRefreshing()
                }
            } else {
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WXUserInvestRecordTableViewCell = tableView.dequeueReusableCellWithIdentifier("userInvestRecordCell", forIndexPath: indexPath) as! WXUserInvestRecordTableViewCell
        cell.investModel = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}








