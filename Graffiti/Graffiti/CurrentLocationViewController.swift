//
//  CurrentLocationViewController
//  Graffiti
//
//  Created by Roger Florat on 11/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import MapKit

class CurrentLocationViewController: UIViewController {
    
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tagButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var graffiti : Graffiti?
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var updatingLocation = false {
        didSet{
            if updatingLocation {
                getButton.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                getButton.isUserInteractionEnabled = false
            } else {
                getButton.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                getButton.isUserInteractionEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "img_navbar_title")
        self.navigationItem.titleView = UIImageView(image: image)
        
        updatingLocation = false
        
    }
    
    
    @IBAction func getLocation(_ sender: AnyObject) {
        startLocationManager()
    }
    
    func startLocationManager() {
        let authAtatus = CLLocationManager.authorizationStatus()
        
        switch authAtatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showLocationServicesDeniedAlert()
        default:
            if CLLocationManager.locationServicesEnabled() {
                
                self.updatingLocation = true
                self.tagButton.isEnabled = false
                
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestLocation()
                
                // Hacemos zoom sobre la localizaón del usuario
                let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
                
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
            }
        }
    }
    
    func showLocationServicesDeniedAlert(){
        let alert = UIAlertController(title: "Localización desactivada", message: "por favor, activa la localización para esta app en Ajustes", preferredStyle: .alert)
        let okAccion = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAccion)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        var line1 = ""
        if let address = placemark.thoroughfare{
            line1 += address + ", "
        }
        
        if let number = placemark.subThoroughfare{
            line1 += number
        }
        
        var line2 = ""
        if let pcode = placemark.postalCode{
            line2 += pcode + " "
        }
        
        if let locality = placemark.locality{
            line2 += locality
        }
        
        var line3 = ""
        if let area = placemark.administrativeArea{
            line3 += area
        }
        
        return line1 + "\n" + line2 + "\n" + line3
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TagGraffiti" {
            let navigationController = segue.destination as! UINavigationController
            let detailsViewController = navigationController.topViewController as! GraffitiDetailsViewController
            
            detailsViewController.taggedGraffiti = self.graffiti
            detailsViewController.delegate = self
        }
    }
   
}

extension CurrentLocationViewController: GraffitiDetailsViewControllerDelegate {
    func graffitiDidFinishGetTagged(sender: GraffitiDetailsViewController, taggedGraffiti: Graffiti) {
    }
}

extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error en Core Location *******")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.last else { return }
        
        let latitude = Double(newLocation.coordinate.latitude)
        let longitude = Double(newLocation.coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(newLocation) { (placemark, error) in
            if error == nil {
                var address = "No se a podido determinar"
                if let placemark = placemark?.last {
                    address = self.stringFromPlacemark(placemark: placemark)
                }
                
                self.graffiti = Graffiti(addres: address, latitude: latitude, longitude: longitude, image: "")
            }
            self.updatingLocation = false
            self.tagButton.isEnabled = true
        }
        
    }
}

