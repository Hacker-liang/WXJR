//
//  WXBuyLoanBuyTableViewCell.swift
//  WXJR
//
//  Created by liangpengshuai on 9/21/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

@objc protocol WXBuyLoanBuyTableViewCellDelegate {
    
    func updateBuyValue(value: NSString)
}

class WXBuyLoanBuyTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var loanDetail: WXLoanDetailModel?
    
    weak var delegate: WXBuyLoanBuyTableViewCellDelegate?

    @IBOutlet weak var contentTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTF.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return true
        }
        if let str: NSString = textField.text! {
            let newString =  str.stringByReplacingCharactersInRange(range, withString: string)
            delegate?.updateBuyValue(newString)
        }
        
        return true
    }
    
}
