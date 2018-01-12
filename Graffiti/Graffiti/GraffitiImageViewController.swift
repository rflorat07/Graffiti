//
//  GraffitiImageViewController.swift
//  Graffiti
//
//  Created by Roger Florat on 12/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class GraffitiImageViewController: UIViewController {
    
    
    @IBOutlet weak var graffitiImage: UIImageView!
    
    var selectedCallout : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCallout = selectedCallout {
            graffitiImage.image = selectedCallout
        }
    }
    
    
    @IBAction func closeBottonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
