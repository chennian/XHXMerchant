//
//  XMerHomeController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerHomeController: SNBaseViewController {
    
    var model:[ShopHomeModel] = []
    let headerCell:MerHeaderCell = MerHeaderCell()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(MerHomeTopCell.self)
        $0.register(MerHomeEndCell.self)
        $0.register(MerHeaderCell.self)


        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    fileprivate func setupUI() {
        self.title = "店铺首页"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }

    
    override func loadData() {
        SNRequest(requestType: API.shopHome, modelType: [ShopHomeModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
            case .fail(_ ,let msg):
                SZHUD(msg ?? "获取数据失败", type:.error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    override func setupView() {
        setupUI()
    }
}

extension XMerHomeController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:MerHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if self.model.isEmpty{
                cell.merName.text = "暂无店铺"
                cell.staffNum.text = "员工数量:0"
                cell.userNum.text = "会员数量:0"
            }else{
                cell.merName.text = self.model[0].shopName
                cell.staffNum.text = self.model[0].personal
                cell.userNum.text = self.model[0].flow_num
            }
           
            return cell
        }else if indexPath.row == 1{
            let cell:MerHomeTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = {[unowned self] (para) in
                if para == "1"{
                    self.navigationController?.pushViewController(XMerReciptCodeController(), animated: true)
                }else if para == "2"{
                    self.navigationController?.pushViewController(XMerDataController(), animated: true)
                }
            }
            return cell
        }else{
            let cell:MerHomeEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(450)

        }else if indexPath.row == 1{
            return fit(430)
        }else{
            return fit(430)
        }
    }
    
}
