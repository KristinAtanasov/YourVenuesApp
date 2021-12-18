

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
    
    var venuesNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVenues()
        saveVenues()
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
            
            let nearFindedVenues = response.mapItems

            // Adding the venues names from near venues MapView objects into venuesNames array
            for venue in nearFindedVenues{
                guard let venueName = venue.name else {return}
                
                self.venuesNames.append(venueName)
            }
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
    
    
    func saveVenues(){
        
        let coreDataVenue = Venues(context: self.context)
        
        coreDataVenue.venues = venuesNames
        
        // Save the data into Core Data model
        do {
            try self.context.save()
        }
        catch{
            print("\(error.localizedDescription)")
        }
        self.fetchVenues()
    }
    
    func fetchVenues(){

        // Fetch the venues from the Core Data and asign it to venuesNames array
        do{
            let fetchRequest = Venues.fetchRequest() as NSFetchRequest<Venues>
    
            
            self.venuesNames = try (context.fetch(fetchRequest).first?.venues as! [String])
            
            print("Check")
            print(self.venuesNames)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            print("\(error.localizedDescription)")
        }
    }

    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesNames.count - 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let venueName = venuesNames[indexPath.row]
        
        cell.textLabel?.text = venueName
       
        return cell
        
    }
}
   













