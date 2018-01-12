//
//  GraffitiManager.swift
//  Graffiti
//
//  Created by Roger Florat on 12/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class GraffitiManager {
    static let sharedInstance = GraffitiManager()
    
    var graffitis : [Graffiti] = [Graffiti]()
    
    func save() {
        if let url = databaseURL() {
            NSKeyedArchiver.archiveRootObject(graffitis, toFile: url.path)
        } else {
            print("Error guardando datos")
        }
    }
    
    func load() {
        if let url = databaseURL(),
            let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [Graffiti] {
            graffitis = savedData
        } else {
            print("Error cargando los datos")
        }
    }
    
    func databaseURL() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let url = URL(fileURLWithPath: documentDirectory)
            return url.appendingPathComponent("graffitis.data")
            
        } else {
            return nil
        }
    }
    
    func imagesURL() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let url = URL(fileURLWithPath: documentDirectory)
            return url
            
        } else {
            return nil
        }
    }
    
    
}
