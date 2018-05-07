//
//  XCashController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/3.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XCashController: SNBaseViewController {
    
    let imglogo = UIImageView().then{
        $0.image = UIImage(named: "money")
    }
    let NoticeOne = UILabel().then{
        $0.font = Font(28)
        $0.textColor = Color(0x8f8f8f)
        $0.text = "可提现金额"
    }
    let totalMoney = UILabel().then{
        $0.font = BoldFont(60)
        $0.textColor = Color(0x313131)
        $0.text = "10000.00"
    }
    
    let cashView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let cashBankLable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.text = "提现银行卡"
    }
    let cashBank = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x0073e9)
        $0.text = "招商银行(3344)"
    }
    let cashLine = UIView().then{
        $0.backgroundColor = Color(0xe2e2e2)
    }
    let cashMoneyLable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.text = "兑换金额"
    }
    
    let symbleMoney = UILabel().then{
        $0.font = BoldFont(66)
        $0.textColor = Color(0x313131)
        $0.text = "￥"
    }
    let cashMoney = UITextField().then{
        $0.placeholder = "0.00"
        $0.font = Font(88)
        $0.textColor = Color(0x313131)
        $0.keyboardToolbar.isHidden = true
        $0.keyboardType = .numberPad
    }
    let noticeTwo = UILabel().then{
        $0.font = Font(28)
        $0.textColor = Color(0xa2a2a2)
        $0.text = "兑换金额必须是100的整数倍，每笔扣除20%的税及手续费5赞分"
        $0.numberOfLines = 0
    }
    
    let btn = UIButton().then{
        $0.setTitle("确认兑换", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    
    
    let mask = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.alpha = 0.3
    }
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
    }
    
    let deleteBtn = UIButton().then{
        $0.setImage(UIImage(named: "close"), for: .normal)
        $0.setTitleColor(Color(0xe5e5e5), for: .normal)
        $0.titleLabel?.font = Font(40)
    }
    
    let notice = UILabel().then{
        $0.font = Font(40)
        $0.textColor = Color(0x313131)
        $0.text = "请输入支付密码"
    }
    
    let lineOne = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    let noticeMoney = UILabel().then{
        $0.font = Font(34)
        $0.textColor = Color(0x313131)
        $0.text = "提现金额"
    }
    let moneyLable = UILabel().then{
        $0.font = BoldFont(40)
        $0.textColor = Color(0x313131)
    }
    
    let passwordView = PassWordField().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.cashMoney.resignFirstResponder()
        
    }
    override func bindEvent() {
        btn.addTarget(self, action: #selector(cash), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteBack), for: .touchUpInside)
    }
    @objc func deleteBack(){
        passwordView.textField.resignFirstResponder()
        mainView.removeFromSuperview()
        mask.removeFromSuperview()

    }
    @objc func cash(){
        setPasswordView()
    }

    override func setupView() {
        setUI()
    }
    
    func setPasswordView(){
        
        self.view.addSubview(mask)
        mask.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        CNLog(self.cashMoney.text!)
        moneyLable.text =   String(format: "%.2f", self.cashMoney.text!)
        
        self.view.addSubview(mainView)
        mainView.addSubview(deleteBtn)
        mainView.addSubview(notice)
        mainView.addSubview(lineOne)
        mainView.addSubview(noticeMoney)
        mainView.addSubview(moneyLable)
        mainView.addSubview(passwordView)
        passwordView.delegate = self
        passwordView.textField.becomeFirstResponder()
        
        
        deleteBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(40)
            make.width.snEqualTo(35)
            make.height.snEqualTo(35)
        }
        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(65)
            make.right.equalToSuperview().snOffset(-65)
            make.top.equalToSuperview().snOffset(104)
            make.height.snEqualTo(455)
        }
        
        notice.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(40)
            make.centerX.equalToSuperview()
        }
        lineOne.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(notice.snp.bottom).snOffset(35)
        }
        noticeMoney.snp.makeConstraints { (make) in
            make.top.equalTo(lineOne.snp.bottom).snOffset(40)
            make.centerX.equalToSuperview()
        }
        moneyLable.snp.makeConstraints { (make) in
            make.top.equalTo(noticeMoney.snp.bottom).snOffset(30)
            make.centerX.equalToSuperview()
        }
      
        passwordView.snp.makeConstraints { (make) in
            make.width.snEqualTo(547)
            make.height.snEqualTo(88)
            make.top.equalTo(moneyLable.snp.bottom).snOffset(35)
            make.centerX.equalToSuperview()
            
        }

    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "记录", imgName:"", target: self, action: #selector(cashRecord))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc func cashRecord(){
        self.navigationController?.pushViewController(XCashRecordController(), animated: true)
    }
    func setUI(){
        setNavigationBar()
        self.title = "提现"
        self.view.backgroundColor = Color(0xf5f5f5)
        self.view.addSubview(imglogo)
        self.view.addSubview(NoticeOne)
        self.view.addSubview(totalMoney)
        
        self.view.addSubview(cashView)
        cashView.addSubview(cashBankLable)
        cashView.addSubview(cashBank)
        cashView.addSubview(cashLine)
        cashView.addSubview(cashMoneyLable)
        cashView.addSubview(symbleMoney)
        cashView.addSubview(cashMoney)
        
        self.view.addSubview(noticeTwo)
        self.view.addSubview(btn)

        self.view.addSubview(btn)
        
        imglogo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(43)
            make.height.width.snEqualTo(166)
        }
        NoticeOne.snp.makeConstraints { (make) in
            make.top.equalTo(imglogo.snp.bottom).snOffset(24)
            make.centerX.equalToSuperview()
        }
        totalMoney.snp.makeConstraints { (make) in
            make.top.equalTo(NoticeOne.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        cashView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(totalMoney.snp.bottom).snOffset(40)
            make.height.snEqualTo(320)
        }
        
        cashBankLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(38)
        }
        cashBank.snp.makeConstraints { (make) in
            make.left.equalTo(cashBankLable.snp.right).snOffset(16)
            make.centerY.equalTo(cashBankLable.snp.centerY)
        }
        cashLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(cashBankLable.snp.bottom).snOffset(32)
        }
        cashMoneyLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(cashLine.snp.bottom).snOffset(40)
        }
        symbleMoney.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(cashMoneyLable.snp.bottom).snOffset(46)
            make.width.snEqualTo(50)
        }
        cashMoney.snp.makeConstraints { (make)  in
            make.centerY.equalTo(symbleMoney.snp.centerY)
            make.left.equalTo(symbleMoney.snp.right).snOffset(46)
            make.right.equalToSuperview().snOffset(-80)
        }
        noticeTwo.snp.makeConstraints { (make) in
            make.top.equalTo(cashView.snp.bottom).snOffset(20)
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
        }
        btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(100)
            make.top.equalTo(noticeTwo.snp.bottom).snOffset(80)
        }
        
    }
}

extension XCashController:PassWordFieldDelegate{
    func inputTradePasswordFinish(tradePasswordView: PassWordField, password: String) {
        CNLog(password)
    }
    
}
