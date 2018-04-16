//
//  UserModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserModel: SNSwiftyJSONAble {
    var nickName : String
    var phone : String
    var headImg : String
    var isMer : String
    var isAgent : String
    var parent_id : String
    var roles : String
    var parent_phone : String
    var operater : String
    var corporation: String


    required init?(jsonData: JSON) {
        self.nickName = jsonData["nickName"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.headImg = jsonData["headImg"].stringValue
        self.isMer = jsonData["isMer"].stringValue
        self.isAgent = jsonData["isAgent"].stringValue
        self.parent_id = jsonData["parent_id"].stringValue
        self.roles = jsonData["roles"].stringValue
        self.parent_phone = jsonData["parent_phone"].stringValue
        self.operater = jsonData["operater"].stringValue
        self.corporation = jsonData["corporation"].stringValue


    }
}
