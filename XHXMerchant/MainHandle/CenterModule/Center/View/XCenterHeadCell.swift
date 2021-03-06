//
//  XCenterHeadCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XCenterHeadCell: SNBaseTableViewCell {
    
    var imgTap = PublishSubject<(AliOssTransferProtocol)>()

    var headImg = DDZUploadBtn().then{
        $0.setImage(UIImage(named: "LBlogoIcon"), for: .normal)
        $0.layer.cornerRadius = fit(60)
        $0.layer.masksToBounds = true
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var name = UILabel().then{
        $0.text = "17603078066"
        $0.textColor = Color(0xffffff)
        $0.font = Font(30)
    }
    var phone = UILabel().then{
        $0.text = "服务商"
        $0.textColor = Color(0xffffff)
        $0.font = Font(30)
    }
    
    var timeButton = TimerButton().then{
        $0.timeLength = 60
        $0.backgroundColor = Color(0x272424)

    }
    
    var backgrundimg = UIImageView().then{
        $0.image = UIImage(named: "my_shade")
        $0.isUserInteractionEnabled = true
    }
    
    func bindEvernt(){
        headImg.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext:{
            [unowned self] () in
            self.imgTap.onNext((self.headImg))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(backgrundimg)
        backgrundimg.addSubview(headImg)
        backgrundimg.addSubview(name)
        backgrundimg.addSubview(phone)
        contentView.addSubview(timeButton)
    
        self.backgroundColor = Color(0xff8518)
        
        bindEvernt()
        
        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)

        timeButton.isHidden = true
        
        backgrundimg.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        headImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(57)
            make.top.equalToSuperview().snOffset(24)
            make.height.width.snEqualTo(122)
        }
        name.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).snOffset(30)
            make.top.equalTo(headImg.snp.top).snOffset(15)
        }
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).snOffset(30)
            make.bottom.equalTo(headImg.snp.bottom).snOffset(-15)
        }
        timeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(headImg.snp.centerY)
            make.width.snEqualTo(150)
            make.height.snEqualTo(40)
        }
    }

}
