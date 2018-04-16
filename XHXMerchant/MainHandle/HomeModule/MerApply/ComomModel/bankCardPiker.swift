//
//  bankCardPiker.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
class bankCardPiker:UIView {
    
    var selectValue:((_ name:String,_ id:String)->())?

    let disposeBag = DisposeBag()

    var jsonArr:JSON = []
    
    var bank_id:[String] = []
    
    var bankName:[String] = []
    
    var name:String    = ""
    var id  :String    = ""


    fileprivate lazy var bankPiker: UIPickerView! = { [unowned self] in
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
        }()
    
    fileprivate func loadBankData(){
        SNRequestJson(requestType: API.bankList).subscribe(onNext: { [unowned self] (res) in
            switch res{
            case .success(let json):
                self.jsonArr = json["data"]
                
                for (_,subJson):(String,JSON) in self.jsonArr {
                    self.bankName.append(subJson["bankName"].string!)
                    self.bank_id.append(subJson["bankId"].string!)
                }
            default:
                break
            }
            
        }).disposed(by: disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bankPiker)
        loadBankData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension bankCardPiker:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bankName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bankName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.name = self.bankName[row]
        self.id = self.bank_id[row]
        
        guard let selectVal = selectValue else {
            return
        }
        selectVal(self.name,self.id)
    }
    
    
}
