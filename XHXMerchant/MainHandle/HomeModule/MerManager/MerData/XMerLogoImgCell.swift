//
//  XMerLogoImgCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XMerLogoImgCell: SNBaseTableViewCell {
    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "店铺logo图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var logoImg = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_logo_uploading"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "2"
    }
    
    let permitCardNotice = UILabel().then{
        $0.text = "此图用于店铺详情页logo的展示"
        $0.font = Font(24)
        $0.textColor = Color(0x8b8e94)
    }
    
    func bindEvent() {
        logoImg.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.logoImg,self.logoImg.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(logoImg)
        contentView.addSubview(permitCardNotice)
        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
        }
        
        logoImg.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(60)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(232)
            make.height.snEqualTo(232)
        }
        
        permitCardNotice.snp.makeConstraints { (make) in
            make.top.equalTo(logoImg.snp.bottom).snOffset(18)
            make.centerX.equalTo(logoImg.snp.centerX)
        }
        
    }
    
}
