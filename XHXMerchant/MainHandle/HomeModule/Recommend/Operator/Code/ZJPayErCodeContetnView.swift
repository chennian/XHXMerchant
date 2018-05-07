//
//  ZJPayErCodeContetnView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJPayErCodeContetnView: SNBaseView {
    var icon :UIImage?
    func creatErcode(){
        let phone = XKeyChain.get(PHONE)
        if XKeyChain.get(HEADIMG) != "" {
            let url = URL(string: XKeyChain.get(HEADIMG))
            let imgData = try? Data(contentsOf: url!)
            icon = UIImage(data: imgData!)
            
        }else{
            icon = UIImage(named: "LBlogoIcon")
        }
        
        let url = "http://frontend.xiaoheixiong.net/public/recommend?phone=" + phone
        let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(400), icon: icon)
        ercodeBtn.setImage(img, for: UIControlState.normal)
    }
    
    func creatReceiveErcode(_ shopId:String){
        let url = "http://pay.xiaoheixiong.net/public/getOpenid_uid?shop_id=" + shopId
        let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(448), icon: nil)
        ercodeBtn.setImage(img, for: UIControlState.normal)
    }
    
    func creatErcodeStaff(_ shopId:String){
        let url = "http://pay.xiaoheixiong.net/public/getOpenid_uid?shop_id=" + shopId
        let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(448), icon: nil)
        ercodeBtn.setImage(img, for: UIControlState.normal)
    }
    
    let ercodeBtn = UIButton()
    
    override func setupView() {
     
        addSubview(ercodeBtn)
        
        ercodeBtn.snp.makeConstraints { (make) in
           make.left.right.bottom.top.equalToSuperview()
        }
    }

}
