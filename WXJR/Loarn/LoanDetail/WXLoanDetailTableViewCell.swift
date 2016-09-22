//
//  WXLoanDetailTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/20/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

@objc protocol WXLoanDetailCellDelete {
    
    func didSelectAtIndex(index: NSIndexPath)
}


class WXLoanDetailTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: WXLoanDetailCellDelete?

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func updateView(dataSource: [String]) {
        self.dataSource = dataSource
        self.collectionView.reloadData()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let imageView = UIImageView(frame: CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height))
        imageView.sd_setImageWithURL(NSURL(string: dataSource[indexPath.row]), completed: nil)
        cell.addSubview(imageView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let delegate = self.delegate {
            delegate.didSelectAtIndex(indexPath)
        }
    }
}







