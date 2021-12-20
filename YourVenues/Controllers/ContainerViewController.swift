// This is the conteiner controller for HomeScreen and VenuesTableView controllers

import UIKit
import MapKit

class ContainerViewController: UIViewController {
    
    @IBOutlet var segmentController: UISegmentedControl!
    
    let homeScreenVC = HomeScreenViewController()
    let venuesVC = VenuesTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add homeScreenVC and venuesVC as a childs to the main view
        setupVC()

        // Fetch the data for near venues based on user location
        VenuesNetworkController.VNController.searchVenues()
    }

    private func setupVC(){
        
        // Add homeScreenVC and venuesVC as a childs to the main view
        addChild(homeScreenVC)
        addChild(venuesVC)
        self.view.addSubview(homeScreenVC.view)
        self.view.addSubview(venuesVC.view)
        
        homeScreenVC.didMove(toParent: self)
        venuesVC.didMove(toParent: self)
        
        homeScreenVC.view.frame = self.view.bounds
        venuesVC.view.frame = self.view.bounds
        venuesVC.view.isHidden = true
        
    }
    
    @IBAction func segmenControlTapped(_ sender: UISegmentedControl) {
        
        homeScreenVC.view.isHidden = true
        venuesVC.view.isHidden = true
        
        if sender.selectedSegmentIndex == 0 {
            homeScreenVC.view.isHidden = false
        } else {
            
            venuesVC.view.isHidden = false
            
            // Fetch the venues names from the Core Data
            VenuesNetworkController.VNController.loadVenuesNames()
            
            // Add the fetched data from CD entity atribute into ,,nearVenuesNames'' array which will populate the TableView
            venuesVC.nearVenuesNames = VenuesNetworkController.VNController.coreDataVenuesNames
            venuesVC.tableView.reloadData()
        }
    }
}
