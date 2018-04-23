//
//  XMerListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class XMerListModel: SNSwiftyJSONAble {
    var shop_id : String
    var mer_id : String
    var user_id : String
    var category : String
    var shopName : String
    var phone : String
    var banner : String
    var logo : String
    var tab : String
    var realName : String
    var flow_num : String
    var personal : String
    var state : String
    var address : String
    var detail : String
    var add_time : String

    required init?(jsonData: JSON) {
        self.shop_id = jsonData["shop_id"].stringValue
        self.mer_id = jsonData["mer_id"].stringValue
        self.user_id = jsonData["user_id"].stringValue
        self.category = jsonData["category"].stringValue
        self.shopName = jsonData["shopName"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.banner = jsonData["banner"].stringValue
        self.logo = jsonData["logo"].stringValue
        self.tab = jsonData["tab"].stringValue
        self.realName = jsonData["realName"].stringValue
        self.flow_num = jsonData["flow_num"].stringValue
        self.personal = jsonData["personal"].stringValue
        self.state = jsonData["state"].stringValue
        self.address = jsonData["address"].stringValue
        self.detail = jsonData["detail"].stringValue
        self.add_time = jsonData["add_time"].stringValue
    }
}
