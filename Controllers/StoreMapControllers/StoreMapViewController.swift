//
//  StoreMapViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 14/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var storeMapView : MKMapView!
    // es necesario la variable de abajo?
    var comicStoresList : [StoreComicAnnotation] = []
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        let regionRadius: CLLocationDistance = 1000
        let initialLocation = CLLocation(latitude: -38.717392, longitude: -62.265564)
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        storeMapView.setRegion(coordinateRegion, animated: true)
        
        if comicStoresList.isEmpty {
            
            comicStoresList = StoreAnnotationsManager.shared.launch()
            storeMapView.addAnnotations(comicStoresList)
   
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setupLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices () {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert saying to turn it on
        }
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
           
            case .authorizedAlways :
                    storeMapView.showsUserLocation = true
            
            case .authorizedWhenInUse :
                    storeMapView.showsUserLocation = true
            
            case .denied :
                    let alert = UIAlertController(title: "We need your location", message: "In order to provide you the best experience we need you to allow user localization", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
            
            case .notDetermined :
                    locationManager.requestWhenInUseAuthorization()
            
            case .restricted :
                let alert = UIAlertController(title: "We need your location", message: "In order to provide you the best experience we need you to allow user localization", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
            
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkLocationAuthorization()
        
    }
    
    
}

extension StoreMapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? StoreComicAnnotation else { return nil }
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "marker") as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        
        return view
        
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let geocoder: CLGeocoder = CLGeocoder()
        let location = CLLocation(latitude: -38.717392, longitude: -62.265564)
        
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), completionHandler: { (placemarks, error) in
            
            guard error == nil else {return}
            guard let thePlaceMark = placemarks?.first else {return}
            
            let alertController = UIAlertController(title: "Ciudad", message: thePlaceMark.locality ?? "", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Show on Map", style: .default, handler: { (action) in
                
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
                if let titleAnnotation = view.annotation?.title {
                    mapItem.name = "\(titleAnnotation!)"
                }
                
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            
            }))
        
            self.present(alertController, animated: true, completion: nil)
            
        })
    }
    
}
