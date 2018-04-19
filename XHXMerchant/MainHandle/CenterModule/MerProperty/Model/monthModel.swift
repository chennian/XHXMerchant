//
//  monthModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
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
