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
    case getUserInfo

    case forgetPass(mobile:String,code:String,password:String)
    case bannar
    case bankList
    case insertMerchant(paremeter:[String:Any])
    case sendSMS(mobile:String,vtype:String)
    case verifyCode(mobile:String,code:String,vtype:String)
    case alterAccountPwd(mobile:String,code:String,password:String)
    case myBankCard
    case addBankcard(paremeter:[String:Any])
    case recmdOperator(paremeter:[String:Any])
    case upgrade0perator(verifycode:String)
    case upgradeServer(verifycode:String,activatecode:String)
    case flowMer
    case flowTeam
    case monthTotalRevenue
    case shopHome



}


extension API: JSONMappableTargetType {
    var headers: [String : String]? {
        switch self {
        case .login(let phone,let password):
            return ["X-AUTH-TOKEN":"\(phone):\(password)"]
        default:
            let token = XKeyChain.get(TOKEN)
            let timestamp = XKeyChain.get(TIMESTAMP)
            CNLog(token + timestamp)
            return ["X-AUTH-TOKEN":token,"X-AUTH-TIMESTAMP":timestamp]
        }
        
        
    }
    
    var responseType: SNSwiftyJSONAble.Type {
        return SNNetModel.self
    }
    
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "http://merchant.xiaoheixiong.net/")!
//        return URL(string: "http://192.168.0.3:8016/")!

        }
        
    }
    
    var path: String {
        switch self {
        case .login:
            return "user/validateCredentials"
        case .getUserInfo:
            return "api/getUserInformation"
        case .forgetPass:
            return "user/alterAccountPwd"
        case .bannar:
            return "commom/banner"
        case .bankList:
            return "commom/getBankList"
        case .insertMerchant:
            return "api/merchantAdd"
        case .sendSMS:
            return "commom/sendSMS"
        case .verifyCode:
            return "commom/verifyCode"
        case .alterAccountPwd:
            return "user/alterAccountPwd"
        case .myBankCard:
            return "api/getBank"
        case .addBankcard:
            return "api/addBankcard"
        case .recmdOperator:
            return "api/recommendOperator"
        case .upgrade0perator:
            return "api/upgrade0perator"
        case .upgradeServer:
            return "api/upgradeServer"
        case .flowMer:
            return "api/getMerchantList"
        case .flowTeam:
            return "api/getLiuliangList"
        case .monthTotalRevenue:
            return "api/monthTotalRevenue"
        case .shopHome:
            return "api/shopHome"
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
        case .insertMerchant(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .sendSMS(let mobile,let vtype):
            let para = ["mobile": mobile,"vtype":vtype]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .verifyCode(let mobile,let code,let vtype):
            let para = ["mobile": mobile,"code":code,"vtype":vtype]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .alterAccountPwd(let mobile,let code,let password):
            let para = ["mobile": mobile,"code":code,"password":password]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .addBankcard(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .recmdOperator(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .upgrade0perator(let verifycode):
            let para = ["verifycode":verifycode]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
            
        case .upgradeServer(let verifycode,let activatecode):
            let para = ["verifycode":verifycode,"activatecode":activatecode]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        default:
            return Task.requestPlain
        }
        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}

