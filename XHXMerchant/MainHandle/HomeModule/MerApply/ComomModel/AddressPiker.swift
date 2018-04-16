//
//  AddressPiker.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddressPiker: UIView {
    var selectValue:((_ all:String,_ province:String,_ city:String,_ county:String)->())?
    
    var provinceArray:[String] = []
    var cityArray:[String] = []
    var countyArray:[String] = []
    
    var provinceString:String = ""
    var cityString:String = ""
    var countyString:String = ""
    
    var jsonArr:JSON = []
    
    var counrentRow:Int = 0
    
    fileprivate lazy var addressPiker: UIPickerView! = { [unowned self] in
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
        }()
    fileprivate func setSubView(){
        
        addSubview(addressPiker)
    }

    fileprivate func loadAddressData(){
        let JsonPath = Bundle.main.path(forResource: "province_data", ofType: "json")
        let url = URL(fileURLWithPath: JsonPath!)
        do {
            let data = try Data(contentsOf: url)
            jsonArr = JSON(data: data)
            
            for (_,subJson):(String,JSON) in jsonArr {
                provinceArray.append(subJson["name"].string!)
                
            }
            for (_,subJson):(String,JSON) in jsonArr[0]["sub"] {
                cityArray.append(subJson["name"].string!)
                
            }
            for (_,subJson):(String,JSON) in jsonArr[0]["sub"][0]["sub"] {
                countyArray.append(subJson["name"].string!)
            }
            
        } catch let error as Error? {
            print("读取本地数据出现错误!",error as Any)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        loadAddressData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension AddressPiker:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font(26)
        label.textColor = Color(0x313131)
        label.text = pickerView.delegate?.pickerView!(pickerView, titleForRow: row, forComponent: component)
        label.frame = CGRect(x: 0, y: 0, width: fit(240), height: fit(30))
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        CNLog(provinceArray)
        if (component == 0) {
            return provinceArray.count;
        }
        if (component==1) {
            return  cityArray.count;
        }
        if (component==2) {
            return countyArray.count;
        }
        return 0;
    }
    
    //设置列宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return fit(240)
        }else if component == 1{
            return fit(240)
        }else{
            return fit(240)
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int)
        -> CGFloat {
            return fit(80)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return provinceArray[row];
        }
        if component == 1 {
            return cityArray[row];
        }
        if component == 2 {
            return countyArray[row];
        }
        return nil;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        provinceString = provinceArray[0]
        cityString = cityArray[0]
        if component == 0 {
            cityArray.removeAll()
            countyArray.removeAll()
            for (_,subJson):(String,JSON) in jsonArr[row]["sub"] {
                cityArray.append(subJson["name"].string!)
            }
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: false)
            
            for (_,subJson):(String,JSON) in jsonArr[row]["sub"][0]["sub"] {
                countyArray.append(subJson["name"].string!)
            }
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: false)
            
            self.counrentRow = row
            
            provinceString = provinceArray[row]
            cityString = cityArray[0]
            countyString = countyArray[0]
        }
        if component == 1 {
            countyArray.removeAll()
            for (_,subJson):(String,JSON) in jsonArr[counrentRow]["sub"][row]["sub"] {
                countyArray.append(subJson["name"].string!)
            }
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: false)
            cityString = cityArray[row]
            countyString = countyArray[0]
        }
        if component == 2 {
            countyString = countyArray[row]
        }
        guard let selectVal = selectValue else {
            return
        }
        selectVal(provinceString + cityString + countyString,provinceString,cityString,countyString)

    }
}


