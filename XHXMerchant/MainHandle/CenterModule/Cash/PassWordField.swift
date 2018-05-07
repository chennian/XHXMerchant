//
//  PassWordField.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/3.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

protocol PassWordFieldDelegate: class {
    func inputTradePasswordFinish(tradePasswordView: PassWordField, password: String) -> Void
}

class PassWordField: SNBaseView{
    weak var delegate: PassWordFieldDelegate?

    var selfWidth:CGFloat = 0.0
    let textField = UITextField().then{
        $0.keyboardType = .numberPad
        $0.keyboardToolbar.isHidden = true
        $0.returnKeyType = .done
    }
    var textFieldText:String = ""
    
    let outLine = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
        $0.layer.borderWidth = fit(1.5)
        $0.layer.borderColor = Color(0xe5e5e5).cgColor
    }
    
    let line1 = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    let line2 = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    let line3 = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    let line4 = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    let line5 = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    
    let view1 = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.layer.cornerRadius = fit(15)
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    let view2 = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.layer.cornerRadius = fit(15)
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    let view3 = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.layer.cornerRadius = fit(15)
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    let view4 = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.layer.cornerRadius = fit(15)
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    let view5 = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.layer.cornerRadius = fit(15)
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    let view6 = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.layer.cornerRadius = fit(15)
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    override func bindEvent(){
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(oneTap(ges:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func oneTap(ges: UITapGestureRecognizer) -> Void {
        self.textField.becomeFirstResponder()
    }
    @objc func textFieldDidChange(textField: UITextField) -> Void {
        CNLog(textField.text!.count)
        switch (textField.text!.count) {
        case 0:
            self.view1.isHidden = true
            self.view2.isHidden = true
            self.view3.isHidden = true
            self.view4.isHidden = true
            self.view5.isHidden = true
            self.view6.isHidden = true
        case 1:
            self.view1.isHidden = false
            self.view2.isHidden = true
            self.view3.isHidden = true
            self.view4.isHidden = true
            self.view5.isHidden = true
            self.view6.isHidden = true
        case 2:
            self.view1.isHidden = false
            self.view2.isHidden = false
            self.view3.isHidden = true
            self.view4.isHidden = true
            self.view5.isHidden = true
            self.view6.isHidden = true
        case 3:
            self.view1.isHidden = false
            self.view2.isHidden = false
            self.view3.isHidden = false
            self.view4.isHidden = true
            self.view5.isHidden = true
            self.view6.isHidden = true
        case 4:
            self.view1.isHidden = false
            self.view2.isHidden = false
            self.view3.isHidden = false
            self.view4.isHidden = false
            self.view5.isHidden = true
            self.view6.isHidden = true
        case 5:
            self.view1.isHidden = false
            self.view2.isHidden = false
            self.view3.isHidden = false
            self.view4.isHidden = false
            self.view5.isHidden = false
            self.view6.isHidden = true
        case 6:
            self.view1.isHidden = false
            self.view2.isHidden = false
            self.view3.isHidden = false
            self.view4.isHidden = false
            self.view5.isHidden = false
            self.view6.isHidden = false
        default:
            break
        }
        
        self.textFieldText = textField.text!
        if textFieldText.count == 6 {
            self.delegate?.inputTradePasswordFinish(tradePasswordView: self, password: self.textFieldText)
        }
        
    }
    
    
    override func setupView() {
        
        selfWidth = self.width/6
        self.addSubview(outLine)
        
        self.textField.frame = CGRect.zero
        self.textField.delegate = self
        self.textField.keyboardType = .numberPad
        CNLog(self.textField.text!.count)
        self.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.addSubview(textField)

        outLine.addSubview(line1)
        outLine.addSubview(line2)
        outLine.addSubview(line3)
        outLine.addSubview(line4)
        outLine.addSubview(line5)
        
        outLine.addSubview(view1)
        outLine.addSubview(view2)
        outLine.addSubview(view3)
        outLine.addSubview(view4)
        outLine.addSubview(view5)
        outLine.addSubview(view6)

        
        outLine.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(90)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(1)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalTo(line1).snOffset(90)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(1)
        }
        line3.snp.makeConstraints { (make) in
            make.left.equalTo(line2).snOffset(90)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(1)
        }
        line4.snp.makeConstraints { (make) in
            make.left.equalTo(line3).snOffset(90)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(1)
        }
        line5.snp.makeConstraints { (make) in
            make.left.equalTo(line4).snOffset(90)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(1)
        }
        view1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(30)
        }
        view2.snp.makeConstraints { (make) in
            make.left.equalTo(view1).snOffset(90)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(30)
        }
        view3.snp.makeConstraints { (make) in
            make.left.equalTo(view2).snOffset(90)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(30)
        }
        view4.snp.makeConstraints { (make) in
            make.left.equalTo(view3).snOffset(90)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(30)
        }
        view5.snp.makeConstraints { (make) in
            make.left.equalTo(view4).snOffset(90)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(30)
        }
        view6.snp.makeConstraints { (make) in
            make.left.equalTo(view5).snOffset(90)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(30)
        }
    
    }

}
extension PassWordField:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text!.count) >= 6 && string != "" {
            return false
        }
        
        return true
        
    }

}
