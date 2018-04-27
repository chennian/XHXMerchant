//
//  barChartView.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XbarChartView: UIView {
    
    let maxHeight:CGFloat = fit(330)

    var imgOneHeight:CGFloat = 100
    var imgTwoHeight:CGFloat = 200
    var imgThreeHeight:CGFloat = 300
    var imgFourHeight:CGFloat = 150
    var imgFiveHeight:CGFloat = 250

    var dataArray:[CGFloat] = []

    var realHeight:[CGFloat] = []
    
    init(frame: CGRect, items: [CGFloat]) {
        super.init(frame: frame)
        self.dataArray = items
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var color: UIColor = .white{
        didSet{
            self.backgroundColor = color
        }
    }
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xdde1e5)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xdde1e5)
    }
    
    var numLable = UILabel().then{
        $0.text = "数量"
        $0.font = Font(25)
        $0.textColor = Color(0x313131)
    }
    var typeLable = UILabel().then{
        $0.text = "类型"
        $0.font = Font(25)
        $0.textColor = Color(0x313131)
    }
    
    var imgOne = UIImageView().then{
        $0.backgroundColor = Color(0x2894ff)
    }
    var imgTwo = UIImageView().then{
        $0.backgroundColor = Color(0xffcc00)
    }
    var imgThree = UIImageView().then{
        $0.backgroundColor = Color(0xff566e)
    }
    var imgFour = UIImageView().then{
        $0.backgroundColor = Color(0x0fdca0)
    }
    var imgFive = UIImageView().then{
        $0.backgroundColor = Color(0xff9c00)
    }
    
    var  lableOne = UILabel().then{
        $0.text = "20"
        $0.font = Font(23)
        $0.textColor = Color(0x313131)
    }
    var  lableTwo = UILabel().then{
        $0.text = "20"
        $0.font = Font(23)
        $0.textColor = Color(0x313131)
    }
    var  lableThree = UILabel().then{
        $0.text = "20"
        $0.font = Font(23)
        $0.textColor = Color(0x313131)
    }
    var  lableFour = UILabel().then{
        $0.text = "20"
        $0.font = Font(23)
        $0.textColor = Color(0x313131)
    }
    var  lableFive = UILabel().then{
        $0.text = "20"
        $0.font = Font(23)
        $0.textColor = Color(0x313131)
    }
    
    fileprivate func getMaxHeight(_ para:[CGFloat]) -> [CGFloat]{
        var max:CGFloat = 0
        for i in 0..<para.count {
            if para[i] > max {
                max = para[i]
            }
        }
        
        let  ratio = fit(max)/maxHeight
        if   ratio == 0 {
            realHeight = [0,0,0,0,0]
        }else{
            realHeight = dataArray.map {
                return $0/ratio
            }
        }
        return realHeight
    }
    
    
    func setupView() {
        
        self.addSubview(numLable)
        self.addSubview(typeLable)
        self.addSubview(line1)
        self.addSubview(line2)
        self.addSubview(imgOne)
        self.addSubview(imgTwo)
        self.addSubview(imgThree)
        self.addSubview(imgFour)
        self.addSubview(imgFive)
        self.addSubview(lableOne)
        self.addSubview(lableTwo)
        self.addSubview(lableThree)
        self.addSubview(lableFour)
        self.addSubview(lableFive)
        
        getMaxHeight(dataArray)
      
        CNLog(realHeight)
        
        self.lableOne.text   = "\(Int(dataArray[0]))"
        self.lableTwo.text   = "\(Int(dataArray[1]))"
        self.lableThree.text = "\(Int(dataArray[2]))"
        self.lableFour.text  = "\(Int(dataArray[3]))"
        self.lableFive.text  = "\(Int(dataArray[4]))"
        
        if dataArray[0] == 0{
            self.lableOne.isHidden = true
        }
        if dataArray[1] == 0{
            self.lableTwo.isHidden = true
        }
        if dataArray[2] == 0{
            self.lableThree.isHidden = true
        }
        if dataArray[3] == 0{
            self.lableFour.isHidden = true
        }
        if dataArray[4] == 0{
            self.lableFive.isHidden = true
        }
        
        imgOneHeight = realHeight[0]
        imgTwoHeight = realHeight[1]
        imgThreeHeight = realHeight[2]
        imgFourHeight = realHeight[3]
        imgFiveHeight = realHeight[4]
        
        
        
        numLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(5)
            make.top.equalToSuperview()
        }
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(25)
            make.top.equalTo(numLable.snp.bottom).snOffset(13)
            make.width.snEqualTo(4)
            make.height.snEqualTo(399)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(4)
            make.bottom.equalToSuperview().snOffset(-34)
        }
        typeLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imgOne.snp.makeConstraints { (make) in
            make.left.equalTo(line1.snp.right).snOffset(19)
            make.bottom.equalTo(line2.snp.top)
            make.width.snEqualTo(84)
            make.height.snEqualTo(imgOneHeight)
        }
        imgTwo.snp.makeConstraints { (make) in
            make.left.equalTo(imgOne.snp.right).snOffset(34)
            make.bottom.equalTo(line2.snp.top)
            make.width.snEqualTo(84)
            make.height.snEqualTo(imgTwoHeight)
        }
        imgThree.snp.makeConstraints { (make) in
            make.left.equalTo(imgTwo.snp.right).snOffset(34)
            make.bottom.equalTo(line2.snp.top)
            make.width.snEqualTo(84)
            make.height.snEqualTo(imgThreeHeight)
        }
        imgFour.snp.makeConstraints { (make) in
            make.left.equalTo(imgThree.snp.right).snOffset(34)
            make.bottom.equalTo(line2.snp.top)
            make.width.snEqualTo(84)
            make.height.snEqualTo(imgFourHeight)
        }
        imgFive.snp.makeConstraints { (make) in
            make.left.equalTo(imgFour.snp.right).snOffset(34)
            make.bottom.equalTo(line2.snp.top)
            make.width.snEqualTo(84)
            make.height.snEqualTo(imgFiveHeight)
        }
        
        lableOne.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgOne.snp.centerX)
            make.bottom.equalTo(imgOne.snp.top).snOffset(-10)
        }
        lableTwo.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgTwo.snp.centerX)
            make.bottom.equalTo(imgTwo.snp.top).snOffset(-10)
        }
        lableThree.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgThree.snp.centerX)
            make.bottom.equalTo(imgThree.snp.top).snOffset(-10)
        }
        lableFour.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgFour.snp.centerX)
            make.bottom.equalTo(imgFour.snp.top).snOffset(-10)
        }
        lableFive.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgFive.snp.centerX)
            make.bottom.equalTo(imgFive.snp.top).snOffset(-10)
        }
    }

}
