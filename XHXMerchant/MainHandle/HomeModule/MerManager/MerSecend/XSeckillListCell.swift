//
//  XSeckillListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XSeckillListCell: SNBaseTableViewCell {
    
    var clickEventDelete:((_ para1:String,_ para2:String)->())?
    var clickEventPreview:((_ para:String)->())?

    var shopid:String = ""
    var id :String = ""
    
    var model:XSeckillListModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            img.kf.setImage(with: URL(string: cellModel.mainImg))
            name.text = cellModel.name
            num.text = "\(cellModel.cardNum)人尊享套餐"
            countTime.text = "有效期至:\(cellModel.endTime)"
            endTime.text = "截止日期:\(cellModel.terminaltime)"
            self.shopid = cellModel.shopId
            self.id = cellModel.id

        }
    }

    let img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleToFill
    }
    let name = UILabel().then{
        $0.text = "木屋烧烤民治店"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let num = UILabel().then{
        $0.text = "4人尊享套餐"
        $0.textColor = Color(0x8e8e8e)
        $0.font = Font(24)
    }
    
    let lineView = UIView().then{
        $0.backgroundColor = Color(0x8e8e8e)
    }
    
    let notice = UILabel().then{
        $0.textColor = Color(0x8e8e8e)
        $0.font = Font(30)
    }
    
    let countTime = UILabel().then{
        $0.text = "有效期至:2018-23-23"
        $0.textColor = Color(0x8e8e8e)
        $0.font = Font(24)
    }
    let endTime = UILabel().then{
        $0.text = "2018-23-232"
        $0.textColor = Color(0x8e8e8e)
        $0.font = Font(24)
    }
    
    let lineButtom = UILabel().then{
        $0.textColor = Color(0x8e8e8e)
        $0.font = Font(30)
    }
    
    let leftBtn = UIButton().then{
        $0.setTitle("预览", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor = Color(0x272424)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0x313131).cgColor
        $0.layer.cornerRadius = fit(8)

    }
    let rightBtn = UIButton().then{
        $0.setTitle("删除", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0x313131).cgColor
        $0.layer.cornerRadius = fit(8)
        $0.backgroundColor = Color(0x272424)
    }
    @objc func preview(){
        guard let action = clickEventPreview else {
            return
        }
        action(self.shopid)
        
    }
    @objc func deleteThis(){
        guard let action = clickEventDelete else {
            return
        }
        action(self.shopid,self.id)
    }
    
    func bindEvent(){
        leftBtn.addTarget(self, action: #selector(preview), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(deleteThis), for: .touchUpInside)

    }
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(num)
        contentView.addSubview(lineView)
        contentView.addSubview(notice)
        contentView.addSubview(countTime)
        contentView.addSubview(endTime)
        contentView.addSubview(lineButtom)
        contentView.addSubview(leftBtn)
        contentView.addSubview(rightBtn)
        
        bindEvent()
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.height.width.snEqualTo(160)
            make.centerY.equalToSuperview()
        }
        name.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(img.snp.top)
        }
        num.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(name.snp.bottom).snOffset(15)
            
        }
        
        countTime.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(num.snp.bottom).snOffset(15)
        }
        
        
        endTime.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(countTime.snp.bottom).snOffset(15)
        }
       
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-20)
            make.width.snEqualTo(100)
            make.height.snEqualTo(45)
            make.bottom.equalToSuperview().snOffset(-15)
        }
        leftBtn.snp.makeConstraints { (make) in
            make.right.snEqualTo(rightBtn.snp.left).snOffset(-15)
            make.width.snEqualTo(100)
            make.height.snEqualTo(45)
            make.bottom.equalToSuperview().snOffset(-15)
        }
        
        
    }
}
