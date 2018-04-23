//
//  UIViewController+Extension.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/22.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
extension UIViewController{
    func setUp(_ vClass: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        
        vClass.tabBarItem = setUpTabbarItem(title: nil, image: image, selectedImage: selectedImage)
        //        vClass.tabBarItem.title = title
        vClass.title = title
        
        let selAttr = [
            NSAttributedStringKey.foregroundColor : color_main
        ]
        
        let defAttr = [
            NSAttributedStringKey.foregroundColor : Color(0x6c6c6c)
        ]
        
        vClass.tabBarItem.setTitleTextAttributes(defAttr, for: .normal)
        vClass.tabBarItem.setTitleTextAttributes(selAttr, for: .selected)
        
        let navi = SNBaseNaviController(rootViewController: vClass)
        navi.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : Font(36)]
        return navi
    }
    func setUpTabbarItem(title: String?, image: String?, selectedImage: String?) -> UITabBarItem {
        let bar = UITabBarItem()
        if let t = title {
            bar.title = t
        }
        if let img = image {
            bar.image = Image(img)
        }
        if let simg = selectedImage {
            bar.selectedImage = Image(simg)
        }
        return bar
    }
    
}
