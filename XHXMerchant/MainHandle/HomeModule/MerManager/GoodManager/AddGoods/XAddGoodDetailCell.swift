//
//  XAddGoodDetailCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift
class XAddGoodDetailCell: SNBaseTableViewCell {
    var imgTap = PublishSubject<(AliOssTransferProtocol,String)>()
    
    let imgLable = UILabel().then{
        $0.text = "详情页轮播图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var Img1 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"commodity_picture"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "2"
        
    }
    var Img2 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"commodity_picture"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "3"
    }
    var Img3 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"commodity_picture"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "4"
    }
    var Img4 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"commodity_picture"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "5"
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
        Img4.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.Img4,self.Img4.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(imgLable)
        contentView.addSubview(Img1)
        contentView.addSubview(Img2)
        contentView.addSubview(Img3)
        contentView.addSubview(Img4)

        
        bindEvent()
        
        imgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
        }
       
        Img1.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable.snp.bottom).snOffset(43)
            make.left.equalToSuperview().snOffset(30)
            make.width.snEqualTo(154)
            make.height.snEqualTo(154)
        }
        Img2.snp.makeConstraints { (make) in
            make.left.equalTo(Img1.snp.right).snOffset(25)
            make.top.equalTo(Img1.snp.top)
            make.width.height.snEqualTo(154)
        }
        Img3.snp.makeConstraints { (make) in
            make.left.equalTo(Img2.snp.right).snOffset(25)
            make.top.equalTo(Img2.snp.top)
            make.width.height.snEqualTo(154)
        }
        Img4.snp.makeConstraints { (make) in
            make.left.equalTo(Img3.snp.right).snOffset(25)
            make.top.equalTo(Img3.snp.top)
            make.width.height.snEqualTo(154)
        }
        
    }
    
}
