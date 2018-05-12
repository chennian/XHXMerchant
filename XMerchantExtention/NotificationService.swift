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
    fileprivate let avSpeech = AVSpeechSynthesizer()
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            let userInfo = bestAttemptContent.userInfo
            let aps = userInfo["aps"] as! NSDictionary
            let alert = aps["alert"] as! String
            startTranslattion(alert)
            contentHandler(bestAttemptContent)
        }
    }
    fileprivate func startTranslattion(_ string:String){
        //1. 创建需要合成的声音类型
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        //2. 创建合成的语音类
        let utterance = AVSpeechUtterance(string:string)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voice
        utterance.volume = 1
        utterance.postUtteranceDelay = 0.1
        utterance.pitchMultiplier = 1
        //开始播放
        avSpeech.speak(utterance)
    }
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
