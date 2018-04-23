//
//  XFlowTeamCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XFlowTeamCell: SNBaseTableViewCell {
    
    var models : FlowTeamModel?{
        didSet{
            guard let model = models else {
                return
            }
            if model.nickName == ""{
                nameLable.text = model.phone
            }else{
                nameLable.text  = model.nickName

            }
            if model.corporation == "1"{
                rank.text = "当前等级:服务中心"
            }else{
                if model.operater == "1"{
                    rank.text = "当前等级:运营商"
                }else{
                    rank.text = "当前等级:服务商"
                }
            }
        }
    }
    
    var img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "LBlogoIcon")
//        $0.layer.cornerRadius = fit(35)
//        $0.clipsToBounds = true
    }
    
    var nameLable = UILabel().then{
        $0.text = "木屋烧烤"
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    }
    
    var rank = UILabel().then{
        $0.text = "当前等级:服务商"
        $0.font = Font(24)
        $0.textColor = Color(0x818181)
    }

    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(nameLable)
        contentView.addSubview(rank)
        
        //        line.isHidden = true
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.height.width.snEqualTo(70)
        }
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalTo(img.snp.top)
        }
        rank.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.bottom.equalTo(img.snp.bottom)
        }
        
       
       
    }
    
}
