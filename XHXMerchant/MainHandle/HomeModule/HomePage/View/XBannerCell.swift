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
    var model :[BannerModel] = []
//    var models : [BannerModel] = []{
//        didSet{
//            let arry = models.map({return $0.site_url})
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
        loadBannerData()
    }
    
    fileprivate func loadBannerData(){
        SNRequest(requestType: API.bannar, modelType: [BannerModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
                let dataArray = self.model.map({return $0.site_url + "@2x.png"})
                CNLog(dataArray)
                self.sdScrollBanner.imageURLStringsGroup = dataArray
            case .fail(let code,let msg):
                CNLog(msg)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    lazy var sdScrollBanner : SDCycleScrollView = {
        let obj = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: UIImage())
        obj?.bannerImageViewContentMode = .scaleAspectFill
        obj?.pageDotColor = UIColor(white: 1.0, alpha: 0.6)
        obj?.currentPageDotColor = .white
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
