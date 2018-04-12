//
//  XTotalEarningsMidCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningsMidCell: SNBaseTableViewCell {
    var clickEvent1: (() -> ())?
    var clickEvent2: (() -> ())?
    var clickEvent3: (() -> ())?
    var clickEvent4: (() -> ())?

    var img = UIImageView().then{
        $0.backgroundColor = .red
//        $0.image = UIImage(named: "")
    }
    
    var todayLable = UILabel().then{
        $0.text = "今日收益"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
      
    }
    var descriptionLable = UILabel().then{
        $0.text = "388.88"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line3 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line4 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    
    var view1 = UIView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    var view2 = UIView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    var view3 = UIView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    var view4 = UIView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true

    }

    var merPayment = UILabel().then{
        $0.text = "商家货款"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    var serviceProfit = UILabel().then{
        $0.text = "服务商分润"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    var operatorProfit = UILabel().then{
        $0.text = "运营商分润"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    var merFlow = UILabel().then{
        $0.text = "商家倒流分润"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    
    var merPaymentLable = UILabel().then{
        $0.text = "1000"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    var serviceProfitLable = UILabel().then{
        $0.text = "1000"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    var operatorProfitLable = UILabel().then{
        $0.text = "1000"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    var merFlowLable = UILabel().then{
        $0.text = "1000"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
    
    var merPaymentDsc = UILabel().then{
        $0.text = "共1000笔交易"
        $0.font = Font(24)
        $0.textColor = Color(0x9ea3aa)
    }
    var serviceProfitDsc = UILabel().then{
        $0.text = "共1000笔交易"
        $0.font = Font(24)
        $0.textColor = Color(0x9ea3aa)
    }
    var operatorProfitDsc = UILabel().then{
        $0.text = "共1000笔交易"
        $0.font = Font(24)
        $0.textColor = Color(0x9ea3aa)
    }
    var merFlowDsc = UILabel().then{
        $0.text = "共1000笔交易"
        $0.font = Font(24)
        $0.textColor = Color(0x9ea3aa)
    }
    
    func bindEvent(){
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapOne))
        view1.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapTwo))
        view2.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(tapThree))
        view3.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(tapFour))
        view4.addGestureRecognizer(tapGesture4)
    }
    
    @objc func tapOne()  {
        guard let clickEvent = clickEvent1 else {return}
        clickEvent()

    }
    @objc func tapTwo()  {
        guard let clickEvent = clickEvent2 else {return}
        clickEvent()

    }
    @objc func tapThree()  {
        guard let clickEvent = clickEvent3 else {return}
        clickEvent()

    }
    @objc func tapFour()  {
        guard let clickEvent = clickEvent4 else {return}
        clickEvent()
    }
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(todayLable)
        contentView.addSubview(descriptionLable)
        
        contentView.addSubview(view1)
        contentView.addSubview(view2)
        contentView.addSubview(view3)
        contentView.addSubview(view4)
        
        contentView.addSubview(line1)
        view1.addSubview(line2)
        view2.addSubview(line3)
        view3.addSubview(line4)

        view1.addSubview(merPayment)
        view1.addSubview(merPaymentDsc)
        view1.addSubview(merPaymentLable)
        view2.addSubview(serviceProfit)
        view2.addSubview(serviceProfitDsc)
        view2.addSubview(serviceProfitLable)
        view3.addSubview(operatorProfit)
        view3.addSubview(operatorProfitDsc)
        view3.addSubview(operatorProfitLable)
        view4.addSubview(merFlow)
        view4.addSubview(merFlowDsc)
        view4.addSubview(merFlowLable)
        
        bindEvent()
    
        view1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(120)
            make.top.equalToSuperview().snOffset(96)
        }
        view2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(120)
            make.top.equalTo(view1.snp.bottom)
        }
        view3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(120)
            make.top.equalTo(view2.snp.bottom)
        }
        view4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(120)
            make.top.equalTo(view3.snp.bottom)
        }
        
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.bottom.equalTo(view1.snp.top)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(1)
            make.bottom.equalToSuperview()
        }
        line3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(1)
            make.bottom.equalToSuperview()
        }
        line4.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(1)
            make.bottom.equalToSuperview()
        }
    
        img.snp.makeConstraints { (make) in
            make.left.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(32)
            make.width.snEqualTo(40)
            make.height.snEqualTo(35)
        }
       
        todayLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(img.snp.centerY)
            make.left.equalTo(img.snp.right).snOffset(17)
        }
        descriptionLable.snp.makeConstraints { (make) in
           
            make.left.equalTo(todayLable.snp.right).snOffset(17)
            make.centerY.equalTo(todayLable.snp.centerY)
        }
        
        merPayment.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        merPaymentLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(33)
        }
        merPaymentDsc.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalTo(merPaymentLable.snp.bottom).snOffset(11)
        }

        serviceProfit.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        serviceProfitLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalToSuperview().snOffset(31)
        }
        serviceProfitDsc.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalTo(serviceProfitLable.snp.bottom).snOffset(11)
        }
        operatorProfit.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        operatorProfitLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalToSuperview().snOffset(31)
        }
        operatorProfitDsc.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalTo(operatorProfitLable.snp.bottom).snOffset(11)
        }
        merFlow.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        merFlowLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalToSuperview().snOffset(31)
        }
        merFlowDsc.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-34)
            make.top.equalTo(merFlow.snp.bottom).snOffset(11)

        }

    }

}


