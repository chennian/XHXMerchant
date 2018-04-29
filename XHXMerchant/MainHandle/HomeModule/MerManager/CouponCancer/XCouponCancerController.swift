//
//  XCouponCancerController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/29.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import AVFoundation

let kMargin = 35
let kBorderW = 140
let scanViewW = UIScreen.main.bounds.width - CGFloat(kMargin * 2)
let scanViewH = UIScreen.main.bounds.width - CGFloat(kMargin * 2)

class XCouponCancerController:  SNBaseViewController {
    
    var scanView: UIView = UIView().then{
        $0.backgroundColor = .clear
    }
    var scanImageView: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "sweep_bg_line.png")
    }
    var session = AVCaptureSession()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetAnimatinon()
    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "手动输入", imgName:"", target: self, action: #selector(input))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc func input(){
        self.navigationController?.pushViewController(XInputCouponController(), animated: true)
    }
    override func setupView() {
        self.title = "扫一扫"
        view.clipsToBounds = true
        setNavigationBar()
//        setupMaskView()
        setupScanView()
        scaning()
        NotificationCenter.default.addObserver(self, selector: #selector(resetAnimatinon), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 整体遮罩设置fit(-216)
    fileprivate func setupMaskView() {
        let maskView = UIView(frame: CGRect(x: -(view.bounds.height - view.bounds.width) / 2, y: -fit(216), width: view.bounds.height, height: view.bounds.height))
        maskView.layer.borderWidth = fit(118)

        maskView.layer.borderColor = ColorRGBA(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        
        view.addSubview(maskView)

    }
    
    /// 扫描区域设置
    fileprivate func setupScanView() {
        scanView.clipsToBounds = true
        view.addSubview(scanView)
        scanView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().snOffset(118)
            make.right.equalToSuperview().snOffset(-118)
            make.top.equalToSuperview().snOffset(195)
            make.bottom.equalToSuperview().snOffset(-499)
        })
        
        let topLeft = UIButton().then{
            $0.setImage(UIImage(named:"sweep_kuangupperleft.png"), for: .normal)
        }
        scanView.addSubview(topLeft)
        topLeft.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.height.width.snEqualTo(18)
        }
        
        let topRight = UIButton().then{
            $0.setImage(UIImage(named:"sweep_kuangupperright.png"), for: .normal)
        }
        scanView.addSubview(topRight)
        topRight.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.height.width.snEqualTo(18)
        }
        let bottomLeft = UIButton().then{
            $0.setImage(UIImage(named: "sweep_kuangdownleft.png"), for: .normal)
        }
        scanView.addSubview(bottomLeft)
        bottomLeft.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.width.snEqualTo(18)
        }
        let bottomRight = UIButton().then{
            $0.setImage(UIImage(named: "sweep_kuangdownright.png"), for: .normal)
        }
        scanView.addSubview(bottomRight)
        bottomRight.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.width.snEqualTo(18)
        }
    }
    
    
    /// 开始扫描
    fileprivate func scaning() {
        
        //获取摄像设备
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            //创建输入流
            let input = try AVCaptureDeviceInput.init(device: device!)
            //创建输出流
            let output = AVCaptureMetadataOutput()
            output.rectOfInterest = CGRect(x: 0.1, y: 0, width: 0.9, height: 1)
            //设置代理,在主线程刷新
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //初始化链接对象 / 高质量采集率
            session.canSetSessionPreset(AVCaptureSession.Preset.high)
            session.addInput(input)
            session.addOutput(output)
            
            //在上面三行之后写下面代码,不然报错如下:Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[AVCaptureMetadataOutput setMetadataObjectTypes:] Unsupported type found - use -availableMetadataObjectTypes'
            //http://stackoverflow.com/questions/31063846/avcapturemetadataoutput-setmetadataobjecttypes-unsupported-type-found
            //设置扫码支持的编码格式
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code128]
            
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            layer.frame = view.layer.bounds
            view.layer.insertSublayer(layer, at: 0)
            //开始捕捉
            session.startRunning()
            
        } catch let error as NSError  {
            print("errorInfo\(error.domain)")
        }
    }
    
    ///重置动画
    @objc fileprivate func resetAnimatinon() {
        let anim = scanImageView.layer.animation(forKey: "translationAnimation")
        if (anim != nil) {
            //将动画的时间偏移量作为暂停时的时间点
            let pauseTime = scanImageView.layer.timeOffset
            //根据媒体时间计算出准确的启动时间,对之前暂停动画的时间进行修正
            let beginTime = CACurrentMediaTime() - pauseTime
            ///便宜时间清零
            scanImageView.layer.timeOffset = 0.0
            //设置动画开始时间
            scanImageView.layer.beginTime = beginTime
            scanImageView.layer.speed = 1.1
        } else {
            
//            let scanImageViewH = fit(514)
            let scanViewH = view.bounds.width - fit(118)*2
//            let scanImageViewW = scanView.bounds.width
            
//            scanImageView.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW), height: scanImageViewH)
            let scanAnim = CABasicAnimation()
            scanAnim.keyPath = "transform.translation.y"
            scanAnim.byValue = [scanViewH]
            scanAnim.duration = 1.8
            scanAnim.repeatCount = MAXFLOAT
            scanImageView.layer.add(scanAnim, forKey: "translationAnimation")
            scanView.addSubview(scanImageView)
            scanImageView.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalToSuperview()
            }
        }
    }
    func getData(_ para:String){
        SNRequest(requestType: API.getUserMiaoMiaoDetal(code:para), modelType: [CouponModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                let vc = XCouponController()
                vc.model = models[0]
                vc.code = para
                self.navigationController?.pushViewController(vc, animated: true)
            case .fail(let code,let msg):
                SZHUD(msg ?? "请求数据失败", type: .error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}

extension XCouponCancerController:AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count > 0 {
            session.stopRunning()
            let object = metadataObjects[0]
            let string: String = (object as AnyObject).stringValue
            self.getData(string)
        }
    }
}
