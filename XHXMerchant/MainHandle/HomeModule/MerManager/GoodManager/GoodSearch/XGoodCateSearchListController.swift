//
//  XGoodCateSearchListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodCateSearchListController: SNBaseViewController {
    
    var model :[GoodCateSearchModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XGoodCateSearchListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "分类管理"
        
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

        SNRequest(requestType: API.getCategoryGoodNum(paremeter:parameters ), modelType: [GoodCateSearchModel.self]).subscribe(onNext: {[unowned self] (result) in
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

    override func setupView() {
        setupUI()
    }
}

extension XGoodCateSearchListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XGoodCateSearchListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.models = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(110)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = XCateSearchResultController()
        vc.cate = self.model[indexPath.row].cate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
