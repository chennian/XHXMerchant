//
//  GoodCateSearchModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoodCateSearchModel: SNSwiftyJSONAble {
  
    var num :String
    var cate:String
    
    required init?(jsonData: JSON) {
        self.num = jsonData["num"].stringValue
        self.cate = jsonData["cate"].stringValue
        
    }
        
}
