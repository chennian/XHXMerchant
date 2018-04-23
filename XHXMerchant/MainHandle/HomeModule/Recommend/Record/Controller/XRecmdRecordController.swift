//
//  XRecmdRecordController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = XRecmdMerController()
    //第2个子视图控制器
    private let viewController2 = XRecmdUpdateController()
    
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
            return .text(title: MenuItemText(text: "商家入驻"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "用户升级"))
        }
    }
}

class XRecmdRecordController: SNBaseViewController {
    
    fileprivate var rightButton = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: UIControlState.normal)
        $0.setTitle("全部", for: UIControlState.normal)
        $0.titleLabel?.font = Font(28)
        
    }

    override func setupView() {
        setUpUI()
//        setNavBar()
        
    }
    func setNavBar(){
        
        rightButton = UIButton(frame:CGRect(x:0, y:0, width:50, height:30))
        rightButton.setTitle("全部", for: UIControlState.normal)
        rightButton.setTitleColor(Color(0x313131), for: UIControlState.normal)
        rightButton.setImage(UIImage(named: "earnings_select"), for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-185))
        rightButton.addTarget(self, action: #selector(updateData), for: UIControlEvents.touchUpInside)
        let item = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem=item
    }
    
   @objc fileprivate func  updateData() {
        rightButton.isSelected = !rightButton.isSelected
        if rightButton.isSelected {
            rightButton.setTitle("失败", for: UIControlState.selected)
            rightButton.setImage(UIImage(named: "earnings_select"), for: .selected)
            rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-185))
        }
     }
    
    func setUpUI() {
        self.title = "店铺管理"
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame.origin.y += fit(20)
        //        pagingMenuController.view.frame.size.height -= 64
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
    }
}
