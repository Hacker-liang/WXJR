//
//  WXUserCouponListViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/7/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserCouponListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = []
    var couponTypes = ["CASH", "INTEREST", "PRINCIPAL", "REBATE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.registerNib(UINib(nibName: "WXUserCouponTableViewCell", bundle: nil), forCellReuseIdentifier: "userCouponCell")
        self.setupMenuBar()
    }
    
    func setupMenuBar() {
        let items = ["现金券", "加息券", "增值权", "返现券"]
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "现金券", items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        menuView.arrowTintColor = UIColor.blackColor()
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.3
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            
        }
        
        self.navigationItem.titleView = menuView
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCouponCell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    
}




