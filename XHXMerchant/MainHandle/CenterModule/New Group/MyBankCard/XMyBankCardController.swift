//
//  XMyBankCardController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMyBankCardController: SNBaseViewController {
    
    var model :[BankCardModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMyBankCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "我的银行卡"
        self.view.backgroundColor = Color(0xf5f5f5)
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    
    @objc func tapOne(){
        let vc =    XUploadBankController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func loadData(){
        SNRequest(requestType: API.myBankCard, modelType: [BankCardModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                CNLog(models)
                self.model = models
                self.tableView.reloadData()
            case .fail(let code ,let msg):
              SZHUD(msg! , type: .error, callBack: nil)
              if code == 1006 {
                self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                break
            }
        }).disposed(by: disposeBag)

    }

    func setUpRightBar(){
        let button = UIButton(frame:CGRect(x:0, y:0, width:50, height:30))
        button.setTitle("添加", for: UIControlState.normal)
        button.setTitleColor(Color(0x313131), for: UIControlState.normal)
        button.titleLabel?.font = Font(30)
        button.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem=item
    }
    @objc func submit(){
        if model.isEmpty {
            self.navigationController?.pushViewController(XUploadBankController(), animated: true)
        }else{
            SZHUD("只能绑定一张银行卡", type: .info, callBack: nil)
        }
    }
    override func setupView() {
        setupUI()
        setUpRightBar()
    }
}
extension XMyBankCardController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XMyBankCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(350)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = XUploadBankController()
        vc.model = self.model[indexPath.row]
        vc.temp = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
