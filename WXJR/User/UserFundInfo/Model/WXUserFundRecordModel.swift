//
//  WXUserFundRecordModel.swift
//  WXJR
//
//  Created by liangpengshuai on 9/18/16.
//  Copyright © 2016 com.wxjr. All rights reserved.
//

import UIKit

class WXUserFundRecordModel: NSObject {
    
    var orderId: String?
    var amount: Double?
    var status: WXFundRecordStatus?
    var timeRecorded: NSTimeInterval?
    var statusDesc: String? {
        get {
            var retSrt = ""
            if let status = self.status {
                switch status {
                case . kINITIALIZED:
                    retSrt = "初始"
                case .kPROCESSING:
                    retSrt = "处理中"
                case .kAUDITING:
                    retSrt = "审核中"
                case .kPAY_PENDING:
                    retSrt = "支付结果待查"
                case .kCUT_PENDING:
                    retSrt = "代扣结果待查"
                case .kSUCCESSFUL:
                    retSrt = "成功"
                case .kFAILED:
                    retSrt = "失败"
                case .kREJECTED:
                    retSrt = "被拒绝"
                case .kCANCELED:
                    retSrt = "已取消"
                }
            }
            return retSrt
        }
    }
    
    var type: WXUserFundRecordType?
    var typeDesc: String? {
        get {
            var retSrt = ""
            if let type = self.type {
                switch type {
                case .INVEST:
                    retSrt = "投标"
                case .WITHDRAW:
                    retSrt = "取现"
                case .DEPOSIT:
                    retSrt = "充值"
                case .LOAN:
                    retSrt = "放款"
                case .LOAN_REPAY:
                    retSrt = "贷款还款"
                case .DISBURSE:
                    retSrt = "垫付还款"
                case .INVEST_REPAY:
                    retSrt = "投资还款"
                case .CREDIT_ASSIGN:
                    retSrt = "债权转让"
                case .TRANSFER:
                    retSrt = "转账扣款"
                case .OFFLINE_DEPOSIT:
                    retSrt = "线下充值"
                case .LOAN_INTEREST:
                    retSrt = "贷款还息"
                case .INVEST_INTEREST:
                    retSrt = "投资结息"
                case .DISBURSE_INTEREST:
                    retSrt = "垫付结息"
                case .REWARD_REGISTER:
                    retSrt = "注册奖励"
                case .REWARD_REFERRAL:
                    retSrt = "推荐奖励"
                case .REWARD_INVEST:
                    retSrt = "投标奖励"
                case .REWARD_DEPOSIT:
                    retSrt = "充值奖励"
                case .COUPON_CASH:
                    retSrt = "现金券"
                case .COUPON_INTEREST:
                    retSrt = "加息券"
                case .COUPON_PRINCIPAL:
                    retSrt = "增值券"
                case .COUPON_REBATE:
                    retSrt = "返现券"
                case .INTEREST_BEARING_INCOME:
                    retSrt = "余额生息收益"
                case .FEE_WITHDRAW:
                    retSrt = "提现手续费"
                case .FEE_AUTHENTICATE:
                    retSrt = "身份验证手续费"
                case .FEE_INVEST_INTEREST:
                    retSrt = "投资管理费"
                case .FEE_LOAN_SERVICE:
                    retSrt = "借款服务费"
                case .FEE_LOAN_MANAGE:
                    retSrt = "借款管理费"
                case .FEE_LOAN_INTEREST:
                    retSrt = "还款管理费"
                case .FEE_LOAN_VISIT:
                    retSrt = "实地考察费"
                case .FEE_LOAN_GUARANTEE:
                    retSrt = "担保费"
                case .FEE_LOAN_RISK:
                    retSrt = "风险管理费"
                case .FEE_LOAN_OVERDUE:
                    retSrt = "逾期管理费"
                case .FEE_LOAN_PENALTY:
                    retSrt = "逾期罚息(给商户)"
                case .FEE_LOAN_PENALTY_INVEST:
                    retSrt = "逾期罚息(给投资人)"
                case .FEE_DEPOSIT:
                    retSrt = "充值手续费"
                case .FEE_ADVANCE_REPAY:
                    retSrt = "提前还款违约金(给商户)"
                case .FEE_ADVANCE_REPAY_INVEST:
                    retSrt = "提前还款违约金(给投资人)"
                case .FEE_CREDIT_ASSIGN:
                    retSrt = "债权转让手续费"
                case .FEE_BIND_CARD:
                    retSrt = "用户绑卡手续费"
                case .FEE_WEALTHPRODUCT_MANAGE:
                    retSrt = "产品管理费"
                case .FEE_WEALTHPRODUCT_CUSTODY:
                    retSrt = "产品托管费"
                case .FSS:
                    retSrt = "生利宝"
                case .INVESTMENT_FUND:
                    retSrt = "基金"
                case .INSURANCE_PREMIUM:
                    retSrt = "保费"
                case .INSURANCE_APPEND_PREMIUM:
                    retSrt = "保费追加"
                case .INSURANCE_REFUND:
                    retSrt = "退保"
                case .STOCK_PAY:
                    retSrt = "配资付款"
                case .STOCK_PROFIT:
                    retSrt = "提取盈利"
                case .STOCK_AMOUNT_ADD:
                    retSrt = "追加保证金"
                case .STOCK_EXTENSION:
                    retSrt = "配资续期"
                case .STOCk_SETTLE:
                    retSrt = "配资结算"
                case .WEALTH_PRODUCT_SUBSCRIBE_PAY:
                    retSrt = "认购付款"
                }

                
            }
            return retSrt
        }
    }
    
    init(json: NSDictionary) {
        orderId = json.objectForKey("orderId") as? String
        amount = json.objectForKey("amount") as? Double
        timeRecorded = json.objectForKey("timeRecorded") as? NSTimeInterval
        status = WXFundRecordStatus(rawValue: (json.objectForKey("status") as! String))
        type = WXUserFundRecordType(rawValue: (json.objectForKey("type") as! String))
    }
}


enum WXFundRecordStatus: String {
    
    case kINITIALIZED = "INITIALIZED"
    case kPROCESSING = "PROCESSING"
    case kAUDITING = "AUDITING"
    case kPAY_PENDING = "PAY_PENDING"
    case kCUT_PENDING = "CUT_PENDING"
    case kSUCCESSFUL = "SUCCESSFUL"
    case kFAILED = "FAILED"
    case kREJECTED = "REJECTED"
    case kCANCELED = "CANCELED"

}

enum WXUserFundRecordType: String {
    case INVEST = "INVEST"                             //投标
    case WITHDRAW = "WITHDRAW"                         //取现
    case DEPOSIT = "DEPOSIT"                           //充值
    case LOAN = "LOAN"                                 //放款
    case LOAN_REPAY = "LOAN_REPAY"                     //贷款还款
    case DISBURSE = "DISBURSE"                         //垫付还款
    case INVEST_REPAY = "INVEST_REPAY"                 //投资还款
    case CREDIT_ASSIGN = "CREDIT_ASSIGN"               //债权转让
    case TRANSFER = "TRANSFER"                         //转账扣款（商户用）
    case OFFLINE_DEPOSIT = "OFFLINE_DEPOSIT"           //线下充值补录数据用
    case LOAN_INTEREST = "LOAN_INTEREST"               //贷款还息
    case INVEST_INTEREST = "INVEST_INTEREST"           //投资结息
    case DISBURSE_INTEREST = "DISBURSE_INTEREST"       //垫付结息
    case REWARD_REGISTER = "REWARD_REGISTER"           //注册奖励
    case REWARD_REFERRAL = "REWARD_REFERRAL"           //推荐奖励
    case REWARD_INVEST = "REWARD_INVEST"               //投标奖励
    case REWARD_DEPOSIT = "REWARD_DEPOSIT"             //充值奖励
    case COUPON_CASH = "COUPON_CASH"                   //现金券
    case COUPON_INTEREST = "COUPON_INTEREST"           //加息券
    case COUPON_PRINCIPAL = "COUPON_PRINCIPAL"         //增值券
    case COUPON_REBATE = "COUPON_REBATE"               //返现券
    case INTEREST_BEARING_INCOME = "INTEREST_BEARING_INCOME"  //余额生息收益
    case FEE_WITHDRAW = "FEE_WITHDRAW"                 //提现手续费
    case FEE_AUTHENTICATE = "FEE_AUTHENTICATE"         //验证身份手续费
    case FEE_INVEST_INTEREST = "FEE_INVEST_INTEREST"   //投资管理费
    case FEE_LOAN_SERVICE = "FEE_LOAN_SERVICE"         //借款服务费
    case FEE_LOAN_MANAGE = "FEE_LOAN_MANAGE"           //借款管理费
    case FEE_LOAN_INTEREST = "FEE_LOAN_INTEREST"       //还款管理费
    case FEE_LOAN_VISIT = "FEE_LOAN_VISIT"             //实地考察费
    case FEE_LOAN_GUARANTEE = "FEE_LOAN_GUARANTEE"     //担保费
    case FEE_LOAN_RISK = "FEE_LOAN_RISK"               //风险管理费
    case FEE_LOAN_OVERDUE = "FEE_LOAN_OVERDUE"         //逾期管理费
    case FEE_LOAN_PENALTY = "FEE_LOAN_PENALTY"         //逾期罚息(给商户)
    case FEE_LOAN_PENALTY_INVEST = "FEE_LOAN_PENALTY_INVEST"  //逾期罚息(给投资人)
    case FEE_DEPOSIT = "FEE_DEPOSIT"                   //充值手续费
    case FEE_ADVANCE_REPAY = "FEE_ADVANCE_REPAY"       //提前还款违约金(给商户)
    case FEE_ADVANCE_REPAY_INVEST = "FEE_ADVANCE_REPAY_INVEST"   //提前还款违约金(给投资人)
    case FEE_CREDIT_ASSIGN = "FEE_CREDIT_ASSIGN"        //债权转让手续费
    case FEE_BIND_CARD = "FEE_BIND_CARD"                //用户绑卡手续费
    case FEE_WEALTHPRODUCT_MANAGE = "FEE_WEALTHPRODUCT_MANAGE"      //产品管理费
    case FEE_WEALTHPRODUCT_CUSTODY = "FEE_WEALTHPRODUCT_CUSTODY"    //产品托管费
    case FSS = "FSS"                                    //生利宝
    case INVESTMENT_FUND = "INVESTMENT_FUND"            //基金
    case INSURANCE_PREMIUM = "INSURANCE_PREMIUM"        //保费
    case INSURANCE_APPEND_PREMIUM = "INSURANCE_APPEND_PREMIUM"      //保费追加
    case INSURANCE_REFUND = "INSURANCE_REFUND"          //退保
    case STOCK_PAY = "STOCK_PAY"                        //配资付款
    case STOCK_PROFIT = "STOCK_PROFIT"                  //提取盈利
    case STOCK_AMOUNT_ADD = "STOCK_AMOUNT_ADD"          //追加保证金
    case STOCK_EXTENSION = "STOCK_EXTENSION"            //配资续期
    case STOCk_SETTLE = "STOCk_SETTLE"                  //配资结算
    case WEALTH_PRODUCT_SUBSCRIBE_PAY = "WEALTH_PRODUCT_SUBSCRIBE_PAY"      //认购付款


}