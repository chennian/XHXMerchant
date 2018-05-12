//
//  XGoodCateListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodCateListController: SNBaseViewController {
    
    var model :[GoodCateModel] = []
    
    var tempString:String = ""
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XGoodCateCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "分类管理"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func loadData(){
        let parameters:[String:Any] = ["shop_id":XKeyChain.get("SHOPID")]
        SNRequest(requestType: API.getCategory(paremeter: parameters), modelType: [GoodCateModel.self]).subscribe(onNext: {[unowned self] (result) in
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
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "", imgName:"classify_addition", target: self, action: #selector(addCate))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc func addCate(){
        self.navigationController?.pushViewController(XAddCateController(), animated: true)
    }
    override func setupView() {
        setupUI()
        setNavigationBar()
    }
}

extension XGoodCateListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XGoodCateCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.models = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(110)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tempString == "1"{
            let NotifMycation = NSNotification.Name(rawValue:"GoodCate")
            NotificationCenter.default.post(name: NotifMycation, object: self.model[indexPath.row].category_name)
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc = XGoodCateEditController()
            vc.cate = self.model[indexPath.row].category_name
            vc.id = self.model[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
    }
    
}
