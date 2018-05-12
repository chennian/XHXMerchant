//
//  XGoodSearchController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodSearchController: SNBaseViewController {
    
    var model :[GoodListModel] = []
    var para:String = ""
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XGoodListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    var searchBar = UISearchBar().then{
        $0.placeholder = "查找"
        $0.showsCancelButton = false
        $0.searchBarStyle = .minimal
        $0.barTintColor = Color(0xf5f5f5)
        $0.showsCancelButton = true;
    }
    func getDate(_ para:String){
        let parameters:[String:Any] = ["shop_id":XKeyChain.get("SHOPID"),
                                       "keyword":para]
        
        SNRequest(requestType: API.searchGoodGoodsList(paremeter: parameters), modelType: [GoodListModel.self]).subscribe(onNext: {[unowned self] (result) in
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
    fileprivate func setupUI() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func setupView() {
        setupUI()
        setSearchBar()
    }
    func setSearchBar(){
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        // 创建搜索框
        searchBar.frame = CGRect(x: 0, y: 0, width:fit(493), height: 30)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        let cancelBtn:UIButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.red, for: .normal)
        cancelBtn.addTarget(self, action: #selector(back), for: .touchUpInside)

    }
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    func soldOut(_ goodid:String,_ status:String){
        let parameters:[String:Any] = ["goods_id":goodid,
                                       "shop_id":XKeyChain.get("SHOPID"),
                                       "status":status]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.putOffOrONGoodsBat(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                self.getDate(self.para)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
    }
    func preview(_ model:GoodListModel){
        let vc = XGoodPreviewController()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension XGoodSearchController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XGoodListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.models = self.model[indexPath.row]
        if self.model[indexPath.row].status == "1"{
            cell.rightBtn.setTitle("下架", for: .normal)
            cell.soldEvent = {[unowned self] in
                self.soldOut(self.model[indexPath.row].id,"2")
            }
        }else{
            cell.rightBtn.setTitle("上架", for: .normal)
            cell.soldEvent = {[unowned self] in
                self.soldOut(self.model[indexPath.row].id,"1")
            }
        }
      
        cell.previewEvent = {[unowned self] in
            self.preview(self.model[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(201)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = XAddGoodsController()
        vc.model = self.model[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension XGoodSearchController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.para = searchBar.text!
        getDate(searchBar.text!)

    }
   
}
