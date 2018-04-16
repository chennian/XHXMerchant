//
//  BankListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class BankListModel: SNSwiftyJSONAble {
    var bankId : String
    var bankName : String
    required init?(jsonData: JSON) {
        self.bankId = jsonData["bankId"].stringValue
        self.bankName = jsonData["bankName"].stringValue
    }
    
    
}
