//
//  RecordListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/27.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class RecordListModel: SNSwiftyJSONAble {
    var money :String
    var add_time:String
    
    required init?(jsonData: JSON) {
        self.money = jsonData["money"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        
    }

}
