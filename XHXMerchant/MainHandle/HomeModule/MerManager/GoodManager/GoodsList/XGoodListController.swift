//
//  XGoodListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = XGoodOnSaleController()
    //第2个子视图控制器
    private let viewController2 = XGoodSoldOutController()
    
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
            return .text(title: MenuItemText(text: "销售中"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "已下架"))
        }
    }
}


class XGoodListController: SNBaseViewController {
    var shopid :String = ""
    
    var currentPage:Int = 0
    
    var searchBar = UISearchBar().then{
        $0.placeholder = "查找"
        $0.showsCancelButton = false
        $0.searchBarStyle = .minimal
        $0.barTintColor = Color(0xf5f5f5)
        $0.backgroundColor = .clear
    }
    
    var bottomView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let addBtn = UIButton().then{
        $0.setTitle("添加商品", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setImage(UIImage(named: "commodity_addition"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-20))

    }
    let editBtn = UIButton().then{
        $0.setTitle("编辑", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setImage(UIImage(named: "commodity_compile"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-20))
    }
    let sepline = UIView().then{
        $0.backgroundColor = Color(0xb0b4b8)
    }
    let topline = UIView().then{
        $0.backgroundColor = Color(0xb0b4b8)
    }
    
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "", imgName:"sifting_sort", target: self, action: #selector(cate))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc func cate(){
        //分类
        self.navigationController?.pushViewController(XGoodCateSearchListController(), animated: true)
    }
    
    func setBarButtonItem() {
        let searchBarBaseView = UIView(frame: CGRect(x: 0, y: 0, width:fit(500), height: 30))
        navigationItem.hidesBackButton = true
        searchBarBaseView.addSubview(searchBar)
        // 创建搜索框
        searchBar.frame = CGRect(x: 0, y: 0, width:fit(500), height: 30)
        searchBar.delegate = self
        navigationItem.titleView = searchBarBaseView
    }
    func setupUI() {

        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签将要切换 ---")
                print("老标签：\(previousMenuItemView.titleLabel.text!)")
                print("新标签：\(menuItemView.titleLabel.text!)")
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签切换完毕 ---")
                if menuItemView.titleLabel.text! == "已下架"{
                    XKeyChain.set("2", key: "EDITTYPE")
                    let NotifMycation = NSNotification.Name(rawValue:"SoldOutReload")
                    NotificationCenter.default.post(name: NotifMycation, object:nil)
                }else{
                    XKeyChain.set("1", key: "EDITTYPE")
                    let NotifMycation = NSNotification.Name(rawValue:"OnSaleReload")
                    NotificationCenter.default.post(name: NotifMycation, object:nil)
                }
                print("老标签：\(previousMenuItemView.titleLabel.text!)")
                print("新标签：\(menuItemView.titleLabel.text!)")
            case let .willMoveController(menuController, previousMenuController):
                print("--- 页面将要切换 ---")
                print("老页面：\(previousMenuController)")
                print("新页面：\(menuController)")
            case let .didMoveController(menuController, previousMenuController):
                print("--- 页面切换完毕 ---")
                print("老页面：\(previousMenuController)")
                print("新页面：\(menuController)")
            case .didScrollStart:
                print("--- 分页开始左右滑动 ---")
            case .didScrollEnd:
                print("--- 分页停止左右滑动 ---")
            }
        }
        
//        pagingMenuController.view.frame.origin.y += fit(20)
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        setBottomView()
    }
    func setBottomView(){
        self.view.addSubview(bottomView)
        bottomView.addSubview(addBtn)
        bottomView.addSubview(editBtn)
        bottomView.addSubview(sepline)
        bottomView.addSubview(topline)

        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.snEqualTo(100)
        }
        addBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(110)
            make.centerY.equalToSuperview()
            make.height.snEqualTo(30)
            make.width.snEqualTo(150)
        }
        editBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-110)
            make.centerY.equalToSuperview()
            make.height.snEqualTo(30)
            make.width.snEqualTo(150)
        }
        sepline.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.snEqualTo(1)
            make.height.snEqualTo(40)
        }
        topline.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(1)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func bindEvent(){
        addBtn.addTarget(self, action: #selector(addGoods), for: UIControlEvents.touchUpInside)
        editBtn.addTarget(self, action: #selector(editGoods), for: .touchUpInside)
    }
    @objc func addGoods(){
        let vc = XAddGoodsController()
        vc.shopid = self.shopid
        vc.tempString = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func editGoods(){

        self.navigationController?.pushViewController(XGoodEditController(), animated: true)
    }
    override func setupView() {
        XKeyChain.set("1", key: "EDITTYPE")
        setNavigationBar()
        setBarButtonItem()
        setupUI()
    }
}
extension XGoodListController:UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationController?.pushViewController(XGoodSearchController(), animated: true)
        return true
    }
}
extension XGoodListController:UIScrollViewDelegate{
    
}

