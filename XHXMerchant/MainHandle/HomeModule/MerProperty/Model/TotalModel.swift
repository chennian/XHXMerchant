//
//  TotalModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

enum propertyType{
    case hearder(monthModel)
    case todayHead(todayModel)
    case todayEnd(todayModel)
    case history(historyModel)
    case historyHead
    case space
    
    case service([String])
    case operation([String])
    case merchant([String])
    case merchantFlow([String])
    case center([String])

}

class TotalModel: SNSwiftyJSONAble {
    var month : [monthModel]
    var today : [todayModel]
    var history : [historyModel]
    
    required init?(jsonData: JSON) {
        self.month = jsonData["month"].arrayValue.map({ (json) -> monthModel in
            let model = monthModel.init(jsonData: json)
            return model!
        })
        self.today = jsonData["today"].arrayValue.map({ (json) -> todayModel in
            let model = todayModel.init(jsonData: json)
            return model!
        })
        self.history = jsonData["history"].arrayValue.map({ (json) -> historyModel in
            let model = historyModel.init(jsonData: json)
            return model!
        })
        
    }
}
