//
//  RevenueModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/23.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

import SwiftyJSON
//导流收益, 货款收益
class oneRevenueModel: SNSwiftyJSONAble {
    var credit : String
    var shopName : String
    var money : String
    var add_time:String
    
    required init?(jsonData: JSON) {
        self.credit = jsonData["credit"].stringValue
        self.shopName = jsonData["shopName"].stringValue
        self.money = jsonData["money"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        
    }
}
//服务中心收益,运营商收益,服务商收益
class twoRevenueModel: SNSwiftyJSONAble {
    var num : String
    var shopName : String
    var money : String
    
    required init?(jsonData: JSON) {
        self.num = jsonData["num"].stringValue
        self.shopName = jsonData["shopName"].stringValue
        self.money = jsonData["money"].stringValue
        
    }
}

class RevenueOneModel:SNSwiftyJSONAble {
    var sumMoney : String
    var info : [oneRevenueModel]
    
    required init?(jsonData: JSON) {
        self.sumMoney = jsonData["sumMoney"].stringValue
        
        self.info = jsonData["info"].arrayValue.map({ (json) -> oneRevenueModel in
            let model = oneRevenueModel.init(jsonData: json)
            return model!
        })
    }
}
class RevenueTwoModel:SNSwiftyJSONAble {
    var sumMoney : String
    var info : [twoRevenueModel]
    
    required init?(jsonData: JSON) {
        self.sumMoney = jsonData["sumMoney"].stringValue
        
        self.info = jsonData["info"].arrayValue.map({ (json) -> twoRevenueModel in
            let model = twoRevenueModel.init(jsonData: json)
            return model!
        })
    }
}
