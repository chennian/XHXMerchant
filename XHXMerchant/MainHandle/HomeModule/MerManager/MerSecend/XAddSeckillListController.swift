//
//  XAddSeckillListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddSeckillListController: SNBaseViewController {

    var shopid :String = ""
    var model :[XSeckillListModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XSeckillListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    @objc func addSencond(){
        let vc =  LBAddSeckillController()
        vc.shopid = self.shopid
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "新增秒秒", imgName:"", target: self, action: #selector(addSencond))
        navigationItem.rightBarButtonItem = barbutton
    }
    
    fileprivate func setupUI() {
        self.title = "我的秒秒"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    override func loadData() {
        let paramert:[String:String] = ["shopId":shopid]
        SNRequest(requestType: API.getKillList(paremeter: paramert), modelType: [XSeckillListModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
                self.tableView.reloadData()
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
    func deleteThis(_ para1:String,_ para2:String){
        let parameter:[String:Any] = ["shopId":para1,"id":para2]
        SNRequestBool(requestType: API.deleteSecond(paremeter:parameter)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                UIAlertView(title: "温馨提示", message: msg, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
                self.navigationController?.popViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        setupUI()
        setNavigationBar()
    }
}


extension XAddSeckillListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XSeckillListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = self.model[indexPath.row]
        cell.clickEventDelete = {[unowned self] (para1,para2) in
            self.deleteThis(para1,para2)
        }
        cell.clickEventPreview = {[unowned self] (para) in
            let vc = LBAddSeckillController()
            vc.model = self.model[indexPath.row]
            vc.temp = "1"
            self.navigationController?.pushViewController(vc, animated:true)
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(220)
    }
    
}
