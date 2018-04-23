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
    
    var model :XMerListModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            if cellModel.banner != ""{
                activityImg.kf.setImage(with: URL(string:cellModel.banner), for: UIControlState.normal)
            }else{
                activityImg.setImage(UIImage(named:"shop_flat_patternmaking"),for:.normal)
            }
            
            if cellModel.logo != ""{
                logoImg.kf.setImage(with: URL(string:cellModel.logo), for: UIControlState.normal)
            }else{
                logoImg.setImage(UIImage(named:"shop_logo_uploading"),for:.normal)
            }
            
            if cellModel.detail != "" {
                let imgArray = cellModel.detail.components(separatedBy: "|")
                if  imgArray.count == 1{
                    Img1.kf.setImage(with: URL(string:imgArray[0]), for: .normal)
                    Img2.setImage(UIImage(named:"shop_particulars"),for:.normal)
                    Img3.setImage(UIImage(named:"shop_particulars"),for:.normal)
                }else if imgArray.count == 2{
                    Img1.kf.setImage(with: URL(string:imgArray[0]), for: .normal)
                    Img2.kf.setImage(with: URL(string:imgArray[1]), for: .normal)
                    Img3.setImage(UIImage(named:"shop_particulars"),for:.normal)
                }else{
                    Img1.kf.setImage(with: URL(string:imgArray[0]), for: .normal)
                    Img2.kf.setImage(with: URL(string:imgArray[1]), for: .normal)
                    Img3.kf.setImage(with: URL(string:imgArray[2]), for: .normal)
                }
            }else{
                Img1.setImage(UIImage(named:"shop_particulars"),for:.normal)
                Img2.setImage(UIImage(named:"shop_particulars"),for:.normal)
                Img3.setImage(UIImage(named:"shop_particulars"),for:.normal)
            }
        }
    }
    
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
    let viewSpace = UIView().then{
        $0.backgroundColor = Color(0xf5f5f5)
    }
    
    let imgLable2 = UILabel().then{
        $0.text = "店铺logo图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var logoImg = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_logo_uploading"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "2"
    }
    
    let permitCardNotice2 = UILabel().then{
        $0.text = "此图用于店铺详情页logo的展示"
        $0.font = Font(24)
        $0.textColor = Color(0x8b8e94)
    }
    
    let viewSpace1 = UIView().then{
        $0.backgroundColor = Color(0xf5f5f5)
    }
    
    let imgLable3 = UILabel().then{
        $0.text = "店铺详情图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var Img1 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_particulars"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "3"
        
    }
    var Img2 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_particulars"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "4"
        
    }
    var Img3 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"shop_particulars"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.fuName = "5"
        
    }
    
    func bindEvent() {
        activityImg.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.activityImg,self.activityImg.fuName))
        }).disposed(by: disposeBag)
        logoImg.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.logoImg,self.logoImg.fuName))
        }).disposed(by: disposeBag)
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
        contentView.addSubview(activityImg)
        contentView.addSubview(permitCardNotice)
        
        contentView.addSubview(viewSpace)
        
        contentView.addSubview(imgLable2)
        contentView.addSubview(logoImg)
        contentView.addSubview(permitCardNotice2)
        
        contentView.addSubview(viewSpace1)
        
        contentView.addSubview(imgLable3)
        contentView.addSubview(Img1)
        contentView.addSubview(Img2)
        contentView.addSubview(Img3)
        
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
        
        viewSpace.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(permitCardNotice.snp.bottom).snOffset(38)
            make.height.snEqualTo(20)
        }
        
        imgLable2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(viewSpace.snp.bottom).snOffset(30)
        }
        
        
        logoImg.snp.makeConstraints { (make) in
            make.top.equalTo(imgLable2.snp.bottom).snOffset(60)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(232)
            make.height.snEqualTo(232)
        }
        
        permitCardNotice2.snp.makeConstraints { (make) in
            make.top.equalTo(logoImg.snp.bottom).snOffset(18)
            make.centerX.equalTo(logoImg.snp.centerX)
        }
        viewSpace1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(20)
            make.top.equalTo(permitCardNotice2.snp.bottom).snOffset(36)
        }
        imgLable3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(viewSpace1.snp.bottom).snOffset(30)
        }
        Img2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgLable3.snp.bottom).snOffset(60)
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
