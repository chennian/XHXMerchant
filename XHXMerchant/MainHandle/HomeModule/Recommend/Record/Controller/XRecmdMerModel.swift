//
//  XRecmdMerModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/21.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class XRecmdMerModel: SNSwiftyJSONAble {
    var shopName : String
    var name : String
    var state : String
    var state_msg : String
    var add_time : String

    required init?(jsonData: JSON) {
        self.shopName = jsonData["shopName"].stringValue
        self.name = jsonData["name"].stringValue
        self.state = jsonData["state"].stringValue
        self.state_msg = jsonData["state_msg"].stringValue
        self.add_time = jsonData["add_time"].stringValue
    }
}
