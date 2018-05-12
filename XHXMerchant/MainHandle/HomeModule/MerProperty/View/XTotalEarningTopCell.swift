//
//  XTotalEarningTopCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningTopCell: SNBaseTableViewCell {
    
    enum merType {
        case service(profit:CGFloat,color:UIColor,name:String)
        case operation(profit:CGFloat,color:UIColor,name:String)
        case merchant(profit:CGFloat,color:UIColor,name:String)
        case merchantFlow(profit:CGFloat,color:UIColor,name:String)
        case center(profit:CGFloat,color:UIColor,name:String)
    }
    
    var item:[UIView] = []
    
    var chartArray:[merType] = []
    
    var models:monthModel?{
        didSet{
            guard let model = models else {
                return
            }
            self.totalLable.text = model.credit
        
            chartArray.removeAll()
    
            if !model.merchant_total.isEmpty{
                 chartArray.append(.merchant(profit:StringToFloat(str: model.merchant_total),color:Color(0xff566e), name:"商家货款"))
            }else{
                item3.value = 0
            }
            if !model.flowmeter_total.isEmpty{
                chartArray.append(.merchantFlow(profit:StringToFloat(str: model.flowmeter_total),color:Color(0x0fdca0), name:"跨店分红"))
            }else{
                item4.value = 0
            }
            if !model.service_total.isEmpty{
                chartArray.append(.service(profit:StringToFloat(str: model.service_total), color:Color(0x2894ff), name:"服务商"))
            }else{
                item1.value = 0
            }
            if !model.operator_total.isEmpty{
                chartArray.append(.operation(profit:StringToFloat(str: model.operator_total),color:Color(0xffcc00), name:"运营商"))
            }else{
                item2.value = 0
            }
            if !model.corporation_total.isEmpty{
                chartArray.append(.center(profit:StringToFloat(str: model.corporation_total),color:Color(0xff9c00), name:"服务中心"))
            }else{
                item5.value = 0
            }
            
            setupleft(chartArray)
            setPieChart(chartArray)
            
        }
    }
    func setupleft(_ chartArray:[merType]){
        
        leftBaseView.frame = CGRect(x: fit(74), y: fit(208), width: fit(300), height:fit(40)*CGFloat(chartArray.count))
        self.contentView.addSubview(leftBaseView)
        item.removeAll()
        for i in 0 ..< chartArray.count{
            let view = XTotalProfitView.init(frame: CGRect(x:0, y: fit(40)*CGFloat(i), width: fit(226), height:fit(20)))

            switch  chartArray[i]{
            case .service(let profit,let color,let name):
                view.profit.text = String(format:"%.2f",profit)
                view.imgView.backgroundColor = color
                view.roleLable.text = name
            case .operation(let profit,let color,let name):
                view.profit.text = String(format:"%.2f",profit)
                view.imgView.backgroundColor = color
                view.roleLable.text = name
            case .merchant(let profit,let color,let name):
                view.profit.text = String(format:"%.2f",profit)
                view.imgView.backgroundColor = color
                view.roleLable.text = name
            case .merchantFlow(let profit,let color,let name):
                view.profit.text = String(format:"%.2f",profit)
                view.imgView.backgroundColor = color
                view.roleLable.text = name
            case .center(let profit,let color,let name):
                view.profit.text = String(format:"%.2f",profit)
                view.imgView.backgroundColor = color
                view.roleLable.text = name
            }
            
            
            item.append(view)
            leftBaseView.addSubview(view)
        }
    }
    var leftBaseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
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
    
    
    var item1 = PNPieChartDataItem(dateColor: Color(0x2894ff), description: "") //"服务商")
    var item2 = PNPieChartDataItem(dateColor: Color(0xffcc00), description: "")//"运营商")
    var item3 = PNPieChartDataItem(dateColor: Color(0xff566e), description: "")//"商家货款")
    var item4 = PNPieChartDataItem(dateColor: Color(0x0fdca0), description: "")//"跨店分红")
    var item5 = PNPieChartDataItem(dateColor: Color(0xff9c00), description: "")//"服务中心")

  //圆饼图
    private func setPieChart(_ chartArray:[merType]){
        var items:[PNPieChartDataItem] = []
    
        for item in chartArray{
            switch item {
            case .service(let profit,_,_):
                item1.value = profit
            case .operation(let profit,_,_):
                item2.value = profit
            case .merchant(let profit,_,_):
                item3.value = profit
            case .merchantFlow(let profit,_,_):
                item4.value = profit
            case .center(let profit,_,_):
                item5.value = profit
            }
        }
        
        if item1.value == 0 ,item2.value == 0,item3.value == 0,item4.value == 0,item5.value == 0{
            let item = PNPieChartDataItem(dateValue: 1, dateColor:  .lightGray, description: "暂无数据")
            items = [item]
        }else{
            items = [item1, item2, item3,item4,item5]
        }
        CNLog(items)
        
        let pieChart = PNPieChart(frame:.zero, items: items)
        pieChart.descriptionTextColor = UIColor.white
        pieChart.descriptionTextFont = Font(14)
        pieChart.hideValues = true
        contentView.addSubview(pieChart)
        
        pieChart.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftBaseView.snp.centerY)
            make.right.equalToSuperview().snOffset(-79)
            make.height.width.snEqualTo(227)
        }
    }
    func StringToFloat(str:String)->(CGFloat){
        
        let string = str
        var cgFloat: CGFloat = 0
        
        
        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    override func setupView() {
        contentView.addSubview(totalLable)
        contentView.addSubview(descriptionLable)
        
        totalLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.top.equalToSuperview().snOffset(67)
        }
        descriptionLable.snp.makeConstraints { (make) in
            make.top.equalTo(totalLable.snp.bottom).snOffset(12)
            make.left.equalTo(totalLable.snp.left)
        }
    }

}
