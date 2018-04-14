//
//  XMerLicenseImgCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XMerLicenseImgCell: SNBaseTableViewCell {

    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "上传信息"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var LicenseImage = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"business_license"),for:.normal)
        $0.fuName = "img1"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var doorImage = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"appearance"),for:.normal)
        $0.fuName = "img2"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var checkstandImage = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"cashier_desk"),for:.normal)
        $0.fuName = "img3"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var indoorImage = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_inside"),for:.normal)
        $0.fuName = "img4"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    let LicenseNotice = UILabel().then{
        $0.text = "营业执照照片"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    let doorNotice = UILabel().then{
        $0.text = "门头照照片"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    let checkstandNotice = UILabel().then{
        $0.text = "收银台照片"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    let indoorNotice = UILabel().then{
        $0.text = "店内照片"
        $0.font = Font(30)
        $0.textColor = Color(0x9a9a9a)
    }
    
    func bindEvent() {
    
        LicenseImage.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.LicenseImage,self.LicenseImage.fuName))
        }).disposed(by: disposeBag)
        doorImage.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] in
            self.imgTap.onNext((self.doorImage, self.doorImage.fuName))
        }).disposed(by: disposeBag)
        checkstandImage.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] in
            self.imgTap.onNext((self.checkstandImage, self.checkstandImage.fuName))
        }).disposed(by: disposeBag)
        indoorImage.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] in
            self.imgTap.onNext((self.indoorImage, self.indoorImage.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(LicenseImage)
        contentView.addSubview(doorImage)
        contentView.addSubview(checkstandImage)
        contentView.addSubview(indoorImage)

        contentView.addSubview(LicenseNotice)
        contentView.addSubview(doorNotice)
        contentView.addSubview(checkstandNotice)
        contentView.addSubview(indoorNotice)

        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(29)
            make.top.equalToSuperview().snOffset(36)
        }
        
        LicenseImage.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(75)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
        doorImage.snp.makeConstraints { (make) in
            make.top.equalTo(LicenseImage.snp.bottom).snOffset(112)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
        checkstandImage.snp.makeConstraints { (make) in
            make.top.equalTo(doorImage.snp.bottom).snOffset(112)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        indoorImage.snp.makeConstraints { (make) in
            make.top.equalTo(checkstandImage.snp.bottom).snOffset(112)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(483)
            make.height.snEqualTo(260)
        }
        
        LicenseNotice.snp.makeConstraints { (make) in
            make.top.equalTo(LicenseImage.snp.bottom).snOffset(21)
            make.centerX.equalTo(LicenseImage.snp.centerX)
        }
        doorNotice.snp.makeConstraints { (make) in
            make.top.equalTo(doorImage.snp.bottom).snOffset(21)
            make.centerX.equalTo(doorImage.snp.centerX)
        }
        checkstandNotice.snp.makeConstraints { (make) in
            make.top.equalTo(checkstandImage.snp.bottom).snOffset(21)
            make.centerX.equalTo(checkstandImage.snp.centerX)
        }
        indoorNotice.snp.makeConstraints { (make) in
            make.top.equalTo(indoorImage.snp.bottom).snOffset(21)
            make.centerX.equalTo(indoorImage.snp.centerX)
        }
        
    }
}
