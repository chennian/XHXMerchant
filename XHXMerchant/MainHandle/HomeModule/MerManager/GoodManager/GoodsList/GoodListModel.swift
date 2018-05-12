//
//  GoodListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class GoodListModel: SNSwiftyJSONAble {
    var name :String
    var price:String
    var cate:String
    var main_img:String
    var detail_img:String
    var description:String
    var shop_id:String
    var sell_num:String
    var id:String
    var status:String

    required init?(jsonData: JSON) {
        self.name = jsonData["name"].stringValue
        self.price = jsonData["price"].stringValue
        self.cate = jsonData["cate"].stringValue
        self.main_img = jsonData["main_img"].stringValue
        self.detail_img = jsonData["detail_img"].stringValue
        self.description = jsonData["description"].stringValue
        self.shop_id = jsonData["shop_id"].stringValue
        self.sell_num = jsonData["sell_num"].stringValue
        self.id = jsonData["id"].stringValue
        self.status = jsonData["status"].stringValue
    }
    
}
