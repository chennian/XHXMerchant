//
//  XTotalEarningTopCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningTopCell: SNBaseTableViewCell {
    
    var models:monthModel?{
        didSet{
            guard let model = models else {
                return
            }
            self.totalLable.text = model.credit
            if model.service_total == ""{
                model.service_total = "0"
            }
            if model.operator_total == ""{
                model.service_total = "0"
            }
            if model.flowmeter_total == ""{
                model.service_total = "0"
            }
            if model.merchant_total == ""{
                model.service_total = "0"
            }
            if model.corporation_total == ""{
                model.service_total = "0"
            }
            self.oneLable.text = "服务商       \(model.service_total)"
            self.twoLable.text = "运营商       \(model.operator_total)"
            self.threeLable.text = "商家导流       \(model.flowmeter_total)"
            self.threeLable.text = "商家货款       \(model.merchant_total)"
            self.threeLable.text = "服务中心       \(model.corporation_total)"
            item1.value = 26
            item2.value = 26
            item3.value = 26
            item4.value = 26
            item5.value = 26

        }
    }
  
    var totalLable = UILabel().then{

        $0.text = "88888.88"
        $0.font = BoldFont(64)
        $0.textColor = Color(0x313131)
    }
    var descriptionLable = UILabel().then{
        $0.text = "本月累计收益"
        $0.font = Font(24)
        $0.textColor = Color(0x313131)
    }
    
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
        $0.backgroundColor = Color(0xfc)
        //        $0.layer.cornerRadius = fit(5)
        //        $0.clipsToBounds = true
    }

    var oneLable = UILabel().then{
        $0.text = "服务商       88888.88"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var twoLable = UILabel().then{
        $0.text = "运营商       88888.88"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var threeLable = UILabel().then{
        $0.text = "商家货款   88888.88"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var fourLable = UILabel().then{
        $0.text = "商家导流   88888.88"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var fiveLable = UILabel().then{
        $0.text = "服务中心   88888.88"
        $0.font = Font(24)
        $0.textColor = Color(0x75797d)
    }
    var item1 = PNPieChartDataItem(dateColor: Color(0x2894ff), description: "") //"服务商")
    var item2 = PNPieChartDataItem(dateColor: Color(0xffcc00), description: "")//"运营商")
    var item3 = PNPieChartDataItem(dateColor: Color(0xff566e), description: "")//"商家货款")
    var item4 = PNPieChartDataItem(dateColor: Color(0x0fdca0), description: "")//"商家导流")
    var item5 = PNPieChartDataItem(dateColor: Color(0xff9c00), description: "")//"服务中心")


    override func layoutSubviews() {
        super.layoutSubviews()
        item1.value = 0
        item2.value = 0
        item3.value = 0
        item4.value = 0
        item5.value = 0
    }
  //圆饼图
    private func setPieChart(){
        var items:[PNPieChartDataItem] = []
    
        item1.value = 10
        item2.value = 20
        item3.value = 30
        item4.value = 0
        item5.value = 0
        
        if item1.value == 0 ,item2.value == 0,item3.value == 0,item4.value == 0,item5.value == 0{
            let item = PNPieChartDataItem(dateValue: 1, dateColor:  .lightGray, description: "暂无数据")
            items = [item]
        }else{
            items = [item1, item2, item3,item4,item5]
        }
        
        let pieChart = PNPieChart(frame:.zero, items: items)
        pieChart.descriptionTextColor = UIColor.white
        pieChart.descriptionTextFont = Font(14)
        pieChart.hideValues = true
        contentView.addSubview(pieChart)
        
        pieChart.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(188)
            make.right.equalToSuperview().snOffset(-79)
            make.height.width.snEqualTo(227)
        }
    }
    override func setupView() {
        contentView.addSubview(totalLable)
        contentView.addSubview(descriptionLable)
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

        setPieChart()
        
        totalLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalToSuperview().snOffset(67)
        }
        descriptionLable.snp.makeConstraints { (make) in
            make.top.equalTo(totalLable.snp.bottom).snOffset(12)
            make.left.equalTo(totalLable.snp.left)
        }
        
        imgOne.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalTo(descriptionLable.snp.bottom).snOffset(40)
            make.width.height.snEqualTo(20)
        }
        imgTwo.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalTo(imgOne.snp.bottom).snOffset(19)
            make.width.height.snEqualTo(20)
        }
        imgThree.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalTo(imgTwo.snp.bottom).snOffset(19)
            make.width.height.snEqualTo(20)
        }
        imgFour.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalTo(imgThree.snp.bottom).snOffset(19)
            make.width.height.snEqualTo(20)
        }
        imgFive.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalTo(imgFour.snp.bottom).snOffset(19)
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
