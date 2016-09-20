//
//  WXLoanDetailViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/8/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var interestLabel: UILabel!
    var totalMoneyLabel: UILabel!
    var totalSaleMoneyLabel: UILabel!
    var dateCountLabel: UILabel!
    
    var loanDetail: WXLoanDetailModel?
    
    let sectionDataSource = ["项目介绍", "资金用途", "还款来源", "项目资料"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = COLOR_LINE
        tableView.backgroundColor = APP_PAGE_COLOR
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.setupNaviBar()
        self.setupHeaderView()
        self.setupFooterView()
        self.setupToolBar()
        
        WXLoanManager.loadLoanDetail(self.loanDetail!.loanId!) { (isSuccess, loanDetail) in
            self.loanDetail = loanDetail
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
    
    func setupNaviBar() {
        let naviView = UIView(frame: CGRectMake(0,0,kWindowWidth,64))
        naviView.backgroundColor = APP_THEME_COLOR
        
        let backButton = UIButton(frame: CGRectMake(5,22,40, 40))
        backButton.setImage(UIImage(named: "icon_navi_back_white"), forState: .Normal)
        backButton.addTarget(self, action: #selector(dismissCtl), forControlEvents: .TouchUpInside)
        naviView.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRectMake(0,20,kWindowWidth,44))
        titleLabel.text = "MB0010807"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(17.0)
        naviView.addSubview(titleLabel)
        self.view.addSubview(naviView)
    }
    
    func setupHeaderView() {
        let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,200))
        headerView.backgroundColor = APP_PAGE_COLOR
        
        let bgView = UIView(frame: CGRectMake(0,0,kWindowWidth,190))
        bgView.backgroundColor = APP_THEME_COLOR
        headerView.addSubview(bgView)

        let titleLabel = UILabel(frame: CGRectMake(0,50,kWindowWidth,15))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        titleLabel.text = "年化收益率"
        titleLabel.textAlignment = .Center
        headerView.addSubview(titleLabel)
        
        interestLabel = UILabel(frame: CGRectMake(0,80,kWindowWidth,30))
        interestLabel.textColor = UIColor.whiteColor()
        interestLabel.font = UIFont.systemFontOfSize(40.0)
        interestLabel.text = "10.0%"
        interestLabel.textAlignment = .Center
        headerView.addSubview(interestLabel)
        
        let titleLabel1 = UILabel(frame: CGRectMake(0,140,kWindowWidth/3,15))
        titleLabel1.textColor = UIColor.whiteColor()
        titleLabel1.font = UIFont.systemFontOfSize(12.0)
        titleLabel1.text = "总金额"
        titleLabel1.textAlignment = .Center
        headerView.addSubview(titleLabel1)
        
        totalMoneyLabel = UILabel(frame: CGRectMake(0,160,kWindowWidth/3,15))
        totalMoneyLabel.textColor = UIColor.whiteColor()
        totalMoneyLabel.font = UIFont.systemFontOfSize(14.0)
        totalMoneyLabel.text = "65.123万"
        totalMoneyLabel.textAlignment = .Center
        headerView.addSubview(totalMoneyLabel)
        
        let titleLabe2 = UILabel(frame: CGRectMake(kWindowWidth/3,140,kWindowWidth/3,15))
        titleLabe2.textColor = UIColor.whiteColor()
        titleLabe2.font = UIFont.systemFontOfSize(12.0)
        titleLabe2.text = "可购金额"
        titleLabe2.textAlignment = .Center
        headerView.addSubview(titleLabe2)
        
        totalSaleMoneyLabel = UILabel(frame: CGRectMake(kWindowWidth/3,160,kWindowWidth/3,15))
        totalSaleMoneyLabel.textColor = UIColor.whiteColor()
        totalSaleMoneyLabel.font = UIFont.systemFontOfSize(14.0)
        totalSaleMoneyLabel.text = "12.4万"
        totalSaleMoneyLabel.textAlignment = .Center
        headerView.addSubview(totalSaleMoneyLabel)
        
        let titleLabe3 = UILabel(frame: CGRectMake(kWindowWidth/3*2,140,kWindowWidth/3,15))
        titleLabe3.textColor = UIColor.whiteColor()
        titleLabe3.font = UIFont.systemFontOfSize(12.0)
        titleLabe3.text = "期限"
        titleLabe3.textAlignment = .Center
        headerView.addSubview(titleLabe3)
        
        dateCountLabel = UILabel(frame: CGRectMake(kWindowWidth/3*2,160,kWindowWidth/3,15))
        dateCountLabel.textColor = UIColor.whiteColor()
        dateCountLabel.font = UIFont.systemFontOfSize(14.0)
        dateCountLabel.text = "15天"
        dateCountLabel.textAlignment = .Center
        headerView.addSubview(dateCountLabel)
        
        let spaceView = UIView(frame: CGRectMake(kWindowWidth/3, 143, 0.5, 30))
        spaceView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(spaceView)
        
        let spaceView1 = UIView(frame: CGRectMake(kWindowWidth/3*2, 143, 0.5, 30))
        spaceView1.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(spaceView1)
        
        self.tableView.tableHeaderView = headerView
    }
    
    func setupFooterView() {
        let footerView = UIView(frame: CGRectMake(0,0,kWindowWidth,55))
        footerView.backgroundColor = APP_PAGE_COLOR
        self.tableView.tableFooterView = footerView
    }
    
    func setupToolBar() {
        let toolBar = UIView(frame: CGRectMake(0,kWindowHeight-50,kWindowWidth, 50))
        toolBar.backgroundColor = UIColor.whiteColor()
        
        let spaceView = UIView(frame: CGRectMake(0,0,kWindowWidth,1))
        spaceView.backgroundColor = APP_THEME_COLOR
        toolBar.addSubview(spaceView)
        
        let chatButton = UIButton(frame: CGRectMake(0,0,80,50))
        chatButton.setTitle("在线\n客服", forState: .Normal)
        chatButton.titleLabel?.numberOfLines = 0
        chatButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        chatButton.setTitleColor(UIColorFromRGB(0x39B762, alpha: 1), forState: .Normal)
        toolBar.addSubview(chatButton)
        
        let spaceView1 = UIView(frame: CGRectMake(80, 10, 0.5, 30))
        spaceView1.backgroundColor = COLOR_LINE
        toolBar.addSubview(spaceView1)
        
        let buyButton = UIButton(frame: CGRectMake(60,0,kWindowWidth-80,50))
        buyButton.setTitle("立即购买", forState: .Normal)
        buyButton.titleLabel?.numberOfLines = 0
        buyButton.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        buyButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        toolBar.addSubview(buyButton)

        self.view.addSubview(toolBar)
    }
    
    func dismissCtl() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0,0,kWindowWidth,40))
        view.backgroundColor = UIColor.whiteColor()
        let titleLabel = UILabel(frame: CGRectMake(12,0,kWindowWidth-24,40))
        titleLabel.textColor = COLOR_TEXT_I
        titleLabel.font = UIFont.systemFontOfSize(15.0)
        titleLabel.text = sectionDataSource[section]
        view.addSubview(titleLabel)
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionDataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section < 3 {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.selectionStyle = .None
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFontOfSize(14.0)
            cell.textLabel?.textColor = COLOR_TEXT_II
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 8
            style.paragraphSpacing = 5.0
            style.firstLineHeadIndent = 10
            
            var contentStr = ""
            
            if indexPath.section == 0 {
                if let str = self.loanDetail?.loanRequest?.desc {
                    contentStr = str
                }
                
            } else if indexPath.section == 1 {
                if let str = self.loanDetail?.loanRequest?.guaranteeInfo {
                    contentStr = str
                }

                
            } else if indexPath.section == 2 {
                if let str = self.loanDetail?.loanRequest?.mortgageInfo {
                    contentStr = str
                }

                
            } else if indexPath.section == 3 {
                contentStr = ""
                
            }
            
            let attrText = NSMutableAttributedString(string: contentStr)
            attrText.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, contentStr.characters.count))
            cell.textLabel?.attributedText = attrText
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -60 {
            scrollView.contentOffset = CGPointMake(0, -60)
        }
    }
    
}
