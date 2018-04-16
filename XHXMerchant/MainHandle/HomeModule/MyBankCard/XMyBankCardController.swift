//
//  XMyBankCardController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMyBankCardController: SNBaseViewController {
    
    var model :[BankCardModel] = []

    var bank:String = ""
    var name:String = ""
    var bankNum:String = ""
    var phone:String = ""


    var bankCardImg = UIView().then{
        $0.layer.cornerRadius = fit(10)
    }
    
    let notice = UILabel().then{
        $0.text = "注：此银行卡用于分润收款"
        $0.font = Font(24)
        $0.textColor = Color(0x6c6c6c)
    }
    var  bankName = UILabel().then{
        $0.text = "招商银行"
        $0.font = Font(44)
        $0.textColor = Color(0xfffff)
    }
    var cardholder = UILabel().then{
        $0.text = "姓名：尤泽钦"
        $0.font = Font(28)
        $0.textColor = Color(0xfffff)
    }
    var cardNum = UILabel().then{
        $0.text = "银行卡号：475******3047"
        $0.font = Font(28)
        $0.textColor = Color(0xfffff)
    }
    @objc func tapOne(){
        let vc =    XUploadBankController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func loadBankData(){
        SNRequest(requestType: API.myBankCard, modelType: [BankCardModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                CNLog(models)
                self.model = models
                if self.model.isEmpty {
                    DispatchQueue.main.async {
                      self.bankCardImg.isHidden = true
                        self.notice.text = "                                      暂未绑定银行卡"
                    }
                }else{
                    self.bank = self.model.map({return $0.bank_name})[0]
                    self.name = self.model.map({return $0.real_name})[0]
                    self.bankNum = self.model.map({return $0.bank_num})[0]
                    self.phone = self.model.map({return $0.phone})[0]
                    
                    CNLog(self.bank + self.name + self.bankNum)
                    DispatchQueue.main.async {
                        self.bankName.text = self.bank
                        self.cardholder.text = "姓名：\(self.name)"
                        self.cardNum.text = "银行卡号：\(self.bankNum)"
                    }
                }
             

            case .fail(_ ,let msg):
              SZHUD(msg! , type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)

    }

    func setUpRightBar(){
        let button = UIButton(frame:CGRect(x:0, y:0, width:50, height:30))
        button.setTitle("添加", for: UIControlState.normal)
        button.setTitleColor(Color(0x313131), for: UIControlState.normal)
        button.titleLabel?.font = Font(30)
        button.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem=item
    }
    @objc func submit(){
        if model.isEmpty {
            self.navigationController?.pushViewController(XUploadBankController(), animated: true)
        }else{
            SZHUD("只能绑定一张银行卡", type: .info, callBack: nil)
        }
    }
    
    func setUI(){
        self.title = "我的银行卡"
        bankCardImg.frame  = CGRect(x: fit(30), y: fit(66), width: fit(690), height: fit(209))
        let gradientLayer = CAGradientLayer().shadowLayer()
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOne))
//        bankCardImg.addGestureRecognizer(tapGesture)
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: fit(690), height: fit(209))
        gradientLayer.cornerRadius = fit(10)
        bankCardImg.layer.insertSublayer(gradientLayer, at:0)
        
        self.view.addSubview(bankCardImg)
        self.view.addSubview(notice)
        bankCardImg.addSubview(bankName)
        bankCardImg.addSubview(cardholder)
        bankCardImg.addSubview(cardNum)
    
 
        
        notice.snp.makeConstraints { (make) in
            make.left.equalTo(bankCardImg.snp.left)
            make.top.equalTo(bankCardImg.snp.bottom).snOffset(23)
        }
        bankName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(25)
            make.top.equalToSuperview().snOffset(53)
        }
        cardholder.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-27)
            make.centerY.equalTo(bankName.snp.centerY)
        }
        cardNum.snp.makeConstraints { (make) in
            make.left.equalTo(bankName.snp.left)
            make.top.equalTo(bankName.snp.bottom).snOffset(38)
        }
        
    
    }

    
    override func setupView() {
        loadBankData()
        setUI()
        setUpRightBar()
    }
}

extension CAGradientLayer {
    
    func shadowLayer() -> CAGradientLayer {
        
        let gradientColors = [Color(0xfd4f02).cgColor,Color(0xff7f02).cgColor]
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        self.colors = gradientColors
        self.locations = gradientLocations
        
        //设置渲染的起始结束位置（横向渐变）
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        
        return self
    }
}
