//
//  todayModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class todayModel:SNSwiftyJSONAble {
    var flowmeter : String
    var flow_num : String
    var merchant : String
    var merchant_num : String
    var service : String
    var service_num : String
    var operater : String
    var corporation : String
    var corporation_num : String
    var money : String

    
    required init?(jsonData: JSON) {
        self.flowmeter = jsonData["flowmeter"].stringValue
        self.flow_num = jsonData["flow_num"].stringValue
        self.merchant = jsonData["merchant"].stringValue
        self.merchant_num = jsonData["merchant_num"].stringValue
        self.service = jsonData["service"].stringValue
        self.service_num = jsonData["service_num"].stringValue
        self.operater = jsonData["operator"].stringValue
        self.corporation = jsonData["corporation"].stringValue
        self.corporation_num = jsonData["corporation_num"].stringValue
        self.money = jsonData["money"].stringValue
    }
}

