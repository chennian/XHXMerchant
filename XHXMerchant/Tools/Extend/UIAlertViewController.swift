//
//  UIAlertViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
extension UIViewController{
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    
    //在指定视图控制器上弹出确认框
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
    
    //在指定视图控制器上弹出确认框
    static func showConfirmPay(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionTwo = UIAlertAction(title: "忘记密码", style: .default, handler: confirm)
        alert.addAction(actionTwo)
        actionTwo.setValue(Color(0xff0000), forKey:"titleTextColor")
        viewController.present(alert, animated: true)
        let actionOne = UIAlertAction(title: "重试", style: .cancel)
        alert.addAction(actionOne)
        actionOne.setValue(Color(0xff0000), forKey:"titleTextColor")
       
    }
    
    //在根视图控制器上弹出确认框
    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
    static func showConfirmPay(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirmPay(message: message, in: vc, confirm: confirm)
        }
    }
}



