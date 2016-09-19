//
//  WXUserFundRecordViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserFundRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [WXUserFundRecordModel] = []
    var page = 1
    var pageSize = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "WXUserFundRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "userFundRecordCell")
        self.navigationItem.title = "资金记录"
        
        self.tableView.hidden = true
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 1
            WXUserManager.loadUserFundRecordList((WXAccountManager.shareInstance().accountDetail?.userId)!, page: self.page, pageSize: self.pageSize, completionBlock: { (isSuccess, fundRecordList) in
                if isSuccess {
                    self.dataSource.removeAll()
                    for fund in fundRecordList! {
                        self.dataSource.append(fund)
                    }
                    self.page += 1
                    self.tableView.reloadData()
                }
                self.tableView.mj_header.endRefreshing()

            })
            self.tableView.hidden = false
        })
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreFundRecordData))
    }
    
    func loadMoreFundRecordData()  {
        WXUserManager.loadUserFundRecordList((WXAccountManager.shareInstance().accountDetail?.userId)!, page: self.page, pageSize: self.pageSize, completionBlock: { (isSuccess, fundRecordList) in
            if isSuccess {
                for fund in fundRecordList! {
                    self.dataSource.append(fund)
                }
                self.page += 1
                self.tableView.reloadData()
                if fundRecordList!.count  < self.pageSize {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer.endRefreshing()
                }
            } else {
                self.tableView.mj_footer.endRefreshing()
            }
        })
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
        let cell: WXUserFundRecordTableViewCell = tableView.dequeueReusableCellWithIdentifier("userFundRecordCell", forIndexPath: indexPath) as! WXUserFundRecordTableViewCell
        cell.userFundDetail = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
