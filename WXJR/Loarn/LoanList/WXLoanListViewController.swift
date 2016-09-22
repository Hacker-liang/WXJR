//
//  WXLoanListViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:[WXLoanDetailModel] = []
    var page = 1
    var pageSize = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "资产列表"
        
        self.view.backgroundColor = APP_PAGE_COLOR
        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.registerNib(UINib(nibName: "WXLoanListTableViewCell", bundle: nil), forCellReuseIdentifier: "loanListTableViewCell")
        self.view.addSubview(self.tableView)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.page = 1
            WXLoanManager.loadAllLoanList(self.page, pageSize: 10) { (isSuccess, error, retLoans) in
                if let loans = retLoans {
                    self.dataSource = loans
                    self.tableView.reloadData()
                }
                self.tableView.mj_header.endRefreshing()
            }
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreLoan))
        self.loadLoansDataSource()
    }
    
    func loadLoansDataSource() {
        page = 1
        WXLoanManager.loadAllLoanList(page, pageSize: 10) { (isSuccess, error, retLoans) in
            if let loans = retLoans {
                self.dataSource = loans
                self.tableView.reloadData()
            }
        }
    }
    
    func loadMoreLoan() {
        page += 1
        WXLoanManager.loadAllLoanList(page, pageSize: 10) { (isSuccess, error, retLoans) in
            if let loans = retLoans {
                self.dataSource.appendContentsOf(loans)
                self.tableView.reloadData()
            }
            self.tableView.mj_footer.endRefreshing()
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
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:WXLoanListTableViewCell = tableView.dequeueReusableCellWithIdentifier("loanListTableViewCell", forIndexPath: indexPath) as! WXLoanListTableViewCell
        cell.loanDetail = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let ctl = WXLoanDetailViewController()
        ctl.loanDetail = dataSource[indexPath.row]
        ctl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctl, animated: true)
        
    }
}




