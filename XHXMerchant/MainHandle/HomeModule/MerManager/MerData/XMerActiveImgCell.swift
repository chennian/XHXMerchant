//
//  XMerActiveImgCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XMerActiveImgCell: SNBaseTableViewCell {
    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "店铺展示图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var activityImg = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_flat_patternmaking"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "1"
    }
    
    let permitCardNotice = UILabel().then{
        $0.text = "此图用于用户版首页广告图"
        $0.font = Font(24)
        $0.textColor = Color(0x8b8e94)
    }
    
    func bindEvent() {
        activityImg.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.activityImg,self.activityImg.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(activityImg)
        contentView.addSubview(permitCardNotice)
        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
        }
        
        activityImg.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(60)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(509)
            make.height.snEqualTo(232)
        }
        
        permitCardNotice.snp.makeConstraints { (make) in
            make.top.equalTo(activityImg.snp.bottom).snOffset(18)
            make.centerX.equalTo(activityImg.snp.centerX)
        }
        
    }
    
}
