//
//  BankCardModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class BankCardModel: SNSwiftyJSONAble {
    var real_name : String
    var real_card : String
    var bank_id : String
    var bank_name : String
    var bank_num : String
    var subbranch : String
    var bank_logo : String
    var phone : String
    
    required init?(jsonData: JSON) {
        self.real_name = jsonData["real_name"].stringValue
        self.real_card = jsonData["real_card"].stringValue
        self.bank_id = jsonData["bank_id"].stringValue
        self.bank_name = jsonData["bank_name"].stringValue
        self.bank_num = jsonData["bank_num"].stringValue
        self.subbranch = jsonData["subbranch"].stringValue
        self.bank_logo = jsonData["bank_logo"].stringValue
        self.phone = jsonData["phone"].stringValue

    }
}
