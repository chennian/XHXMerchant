//
//  XTotalEarningEndDetailCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningEndDetailCell: SNBaseTableViewCell {
    var model :[historyModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XTotalEarningsListCell.self)
        $0.separatorStyle = .none
    }
    fileprivate func setupUI() {
        
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    override func setupView() {
        setupUI()
    }
}
extension XTotalEarningEndDetailCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XTotalEarningsListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.models = model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(121)
    }
}
