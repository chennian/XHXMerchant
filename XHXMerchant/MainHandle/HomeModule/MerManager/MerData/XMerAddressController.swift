//
//  XMerAddressController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/20.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerAddressController: SNBaseViewController {
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMerAddressCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    
    let service   = BMKLocationService()
    let poiSearch = BMKPoiSearch()
    let option = BMKNearbySearchOption()
    var key:String = "店铺"
    var dataArray:[BMKPoiInfo] = []
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    
    let searchField = UITextField().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.placeholder = "请输入你想搜索的位置"
    }
    
   
    
    func setup(){
        
        self.title = "附近位置"
        self.view.backgroundColor = Color(0xf5f5f5)
        self.view.addSubview(tableView)
        self.view.addSubview(mainView)
        mainView.addSubview(searchField)
        mainView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(100)
        }
        searchField.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().snOffset(60)
            make.right.equalToSuperview().snOffset(-60)
            make.height.snEqualTo(60)
        }
        let searchImg  = UIImageView()
        searchImg.image = UIImage(named: "search_site")
        searchImg.size = CGSize(width: fit(27), height: fit(27))
        
        searchField.rightView = searchImg
        searchField.rightViewMode = .always
        searchField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom).snOffset(20)
        }
        
    }
    func setMapService(){

        service.delegate = self
        service.startUserLocationService()
        SZHUD("加载中...", type:.loading, callBack: nil)
      
    }
    override func setupView() {
        setup()
        setMapService()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        poiSearch.delegate = nil
    }

}
extension XMerAddressController:BMKPoiSearchDelegate,BMKLocationServiceDelegate{
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        if errorCode == BMK_SEARCH_NO_ERROR {
            self.dataArray.removeAll()
            //在此处理正常结果
            CNLog(poiResult.poiInfoList)
            for info in poiResult.poiInfoList{
                self.dataArray.append(info as! BMKPoiInfo)
            }
            CNLog(self.dataArray)
            self.tableView.reloadData()
            SZHUDDismiss()
            
        }else{
            SZHUD("未找到结果", type:.error, callBack: nil)
        }
    }
    func didUpdate(_ userLocation: BMKUserLocation!) {
        poiSearch.delegate = self
        option.pageIndex = 0
        option.pageCapacity =  20
        option.radius = 1000
        option.keyword = self.key
        CNLog(self.key)
        option.location = userLocation.location.coordinate
        
        let bool = poiSearch.poiSearchNear(by: option)
        if bool {
            CNLog("成功")
        }else{
            CNLog("失败")
        }
    }
}
extension XMerAddressController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XMerAddressCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = self.dataArray[indexPath.row]
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(120)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.searchField.text = self.dataArray[indexPath.row].address
        let NotifMycation = NSNotification.Name(rawValue:"shopAddress")
        NotificationCenter.default.post(name: NotifMycation, object: self.searchField.text!)
        self.navigationController?.popViewController(animated: true)
    }
}
extension XMerAddressController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.key = self.searchField.text!
        service.startUserLocationService()
        SZHUD("加载中...", type:.loading, callBack: nil)
    }
    
}
