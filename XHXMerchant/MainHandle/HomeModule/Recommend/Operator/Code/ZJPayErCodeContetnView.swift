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

    
    let btnClick = PublishSubject<String>()
    
    func creatErcode(){
        let mercId = "123"
        let url = "http://pay.xiaoheixiong.net/public/getOpenid_uid?mer_id=" + mercId
        let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(400), icon: nil)
        ercodeBtn.setImage(img, for: UIControlState.normal)
    }
    
    override func bindEvent() {
        ercodeBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
            let mercId = "123"
            let url = "http://pay.xiaoheixiong.net/public/getOpenid_uid?mer_id=" + mercId
//            let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(400), icon: nil)
            self.btnClick.onNext(url)
        }).disposed(by: disposeBag)
    }
   
    let ercodeBtn = UIButton()
    
    override func setupView() {
     
        addSubview(ercodeBtn)
        
        ercodeBtn.snp.makeConstraints { (make) in
           make.left.right.bottom.top.equalToSuperview()
        }
    }

}
