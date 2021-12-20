// The VenuesTableView controller of the app

import UIKit
import MapKit
import CoreLocation
import CoreData

class VenuesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate{
    
    //Initialize the MapView and TableView objects
    let mapView = MKMapView()
    let tableView = UITableView()
    
    // Reference to persistent container context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var cellIdentifier = "cell"
    var nearVenuesNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let screenSize = UIScreen.main.bounds
        
        // Set the size for MapView and TableView and add it to the main view.
        mapView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: (screenSize.height / 3))
        tableView.frame = CGRect(x: 0, y: mapView.frame.height, width: screenSize.width, height: screenSize.height)
        view.addSubview(mapView)
        view.addSubview(tableView)
        
        // Set the table view data source and its delegate to the current controller.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a cell with identifier to TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
               
        showCurrentLocation()
    }
  
    func showCurrentLocation(){
        
        // Accessing the user current location
        let coordinate = mapView.userLocation.coordinate
        let locationCordinates = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCordinates
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: locationCordinates, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        self.mapView.setRegion(region, animated: true)
    }

    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearVenuesNames.count - 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = nearVenuesNames[indexPath.row]
       
        return cell
    }
}












