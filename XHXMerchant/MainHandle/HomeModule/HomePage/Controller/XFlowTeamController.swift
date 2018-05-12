//
//  XFlowTeamController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = XServiceFlowController()
    //第2个子视图控制器
    private let viewController2 = XOperationFlowController()
    
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "服务商"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "运营商"))
        }
    }
}

class XFlowTeamController: SNBaseViewController {
    
    func setupUI() {
        self.title = "团队流量"
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame.origin.y += fit(20)
        //        pagingMenuController.view.frame.size.height -= 64
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
    }
  

    override func setupView() {
        setupUI()
    }
}
