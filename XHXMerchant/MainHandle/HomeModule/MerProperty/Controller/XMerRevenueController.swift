//
//  XMerRevenueController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/23.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import APJTextPickerView

class XMerRevenueController: SNBaseViewController {
    
    var model:[oneRevenueModel] = []
    
    var start_date:String = "2010-01-01"
    var end_date:String   = "2030-01-01"
    
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XEarningDayDetailTwoCell.self)
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
        $0.dateFormatter.dateFormat = "yyyy-MM-dd"
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
        $0.dateFormatter.dateFormat = "yyyy-MM-dd"
        
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
    
    var lineHeader = UIView().then{
        $0.backgroundColor = Color(0xe2e2e2)
    }
    
    fileprivate func setupUI() {
        
        self.title = "商家收益"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        startDateField.delegate = self
        endDateField.delegate = self
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
        header.addSubview(lineHeader)
        
        
        header.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(319)
        }
        
        lineHeader.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.snEqualTo(1)
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
    
    func getData() {
        SZHUD("正在加载中...", type: .loading, callBack: nil)
        SNRequest(requestType: API.merchantRevenue(start_date: self.start_date, end_date: self.end_date), modelType: [RevenueOneModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                DispatchQueue.main.async {
                    self.totalProfit.text = models[0].sumMoney
                }
                self.model = models[0].info
                self.tableView.reloadData()
                SZHUDDismiss()
            case .fail(let code,let msg):
                SZHUD(msg ?? "请求数据失败", type: .error, callBack: nil)
                SZHUDDismiss()
                
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
                
            default:
                SZHUDDismiss()
                break
            }
        }).disposed(by: disposeBag)
    }
    override func setupView() {
        setUpHeader()
        setupUI()
        getData()
    }
    
}

extension XMerRevenueController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XEarningDayDetailTwoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model  = self.model[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(130)
    }
}
extension XMerRevenueController:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if startDateField.text! != "",endDateField.text! != ""{
            self.start_date = startDateField.text!
            self.end_date = endDateField.text!
            getData()
        }
    }
}
