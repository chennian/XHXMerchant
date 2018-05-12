//
//  XRecmdCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XRecmdCell: SNBaseTableViewCell {
    
    var clickEvent:((_ para:Int)->())?

    let img = UIImageView().then{
        $0.image = UIImage(named: "above")
    }
    
    let viewOne = UIView().then{
        $0.backgroundColor = Color(0x352e5d)
    }
    
    let codeImage = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    
    let ercodeView = ZJPayErCodeContetnView().then({
        $0.layer.cornerRadius = fit(10)
        
    })
    let notice = UILabel().then{
        $0.text = "长按保存二维码"
        $0.textColor = Color(0xffffff)
        $0.font = Font(30)
    }
    
    let recmdMerBtn = UIButton().then{
        $0.setTitle("推荐商家", for: .normal)
        $0.setTitleColor(Color(0x333333), for: .normal)
        $0.backgroundColor = Color(0xffe402)
        $0.layer.cornerRadius = fit(4)
        $0.titleLabel?.font = Font(32)
        $0.tag = 1
    }
    
    let recmdOperBtn = UIButton().then{
        $0.setTitle("推荐创业家", for: .normal)
        $0.setTitleColor(Color(0x333333), for: .normal)
        $0.backgroundColor = Color(0xffe402)
        $0.layer.cornerRadius = fit(4)
        $0.titleLabel?.font = Font(32)
        $0.tag = 2
    }
    
    let myRcmd = UILabel().then{
        $0.text = "我的推荐人:\(XKeyChain.get(PARENTPHONE))"
        $0.textColor = Color(0x9488d6)
        $0.font = Font(24)
        $0.textAlignment = .center
    }
    
    func bindEvent(){
        recmdMerBtn.addTarget(self, action: #selector(recmdMer), for: .touchUpInside)
        recmdOperBtn.addTarget(self, action: #selector(recmdMer), for: .touchUpInside)
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longTap.minimumPressDuration = 1.5
        codeImage.addGestureRecognizer(longTap)
    }
    
    
    @objc func longPress(){
        let phone = XKeyChain.get(PHONE)
        let icon:UIImage?
        if XKeyChain.get(HEADIMG) != "" {
            let url = URL(string: XKeyChain.get(HEADIMG))
            let imgData = try? Data(contentsOf: url!)
            icon = UIImage(data: imgData!)
            
        }else{
            icon = UIImage(named: "LBlogoIcon")
        }
        
        let url = "http://frontend.xiaoheixiong.net/public/recommend?phone=" + phone
        let image = ErCodeTool.creatQRCodeImage(text: url, size: fit(1000), icon: icon)
        
        UIAlertController.showConfirm(message: "是否保存二维码") { (_) in
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
            SZHUD("保存失败", type: .error, callBack: nil)
        }else{
            SZHUD("保存成功", type: .success, callBack: nil)
        }
    }
    
    @objc func recmdMer(_ btn:UIButton){
        guard let action = clickEvent else {
            return
        }
        action(btn.tag)
    }
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(viewOne)
        viewOne.addSubview(codeImage)
        viewOne.addSubview(notice)
        viewOne.addSubview(recmdMerBtn)
        viewOne.addSubview(recmdOperBtn)
        viewOne.addSubview(myRcmd)
        codeImage.addSubview(ercodeView)

        bindEvent()
        self.ercodeView.creatErcode()

        img.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(401)
        }
        viewOne.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(img.snp.bottom)
        }
        
        codeImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(27)
            make.width.height.snEqualTo(330)
        }
        
        ercodeView.snp.makeConstraints { (make) in
            make.centerX.equalTo(codeImage.snp.centerX)
            make.centerY.equalTo(codeImage.snp.centerY)
            make.width.height.snEqualTo(314)
        }
        
        notice.snp.makeConstraints { (make) in
            make.top.equalTo(codeImage.snp.bottom).snOffset(24)
            make.centerX.equalTo(codeImage.snp.centerX)
        }
        
        recmdMerBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(codeImage.snp.centerX)
            make.top.equalTo(codeImage.snp.bottom).snOffset(130)
            make.height.snEqualTo(90)
            make.width.snEqualTo(600)
        }
        
        recmdOperBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(recmdMerBtn.snp.centerX)
            make.top.equalTo(recmdMerBtn.snp.bottom).snOffset(36)
            make.height.snEqualTo(90)
            make.width.snEqualTo(600)
        }
        
        myRcmd.snp.makeConstraints { (make) in
            make.top.equalTo(recmdOperBtn.snp.bottom).snOffset(51)
            make.centerX.equalTo(recmdOperBtn.snp.centerX)
        }
    }


}
