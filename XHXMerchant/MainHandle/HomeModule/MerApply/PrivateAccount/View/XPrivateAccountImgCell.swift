//
//  XPrivateAccountImgCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XPrivateAccountImgCell: SNBaseTableViewCell {

    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "上传资料"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var bankCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"bank_card"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "1"
    }
    var bankCardBack = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"bank_card"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "2"
    }
    
    let permitCardNotice = UILabel().then{
        $0.text = "银行卡正面照"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    let permitCardBackNotice = UILabel().then{
        $0.text = "银行卡反面照"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    func bindEvent() {
        bankCard.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.bankCard,self.bankCard.fuName))
        }).disposed(by: disposeBag)
        
        bankCardBack.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.bankCardBack,self.bankCardBack.fuName))
        }).disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(bankCard)
        contentView.addSubview(permitCardNotice)
        contentView.addSubview(bankCardBack)
        contentView.addSubview(permitCardBackNotice)

        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(29)
            make.top.equalToSuperview().snOffset(36)
        }
        
        bankCard.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(75)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
        
        permitCardNotice.snp.makeConstraints { (make) in
            make.top.equalTo(bankCard.snp.bottom).snOffset(21)
            make.centerX.equalTo(bankCard.snp.centerX)
        }
        
        bankCardBack.snp.makeConstraints { (make) in
            make.top.equalTo(bankCard.snp.bottom).snOffset(75)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        permitCardBackNotice.snp.makeConstraints { (make) in
            make.top.equalTo(bankCardBack.snp.bottom).snOffset(21)
            make.centerX.equalTo(bankCardBack.snp.centerX)
        }
    }
    
}

