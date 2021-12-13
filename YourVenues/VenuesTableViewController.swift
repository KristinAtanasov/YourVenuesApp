

import UIKit
import MapKit
import CoreLocation
import CoreData

class VenuesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate{
    
    //Initialize the MapView and TableView objects
    let mapView = MKMapView()
    let tableView = UITableView()
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var cellIdentifier = "cell"
    
    var matchingVenues = [MKMapItem]()
    var coreDataVenues = [Venues]()
    

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
        
        // Register a cell with identifier to TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(mapView)
        view.addSubview(tableView)
        
     //   saveVenues()
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
            
            self.matchingVenues = response.mapItems
            self.tableView.reloadData()
        }
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
    
//    func fetchVenues(){
//
//        do{
//            // Fetch the venues from the Core Data and asign it to venues array
//            self.coreDataVenues = try context.fetch(Venues.fetchRequest())
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        catch{
//            print("\(error.localizedDescription)")
//        }
//        print(self.coreDataVenues)
//    }
//
//    func saveVenues(){
//
//        let venueObject = Venues(context: self.context)
//        //var newVenues = [String]()
//
//        for venue in matchingVenues{
////            guard let venues = venue.name else {return}
////            newVenues.append(venues)
//            venueObject.venue = venue.name
//        }
//        print(self.matchingVenues)
//        //venueObject.venues = newVenues
//
//        // Save the data into Core Data model
//        do {
//            try self.context.save()
//        }
//        catch{
//            print("\(error.localizedDescription)")
//        }
//
//        // Re fetch the data from Core Data
//        self.fetchVenues()
//        print(self.coreDataVenues)
//    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataVenues.count - 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let venuesNames = coreDataVenues[indexPath.row].venue  else {return cell}
        //let venuesNames = nearVenues[indexPath.row]
       
        print(self.matchingVenues)
        cell.textLabel?.text = venuesNames
        
        return cell
        
    }
}












