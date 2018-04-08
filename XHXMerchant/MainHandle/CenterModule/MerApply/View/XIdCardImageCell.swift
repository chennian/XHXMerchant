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
    
    var frontCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition"),for:.normal)
        $0.fuName = "img1"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var backCard = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition"),for:.normal)
        $0.fuName = "img2"
        $0.imageView?.contentMode = .scaleAspectFill
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
    }
    
    override func setupView() {
        contentView.addSubview(frontCard)
        contentView.addSubview(backCard)
        bindEvent()
        
        frontCard.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(400)
            make.height.snEqualTo(300)
        }
        
        backCard.snp.makeConstraints { (make) in
            make.top.equalTo(frontCard.snp.bottom).snOffset(30)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(400)
            make.height.snEqualTo(300)
        }
        
    }

}
