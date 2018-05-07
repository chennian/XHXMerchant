//
//  XEarningDayEndCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XEarningDayEndCell: SNBaseTableViewCell {
    
    var itemArray:[CGFloat] = [0,0,0,0,0]
    
    var models:todayModel?{
        didSet{
            guard let model = models else {return}
            chartArray.removeAll()
            if !model.merchant.isEmpty{
                chartArray.append(.merchantFlow(profit:StringToFloat(str: model.merchant_num),color:Color(0xff566e), name:"商家货款"))
                itemArray[2] = StringToFloat(str: model.merchant_num)
            }else{
                itemArray[2] = 0
            }
            if !model.flowmeter.isEmpty{
                chartArray.append(.merchant(profit:StringToFloat(str: model.flow_num),color:Color(0x0fdca0), name:"跨店分红"))
                itemArray[3] = StringToFloat(str: model.flow_num)
            }else{
                itemArray[3] = 0
            }
            if !model.service.isEmpty{
                chartArray.append(.service(profit:StringToFloat(str: model.service_num), color:Color(0x2894ff), name:"服务商"))
                itemArray[0] = StringToFloat(str: model.service_num)
            }else{
                itemArray[0] = 0
            }
            if !model.operater.isEmpty{
                chartArray.append(.operation(profit:StringToFloat(str: model.operator_num),color:Color(0xffcc00), name:"运营商"))
                itemArray[1] = StringToFloat(str: model.operator_num)
            }else{
                itemArray[1] = 0
            }

            if !model.corporation.isEmpty{
                chartArray.append(.center(profit:StringToFloat(str: model.corporation_num),color:Color(0xff9c00), name:"服务中心"))
                itemArray[4] = StringToFloat(str: model.corporation_num)

            }else{
                itemArray[4] = 0
            }
            
            var  total:CGFloat = 0.0
            for i in itemArray {
                total += i
            }
            self.numberLable.text =  model.totalNum
            setBarChart(itemArray)
            setupBottom(chartArray)
            
        }
    }
    func setupBottom(_ chartArray:[merType]){
        
        bottomBaseView.frame = CGRect(x: fit(100), y: fit(640), width: fit(575), height:fit(115))
        self.contentView.addSubview(bottomBaseView)
        
        item.removeAll()
        for i in 0 ..< chartArray.count{
            
            if i % 2 == 0{
                let view = XTotalProfitView.init(frame: CGRect(x:0, y: fit(20)*CGFloat(i), width: fit(226), height:fit(20)))
                view.profit.isHidden = true
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
                view.profit.isHidden = true
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
    func setBarChart(_ chartArray:[CGFloat]){
        let barChart = XbarChartView.init(frame:.zero,items:chartArray)
        contentView.addSubview(barChart)
        
        barChart.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(52)
            make.right.equalToSuperview().snOffset(-52)
            make.top.equalToSuperview().snOffset(160)
            make.height.snEqualTo(446)
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
    var bottomBaseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
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

    var des = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.text = "交易数量"
    }
    var numberLable = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = BoldFont(34)
        $0.text = "88.00"
    }
    
    var linehead = UIView().then{
        $0.backgroundColor = Color(0xe0e0e0)
    }
    override func setupView() {
        contentView.addSubview(des)
        contentView.addSubview(numberLable)
        contentView.addSubview(linehead)

        des.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(40)
        }
        numberLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(des.snp.centerY)
        }
        linehead.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(des.snp.bottom).snOffset(40)
        }
    }

}
