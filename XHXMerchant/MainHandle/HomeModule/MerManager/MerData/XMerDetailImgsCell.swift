//
//  XMerDetailImgsCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XMerDetailImgsCell: SNBaseTableViewCell {
    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "店铺ogo图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var Img1 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_particulars"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "1"

    }
    var Img2 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_particulars"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "2"

    }
    var Img3 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_particulars"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "3"

    }
    

    
    func bindEvent() {
        Img1.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.Img1,self.Img1.fuName))
        }).disposed(by: disposeBag)
        
        Img2.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.Img2,self.Img2.fuName))
        }).disposed(by: disposeBag)
        
        Img3.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.Img3,self.Img3.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(Img1)
        contentView.addSubview(Img2)
        contentView.addSubview(Img3)
        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
        }
        Img2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgLable.snp.bottom).snOffset(60)
            make.width.height.snEqualTo(190)
        }
        
        Img1.snp.makeConstraints { (make) in
            make.top.equalTo(Img2.snp.top)
            make.left.equalToSuperview().snOffset(30)
            make.width.snEqualTo(190)
            make.height.snEqualTo(190)
        }
        Img3.snp.makeConstraints { (make) in
            make.top.equalTo(Img2.snp.top)
            make.right.equalToSuperview().snOffset(-30)
            make.width.snEqualTo(190)
            make.height.snEqualTo(190)
        }
     
        
    }
    
}
