//
//  FlowTeamModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlowTeamModel:SNSwiftyJSONAble {
    var isAgent : String
    var operater : String
    var corporation : String
    var headImg : String
    var nickName : String
    var phone : String
    var shop_num:String

    required init?(jsonData: JSON) {
        self.isAgent = jsonData["isAgent"].stringValue
        self.operater = jsonData["operator"].stringValue
        self.corporation = jsonData["corporation"].stringValue
        self.headImg = jsonData["headImg"].stringValue
        self.nickName = jsonData["nickName"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.shop_num = jsonData["shop_num"].stringValue


    }
    
}
