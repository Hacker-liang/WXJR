//
//  WXRootViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXRootViewController: UITabBarController {

    var mineRootViewController: WXMineRootViewController!
    var loanRecommentViewController: WXLoanRecommendViewController!
    var loanListViewController: WXLoanListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupViewControllers() {
        mineRootViewController = WXMineRootViewController()
        loanRecommentViewController = WXLoanRecommendViewController()
        loanListViewController = WXLoanListViewController()
        self.viewControllers = [UINavigationController(rootViewController: loanRecommentViewController), UINavigationController(rootViewController: loanListViewController), UINavigationController(rootViewController: mineRootViewController)]
        
        let titles = ["首页", "列表", "我的"]
        var index = 0
        for tabbarItem in self.tabBar.items! {
            tabbarItem.title = titles[index]
            index += 1;
        }
    }
    
    func gotoLogin() {
        let ctl = WXUserLoginViewController()
        self.presentViewController(UINavigationController(rootViewController: ctl), animated: true) {
            
        }
    }
    
    //Mark: TabBarDelegate
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.isEqual(self.tabBar.items?.last) {
            if !WXAccountManager.shareInstance().userIsLoginIn() {
                self.gotoLogin()
            }
//            self.gotoLogin()
            mineRootViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        if item.isEqual(self.tabBar.items?.first) {
            
//            loanRecommentViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
}



