//
//  SNMainTabBarStaffController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/21.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class SNMainTabBarStaffController:UITabBarController {
    
    static let shared = SNMainTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setup()
    }
    
    
    override var selectedIndex: Int{
        willSet{
            ZJLog(messagr: selectedIndex)
        }
        
    }
    
}

fileprivate extension SNMainTabBarStaffController {
    
    func setup() {
        
        let home = navi(XHomeController(), title: "首页", image: "home_homepage", selectedImage: "home_homepage1")
        let center = navi(XCenterController(), title: "我的", image: "home_personal_center", selectedImage: "home_personal_center-1")
        //        let me = navi(BMMeViewController(), title: "我的", image: "home_personal_center", selectedImage: "home_personal_center1")
        //
        self.viewControllers = [home,center]
        
        self.delegate = self
    }
    
    func customTabbarItem(title: String?, image: String?, selectedImage: String?) -> UITabBarItem {
        
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
    
    func navi(_ vClass: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        
        vClass.tabBarItem = customTabbarItem(title: nil, image: image, selectedImage: selectedImage)
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
    
    
}

extension SNMainTabBarStaffController : UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
}
