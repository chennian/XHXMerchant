//
//  CashInfoModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class CashInfoModel: SNSwiftyJSONAble {
    var account : String
    var pay_pwd : String
    var bankname : String
    var state : String
    
    
    required init?(jsonData: JSON) {
        self.account = jsonData["account"].stringValue
        self.pay_pwd = jsonData["pay_pwd"].stringValue
        self.bankname = jsonData["bankname"].stringValue
        self.state = jsonData["state"].stringValue
    }
}
