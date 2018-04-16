//
//  BannerModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class BannerModel: SNSwiftyJSONAble {
    var name : String
    var logo : String
    var fast_way : String
    var site_url : String
    var jump_id : String
    required init?(jsonData: JSON) {
        self.name = jsonData["name"].stringValue
        self.logo = jsonData["logo"].stringValue
        self.fast_way = jsonData["fast_way"].stringValue
        self.site_url = jsonData["site_url"].stringValue
        self.jump_id = jsonData["jump_id"].stringValue
    }
    
    
}
