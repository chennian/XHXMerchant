//
//  XMenberListModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class XMenberListModel: NSObject {
    var username : String
    var detail : String
    var user_id : String
    var id : String
    var create_time : String
    var temp:String
    
    required init?(jsonData: JSON) {
        self.username = jsonData["username"].stringValue
        self.detail = jsonData["detail"].stringValue
        self.user_id = jsonData["user_id"].stringValue
        self.id = jsonData["id"].stringValue
        self.create_time = jsonData["create_time"].stringValue
        self.temp = ""

    }
}
class MenberTypeModel: SNSwiftyJSONAble {
    var weichat : [XMenberListModel]
    var alipay : [XMenberListModel]
    
    required init?(jsonData: JSON) {
        self.weichat = jsonData["weichat"].arrayValue.map({ (json) -> XMenberListModel in
            let model = XMenberListModel.init(jsonData: json)
            return model!
        })
        self.alipay = jsonData["alipay"].arrayValue.map({ (json) -> XMenberListModel in
            let model = XMenberListModel.init(jsonData: json)
            return model!
        })
     
        
    }
}
