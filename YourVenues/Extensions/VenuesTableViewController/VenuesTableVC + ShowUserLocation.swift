// The extension hold the method for user current location

import UIKit
import MapKit

extension VenuesTableViewController{
    
    func showCurrentLocation(){
        
        // Accessing the user current location and displayed on MapView
        let coordinate = mapView.userLocation.coordinate
        let locationCordinates = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCordinates
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: locationCordinates, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        self.mapView.setRegion(region, animated: true)
    }
}
