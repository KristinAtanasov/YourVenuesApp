

import UIKit
import MapKit
import CoreLocation

class VenuesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate{
    
    let mapView = MKMapView()
    let tableView = UITableView()
    
    let locationManager = CLLocationManager()
    var location = CLLocation()
    
    private var cellIdentifier = "cell"
    
    var matchingItems = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVenues()
        
        // Set the table view data source and delegate to the current controller.
        tableView.dataSource = self
        tableView.delegate = self
        
        let screenSize = UIScreen.main.bounds
        
        // Set the size for MapView and TableView and add it to the controller main view.
        mapView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: (screenSize.height / 3))
        tableView.frame = CGRect(x: 0, y: mapView.frame.height, width: screenSize.width, height: screenSize.height)
        
        view.addSubview(mapView)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        showCurrentLocation()
    }
    
    
    // Search for near venues based on a current location
    func searchVenues(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Venue"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    
        func showCurrentLocation(){
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
            return matchingItems.count - 20
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            let venuesNames = matchingItems[indexPath.row]
            
            cell.textLabel?.text = venuesNames.name
            
            return cell
            
            
        }
    }












