//
//  XTotalEarningListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class historyModel: SNSwiftyJSONAble {
    var credit : String
    var num : String
    var add_time : String

    required init?(jsonData: JSON) {
        self.credit = jsonData["credit"].stringValue
        self.num = jsonData["num"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        
    }
}
class todayModel:SNSwiftyJSONAble {
    var flowmeter : String
    var flow_num : String
    var merchant : String
    var merchant_num : String
    var service : String
    var service_num : String
    var operater : String
    var operator_num:String
    var corporation : String
    var corporation_num : String
    var money : String
    var credit : String
    var totalNum : String
    
    required init?(jsonData: JSON) {
        self.flowmeter = jsonData["flowmeter"].stringValue
        self.flow_num = jsonData["flow_num"].stringValue
        self.merchant = jsonData["merchant"].stringValue
        self.merchant_num = jsonData["merchant_num"].stringValue
        self.service = jsonData["service"].stringValue
        self.service_num = jsonData["service_num"].stringValue
        self.operater = jsonData["operator"].stringValue
        self.operator_num = jsonData["operator_num"].stringValue
        self.corporation = jsonData["corporation"].stringValue
        self.corporation_num = jsonData["corporation_num"].stringValue
        self.money = jsonData["money"].stringValue
        self.credit = jsonData["credit"].stringValue
        self.totalNum = jsonData["totalNum"].stringValue

    }
}

class dayModel:SNSwiftyJSONAble {
    var flowmeter : String
    var flow_num : String
    var merchant : String
    var merchant_num : String
    var service : String
    var service_num : String
    var operater : String
    var operator_num:String
    var corporation : String
    var corporation_num : String
    var credit : String
    var totalNum : String

    
    required init?(jsonData: JSON) {
        self.flowmeter = jsonData["flowmeter"].stringValue
        self.flow_num = jsonData["flow_num"].stringValue
        self.merchant = jsonData["merchant"].stringValue
        self.merchant_num = jsonData["merchant_num"].stringValue
        self.service = jsonData["service"].stringValue
        self.service_num = jsonData["service_num"].stringValue
        self.operater = jsonData["operator"].stringValue
        self.operator_num = jsonData["operator_num"].stringValue
        self.corporation = jsonData["corporation"].stringValue
        self.corporation_num = jsonData["corporation_num"].stringValue
        self.credit = jsonData["credit"].stringValue
        self.totalNum = jsonData["totalNum"].stringValue

    }
}

class monthModel:  SNSwiftyJSONAble {
    var flowmeter_total : String
    var merchant_total : String
    var service_total : String
    var operator_total : String
    var corporation_total : String
    var credit : String
    
    required init?(jsonData: JSON) {
        self.flowmeter_total = jsonData["flowmeter_total"].stringValue
        self.merchant_total = jsonData["merchant_total"].stringValue
        self.service_total = jsonData["service_total"].stringValue
        self.operator_total = jsonData["operator_total"].stringValue
        self.corporation_total = jsonData["corporation_total"].stringValue
        self.credit = jsonData["credit"].stringValue
    }
}
