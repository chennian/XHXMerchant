//
//  XRecmdUserModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/21.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class XRecmdUserModel: SNSwiftyJSONAble {
    var current_role : String
    var upgrate_role : String
    var role_name : String
    var parent_role : String
    var add_time : String
    var status : String
    var phone : String
    var headImg : String
    
    
    required init?(jsonData: JSON) {
        self.current_role = jsonData["current_role"].stringValue
        self.upgrate_role = jsonData["upgrate_role"].stringValue
        self.role_name = jsonData["role_name"].stringValue
        self.parent_role = jsonData["parent_role"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        self.status = jsonData["status"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.headImg = jsonData["headImg"].stringValue
    }
}
