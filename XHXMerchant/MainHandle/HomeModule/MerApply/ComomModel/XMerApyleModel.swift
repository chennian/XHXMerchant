//
//  XMerApyleModel.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

protocol StepOneProtocol {

    var registName:String? { get set  }
    var principal: String? { get set  }
    var principalPhone: String? { get set  }
    var idCard: String? { get set  }
    var validity: String? { get set  }
    var frontImage:ApplyImage? { get set }
    var backImage:ApplyImage? { get set }
}

class StepOne: NSObject,StepOneProtocol,NSCoding {
    var registName: String?
    
    var principal: String?
    
    var principalPhone: String?
    
    var idCard: String?
    
    var validity: String?
        
    var frontImage: ApplyImage?
    
    var backImage: ApplyImage?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        registName = aDecoder.decodeObject(forKey: "registName") as? String
        principal = aDecoder.decodeObject(forKey: "principal") as? String
        principalPhone = aDecoder.decodeObject(forKey: "principalPhone") as? String
        idCard = aDecoder.decodeObject(forKey: "idCard") as? String
        validity = aDecoder.decodeObject(forKey: "validity") as? String
      
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(registName, forKey: "registName")
        aCoder.encode(principal, forKey: "principal")
        aCoder.encode(principalPhone, forKey: "principalPhone")
        aCoder.encode(idCard, forKey: "idCard")
        aCoder.encode(validity, forKey: "validity")
    }
}


protocol StepTwoProtocol {
    
    var merShortName:String? { get set  }
    var licenseName: String? { get set  }
    var licenseTerm: String? { get set  }
    var codeNum: String? { get set  }
    var area: String? { get set  }
    var detailAddress: String? { get set  }
    var industryType: String? { get set  }
    
    var LicenseImage:ApplyImage? { get set }
    var doorImage:ApplyImage? { get set }
    var checkstand:ApplyImage? { get set }
    var indoorImage:ApplyImage? { get set }
}

class StepTwo: NSObject,StepTwoProtocol,NSCoding {
    var merShortName: String?
    var licenseName: String?
    var licenseTerm: String?
    var codeNum: String?
    var area: String?
    var detailAddress: String?
    var industryType: String?

    var LicenseImage:ApplyImage?
    var doorImage:ApplyImage?
    var checkstand:ApplyImage?
    var indoorImage:ApplyImage?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        merShortName = aDecoder.decodeObject(forKey: "merShortName") as? String
        licenseName = aDecoder.decodeObject(forKey: "licenseName") as? String
        licenseTerm = aDecoder.decodeObject(forKey: "licenseTerm") as? String
        codeNum = aDecoder.decodeObject(forKey: "codeNum") as? String
        area = aDecoder.decodeObject(forKey: "area") as? String
        detailAddress = aDecoder.decodeObject(forKey: "detailAddress") as? String
        industryType = aDecoder.decodeObject(forKey: "industryType") as? String

        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(merShortName, forKey: "merShortName")
        aCoder.encode(licenseName, forKey: "licenseName")
        aCoder.encode(licenseTerm, forKey: "licenseTerm")
        aCoder.encode(codeNum, forKey: "codeNum")
        aCoder.encode(area, forKey: "area")
        aCoder.encode(detailAddress, forKey: "detailAddress")
        aCoder.encode(industryType, forKey: "industryType")

    }
}

protocol StepThreeProtocol {
    
    var openBankAccount:String? { get set  }
    var openBank: String? { get set  }
    var openBankAddress: String? { get set  }
    var branchnName: String? { get set  }
    var openbankName: String? { get set  }
    var leftPhone: String? { get set  }
    
    var permitCard:ApplyImage? { get set }
    
    
    var privateBankAccount: String?{ get set  }
    var privateBank: String?{ get set  }
    var privateBankAddress: String?{ get set  }
    var branchName: String?{ get set  }
    var privatebankName: String?{ get set  }
    var leftMobile: String?{ get set  }
    
    var frontCard:ApplyImage?{ get set  }
}

class StepThree: NSObject,StepThreeProtocol,NSCoding {
    //对公账户
    var openBankAccount: String?
    var openBank: String?
    var openBankAddress: String?
    var branchnName: String?
    var openbankName: String?
    var leftPhone: String?
    
    var permitCard:ApplyImage?
    
    //对私账户
    var privateBankAccount: String?
    var privateBank: String?
    var privateBankAddress: String?
    var branchName: String?
    var privatebankName: String?
    var leftMobile: String?
    
    var frontCard:ApplyImage?
    

    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        openBankAccount = aDecoder.decodeObject(forKey: "openBankAccount") as? String
        openBank = aDecoder.decodeObject(forKey: "openBank") as? String
        openBankAddress = aDecoder.decodeObject(forKey: "openBankAddress") as? String
        branchnName = aDecoder.decodeObject(forKey: "branchnName") as? String
        openbankName = aDecoder.decodeObject(forKey: "openbankName") as? String
        leftPhone = aDecoder.decodeObject(forKey: "leftPhone") as? String
        
        privateBankAccount = aDecoder.decodeObject(forKey: "privateBankAccount") as? String
        privateBank = aDecoder.decodeObject(forKey: "privateBank") as? String
        privateBankAddress = aDecoder.decodeObject(forKey: "privateBankAddress") as? String
        branchName = aDecoder.decodeObject(forKey: "branchName") as? String
        privatebankName = aDecoder.decodeObject(forKey: "privatebankName") as? String
        leftMobile = aDecoder.decodeObject(forKey: "leftMobile") as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(privateBankAccount, forKey: "privateBankAccount")
        aCoder.encode(privateBank, forKey: "privateBank")
        aCoder.encode(privateBankAddress, forKey: "privateBankAddress")
        aCoder.encode(branchName, forKey: "branchName")
        aCoder.encode(privatebankName, forKey: "privatebankName")
        aCoder.encode(leftMobile, forKey: "leftMobile")
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
    var stepTwo = StepTwo()
    var stepThree = StepThree()

    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let stepOne = aDecoder.decodeObject(forKey: "stepOne") as? StepOne else {
            return nil
        }
        self.stepOne = stepOne
        guard let stepTwo = aDecoder.decodeObject(forKey: "stepTwo") as? StepTwo else {
            return nil
        }
        self.stepTwo = stepTwo
        guard let stepThree = aDecoder.decodeObject(forKey: "stepThree") as? StepThree else {
            return nil
        }
        self.stepThree = stepThree
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stepOne, forKey: "stepOne")
        aCoder.encode(stepTwo, forKey: "stepTwo")
        aCoder.encode(stepThree, forKey: "stepThree")
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
