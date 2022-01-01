// The VenuesTableView controller of the app

import UIKit
import MapKit
import CoreData


class VenuesTableViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var cellIdentifier = "cell"
    var nearVenuesNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Set the table view data source and its delegate to the current controller.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a cell with identifier to the TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Configure the views in the controller
        setupViews()
        
        // Show the user current location on the MapView
        showCurrentLocation()
        
        // Load the venues names from Core Data atribute which will be used to populate the TableView
        loadVenuesNames()
    }
    
    func setupViews(){
        //Setting the constraints for mapView
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        //Setting the constraints for tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

















