//
//  API.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import Moya
//import RxMoya
import Alamofire

//var userToken = ""
//var headerFields = ["X-AUTH-TOKEN": userToken]

let testAPIProvider = RxMoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub)
let BMProvider = RxMoyaProvider<API>()

enum API {
    case login(phone:String,password:String)
    case forgetPass(mobile:String,code:String,password:String)
}


extension API: JSONMappableTargetType {
    var headers: [String : String]? {
        switch self {
        case .login(let phone,let password):
            return ["X-AUTH-TOKEN":"\(phone):\(password)"]
        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded;charset=utf-8"
            ]
        }
        
        
    }
    
    var responseType: SNSwiftyJSONAble.Type {
        return SNNetModel.self
    }
    
    
    var baseURL: URL {
        switch self {
        default:
//            return URL(string: "http://api.xiaoheixiong.net/")!
        return URL(string: "http://192.168.0.3:8016/")!

        }
        
    }
    
    var path: String {
        switch self {
        case .login:
            return "user/validateCredentials"
        case .forgetPass:
            return "user/alterAccountPwd"
        default:
            return ""
        }
        
    }
    

    
    var method: Moya.Method {
        switch self {

        default:
            return .post
        }
        
        
    }
    
   
    
    var sampleData: Data {
        switch self {
        default:
            return "".data(using: .utf8)!
        }
    }
    


    
    var task: Task {
        
        switch self {
        case .forgetPass(let mobile,let code,let password):
            let para = ["mobile": mobile,"code":code,"password":password]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        default:
            return Task.requestPlain
        }
        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}

