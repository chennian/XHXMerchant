//
//  XTotalProfitView.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/22.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalProfitView:UIView{
    
    let imgView = UIView().then{
        $0.backgroundColor = .red
    }
    
    let roleLable = UILabel().then{
        $0.textColor = Color(0x75797d)
        $0.font = Font(22)
        $0.text = "服务商"
    }
    
    let profit = UILabel().then{
        $0.textColor = Color(0x75797d)
        $0.font = Font(22)
        $0.text = "1000.00"
    }
  
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.addSubview(imgView)
        self.addSubview(roleLable)
        self.addSubview(profit)
        
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.height.snEqualTo(20)
        }
        roleLable.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).snOffset(17)
            make.centerY.equalTo(imgView.snp.centerY)
            make.width.snEqualTo(92)
        }
        
        profit.snp.makeConstraints { (make) in
            make.left.equalTo(roleLable.snp.right).snOffset(20)
            make.centerY.equalTo(roleLable.snp.centerY)
        }

    }

}
