//
//  XEarningDayHeaderCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XEarningDayHeaderCell: SNBaseTableViewCell {
    
    
    var models:todayModel?{
        didSet{
            guard let model = models else {return}
            chartArray.removeAll()
          
            if !model.merchant.isEmpty{
                chartArray.append(.merchantFlow(profit:StringToFloat(str: model.merchant),color:Color(0xff566e), name:"商家货款"))
            }else{
                item3.value = 0
            }
            if !model.flowmeter.isEmpty{
                chartArray.append(.merchant(profit:StringToFloat(str: model.flowmeter),color:Color(0x0fdca0), name:"跨店分红"))
            }else{
                item4.value = 0
            }
            if !model.service.isEmpty{
                chartArray.append(.service(profit:StringToFloat(str: model.service), color:Color(0x2894ff), name:"服务商"))
            }else{
                item1.value = 0
            }
            if !model.operater.isEmpty{
                chartArray.append(.operation(profit:StringToFloat(str: model.operater),color:Color(0xffcc00), name:"运营商"))
            }else{
                item2.value = 0
            }
            
            if !model.corporation.isEmpty{
                chartArray.append(.center(profit:StringToFloat(str: model.corporation),color:Color(0xff9c00), name:"服务中心"))
            }else{
                item5.value = 0
            }
            setPieChart(chartArray)
            setupBottom(chartArray)

        }
    }
    
    enum merType {
        case service(profit:CGFloat,color:UIColor,name:String)
        case operation(profit:CGFloat,color:UIColor,name:String)
        case merchant(profit:CGFloat,color:UIColor,name:String)
        case merchantFlow(profit:CGFloat,color:UIColor,name:String)
        case center(profit:CGFloat,color:UIColor,name:String)
    }
    
    var item:[UIView] = []
    
    var chartArray:[merType] = []
    
    var totalLable = UILabel().then{
        
        $0.text = "88888.88"
        $0.font = BoldFont(34)
        $0.textColor = Color(0x313131)
    }
    var descriptionLable = UILabel().then{
        $0.text = "当日总收益"
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    }
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe0e0e0)
    }
    
    var bottomBaseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
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
        
        let pieChart = PNPieChart(frame:.zero, items: items)
        pieChart.descriptionTextColor = UIColor.white
        pieChart.descriptionTextFont = Font(14)
        pieChart.hideValues = true
        contentView.addSubview(pieChart)
        
        pieChart.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(line1.snp.bottom).snOffset(44)
            make.height.width.snEqualTo(264)
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
    func setupBottom(_ chartArray:[merType]){
        
        bottomBaseView.frame = CGRect(x: fit(100), y: fit(472), width: fit(575), height:fit(115))
        self.contentView.addSubview(bottomBaseView)
        item.removeAll()
        for i in 0 ..< chartArray.count{
            
            if i % 2 == 0{
                let view = XTotalProfitView.init(frame: CGRect(x:0, y: fit(20)*CGFloat(i), width: fit(226), height:fit(20)))
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
                bottomBaseView.addSubview(view)
            }else{
                let view = XTotalProfitView.init(frame: CGRect(x:fit(335), y: fit(20)*CGFloat(i - 1), width: fit(226), height:fit(20)))
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
                bottomBaseView.addSubview(view)
            }
        }
        
    }
    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(totalLable)
        contentView.addSubview(descriptionLable)

        descriptionLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(44)
        }
        
        totalLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-32)
            make.centerY.equalTo(descriptionLable.snp.centerY)
        }
        
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(110)
            make.height.snEqualTo(1)
        }
        
    }
    
}
