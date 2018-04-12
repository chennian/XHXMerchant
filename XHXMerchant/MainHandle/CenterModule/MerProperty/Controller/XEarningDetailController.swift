//
//  EarningDetailController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import APJTextPickerView


class XEarningDetailController: SNBaseViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XEarningDayDetailTCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    var header = UIView().then{
        $0.backgroundColor = .clear
    }
    var line =  UIView().then{
        $0.backgroundColor = Color(0xc8cacc)
    }
    
    var startDateField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x828487)
        $0.textAlignment = .center
        $0.backgroundColor = Color(0xf3f3f3)
        $0.layer.cornerRadius = fit(4)
        $0.placeholder = "请选择开始时间"
        $0.datePicker?.datePickerMode = .date
        $0.dateFormatter.dateFormat = "yyyy年MM月dd日"
        $0.textAlignment = .center
        $0.backgroundColor = Color(0xf3f3f3)

    }
    var endDateField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x828487)
        $0.textAlignment = .center
        $0.backgroundColor = Color(0xf3f3f3)
        $0.layer.cornerRadius = fit(4)
        $0.placeholder = "请选择结束时间"
        $0.datePicker?.datePickerMode = .date
        $0.dateFormatter.dateFormat = "yyyy年MM月dd日"

    }
    
    var totalProfit = UILabel().then{
        $0.text = "￥388.88"
        $0.font = Font(60)
        $0.textColor = Color(0x313131)
    }
    var totalDes = UILabel().then{
        $0.text = "总计"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    fileprivate func setupUI() {
        
        self.title = "收益明细"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
        }
    }
    
    fileprivate func  setUpHeader() {
        self.view.addSubview(header)
        header.addSubview(totalProfit)
        header.addSubview(totalDes)
        header.addSubview(startDateField)
        header.addSubview(endDateField)
        header.addSubview(line)
        
        header.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(319)
        }
        
        startDateField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(41)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(300)
            make.height.snEqualTo(70)
        }
        
        endDateField.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-41)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(300)
            make.height.snEqualTo(70)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(startDateField.snp.right).snOffset(12)
            make.right.equalTo(endDateField.snp.left).snOffset(-12)
            make.height.snEqualTo(6)
            make.centerY.equalTo(startDateField)
        }
        
        totalProfit.snp.makeConstraints { (make) in
            make.top.equalTo(endDateField.snp.bottom).snOffset(71)
            make.centerX.equalToSuperview()
        }
        totalDes.snp.makeConstraints { (make) in
            make.top.equalTo(totalProfit.snp.bottom).snOffset(21)
            make.centerX.equalToSuperview()
        }
    
    }
    override func setupView() {
        setUpHeader()
        setupUI()
    }

}

extension XEarningDetailController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XEarningDayDetailTCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(130)
    }
    
    
}
