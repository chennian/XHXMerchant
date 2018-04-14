//
//  XKeyChain.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import KeychainAccess
private let KeychainService = "LittleBlackBear"

class XKeyChain: NSObject {
    /// 将value存入keyChain里
    static func set(_ value: String, key: String){
        let keyChain = Keychain(service: KeychainService)
        do {
            return    try keyChain.set(value, key: key)
        } catch _ {
        }
    }
    /// 传入key值返回Value
    static func get(_ key: String)->String {
        
        let keyChain = Keychain(service: KeychainService)
        do {
            return try keyChain.get(key) ?? ""
        } catch _ {
        }
        return ""
    }
    // 删除所有keyChain的值
    static func removeKeyChain() {
        do {
            try Keychain(service: KeychainService).removeAll()
        } catch _ {
        }
        
    }
}
