//
//  ShopHomeModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShopHomeModel: SNSwiftyJSONAble {
    var shop_id:String
    var shopName:String
    var flow_num:String
    var personal:String
    
    required init?(jsonData: JSON) {
        self.shop_id = jsonData["shop_id"].stringValue
        self.shopName = jsonData["shopName"].stringValue
        self.flow_num = jsonData["flow_num"].stringValue
        self.personal = jsonData["personal"].stringValue
    
    }

}
