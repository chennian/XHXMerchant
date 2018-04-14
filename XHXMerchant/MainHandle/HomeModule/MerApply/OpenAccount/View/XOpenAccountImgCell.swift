//
//  XOpenAccountImgCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XOpenAccountImgCell: SNBaseTableViewCell {

    var imgTap = PublishSubject<(AliOssTransferProtocol)>()
    
    let imgLable = UILabel().then{
        $0.text = "上传资料"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var permitCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"prove"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }

    
    let permitCardNotice = UILabel().then{
        $0.text = "开户许可证"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    

    
    func bindEvent() {
        permitCard.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.permitCard))
        }).disposed(by: disposeBag)
       
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(permitCard)
        contentView.addSubview(permitCardNotice)
        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(29)
            make.top.equalToSuperview().snOffset(36)
        }
        
        permitCard.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(75)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
     
        permitCardNotice.snp.makeConstraints { (make) in
            make.top.equalTo(permitCard.snp.bottom).snOffset(21)
            make.centerX.equalTo(permitCard.snp.centerX)
        }
       
    }
    
}

