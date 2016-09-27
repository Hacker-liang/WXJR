//
//  WXLoanDetailViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 9/8/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoanDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WXLoanDetailCellDelete {

    @IBOutlet weak var tableView: UITableView!
    
    var interestLabel: UILabel!
    var totalMoneyLabel: UILabel!
    var totalSaleMoneyLabel: UILabel!
    var dateCountLabel: UILabel!
    var naviTitleLabel: UILabel!
    var expireTimeLabel: UILabel!
    var whiteBgView: UIView!
    var buyButton: UIButton!
    var stausLabel: UILabel!

    var countdown = 0
    
    var timer: NSTimer?


    var loanDetail: WXLoanDetailModel?
    var loanImageList: [String] = []
    let sectionDataSource = ["项目介绍", "资金用途", "还款来源", "项目资料"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = COLOR_LINE
        tableView.backgroundColor = APP_PAGE_COLOR
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(UINib(nibName: "WXLoanDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "loanDetailCell")
        self.setupNaviBar()
        self.setupHeaderView()
        self.setupFooterView()
        self.setupToolBar()
        self.updateContentView()

        WXLoanManager.loadLoanDetail(self.loanDetail!.loanId!) { (isSuccess, loanDetail) in
            self.loanDetail = loanDetail
            self.updateContentView()
        }
        
        WXLoanManager.loadLoanProof((loanDetail?.loanRequest?.requestId)!) { (isSuccess, imageList) in
            if isSuccess {
                self.loanImageList = imageList!
                self.tableView.reloadData()
            }
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
        
        naviTitleLabel = UILabel(frame: CGRectMake(0,20,kWindowWidth,44))
        naviTitleLabel.textAlignment = .Center
        naviTitleLabel.text = loanDetail?.title
        naviTitleLabel.textColor = UIColor.whiteColor()
        naviTitleLabel.font = UIFont.boldSystemFontOfSize(17.0)
        naviView.addSubview(naviTitleLabel)
        
        self.view.addSubview(naviView)
    }
    
    func setupHeaderView() {
        let headerView = UIView(frame: CGRectMake(0,0,kWindowWidth,240))
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
        dateCountLabel.textAlignment = .Center
        headerView.addSubview(dateCountLabel)
        
        let spaceView = UIView(frame: CGRectMake(kWindowWidth/3, 143, 0.5, 30))
        spaceView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(spaceView)
        
        let spaceView1 = UIView(frame: CGRectMake(kWindowWidth/3*2, 143, 0.5, 30))
        spaceView1.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(spaceView1)
        
        self.whiteBgView = UIView(frame: CGRectMake(0, 190, kWindowWidth, 40))
        whiteBgView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(whiteBgView)
        
        let spaceView2 = UIView(frame: CGRectMake(0, whiteBgView.bounds.size.height-0.5, kWindowWidth, 0.5))
        spaceView2.backgroundColor = COLOR_LINE
        whiteBgView.addSubview(spaceView2)
        
        self.tableView.tableHeaderView = headerView
        
        
    }
    
    func updateContentView() {
        let rateValue: Float = Float(Float((loanDetail?.rate)!)/100.0)
        interestLabel.text = "\(rateValue)%"
        totalMoneyLabel.text = "\(loanDetail!.amount!)元"
        totalSaleMoneyLabel.text = "\(loanDetail!.balance!)元"
        dateCountLabel.text = loanDetail?.duration?.durationDesc
        
        if loanDetail!.status! == .kOPENED {
            buyButton.hidden = false
            stausLabel.hidden = true
            
        } else {
            buyButton.hidden = true
            stausLabel.hidden = false
            stausLabel.text = loanDetail?.statusDesc
        }

        for view in self.whiteBgView.subviews {
            view.removeFromSuperview()
        }
        
        let str = "\(self.loanDetail!.loanRequest!.minInvestAmount!)元起投"
        let attrStr = NSMutableAttributedString(string: str)
        attrStr.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(13.0),NSForegroundColorAttributeName: APP_THEME_COLOR], range: NSMakeRange(0, str.characters.count))
        let width = attrStr.boundingRectWithSize(CGSizeMake(kWindowHeight, 100), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.width
        
        let amountLabel = UILabel(frame: CGRectMake(12, 8, width+14, 25))
        amountLabel.layer.borderColor = APP_THEME_COLOR.CGColor
        amountLabel.layer.borderWidth = 0.5
        amountLabel.textAlignment = .Center
        amountLabel.attributedText = attrStr
        amountLabel.layer.cornerRadius = 3.0
        self.whiteBgView.addSubview(amountLabel)
        
        if let type = self.loanDetail?.payMethodDesc {
            
            let attrStr1 = NSMutableAttributedString(string: type)
            attrStr1.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(13.0),NSForegroundColorAttributeName: APP_THEME_COLOR], range: NSMakeRange(0, type.characters.count))
            let width1 = attrStr1.boundingRectWithSize(CGSizeMake(kWindowHeight, 100), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.width
            
            let typeLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(amountLabel.frame) + 14, 8, width1+12, 25))
            typeLabel.layer.borderColor = APP_THEME_COLOR.CGColor
            typeLabel.layer.borderWidth = 0.5
            typeLabel.attributedText = attrStr1
            typeLabel.textAlignment = .Center
            typeLabel.layer.cornerRadius = 2.0
            self.whiteBgView.addSubview(typeLabel)
        }
        
        if let timeleft = self.loanDetail?.timeLeft {
            self.countdown = timeleft/1000
            if self.countdown > 0 {
                timer?.invalidate()
                timer = nil
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(countdowning), userInfo: nil, repeats: true)

            }
        }
    }
    
    func updateCountdownLabel() {
        let days = countdown/24/60/60;
        let hours = (countdown - days*24*3600)/3600;
        let minute = (countdown - days*24*3600 - hours*3600)/60;
        let second = (countdown - days*24*3600 - hours*3600 - minute*60);
        var str = ""
        
        if (days > 0) {
            str += "\(days)天"
        }
        if (hours > 0) {
            str += "\(hours)小时"
        }
        if (minute > 0) {
            str += "\(minute)分钟"
        }
        if (second >= 0) {
            str += "\(second)秒"
        }
        str += "后结束"
        self.expireTimeLabel.text = str

    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func countdowning() {
        if countdown == 0 {
           
            return
        }
        countdown -= 1
        self.updateCountdownLabel()
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
        
        buyButton = UIButton(frame: CGRectMake(80,0,kWindowWidth-80,40))
        buyButton.setTitle("立即购买", forState: .Normal)
        buyButton.titleLabel?.numberOfLines = 0
        buyButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17.0)
        buyButton.setTitleColor(APP_THEME_COLOR, forState: .Normal)
        buyButton.addTarget(self, action: #selector(buyLoanAction), forControlEvents: .TouchUpInside)
        toolBar.addSubview(buyButton)
        
        stausLabel = UILabel(frame: CGRectMake(80,0,kWindowWidth-80,50))
        stausLabel.textAlignment = .Center
        stausLabel.font = UIFont.systemFontOfSize(17)
        stausLabel.textColor = COLOR_TEXT_II
        toolBar.addSubview(stausLabel)
        
        expireTimeLabel = UILabel(frame: CGRectMake(80,32, kWindowWidth-80, 18))
        expireTimeLabel.textColor = APP_THEME_COLOR.colorWithAlphaComponent(0.7)
        expireTimeLabel.textAlignment = .Center
        expireTimeLabel.font = UIFont.systemFontOfSize(11.5)
        toolBar.addSubview(expireTimeLabel)


        self.view.addSubview(toolBar)
    }
    
    func dismissCtl() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func buyLoanAction() {
        let buyLoanCtl = WXBuyLoanViewController()
        buyLoanCtl.loanDetail = loanDetail
        self.presentViewController(UINavigationController(rootViewController: buyLoanCtl), animated: true, completion: nil)

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
            
            var contentStr: NSString = ""
            
            if indexPath.section == 0 {
                if let str = self.loanDetail?.loanRequest?.desc {
                    contentStr = WXCommonMethods.flattenHTML(str, trimWhiteSpace: true)
                }
                
            } else if indexPath.section == 3 {
                contentStr = ""
                
            } else {
                if indexPath.section == 1 {
                    if let str = self.loanDetail?.loanRequest?.guaranteeInfo {
                        contentStr = WXCommonMethods.flattenHTML(str, trimWhiteSpace: true)
                    }
                    
                    
                } else if indexPath.section == 2 {
                    if let str = self.loanDetail?.loanRequest?.mortgageInfo {
                        contentStr = WXCommonMethods.flattenHTML(str, trimWhiteSpace: true)

                    }
                }
            }

            let attrStr = NSMutableAttributedString(string: contentStr as String, attributes: nil)
            attrStr.addAttributes([NSParagraphStyleAttributeName: style, NSFontAttributeName: UIFont.systemFontOfSize(15), NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], range: NSMakeRange(0, attrStr.length))
            cell.textLabel?.attributedText = attrStr
                
            return cell
        } else {
            let cell: WXLoanDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier("loanDetailCell", forIndexPath: indexPath) as! WXLoanDetailTableViewCell
            cell.delegate = self
            cell.updateView(loanImageList)
            return cell
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -60 {
            scrollView.contentOffset = CGPointMake(0, -60)
        }
    }
    
    func didSelectAtIndex(index: NSIndexPath) {
        
        var images = [SKPhoto]()
        
        for imageUrl in self.loanImageList {
            let photo = SKPhoto.photoWithImageURL(imageUrl)
            photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
            images.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(index.row)
        self.presentViewController(browser, animated: true, completion: nil)
    }
    
}
