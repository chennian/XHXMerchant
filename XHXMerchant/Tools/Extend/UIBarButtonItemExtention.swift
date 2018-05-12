//
//  LBBarButtonItem.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
	
	convenience init(title: String,imgName:String, fontSize: CGFloat = fit(32), target: AnyObject?, action: Selector) {
		
		let btn = UIButton()
		btn.setTitleColor(Color(0x313131), for: .normal)
		btn.setTitle(title, for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
		btn.setImage(UIImage(named: imgName), for: .normal)
		btn.addTarget(target, action: action, for: .touchUpInside)
		btn.frame = CGRect(x: 0, y: 0, width: 20, height: 16)
		self.init(customView: btn)
		
	}
	
}
