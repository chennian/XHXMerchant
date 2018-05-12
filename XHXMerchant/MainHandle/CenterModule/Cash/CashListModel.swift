//
//  CashListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class CashListModel: SNSwiftyJSONAble {
    var money : String
    var status : String
    var transfer_status : String
    var add_time : String
    var bankname : String

    
    required init?(jsonData: JSON) {
        self.money = jsonData["money"].stringValue
        self.status = jsonData["status"].stringValue
        self.transfer_status = jsonData["transfer_status"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        self.bankname = jsonData["bankname"].stringValue
    }
}
