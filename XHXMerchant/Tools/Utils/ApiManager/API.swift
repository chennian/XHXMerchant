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
    case merchantAddPublic(paremeter:[String:Any])
    case sendSMS(mobile:String,vtype:String)
    case verifyCode(mobile:String,code:String,vtype:String)
    case alterAccountPwd(mobile:String,code:String,password:String)
    case myBankCard
    case addBankcard(paremeter:[String:Any])
    case updateBank(paremeter:[String:Any])
    case recmdOperator(paremeter:[String:Any])
    case recommendService(paremeter:[String:Any])
    case upgrade0perator(verifycode:String)
    case upgradeServer(verifycode:String,activatecode:String)
    case flowMer
    case flowTeam(role:String)
    case monthTotalRevenue
    case shopHome(shopId:String)
    case uploadMerData(paremeter:[String:Any])
    case shopList
    case shopCategory
    case submitShopDate(paremeter:[String:Any])
    case getShopEmployeeList(shop_id:String)
    case shopAddEmployee(paremeter:[String:Any])
    case deleteShopEmployee(id:String,shopId:String)
    case shopEditEmployee(paremeter:[String:Any])
    case addBranchShop(paremeter:[String:Any])
    case merchantAddShop(paremeter:[String:Any])
    case myRecommendMerchantList(status:String)
    case myRecommendUserList(status:String)
    case historyRevenue //历史收益
    case todayTotalRevenue //今日收益
    case dayTotalRevenue(paremeter:[String:Any]) //每日收益
    case flowMeterRevenue(start_date:String,end_date:String) //导流收益
    case corporationRevenue(start_date:String,end_date:String) //服务中心收益
    case merchantRevenue(start_date:String,end_date:String) //货款收益
    case operatorRevenue(start_date:String,end_date:String) //运营商收益
    case serviceRevenue(start_date:String,end_date:String) //服务商收益
    case shopPayAuthority(shop_id:String)  //生成收款码权限
    case getLicenseList
    case addSecond(paremeter:[String:Any]) //上传秒秒
    case deleteSecond(paremeter:[String:Any]) //删除秒秒
    case getKillList(paremeter:[String:Any]) //获取秒杀列表
    case editShopKill(paremeter:[String:Any])//编辑
    case getShopMemberList(shopId:String)
    case getShopEmployeeGatheList(employee_id:String)
    case couponCancel(code:String)
    case getUserMiaoMiaoDetal(code:String)
    case updateHeadPic(headImg:String)
    case setPushSwitch(paremeter:[String:Any]) //推送开关
    
    case addGood(paremeter:[String:Any])   //添加商品
    case editGood(paremeter:[String:Any])//编辑商品
    case getGoodsDetal(paremeter:[String:Any])//获取商品详情
    case goodList(paremeter:[String:Any])//商品列表
    case addCategory(paremeter:[String:Any])//添加商品分类
    case deleteCategory(paremeter:[String:Any])//删除商品分类
    case editCategory(paremeter:[String:Any])//编辑商品分类
    case getCategory(paremeter:[String:Any])//获取商品分类列表
    case delGoodsBat(paremeter:[String:Any])//批量删除商品
    case putOffGoodsBat(paremeter:[String:Any])//批量下架商品
    case putOnGoodsBat(paremeter:[String:Any])//批量商家商品
    case putOffOrONGoodsBat(paremeter:[String:Any])
    case searchGoodGoodsList(paremeter:[String:Any])
    case getCategoryGoodNum(paremeter:[String:Any])
    case goodCategoryGoodsList(paremeter:[String:Any])
    
    case getExchangeInfo //提现页面信息
    case getExchangeList //提现记录
    case exchange(paremeter:[String:Any])         //提现
    case alterPwd(mobile:String,code:String,password:String)        //设置支付密码
    case verifySecret(paremeter:[String:Any])     //验证支付密码
 
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
        case .merchantAddPublic:
            return "api/merchantAddPublic"
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
        case .updateBank:
            return "api/updateBank"
        case .recmdOperator:
            return "api/recommendOperator"
        case .recommendService:
            return "api/recommendService"
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
        case .uploadMerData:
            return "api/btnShopInfo"
        case .shopList:
            return "api/getShopList"
        case .shopCategory:
            return "commom/getShopCategory"
        case .submitShopDate:
            return "api/btnShopInfo"
        case .getShopEmployeeList:
            return "api/getShopEmployeeList"
        case .shopAddEmployee:
            return "api/shopAddEmployee"
        case .deleteShopEmployee:
            return "api/deleteShopEmployee"
        case .shopEditEmployee:
            return "api/shopEditEmployee"
        case .addBranchShop:
            return "api/addBranchShop"
        case .merchantAddShop:
            return "api/merchantAddShop"
        case .myRecommendMerchantList:
            return "api/myRecommendMerchantList"
        case .myRecommendUserList:
            return "api/myRecommendUserList"
        case .historyRevenue:
            return "api/historyRevenue"
        case .todayTotalRevenue:
            return "api/todayTotalRevenue"
        case .dayTotalRevenue:
            return "api/theDayRevenue"
        case .flowMeterRevenue:
            return "api/flowMeterRevenue"
        case .corporationRevenue:
            return "api/corporationRevenue"
        case .merchantRevenue:
            return "api/merchantRevenue"
        case .operatorRevenue:
            return "api/operatorRevenue"
        case .serviceRevenue:
            return "api/serviceRevenue"
        case .shopPayAuthority:
            return "commom/shopPayAuthority"
        case .getLicenseList:
            return "api/getLicenseList"
        case .addSecond:
            return "api/addShopKill"
        case .deleteSecond:
            return "api/deleteShopKill"
        case .getKillList:
            return "api/getKillList"
        case .editShopKill:
            return "api/editShopKill"
        case .getShopMemberList:
            return "api/getShopMemberList"
        case .getShopEmployeeGatheList:
            return "commom/getShopEmployeeGatheList"
        case .couponCancel:
            return "api/cancelcoupon"
        case .getUserMiaoMiaoDetal:
            return "api/getUserMiaoMiaoDetal"
        case .updateHeadPic:
            return "api/updateHeadPic"
        case .setPushSwitch:
            return "commom/setPushSwitch"
            
        case .addGood:
            return "goods/addGood"
        case .editGood:
            return "goods/editGood"
        case .getGoodsDetal:
            return "goods/getGoodsDetal"
        case .goodList:
            return "goods/goodList"
        case .addCategory:
            return "goods/addCategory"
        case .deleteCategory:
            return "goods/deleteCategory"
        case .editCategory:
            return "goods/editCategory"
        case .getCategory:
            return "goods/getCategory"
        case .delGoodsBat:
            return "goods/delGoodsBat"
        case .putOffGoodsBat:
            return "goods/putOffGoodsBat"
        case .putOnGoodsBat:
            return "goods/putOnGoodsBat"
        case .putOffOrONGoodsBat:
            return "goods/putOffOrONGoodsBat"
        case .searchGoodGoodsList:
            return "goods/searchGoodGoodsList"
        case .getCategoryGoodNum:
            return "goods/getCategoryGoodNum"
        case .goodCategoryGoodsList:
            return "goods/goodCategoryGoodsList"
            
        case .getExchangeInfo:
            return "api/getExchangeInfo"
        case .getExchangeList:
            return "api/getExchangeList"
        case .exchange:
            return "api/exchange"
        case .alterPwd:
            return "api/alterPwd"
        case .verifySecret:
            return "api/verifySecret"

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
        case .updateHeadPic(let headImg):
            let para = ["headImg": headImg]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .forgetPass(let mobile,let code,let password):
            let para = ["mobile": mobile,"code":code,"password":password]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .insertMerchant(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .merchantAddPublic(let paremeter):
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
        case .updateBank(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .recmdOperator(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .recommendService(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .upgrade0perator(let verifycode):
            let para = ["verifycode":verifycode]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .upgradeServer(let verifycode,let activatecode):
            let para = ["verifycode":verifycode,"activatecode":activatecode]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .shopHome(let shopId):
            let para = ["shop_id":shopId]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .uploadMerData(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .submitShopDate(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .getShopEmployeeList(let shop_id):
            let para = ["shopId":shop_id]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .shopAddEmployee(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .deleteShopEmployee(let id,let shopId):
            let para = ["id":id,"shopId":shopId]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .shopEditEmployee(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .addBranchShop(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .merchantAddShop(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .myRecommendMerchantList(let status):
            let para = ["status":status]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .myRecommendUserList(let status):
            let para = ["status":status]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .flowMeterRevenue(let start_date,let end_date):
            let para = ["start_date":start_date,"end_date":end_date]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .corporationRevenue(let start_date,let end_date):
            let para = ["start_date":start_date,"end_date":end_date]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .merchantRevenue(let start_date,let end_date):
            let para = ["start_date":start_date,"end_date":end_date]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .operatorRevenue(let start_date,let end_date):
            let para = ["start_date":start_date,"end_date":end_date]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .serviceRevenue(let start_date,let end_date):
            let para = ["start_date":start_date,"end_date":end_date]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .shopPayAuthority(let shop_id):
            let para = ["shop_id":shop_id]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .addSecond(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .deleteSecond(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .getKillList(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .editShopKill(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .dayTotalRevenue(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .getShopMemberList(let shopId):
            let para = ["shopId":shopId]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .getShopEmployeeGatheList(let employee_id):
            let para = ["employee_id":employee_id]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .couponCancel(let code):
            let para = ["verfifyCode":code]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .getUserMiaoMiaoDetal(let code):
            let para = ["verfifyCode":code]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .setPushSwitch(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .flowTeam(let role):
            let para = ["role":role]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
            
        case .addGood(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .editGood(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .getGoodsDetal(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .goodList(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .addCategory(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .deleteCategory(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .editCategory(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .getCategory(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .delGoodsBat(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .putOffGoodsBat(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .putOnGoodsBat(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .putOffOrONGoodsBat(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .searchGoodGoodsList(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .getCategoryGoodNum(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .goodCategoryGoodsList(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
            
     
        case .exchange(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        case .alterPwd(let mobile,let code,let password):
            let para = ["mobile": mobile,"code":code,"password":password]
            return .requestParameters(parameters:para,encoding: URLEncoding.default)
        case .verifySecret(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
        default:
            return Task.requestPlain
        }
        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}

