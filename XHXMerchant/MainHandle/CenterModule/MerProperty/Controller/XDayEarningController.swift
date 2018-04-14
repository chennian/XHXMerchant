//
//  XDayEarningController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import APJTextPickerView
class XDayEarningController: SNBaseViewController {
    
   var  titleField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .center
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(4)
        $0.text = "2018-10-28"
        $0.datePicker?.datePickerMode = .date
        $0.dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XEarningDayHeaderCell.self)
        $0.register(XEarningDayEndCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    fileprivate func setupUI() {
//        self.title = "每日收益"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        titleField.delegate = self

        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func setupView() {
        setupUI()
        setNavBar()
    }

}
extension XDayEarningController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XEarningDayHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XEarningDayEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(20)
        }else if indexPath.row == 1{
            return fit(636)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(843)
        }else{
            return fit(20)
        }
    }
}

extension XDayEarningController{
    func setNavBar() {
        navigationItem.titleView = titleField
        let  rightView  = UIView().then{
            $0.backgroundColor = .red
        }
        
        titleField.rightView = rightView
    }
}
extension XDayEarningController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        CNLog("结束编辑")
    }
}
