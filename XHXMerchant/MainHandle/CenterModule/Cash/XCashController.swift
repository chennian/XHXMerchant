//
//  XCashController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/3.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XCashController: SNBaseViewController {
    var model:[CashInfoModel] = []
    var needCashMoney:String = ""
    var intMoney :Int = 0
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
        $0.text = "兑换金额必须是100的整数倍，每笔扣除5%的手续费"
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
        passwordView.textFieldText = ""
        passwordView.textField.text = ""
        passwordView.view1.isHidden = true
        passwordView.view2.isHidden = true
        passwordView.view3.isHidden = true
        passwordView.view4.isHidden = true
        passwordView.view5.isHidden = true
        passwordView.view6.isHidden = true
        mainView.removeFromSuperview()
        mask.removeFromSuperview()

    }
    @objc func cash(){
        if self.cashMoney.text! == ""{
              UIAlertView(title: "温馨提示", message: "请输入提现金额", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        setPasswordView()
    }
    override func loadData() {
        SNRequest(requestType: API.getExchangeInfo, modelType: [CashInfoModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
                DispatchQueue.main.async {
                    self.totalMoney.text = self.model[0].account
                    self.cashBank.text = self.model[0].bankname
                }
            case .fail(let code,let msg):
                SZHUD(msg ?? "请求数据失败", type: .error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                break
            }
        }).disposed(by: disposeBag)
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
        let money =  Float(self.cashMoney.text!)
        self.intMoney = Int(self.cashMoney.text!)!
        moneyLable.text =   String(format: "%.2f", money!)
        self.needCashMoney = String(format: "%.2f", money!)
        
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
    
    func exchange(_ password:String){
        
        if self.intMoney % 100  != 0 {
            self.deleteBack()
            UIAlertView(title: "温馨提示", message: "提现金额请输入100的整数倍", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let parameters:[String:Any] = ["money":self.needCashMoney,
                                       "verifySecret":password]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.exchange(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                DispatchQueue.main.async {
                    self.deleteBack()
                }
                self.navigationController?.popViewController(animated: true)
            case .fail(let res):
                DispatchQueue.main.async {
                    self.deleteBack()
                }
                UIAlertController.showConfirmPay(message: "支付密码错误") { (_) in
                    self.navigationController?.pushViewController(XPayPasswordStepOneController(), animated: true)
                }
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
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
     
        exchange(password)
        CNLog(password)
    }
    
}
