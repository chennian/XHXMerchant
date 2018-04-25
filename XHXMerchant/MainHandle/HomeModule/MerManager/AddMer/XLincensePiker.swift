//
//  XLincensePiker.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/24.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
class XLincensePiker: UIView {
    
    var selectValue:((_ name:String)->())?
    
    let disposeBag = DisposeBag()
    
    var jsonArr:JSON = []
    
    var lincenseName:[String] = []
    
    var name:String    = ""
    
    
    fileprivate lazy var lincensePiker: UIPickerView! = { [unowned self] in
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
        }()
    
    fileprivate func loadLicenseData(){
        SNRequestJson(requestType: API.getLicenseList).subscribe(onNext: { [unowned self] (res) in
            switch res{
            case .success(let json):
                self.jsonArr = json["data"]
                if !self.jsonArr.isEmpty {
                    for (_,subJson):(String,JSON) in self.jsonArr {
                        self.lincenseName.append(subJson["entname"].string!)
                    }
                }else{
                    self.lincenseName.append("暂无营业执照")
                }
               
            default:
                break
            }
            
        }).disposed(by: disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lincensePiker)
        loadLicenseData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension XLincensePiker:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lincenseName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lincenseName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.name = self.lincenseName[row]
        
        guard let selectVal = selectValue else {
            return
        }
        selectVal(self.name)
    }
    
    
}
