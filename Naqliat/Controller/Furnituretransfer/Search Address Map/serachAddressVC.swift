//
//  serachAddressVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}

protocol saveTheAddress {
    func saveAdderssInfo(address: String,lat: Double,long: Double)
}



class serachAddressVC: UIViewController {
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    
    
    var delegate: saveTheAddress?
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 500
    var previousLocation: CLLocation?
    var lat = 0.0
    var long = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        checkLocationServices()
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Close"), style: .done, target: self, action: #selector(dissesView))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        //let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        let locationSearchTable = LocationSearchTable(nibName: "LocationSearchTable", bundle: nil)
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = map
        locationSearchTable.handleMapSearchDelegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dissesView() {
        self.dismiss(animated: true, completion: nil)
    
           }

    func centerViewOnUserLocation() {
         if let location = locationManager.location?.coordinate {
             let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
             map.setRegion(region, animated: true)
         }
     }
     
     func checkLocationAuthorization() {
         switch CLLocationManager.authorizationStatus() {
         case .authorizedWhenInUse:
             startTackingUserLocation()
         case .denied:
             showAlert(title: "Location", message: "Allow location")
             break
         case .notDetermined:
             locationManager.requestWhenInUseAuthorization()
         case .restricted:
             showAlert(title: "Location", message: "Allow location")
             break
         case .authorizedAlways:
             startTackingUserLocation()
         @unknown default:
             break
         }
     }
     
     
    @IBAction func chooseBtn(_ sender: Any) {
        delegate?.saveAdderssInfo(address: addressLabel.text ?? "", lat: lat, long: long)
        dismiss(animated: true)
        
    }
    func startTackingUserLocation() {
            map.showsUserLocation = false
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            previousLocation = getCenterLocation(for: map)
        }
     
     
    func setupLocationManager() {
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
     }
     
    func checkLocationServices() {
         if CLLocationManager.locationServicesEnabled() {
             setupLocationManager()
             checkLocationAuthorization()
         } else {
             showAlert(title: "Location", message: "turn location on")
         }
     }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
           let latitude = map.centerCoordinate.latitude
           let longitude = map.centerCoordinate.longitude
           
           return CLLocation(latitude: latitude, longitude: longitude)
       }
       
       

}


extension serachAddressVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}




extension serachAddressVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let center = getCenterLocation(for: mapView)
            let geoCoder = CLGeocoder()
            
            guard let previousLocation = self.previousLocation else { return }
            
            guard center.distance(from: previousLocation) > 50 else { return }
            self.previousLocation = center
            
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if let _ = error {
                    //TODO: Show alert informing the user
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    //TODO: Show alert informing the user
                    return
                }
                
                let streetNumber = placemark.subThoroughfare ?? ""
                let streetName = placemark.thoroughfare ?? ""
                let area = placemark.locality ?? ""
                let city = placemark.administrativeArea ?? ""
                let zone = placemark.subLocality ?? ""
                print(area)
                
                DispatchQueue.main.async {
                    self.addressLabel.text = "\(streetNumber) \(streetName) \(city) \(zone) \(area)"
                    self.lat = self.map.centerCoordinate.latitude
                    self.long = self.map.centerCoordinate.longitude
                    print(self.map.centerCoordinate.latitude)
                    print(self.map.centerCoordinate.longitude)
                }
            }
        }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        pinView.pinTintColor = UIColor.orange
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        var button: UIButton?
        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button?.setBackgroundImage(UIImage(named: "car"), for: UIControl.State())
        pinView.leftCalloutAccessoryView = button
        
        return pinView
    }

}

    
extension serachAddressVC: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        map.removeAnnotations(map.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        
        map.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        map.setRegion(region, animated: true)
    }
    
}

    
    
