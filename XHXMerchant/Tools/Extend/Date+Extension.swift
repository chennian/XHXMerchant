//
//  Date+Extension.swift
//  BXFractionLink
//
//  Created by 蘇崢 on 2017/8/3.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

extension Date{

	static func timeAgoSinceDate(_ date: Date, numericDates: Bool) -> String {
	
		let calendar = Calendar.current
		let now = Date()
		let earliest = (now as NSDate).earlierDate(date)
		let latest = (earliest == now) ? date : now
		let components:DateComponents = (calendar as NSCalendar).components([
			NSCalendar.Unit.minute,
			NSCalendar.Unit.hour,
			NSCalendar.Unit.day,
			NSCalendar.Unit.weekOfYear,
			NSCalendar.Unit.month,
			NSCalendar.Unit.year,
			NSCalendar.Unit.second
			], from: earliest, to: latest, options: NSCalendar.Options())
		
		if (components.year! >= 2) {
			return "\(components.year!)年前"

		} else if (components.year! >= 1){
			if (numericDates){
				return "1 年前"
			} else {
				return "去年"
			}
		} else if (components.month! >= 2) {
			return "\(components.month!)月前"
		} else if (components.month! >= 1){
			if (numericDates){
				return "1 个月前"
			} else {
				return "上个月"
			}
		} else if (components.weekOfYear! >= 2) {
			return "\(components.weekOfYear!)周前"

		} else if (components.weekOfYear! >= 1){
			if (numericDates){
				return "1 周前"
			} else {
				return "上一周"
			}
		} else if (components.day! >= 2) {
			return "\(components.day!)天前"

		} else if (components.day! >= 1){
			if (numericDates){
				return "1 天前"
			} else {
				return "昨天"
			}
		} else if (components.hour! >= 2) {
			return "\(components.hour!)小时前"
		} else if (components.hour! >= 1){
			return "1 小时前"
		} else if (components.minute! >= 2) {
			return "\(components.minute!)分钟前"
		}
		else if (components.minute! >= 1){
			return "1 分钟前"
		} else if (components.second! >= 3) {
			return "\(components.second!)秒前"

		} else {
			return "刚刚"
		}
	}

	
}
