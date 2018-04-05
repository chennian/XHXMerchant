
//
//  UIImage+Extension.swift
//  逗牛
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 mac. All rights reserved.
//
import UIKit

extension UIImage {
    
    ///对指定图片进行拉伸
    func resizableImage(name: String) -> UIImage {
        
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(image: UIImage, maxLength: Int = 1024 * 200) -> Data? {
        
        //let newSize = self.scaleImage(image: image, imageLength: 800)
        let newImage = UIImage.resizeImage(image: image, newSize: image.size)
        
        var compress:CGFloat = 1.0
        var data = UIImageJPEGRepresentation(newImage, compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(newImage, compress)
        }
        
        return data
    }
    
    
//    func compressImage(image: UIImage,) -> Data? {
//        
//        //let newSize = self.scaleImage(image: image, imageLength: 800)
//        let newImage = UIImage.resizeImage(image: image, newSize: image.size)
//        
//        var compress:CGFloat = 0.9
//        var data = UIImageJPEGRepresentation(newImage, compress)
//        
//        while (data?.count)! > 2000 && compress > 0.01 {
//            compress -= 0.02
//            data = UIImageJPEGRepresentation(newImage, compress)
//        }
//        
//        return data as Data?
//    }
   
    
    
    func compressImage(str : String, maxLength: Int = 1024 * 200) -> [String:AnyObject]?{
        
        
        let newImage = UIImage.resizeImage(image: self, newSize: self.size)
        var compress:CGFloat = 1.0
        var data = UIImageJPEGRepresentation(newImage, compress)
        if data!.count > 1000000{
            compress = 0.5
        }
    
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.05
            data = UIImageJPEGRepresentation(newImage, compress)
        }
        
        ///
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
        let imgSufix = "\(str).jpg"
        
        
        let imgUrl = documentUrl!.appendingPathComponent(imgSufix)
        
        if FileManager.default.fileExists(atPath: imgUrl.absoluteString){
            try? FileManager.default.removeItem(at: imgUrl)
        }
        
        do{
            try data!.write(to: imgUrl)
            
            let img = UIImage(data: data!)

            return ["url" : imgUrl as AnyObject,"image" : img!]
        }catch{
            return nil
        }
        
    }
    
    
    
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
//        let image_width = image.size.width
//        let image_height = image.size.height
        
        if (image.size.width > image.size.height || image.size.height > imageLength){
            
            if (image.size.width > image.size.height) {
                
                newWidth = imageLength;
                newHeight = newWidth * image.size.height / image.size.width;
                
            }else if(image.size.height > image.size.width){
                
                newHeight = imageLength;
                newWidth = newHeight * image.size.width / image.size.height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    class func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            ZJLog(messagr: "无图片")
            return image
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}




