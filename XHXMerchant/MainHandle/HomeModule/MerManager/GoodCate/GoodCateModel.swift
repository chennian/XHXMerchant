//
//  GoodCateModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class GoodCateModel: SNSwiftyJSONAble {
    var category_name :String
    var shop_id:String
    var id :String

    required init?(jsonData: JSON) {
        self.category_name = jsonData["category_name"].stringValue
        self.shop_id = jsonData["shop_id"].stringValue
        self.id = jsonData["id"].stringValue

    }
    
}
