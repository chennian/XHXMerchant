//
//  XMyBankCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/8.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMyBankCell: SNBaseTableViewCell {
    
    var model : BankCardModel?{
        didSet{
            guard let cellModels =  model else {
                return
            }
            bankName.text = cellModels.bank_name
            cardholder.text = cellModels.real_name
            cardNum.text = cellModels.bank_num
        }
    }

    var bankCardImg = UIView().then{
        $0.layer.cornerRadius = fit(10)
    }
    
    let notice = UILabel().then{
        $0.text = "注：此银行卡用于分红收款"
        $0.font = Font(24)
        $0.textColor = Color(0x6c6c6c)
    }
    var  bankName = UILabel().then{
        $0.text = "招商银行"
        $0.font = Font(44)
        $0.textColor = Color(0xffffff)
    }
    var cardholder = UILabel().then{
        $0.text = "姓名：尤泽钦"
        $0.font = Font(28)
        $0.textColor = Color(0xffffff)
    }
    var cardNum = UILabel().then{
        $0.text = "银行卡号：475******3047"
        $0.font = Font(28)
        $0.textColor = Color(0xffffff)
    }
    
    override func setupView() {
        contentView.backgroundColor = Color(0xf5f5f5)
        contentView.addSubview(bankCardImg)
        contentView.addSubview(notice)
        hidLine()
        
        bankCardImg.frame  = CGRect(x: fit(30), y: fit(66), width: fit(690), height: fit(209))
        let gradientLayer = CAGradientLayer().shadowLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: fit(690), height: fit(209))
        gradientLayer.cornerRadius = fit(10)
        bankCardImg.layer.addSublayer(gradientLayer)
        bankCardImg.addSubview(bankName)
        bankCardImg.addSubview(cardholder)
        bankCardImg.addSubview(cardNum)

        bankName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(25)
            make.top.equalToSuperview().snOffset(53)
        }
        cardholder.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-27)
            make.centerY.equalTo(bankName.snp.centerY)
        }
        cardNum.snp.makeConstraints { (make) in
            make.left.equalTo(bankName.snp.left)
            make.top.equalTo(bankName.snp.bottom).snOffset(38)
        }
        
        notice.snp.makeConstraints { (make) in
            make.left.equalTo(bankCardImg.snp.left)
            make.top.equalTo(bankCardImg.snp.bottom).snOffset(23)
        }
    }
  
}
extension CAGradientLayer {
    
    func shadowLayer() -> CAGradientLayer {
        
        let gradientColors = [Color(0xfd4f02).cgColor,Color(0xff7f02).cgColor]
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        self.colors = gradientColors
        self.locations = gradientLocations
        
        //设置渲染的起始结束位置（横向渐变）
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        
        return self
    }
}
