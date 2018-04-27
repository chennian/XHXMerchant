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
    
    var total:String = ""
    var model:[todayModel] = []
    var time:String = ""
    
    var cellType:[propertyType] = []
    
    var  titleField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .center
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(4)
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
    
    override func loadData() {
         let paramert:[String:String] = ["add_time":self.time]
        SNRequest(requestType: API.dayTotalRevenue(paremeter:paramert), modelType: [todayModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
                if !self.model.isEmpty{
                    self.cellType.append(.space)
                    self.cellType.append(.todayHead(self.model[0]))
                    self.cellType.append(.space)
                    self.cellType.append(.todayEnd(self.model[0]))
                    self.cellType.append(.space)
                    self.tableView.reloadData()
                }
               
            case .fail(let code,let msg):
                SZHUD(msg ?? "请求数据失败", type: .error, callBack: nil)
                
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
                
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        setupUI()
        setNavBar()
    }
    
}
extension XDayEarningController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellType[indexPath.row] {
        case  .todayHead(let model):
             let cell:XEarningDayHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
             cell.totalLable.text = model.credit
             cell.models = model
             return cell
        case  .todayEnd(let model):
            let cell:XEarningDayEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = model
            return cell
        case  .space:
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellType[indexPath.row] {
        case .todayHead:
            return fit(636)
        case .todayEnd:
            return fit(843)
        case .space:
            return fit(20)
        default:
            return fit(20)
        }
        
    }
}

extension XDayEarningController{
    func setNavBar() {
        navigationItem.titleView = titleField
        titleField.text = self.time
        titleField.isEnabled = false
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
