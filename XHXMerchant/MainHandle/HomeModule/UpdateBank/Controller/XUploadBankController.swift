//
//  XUpdateBankController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XUploadBankController: SNBaseViewController {

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XUpdateBankHeaderCell.self)
        $0.register(XUploadFrontBankCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }

    fileprivate func setupUI() {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension XUploadBankController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell:XUpdateBankHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:XUploadFrontBankCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return fit(623)
        }else{
            return fit(716)
        }
    }
    
}
