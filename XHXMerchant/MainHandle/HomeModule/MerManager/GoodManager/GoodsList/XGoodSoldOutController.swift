//
//  XGoodSoldOutController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodSoldOutController: SNBaseViewController {
    
    var model :[GoodListModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XGoodListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "已下架"
        receiveNotify()
        self.tableView.separatorStyle = .none
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func loadData(){
     
        let parameters:[String:Any] = ["status":"2",
                                       "shop_id":XKeyChain.get("SHOPID")]
        SNRequest(requestType: API.goodList(paremeter: parameters), modelType: [GoodListModel.self]).subscribe(onNext: {[unowned self] (result) in
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
    func soldOut(_ goodid:String){
        let parameters:[String:Any] = ["goods_id":goodid,
                                       "shop_id":XKeyChain.get("SHOPID"),
                                       "status":"1"]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.putOffOrONGoodsBat(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                self.loadData()
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
    func receiveNotify(){
        let Notify = NSNotification.Name(rawValue:"SoldOutReload")
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notify, object: nil)
    }
    @objc func reload(){
        loadData()
    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    override func setupView() {
        //        getData()
        setupUI()
    }
}

extension XGoodSoldOutController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == model.count{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:XGoodListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = self.model[indexPath.row]
            cell.rightBtn.setTitle("上架", for: .normal)
            cell.soldEvent = {[unowned self] in
                self.soldOut(self.model[indexPath.row].id)
            }
            cell.previewEvent = {[unowned self] in
                self.preview(self.model[indexPath.row])
            }
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == model.count{
            return fit(100)
        }else{
            return fit(201)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = XAddGoodsController()
        vc.model = self.model[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
