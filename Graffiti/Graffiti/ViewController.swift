//
//  ViewController.swift
//  Graffiti
//
//  Created by Roger Florat on 11/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "img_navbar_title")
        self.navigationItem.titleView = UIImageView(image: image)
        
    }

}

