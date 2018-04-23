//
//  XIdCardImageCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/7.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XIdCardImageCell: SNBaseTableViewCell {
    
    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "身份证照片"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var frontCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"papers_front"),for:.normal)
        $0.fuName = "img1"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var backCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"papers_contrary"),for:.normal)
        $0.fuName = "img2"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    var handCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"autonym_hand"),for:.normal)
        $0.fuName = "img3"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    
    let frontNotice = UILabel().then{
        $0.text = "身份证正面照"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    let backNotice = UILabel().then{
        $0.text = "身份证反面照"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    let handNotice = UILabel().then{
        $0.text = "身份证手持照"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    func bindEvent() {
        frontCard.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.frontCard,self.frontCard.fuName))
        }).disposed(by: disposeBag)
        backCard.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] in
            self.imgTap.onNext((self.backCard, self.backCard.fuName))
        }).disposed(by: disposeBag)
        handCard.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] in
            self.imgTap.onNext((self.handCard, self.handCard.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(frontCard)
        contentView.addSubview(backCard)
        contentView.addSubview(frontNotice)
        contentView.addSubview(backNotice)
        contentView.addSubview(handCard)
        contentView.addSubview(handNotice)


        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(29)
            make.top.equalToSuperview().snOffset(36)
        }
        
        frontCard.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(75)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
        backCard.snp.makeConstraints { (make) in
            make.top.equalTo(frontCard.snp.bottom).snOffset(112)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
        handCard.snp.makeConstraints { (make) in
            make.top.equalTo(backCard.snp.bottom).snOffset(112)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        frontNotice.snp.makeConstraints { (make) in
            make.top.equalTo(frontCard.snp.bottom).snOffset(21)
            make.centerX.equalTo(frontCard.snp.centerX)
        }
        backNotice.snp.makeConstraints { (make) in
            make.top.equalTo(backCard.snp.bottom).snOffset(21)
            make.centerX.equalTo(backCard.snp.centerX)
        }
        handNotice.snp.makeConstraints { (make) in
            make.top.equalTo(handCard.snp.bottom).snOffset(21)
            make.centerX.equalTo(handCard.snp.centerX)
        }
        
    }

}
