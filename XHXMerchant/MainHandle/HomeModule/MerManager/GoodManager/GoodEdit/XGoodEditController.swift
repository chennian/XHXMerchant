//
//  XGoodEditController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodEditController: SNBaseViewController {
    
    var model :[GoodListModel] = []
    
    var markArr:[String] = []
    
    var status:String = ""
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XGoodEditCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    let rightBtn = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setTitle("编辑", for: .normal)
        $0.titleLabel?.font = Font(30)
    }
    let bottomView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let noticeLable = UILabel().then{
        $0.text = "已选商品 0 个"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    
    let deleteBtn = UIButton().then{
        $0.setTitle("删除", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.backgroundColor = Color(0xffffff)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0x727272).cgColor
        $0.layer.cornerRadius = fit(6)
        
    }
    let soldOutBtn = UIButton().then{
        $0.setTitle("下架", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.backgroundColor = Color(0xffffff)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0x727272).cgColor
        $0.layer.cornerRadius = fit(6)
    }
    
    fileprivate func setupUI() {
        self.title = "批量编辑"
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func bindEvent() {
        deleteBtn.addTarget(self, action: #selector(deleteGoods), for: .touchUpInside)
        soldOutBtn.addTarget(self, action: #selector(soldOutGoods), for: .touchUpInside)

    }
    @objc func deleteGoods(){
        let goods_id = self.markArr.joined(separator: ",")
        
        let parameters:[String:Any] = ["goods_id":goods_id,
                                       "shop_id":XKeyChain.get("SHOPID")]
        
        SNRequestBool(requestType: API.delGoodsBat(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                self.markArr.removeAll()
                self.loadData()
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
    }
    @objc func soldOutGoods(){
        CNLog(markArr)
        if XKeyChain.get("EDITTYPE") == "1" {
            self.status  = "2"
        }else{
            self.status  = "1"
        }
        let goods_id = self.markArr.joined(separator: ",")
        CNLog(goods_id)

        let parameters:[String:Any] = ["goods_id":goods_id,
                                       "shop_id":XKeyChain.get("SHOPID"),
                                       "status":self.status]
        
        SNRequestBool(requestType: API.putOffOrONGoodsBat(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                self.loadData()
                self.markArr.removeAll()
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
        
    }

    
    func setBottonView(){
        self.view.addSubview(bottomView)
        bottomView.addSubview(noticeLable)
        bottomView.addSubview(soldOutBtn)
        bottomView.addSubview(deleteBtn)
        
        CNLog(XKeyChain.get("EDITTYPE"))
        if XKeyChain.get("EDITTYPE") == "1"{
            self.soldOutBtn.setTitle("下架", for: .normal)
        }else{
            self.soldOutBtn.setTitle("上架", for: .normal)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.snEqualTo(100)
        }
        
        noticeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
            make.height.snEqualTo(54)
            make.width.snEqualTo(130)
        }
        soldOutBtn.snp.makeConstraints { (make) in
            make.right.equalTo(deleteBtn.snp.left).snOffset(-30)
            make.centerY.equalToSuperview()
            make.height.snEqualTo(54)
            make.width.snEqualTo(130)
        }

        
    }
    override func loadData(){
       
        let parameters:[String:Any] = ["status":XKeyChain.get("EDITTYPE"),
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
    fileprivate func setNavigationBar(){
        
        rightBtn.addTarget(self, action: #selector(edit), for: .touchUpInside)
        let barbutton =  UIBarButtonItem.init(customView: rightBtn)
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc func edit(){
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.isEditing = !self.tableView.isEditing
        self.markArr.removeAll()
        DispatchQueue.main.async { [unowned self] in
            self.noticeLable.text = "已选商品\(self.markArr.count)个"
        }
        
        if self.tableView.isEditing{
            self.rightBtn.setTitle("完成", for: .normal)
        }else{
            self.rightBtn.setTitle("编辑", for: .normal)
        }
    }
  
    
    override func setupView() {
        setupUI()
        setNavigationBar()
        setBottonView()
    }
}

extension XGoodEditController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell:XGoodEditCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.tintColor = Color(0xff0000)
        cell.models = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(201)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.tableView.isEditing{
            markArr.append(model[indexPath.row].id)
            DispatchQueue.main.async { [unowned self] in
                self.noticeLable.text = "已选商品\(self.markArr.count)个"
            }
        }
       
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if self.tableView.isEditing{
            markArr.remove(self.model[indexPath.row].id)
            DispatchQueue.main.async { [unowned self] in
                self.noticeLable.text = "已选商品\(self.markArr.count)个"
            }
        }
     
    }
    
}
extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {  
            remove(at: index)
        }
    }
}
