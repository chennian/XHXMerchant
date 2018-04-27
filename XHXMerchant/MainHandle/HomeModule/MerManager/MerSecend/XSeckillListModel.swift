//
//  XSeckillListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class XSeckillListModel: SNSwiftyJSONAble {
    var id : String
    var name : String
    var price : String
    var endTime : String
    var terminaltime : String
    var cardNum : String
    var mainImg : String
    var detailImg : String
    var description : String
    var state : String
    var shopId : String
    var add_time : String

    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.name = jsonData["name"].stringValue
        self.price = jsonData["price"].stringValue
        self.endTime = jsonData["endTime"].stringValue
        self.terminaltime = jsonData["terminaltime"].stringValue
        self.cardNum = jsonData["cardNum"].stringValue
        self.mainImg = jsonData["mainImg"].stringValue
        self.detailImg = jsonData["detailImg"].stringValue
        self.description = jsonData["description"].stringValue
        self.state = jsonData["state"].stringValue
        self.shopId = jsonData["shopId"].stringValue
        self.add_time = jsonData["add_time"].stringValue

    }
}
