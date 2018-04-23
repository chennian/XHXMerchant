//
//  XMerStaffList.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/20.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class XMerStaffList: SNSwiftyJSONAble {
    var id : String
    var user_id : String
    var names : String
    var employee : String
    var password : String
    var shop_id : String
    
    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.user_id = jsonData["user_id"].stringValue
        self.names = jsonData["names"].stringValue
        self.employee = jsonData["employee"].stringValue
        self.password = jsonData["password"].stringValue
        self.shop_id = jsonData["shop_id"].stringValue
    }
}
