//
//  Graffiti.swift
//  Graffiti
//
//  Created by Roger Florat on 11/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class Graffiti: NSObject {

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
    
}
