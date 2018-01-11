//
//  GraffitiDetailsViewController.swift
//  Graffiti
//
//  Created by Roger Florat on 11/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

protocol GraffitiDetailsViewControllerDelegate: class {
    func graffitiDidFinishGetTagged(sender: GraffitiDetailsViewController, taggedGraffiti: Graffiti)
}

class GraffitiDetailsViewController: UIViewController {
    
    weak var delegate: GraffitiDetailsViewControllerDelegate?
    
    @IBOutlet weak var imgGraffiti: UIImageView!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var saveButtom: UIBarButtonItem!
    
    var  taggedGraffiti : Graffiti?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "img_navbar_title")
        self.navigationItem.titleView = UIImageView(image: image)
        
        let takePictureGesture  = UITapGestureRecognizer(target: self, action: #selector(takePictureTapped))
        
        self.imgGraffiti.addGestureRecognizer(takePictureGesture)
        
        configureLabels()
        
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureLabels() {
        latitudeLabel.text = String(format: "%.8f", (taggedGraffiti?.coordinate.latitude)!)
        longitudeLabel.text = String(format: "%.8f", (taggedGraffiti?.coordinate.longitude)!)
        addressLabel.text = taggedGraffiti?.graffitiAddress
    }
    
}

extension GraffitiDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func takePictureTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "Sacar foto", style: .default) {
            _ in
            self.takePhotoWithCamera()
        }
        alertController.addAction(takePhotoAction)
        
        let choosePhotoFromLibrary = UIAlertAction(title: "Elegir de la librería", style: .default) {
            _ in
            self.choosePhotoFromLibrary()
        }
        alertController.addAction(choosePhotoFromLibrary)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func takePhotoWithCamera() {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func choosePhotoFromLibrary() {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imageTaken = info[UIImagePickerControllerEditedImage] as? UIImage
        imgGraffiti.image = imageTaken
        saveButtom.isEnabled = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}








