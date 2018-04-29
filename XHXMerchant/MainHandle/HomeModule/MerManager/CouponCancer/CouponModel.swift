//
//  CouponModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/29.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class CouponModel: SNSwiftyJSONAble {
    var status : String
    var name : String
    var terminaltime : String
    var shopName : String
    
    
    required init?(jsonData: JSON) {
        self.status = jsonData["status"].stringValue
        self.name = jsonData["name"].stringValue
        self.terminaltime = jsonData["terminaltime"].stringValue
        self.shopName = jsonData["shopName"].stringValue
   
    }
}
