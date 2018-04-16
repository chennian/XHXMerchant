//
//  FlowMerModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlowMerModel: SNSwiftyJSONAble {
    var shopName : String
    var realName : String
    var id : String
    var user_num : String
    var address : String
    required init?(jsonData: JSON) {
        self.shopName = jsonData["shopName"].stringValue
        self.realName = jsonData["realName"].stringValue
        self.id = jsonData["id"].stringValue
        self.user_num = jsonData["user_num"].stringValue
        self.address = jsonData["address"].stringValue
    }
    
}
