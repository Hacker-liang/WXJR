//
//  WXLoanRecommendViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanRecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var galleryView: AutoSlideScrollView!
    
    var dataSource:[WXLoanDetailModel] = []

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = APP_PAGE_COLOR
        
        self.navigationItem.title = "未馨金融"
        self.tableView = UITableView(frame: CGRectMake(0, 0, kWindowWidth, kWindowHeight) , style:.Plain)
        self.tableView.backgroundColor = APP_PAGE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.registerNib(UINib(nibName: "WXLoanListTableViewCell", bundle: nil), forCellReuseIdentifier: "loanListTableViewCell")
        self.view.addSubview(self.tableView)
        self.setupHeaderView()
        
        self.loadRecommendDataSource()
        self.loadLoansDataSource()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        galleryView.scrollView.setContentOffset(CGPointZero, animated: true)
        
    }
    
    func setupHeaderView() {
        let headerView = UIView()
        
        let titles = ["资金安全", "标的优质", "现场监控", "回报理想"]
        let icons = ["icon_home_safe.jpg", "icon_home_good.jpg", "icon_home_jiankong.jpg", "icon_home_huibao.jpg"]

        let width = (kWindowWidth-60)/7
        var offsetX:CGFloat = 30.0
        var index = 0
        for title in titles {
            let imageView = UIImageView(frame: CGRectMake(offsetX, 180, width, width))
            imageView.image = UIImage(named: icons[index])
            let titleLabel = UILabel(frame: CGRectMake(offsetX-10, 190+width, width+20, 20))
            titleLabel.text = title
            titleLabel.textAlignment = .Center
            titleLabel.font = UIFont.systemFontOfSize(13.0)
            titleLabel.textColor = COLOR_TEXT_II
            headerView.addSubview(imageView)
            headerView.addSubview(titleLabel)
            index += 1
            offsetX += width*2
        }
        
        headerView.backgroundColor = UIColor.whiteColor()
        galleryView = AutoSlideScrollView(frame: CGRectMake(0,0, kWindowWidth, 160), animationDuration: 10)
        headerView.addSubview(galleryView)
        headerView.frame = CGRectMake(0,64, kWindowWidth, (180 + width+40))

        self.tableView.tableHeaderView = headerView
    }
    
    func loadLoansDataSource() {
        WXLoanManager.loadRecommendLoanLis { (isSuccess, error, retLoans) in
            if let loans = retLoans {
                self.dataSource = loans
                self.tableView.reloadData()
            }
        }
    }
    
    func loadRecommendDataSource() {
        galleryView.totalPagesCount = {
            return 4
        }
        
        galleryView.fetchContentViewAtIndex = {(pageIndex) in
            let imageView = UIImageView(frame: self.galleryView.bounds)
            imageView.image = UIImage(named: "banner\(pageIndex+1).jpeg")
            return imageView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,45))
        headerView.backgroundColor = APP_PAGE_COLOR
        
        let dotView = UIView(frame: CGRectMake(10,15,5,15))
        dotView.backgroundColor = APP_THEME_COLOR
        dotView.layer.cornerRadius = 2.0
        dotView.clipsToBounds = true
        headerView.addSubview(dotView)
        
        let titleLabel = UILabel(frame: CGRectMake(20, 13, 200, 20))
        titleLabel.textColor = COLOR_TEXT_II
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.text = "推荐投资"
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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
        ctl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctl, animated: true)

    }
}
