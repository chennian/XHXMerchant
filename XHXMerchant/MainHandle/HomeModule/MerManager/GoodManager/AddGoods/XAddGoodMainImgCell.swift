//
//  XAddGoodMainImgController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift
class XAddGoodMainImgCell: SNBaseTableViewCell {
    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "商品主图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var logoImg = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"commodity_picture"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "1"
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
        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(27)
        }
        
        logoImg.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(43)
            make.left.equalToSuperview().snOffset(30)
            make.width.snEqualTo(154)
            make.height.snEqualTo(154)
        }
        
    }
    
}
