//
//  NotificationService.swift
//  XMerchantExtention
//
//  Created by Mac Pro on 2018/5/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UserNotifications
import AVFoundation

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            syntheticVoice("123")
            contentHandler(bestAttemptContent)
        }
    }
    func syntheticVoice(_ string: String?) {
        //  语音合成
        let synthesizer = AVSpeechSynthesizer()
        let speechUtterance = AVSpeechUtterance(string: string ?? "")
        //设置语言类别（不能被识别，返回值为nil）
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        //设置语速快慢
        speechUtterance.rate = 0.55
        //语音合成器会生成音频
        synthesizer.speak(speechUtterance)
    }
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
