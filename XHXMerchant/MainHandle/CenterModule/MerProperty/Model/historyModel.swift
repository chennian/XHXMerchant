//
//  XTotalEarningListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class historyModel: SNSwiftyJSONAble {
    var credit : String
    var num : String
    var add_time : String

    required init?(jsonData: JSON) {
        self.credit = jsonData["credit"].stringValue
        self.num = jsonData["num"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        
    }
}

