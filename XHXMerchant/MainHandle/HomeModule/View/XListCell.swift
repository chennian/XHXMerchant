//
//  XListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XListCell: SNBaseTableViewCell {
    
    private lazy var tableview = UITableView.init(frame:.zero, style:UITableViewStyle.plain).then{
        $0.backgroundColor = color_bg_gray_f5
        $0.delegate = self
        $0.dataSource = self
    }
    
    override func setupView() {
        contentView.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }

}
extension XListCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "nihao"
        cell.textLabel?.textColor = .black
        return cell
    }
    
    
}
