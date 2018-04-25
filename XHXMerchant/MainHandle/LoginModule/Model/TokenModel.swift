//
//  TokenModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class TokenModel: SNSwiftyJSONAble {
    var timestamp : String
    var token : String
    var isEmployee : String
    var id : String
    var names : String
    var employee : String

   
    required init?(jsonData: JSON) {
        self.timestamp = jsonData["timestamp"].stringValue
        self.token = jsonData["token"].stringValue
        self.isEmployee = jsonData["isEmployee"].stringValue
        self.id = jsonData["id"].stringValue
        self.names = jsonData["names"].stringValue
        self.employee = jsonData["employee"].stringValue

    }
    
    
}
