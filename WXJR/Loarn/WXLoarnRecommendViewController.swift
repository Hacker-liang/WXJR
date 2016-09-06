//
//  WXLoarnRecommendViewController.swift
//  WXJR
//
//  Created by liangpengshuai on 8/31/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXLoarnRecommendViewController: UIViewController {
    
    var galleryView: AutoSlideScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = APP_PAGE_COLOR
        
        self.navigationItem.title = "未馨金融"
        
        galleryView = AutoSlideScrollView(frame: CGRectMake(0,64, kWindowWidth, 240), animationDuration: 10)
        galleryView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(galleryView)
    }
    
    func loadRecommendDataSource() {
        galleryView.totalPagesCount = {
            return 2
        }
        
        galleryView.fetchContentViewAtIndex = {(pageIndex) in
            let imageView = UIImageView(frame: self.galleryView.bounds)
            return imageView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
