//
//  XEarningDayEndCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XEarningDayEndCell: SNBaseTableViewCell {

    let imgOne = UIImageView().then{
        $0.backgroundColor = Color(0x2894ff)
        //        $0.layer.cornerRadius = fit(10)
        //        $0.clipsToBounds = true
    }
    let imgTwo = UIImageView().then{
        $0.backgroundColor = Color(0xffcc00)
        //        $0.layer.cornerRadius = fit(10)
        //        $0.clipsToBounds = true
    }
    let imgThree = UIImageView().then{
        $0.backgroundColor = Color(0xff566e)
        //        $0.layer.cornerRadius = fit(5)
        //        $0.clipsToBounds = true
    }
    let imgFour = UIImageView().then{
        $0.backgroundColor = Color(0x0fdca0)
        //        $0.layer.cornerRadius = fit(5)
        //        $0.clipsToBounds = true
    }
    let imgFive = UIImageView().then{
        $0.backgroundColor = Color(0xff9c00)
        //        $0.layer.cornerRadius = fit(5)
        //        $0.clipsToBounds = true
    }
    
    var oneLable = UILabel().then{
        $0.text = "服务商"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var twoLable = UILabel().then{
        $0.text = "运营商"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var threeLable = UILabel().then{
        $0.text = "商家贷款"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var fourLable = UILabel().then{
        $0.text = "商家倒流"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var fiveLable = UILabel().then{
        $0.text = "服务中心"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    override func setupView() {
        contentView.addSubview(imgOne)
        contentView.addSubview(imgTwo)
        contentView.addSubview(imgThree)
        contentView.addSubview(imgFour)
        contentView.addSubview(imgFive)
        contentView.addSubview(oneLable)
        contentView.addSubview(twoLable)
        contentView.addSubview(threeLable)
        contentView.addSubview(fourLable)
        contentView.addSubview(fiveLable)
        let barChart = XbarChartView.init(frame:.zero,items:[1000,200,20,500,700])
        contentView.addSubview(barChart)
        
        barChart.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(52)
            make.right.equalToSuperview().snOffset(-52)
            make.top.equalToSuperview().snOffset(52)
            make.height.snEqualTo(446)
        }

        imgOne.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(102)
            make.top.equalTo(barChart.snp.bottom).snOffset(54)
            make.width.height.snEqualTo(20)
        }
        imgTwo.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(102)
            make.top.equalTo(imgOne.snp.bottom).snOffset(23)
            make.width.height.snEqualTo(20)
        }
        imgThree.snp.makeConstraints { (make) in
            make.left.equalTo(imgOne.snp.right).snOffset(335)
            make.top.equalTo(barChart.snp.bottom).snOffset(54)
            make.width.height.snEqualTo(20)
        }
        imgFour.snp.makeConstraints { (make) in
            make.left.equalTo(imgTwo.snp.right).snOffset(335)
            make.top.equalTo(imgThree.snp.bottom).snOffset(23)
            make.width.height.snEqualTo(20)
        }
        imgFive.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(102)
            make.top.equalTo(imgTwo.snp.bottom).snOffset(23)
            make.width.height.snEqualTo(20)
        }
        oneLable.snp.makeConstraints { (make) in
            make.left.equalTo(imgOne.snp.right).snOffset(17)
            make.centerY.equalTo(imgOne)
        }
        twoLable.snp.makeConstraints { (make) in
            make.left.equalTo(imgTwo.snp.right).snOffset(17)
            make.centerY.equalTo(imgTwo)
        }
        threeLable.snp.makeConstraints { (make) in
            make.left.equalTo(imgThree.snp.right).snOffset(17)
            make.centerY.equalTo(imgThree)
        }
        fourLable.snp.makeConstraints { (make) in
            make.left.equalTo(imgFour.snp.right).snOffset(17)
            make.centerY.equalTo(imgFour)
        }
        fiveLable.snp.makeConstraints { (make) in
            make.left.equalTo(imgFive.snp.right).snOffset(17)
            make.centerY.equalTo(imgFive)
        }

    }

}
