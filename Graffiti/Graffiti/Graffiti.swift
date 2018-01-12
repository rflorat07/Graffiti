//
//  Graffiti.swift
//  Graffiti
//
//  Created by Roger Florat on 11/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import MapKit

class Graffiti: NSObject, NSCoding {

    let graffitiAddress : String
    let graffitiLatitude : Double
    let graffitiLongitude : Double
    let graffitiImgName : String
    
    init(addres: String, latitude: Double, longitude: Double, image: String) {
        self.graffitiAddress = addres
        self.graffitiLatitude = latitude
        self.graffitiLongitude = longitude
        self.graffitiImgName = image
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let graffitiAddress = aDecoder.decodeObject(forKey: "graffitiAddress") as! String
        let graffitiLatitude = aDecoder.decodeDouble(forKey: "graffitiLatitude")
        let graffitiLongitude = aDecoder.decodeDouble(forKey: "graffitiLongitude")
        let graffitiImgName = aDecoder.decodeObject(forKey: "graffitiImgName") as! String
        
        self.init(addres: graffitiAddress, latitude: graffitiLatitude, longitude: graffitiLongitude, image: graffitiImgName)
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.graffitiAddress, forKey: "graffitiAddress")
        aCoder.encode(self.graffitiLatitude, forKey: "graffitiLatitude")
        aCoder.encode(self.graffitiLongitude, forKey: "graffitiLongitude")
        aCoder.encode(self.graffitiImgName, forKey: "graffitiImgName")
    }
    
}

extension Graffiti: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return  CLLocationCoordinate2D(latitude: graffitiLatitude, longitude: graffitiLongitude)
        }
    }
    
    var title: String? {
        get {
            return "Graffiti"
        }
    }
    
    var subtitle: String? {
        get {
            return graffitiAddress.replacingOccurrences(of: "\n", with: "")
        }
    }
    
}
