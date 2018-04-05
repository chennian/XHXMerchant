//
//  XBannerCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SDCycleScrollView
class XBannerCell: SNBaseTableViewCell {
    
    //    let didSelectPub = PublishSubject<BMPageJumpType>()
    //    var models : [BMHomePageBannerModel] = []{
    //        didSet{
    //            let arry = models.map({return $0.logo})
    //            sdScrollBanner.imageURLStringsGroup = arry
    //        }
    //    }
    
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
        obj?.imageURLStringsGroup = ["https://img4.duitang.com/uploads/item/201504/14/20150414H5313_NesGP.jpeg","https://img4.duitang.com/uploads/item/201504/14/20150414H5313_NesGP.jpeg","https://img4.duitang.com/uploads/item/201504/14/20150414H5313_NesGP.jpeg"]
        return obj!
    }()
    
    
}
extension XBannerCell : SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
        //        let model = models[index]
        
        
        //        let type : BMPageJumpType = PageJumpTypeType(fast_way: model.fast_way, jump_id: model.jump_id, site_url: model.site_url)
        //        self.didSelectPub.onNext(type)
        
    }
}
