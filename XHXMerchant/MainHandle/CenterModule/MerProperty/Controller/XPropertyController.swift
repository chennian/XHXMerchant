//
//  XPropertyController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XPropertyController: SNBaseViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XTotalEarningTopCell.self)
        $0.register(XTotalEarningsMidCell.self)
        $0.register(XTotalEarningsEndCell.self)

        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    fileprivate func setupUI() {
        self.title = "资产管理"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func setupView() {
        setupUI()
    }
}

extension XPropertyController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XTotalEarningTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2{
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent1 = {[unowned self] () in
                CNLog(123)
                self.navigationController?.pushViewController(XDayEarningController(), animated: true)
            }
            return cell
        }else if indexPath.row == 3{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 4{
            let cell:XTotalEarningsEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.btnClickEvent = {[unowned self] () in
                CNLog(1)
                self.navigationController?.pushViewController(XEarningDetailController(), animated: true)
            }
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(452)
        }else if indexPath.row == 1{
            return fit(20)

        }else if indexPath.row == 2{
            return fit(581)
            
        }else if indexPath.row == 3{
            return fit(20)
        }else if indexPath.row == 4{
            return fit(100)
            
        }else{
            return fit(450)

        }
    }
}

