

import UIKit
import MapKit

class VenuesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let mapKitView = MKMapView()
    let tableView = UITableView()
    
    private var cellIdentifier = "cell"
    
    var array = ["hello", "honey", "compassion", "energy", "believe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view data source and delegate to the current controller.
        tableView.dataSource = self
        tableView.delegate = self
        
        let screenSize = UIScreen.main.bounds
        
        // Set the size for MapView and TableView and add it to the controller main view.
        mapKitView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: (screenSize.height / 3))
        tableView.frame = CGRect(x: 0, y: mapKitView.frame.height, width: screenSize.width, height: screenSize.height)
        view.addSubview(mapKitView)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }

}
