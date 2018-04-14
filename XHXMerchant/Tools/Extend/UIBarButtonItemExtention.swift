//
//  LBBarButtonItem.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
	
	convenience init(title: String,imgName:String, fontSize: CGFloat = fit(30), target: AnyObject?, action: Selector) {
		
		let btn = UIButton()
		btn.setTitleColor(Color(0x313131), for: .normal)
		btn.setTitle(title, for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
		btn.setImage(UIImage(named: imgName), for: .normal)
		btn.setImage(UIImage(named: imgName), for: .highlighted)
		btn.addTarget(target, action: action, for: .touchUpInside)
		btn.frame = CGRect(x: 0, y: 0, width: 8, height: 16)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-180))
		self.init(customView: btn)
		
	}
	
}
