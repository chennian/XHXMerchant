//
//  XLocationManager.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/20.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import CoreLocation

class XLocationManager: NSObject{
    
    fileprivate static let sharedInstance = XLocationManager()
    
    fileprivate lazy var locationManager:CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = 1000.0
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()
    
    func startUpLocation(){
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func stopUpLocation(){
        locationManager.stopUpdatingLocation()
    }
    class var shareUserInfonManager:XLocationManager{
        return sharedInstance
    }
    
    fileprivate override init() {
        
    }
    
}
extension XLocationManager:CLLocationManagerDelegate{
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first
        let coordinate:CLLocationCoordinate2D = (location?.coordinate)!
        let longidute = coordinate.longitude
        let latitude  = coordinate.latitude
        CNLog(latitude)
        CNLog(longidute)
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation((location)!) { (placemar, error) ->Void in
            if error != nil{
                CNLog("Reverse geocoder failed with error" + (error?.localizedDescription)!)
            }
            guard ((placemar?.count) != nil) else {return}
            let placemark:CLPlacemark = (placemar?.first)!
            var city = placemark.locality
            let subLocality = placemark.subLocality
            let are  = placemark.thoroughfare
            if city == nil {
                city = placemark.administrativeArea
            }
            let name = placemark.name
            
            let address = city! + subLocality! + are! + name!
            CNLog(address)
            XKeyChain.set(address, key: "ADDRESS")
            XKeyChain.set(city!, key: "CITY")
            
            guard are != nil  else {return}
            
        }
        
    }
}

