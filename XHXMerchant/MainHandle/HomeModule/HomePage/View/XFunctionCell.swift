//
//  XFunctionCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XFunctionCell: SNBaseTableViewCell {
    
    var clickEvent:((_ para:Int)->())?
    
    let profit = UIButton().then{
        $0.setImage(UIImage(named: "home_earnings"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 1
    }
    let manager = UIButton().then{
        $0.setImage(UIImage(named: "home_store"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 2

    }
    let flowTeam = UIButton().then{
        $0.setImage(UIImage(named: "home_team"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 3

    }
    let flowMer = UIButton().then{
        $0.setImage(UIImage(named: "home_shop"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 4

    }
    let recommend = UIButton().then{
        $0.setImage(UIImage(named: "home_recommend"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 5
    }
    let uploadRole = UIButton().then{
        $0.setImage(UIImage(named: "home_upgrade"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 6
    }
    let operatorRole = UIButton().then{
        $0.setImage(UIImage(named: "home_upgrade1"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 7
    }
    let cashMoneyRole = UIButton().then{
        $0.setImage(UIImage(named: "home_withdraw_deposit"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.tag = 8
//        $0.isHidden = true
    }
    
    let flowTeamLable = UILabel().then{
        $0.text = "团队流量"
        $0.textColor = Color(0x6b6e72)
        $0.font = Font(30)
    }
    let flowMerLable = UILabel().then{
        $0.text = "商家流量"
        $0.textColor = Color(0x6b6e72)
        $0.font = Font(30)
    }
    let recommendLable = UILabel().then{
        $0.text = "推荐"
        $0.textColor = Color(0x6b6e72)
        $0.font = Font(30)
    }
    let uploadRoleLable = UILabel().then{
        $0.text = "升级服务商"
        $0.textColor = Color(0x6b6e72)
        $0.font = Font(30)
    }
    let operatorRoleLable = UILabel().then{
        $0.text = "升级运营商"
        $0.textColor = Color(0x6b6e72)
        $0.font = Font(30)
    }
    let cashMoney = UILabel().then{
        $0.text = "提现"
        $0.textColor = Color(0x6b6e72)
        $0.font = Font(30)
//        $0.isHidden = true
    }
    let profitLable = UILabel().then{
        $0.text = "收益"
        $0.textColor = Color(0xffffff)
        $0.font = Font(32)
    }
    let managerLable = UILabel().then{
        $0.text = "店铺管理"
        $0.textColor = Color(0xffffff)
        $0.font = Font(32)
        
    }
    @objc func click(_ btn:UIButton){
        guard  let action = clickEvent else {
            return
        }
        action(btn.tag)
    }
    func bindEvent(){
         profit.addTarget(self, action: #selector(click), for: .touchUpInside)
         manager.addTarget(self, action: #selector(click), for: .touchUpInside)
         flowTeam.addTarget(self, action: #selector(click), for: .touchUpInside)
         flowMer.addTarget(self, action: #selector(click), for: .touchUpInside)
         recommend.addTarget(self, action: #selector(click), for: .touchUpInside)
         uploadRole.addTarget(self, action: #selector(click), for: .touchUpInside)
         operatorRole.addTarget(self, action: #selector(click), for: .touchUpInside)
         cashMoneyRole.addTarget(self, action: #selector(click), for: .touchUpInside)

    }
    override func setupView() {
        contentView.addSubview(profit)
        contentView.addSubview(manager)
        
        contentView.addSubview(flowTeam)
        contentView.addSubview(flowMer)
        contentView.addSubview(recommend)
        contentView.addSubview(uploadRole)
        contentView.addSubview(operatorRole)
        contentView.addSubview(cashMoneyRole)

        contentView.addSubview(flowTeamLable)
        contentView.addSubview(flowMerLable)
        contentView.addSubview(recommendLable)
        contentView.addSubview(uploadRoleLable)
        contentView.addSubview(operatorRoleLable)
        contentView.addSubview(cashMoney)


        contentView.addSubview(profitLable)
        contentView.addSubview(managerLable)
    
        
        bindEvent()
        hidLine()
        
        profit.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(60)
            make.height.snEqualTo(200)
            make.width.snEqualTo(370)
        }
        manager.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-10)
            make.centerY.equalTo(profit.snp.centerY)
            make.height.snEqualTo(200)
            make.width.snEqualTo(370)
        }
        flowTeam.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(60)
            make.top.equalTo(profit.snp.bottom).snOffset(40)
            make.width.height.snEqualTo(150)
        }
        flowMer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(flowTeam.snp.top)
            make.width.height.snEqualTo(150)
        }
        recommend.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-60)
            make.centerY.equalTo(flowMer.snp.centerY)
            make.width.height.snEqualTo(150)
        }
        uploadRole.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(60)
            make.top.equalTo(flowTeamLable.snp.bottom).snOffset(40)
            make.width.height.snEqualTo(150)
        }
        operatorRole.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(uploadRole.snp.top)
            make.width.height.snEqualTo(150)
        }
        cashMoneyRole.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-60)
            make.centerY.equalTo(operatorRole.snp.centerY)
            make.width.height.snEqualTo(150)
        }
        
        flowTeamLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(flowTeam.snp.centerX)
            make.top.equalTo(flowTeam.snp.bottom).snOffset(-10)
        }
        flowMerLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(flowMer.snp.centerX)
            make.top.equalTo(flowMer.snp.bottom).snOffset(-10)
        }
        recommendLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(recommend.snp.centerX)
            make.top.equalTo(recommend.snp.bottom).snOffset(-10)
        }
        uploadRoleLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(uploadRole.snp.centerX)
            make.top.equalTo(uploadRole.snp.bottom).snOffset(-10)
        }
        operatorRoleLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(operatorRole.snp.centerX)
            make.top.equalTo(operatorRole.snp.bottom).snOffset(-10)
        }
        cashMoney.snp.makeConstraints { (make) in
            make.centerX.equalTo(cashMoneyRole.snp.centerX)
            make.top.equalTo(cashMoneyRole.snp.bottom).snOffset(-10)
        }
        profitLable.snp.makeConstraints { (make) in
            make.right.equalTo(profit.snp.right).snOffset(-60)
            make.top.equalTo(profit.snp.top).snOffset(70)
        }
        managerLable.snp.makeConstraints { (make) in
            make.right.equalTo(manager.snp.right).snOffset(-60)
            make.top.equalTo(profit.snp.top).snOffset(70)
        }

    }
    
}
