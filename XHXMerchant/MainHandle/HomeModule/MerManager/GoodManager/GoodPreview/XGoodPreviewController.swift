//
//  XGoodPreviewController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodPreviewController: SNBaseViewController {
    
    var  model:GoodListModel?
    var shopModel:[XMerListModel] = []
    var cell : XGoodShopCell = XGoodShopCell()
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(XGoodBannerCell.self)
        $0.register(XGoodNameCell.self)
        $0.register(XGoodDesCell.self)
        $0.register(XSpaceCell.self)
        $0.register(XGoodShopCell.self)

        $0.separatorStyle = .none
    }
    
    func loadShopData() {
        
        SNRequest(requestType: API.shopHome(shopId:XKeyChain.get("SHOPID")), modelType: [XMerListModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.shopModel = models
                self.tableView.reloadData()
            case .fail(let code ,let msg):
                SZHUD(msg ?? "获取数据失败", type:.error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    fileprivate func setupUI() {
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tableView.contentInset = UIEdgeInsets(top: -LL_StatusBarAndNavigationBarHeight, left: 0, bottom: 0, right: 0)
        self.view.backgroundColor = Color(0xf5f5f5)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadShopData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension XGoodPreviewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell:XGoodBannerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.banner = (model?.detail_img)!
            return cell
        }else if indexPath.row == 1{
            let cell:XGoodNameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.nameLable.text = model?.name
            cell.price.text = "¥" + (model?.price)!
            cell.num.text = "已售" + (model?.sell_num)! + "件"
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.styleColor = Color(0xf5f5f5)
            return cell
        }else if indexPath.row == 3{
            let cell:XGoodDesCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.descriptionDetail.text = self.model?.description
            return cell
        }else if indexPath.row == 4{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.styleColor = Color(0xf5f5f5)
            return cell
        }else{
            let cell:XGoodShopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if !shopModel.isEmpty{
                cell.model = self.shopModel[0]
            }
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(504)
        }else if indexPath.row == 1{
            return fit(175)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            let size = countWidth(text: (self.model?.description)!, size: CGSize(width: fit(710), height: CGFloat.greatestFiniteMagnitude), font: Font(30))
            return fit(130) + size.height
        }else if indexPath.row == 4{
            return fit(20)
        }else{
            return fit(230)
        }
    }
}
