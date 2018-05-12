//
//  XGoodBannerCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SDCycleScrollView
class XGoodBannerCell:  SNBaseTableViewCell {
    var banner : String = ""{
        didSet{
            let array = banner.components(separatedBy: "|")
            sdScrollBanner.imageURLStringsGroup = array
        }
    }
    
    override func setupView() {
        hidLine()
        contentView.addSubview(sdScrollBanner)
        sdScrollBanner.backgroundColor = .gray
        sdScrollBanner.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    

    lazy var sdScrollBanner : SDCycleScrollView = {
        let obj = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: UIImage())
        obj?.bannerImageViewContentMode = .scaleAspectFill
        obj?.pageDotColor = UIColor(white: 1.0, alpha: 0.6)
        obj?.currentPageDotColor = .white
        return obj!
    }()
    
    
}
extension XGoodBannerCell : SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}
