//
//  XAboutBearController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import WebKit
class XAboutBearController: SNBaseViewController {

    let web = WKWebView().then{
        $0.backgroundColor = .clear
    }
    
    override func setupView() {
        self.title = "小黑熊网络"
        self.view.addSubview(web)
        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string: "https://mp.weixin.qq.com/s/bxjt0rNSAykllBwgiNKQjg")
        let webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.navigationDelegate = self
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view.addSubview(webView)
        
    }

}
extension XAboutBearController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        SZHUD("加载中...", type: .loading, callBack: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SZHUDDismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SZHUD("加载失败", type:.error, callBack: nil)
    }
}

