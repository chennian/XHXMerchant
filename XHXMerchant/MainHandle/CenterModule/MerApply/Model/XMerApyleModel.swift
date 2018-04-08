//
//  XMerApyleModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

protocol StepOneProtocol {

    var accountName:String? { get set  }
    var legalName: String? { get set  }
    var idCard: String? { get set  }
    var emergencyContact: String? { get set  }
    var emergencyContactPhone: String? { get set  }
    var email: String? { get set  }
    var frontImage:ApplyImage? { get set }
    var backImage:ApplyImage? { get set }
}

class StepOne: NSObject,StepOneProtocol,NSCoding {
    var accountName: String?
    
    var legalName: String?
    
    var idCard: String?
    
    var emergencyContact: String?
    
    var emergencyContactPhone: String?
    
    var email: String?
    
    var frontImage: ApplyImage?
    
    var backImage: ApplyImage?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        accountName = aDecoder.decodeObject(forKey: "accountName") as? String
        legalName = aDecoder.decodeObject(forKey: "legalName") as? String
        idCard = aDecoder.decodeObject(forKey: "idCard") as? String
        emergencyContact = aDecoder.decodeObject(forKey: "emergencyContact") as? String
        emergencyContactPhone = aDecoder.decodeObject(forKey: "emergencyContactPhone") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
      
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(accountName, forKey: "accountName")
        aCoder.encode(legalName, forKey: "legalName")
        aCoder.encode(idCard, forKey: "idCard")
        aCoder.encode(emergencyContact, forKey: "emergencyContact")
        aCoder.encode(emergencyContactPhone, forKey: "emergencyContactPhone")
        aCoder.encode(email, forKey: "email")
    }
}

class ApplyModelTool {
    private static let component = "ApplyModel.LittleBlackBear"
    
    private static var path: String? {
        get {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/").appending(ApplyModelTool.component)
        }
    }
    
    static func save(model: ApplyModel) {
        guard let path = path else {
            return
        }
        let backgoundQuene = DispatchQueue(label: "LittleBlackBear.bak")
        backgoundQuene.async {
            NSKeyedArchiver.archiveRootObject(model, toFile: path)
        }
    }
    
    static func readModel() -> ApplyModel {
        var model = ApplyModel()
        guard let path = path else {
            return model
        }
        let backgoundQuene = DispatchQueue(label: "LittleBlackBear.bak")
        backgoundQuene.async {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? ApplyModel ?? model
        }
        
        return model
    }
    
    static func removeModel(){
        guard path != nil , FileManager.default.fileExists(atPath: path!) else {
            return
        }
        do {
            
            try FileManager.default.removeItem(atPath: path!)
            
        } catch let error {
            CNLog(error)
        }
    }
    
    
}
class ApplyModel:NSObject, NSCoding {
    private static let applySelfModelKey = "applySelfModelKey"
    
    static let shareApplyModel = ApplyModelTool.readModel()
    
    
    var applySelfModel = ApplySelfModel()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let applySelfModel = aDecoder.decodeObject(forKey: ApplyModel.applySelfModelKey) as? ApplySelfModel else {
            return nil
        }
        
        self.applySelfModel = applySelfModel
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(applySelfModel, forKey: ApplyModel.applySelfModelKey)
    }
    
}


class ApplySelfModel: NSObject, NSCoding {
    
    var stepOne = StepOne()
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let stepOne = aDecoder.decodeObject(forKey: "stepOne") as? StepOne else {
            return nil
        }
        self.stepOne = stepOne
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stepOne, forKey: "stepOne")
    }
}

class ApplyImage: NSObject, NSCoding {
    var image: UIImage
    var path: String
    init(image: UIImage, path: String) {
        self.image = image
        self.path = path
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        image = aDecoder.decodeObject(forKey: "image") as! UIImage
        path = aDecoder.decodeObject(forKey: "path") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: "image")
        aCoder.encode(path, forKey: "path")
    }
}
