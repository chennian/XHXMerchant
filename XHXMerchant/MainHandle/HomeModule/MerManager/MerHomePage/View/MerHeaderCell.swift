//
//  MerHeaderCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class MerHeaderCell: SNBaseTableViewCell {
    
    var model:XMerListModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            self.merName.text = cellModel.shopName
            self.staffNum.text = "员工数量:\(cellModel.personal)"
            self.userNum.text = "会员数量\(cellModel.flow_num)"
            if cellModel.logo == ""{
                self.merHeaderImg.image = UIImage(named: "store_logo")
                self.backImg.image = UIImage(named:"store_logo")
            }else{
                self.merHeaderImg.kf.setImage(with: URL(string: cellModel.logo))
                self.backImg.kf.setImage(with: URL(string: cellModel.logo))
            }
//            createFrostBackground(img:UIImage(named: "home_earnings")!, view: self.backImg)
        }
    }
    
    let backImg = UIImageView().then{
        $0.image = UIImage(named: "")
    }
    let view  = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let merName = UILabel().then{
        $0.font = BoldFont(44)
        $0.text = "木屋烧烤"
        $0.textColor = Color(0x313131)
    }
    let userNum = UILabel().then{
        $0.font = Font(24)
        $0.text = "会员数量:23232"
        $0.textColor = Color(0x48494d)
    }
    let staffNum = UILabel().then{
        $0.font = Font(24)
        $0.text = "员工数量:23232"
        $0.textColor = Color(0x48494d)
    }
    
    let merHeaderImg  = UIImageView().then{
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = fit(10)
    }
    override func setupView() {
        contentView.addSubview(backImg)
        contentView.addSubview(view)
        view.addSubview(merName)
        view.addSubview(userNum)
        view.addSubview(staffNum)
        contentView.addSubview(merHeaderImg)
        
        let blurEffet = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffet)
        blurView.frame.size = CGSize(width: fit(750), height: fit(240))
        backImg.addSubview(blurView)
        
                
        backImg.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(240)
        }
        view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(backImg.snp.bottom)
        }
        merName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(70)
        }
        userNum.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(158)
            make.top.equalTo(merName.snp.bottom).snOffset(28)
        }
        staffNum.snp.makeConstraints { (make) in
            make.left.equalTo(userNum.snp.left).snOffset(259)
            make.top.equalTo(merName.snp.bottom).snOffset(28)
        }
        
        merHeaderImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(92)
            make.height.snEqualTo(190)
            make.width.snEqualTo(200)
        }

    }
}
extension MerHeaderCell{
    //创建毛玻璃效果的背景
    func createFrostBackground (img:UIImage,view:UIView) {
        let w = self.backImg.frame.width
        let h = self.backImg.frame.height
        let blurImageView = UIImageView(frame: CGRect(x: -w/2, y: -h/2, width: 2*w, height: 2*h))
        // let blurImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        //模糊背景是界面的4倍大小
        blurImageView.contentMode = .scaleAspectFill
        blurImageView.image = img
        //创建毛玻璃效果层
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = blurImageView.frame
        //添加毛玻璃效果层
        blurImageView.addSubview(visualEffectView)
        self.backImg.insertSubview(blurImageView, belowSubview: view)
    }
}
