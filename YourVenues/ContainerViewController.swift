

import UIKit
import MapKit

class ContainerViewController: UIViewController {
    
    @IBOutlet var segmentController: UISegmentedControl!
    
    let homeScreenVC = HomeScreenViewController()
    let venuesVC = VenuesTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
    }
    
    
    private func setupVC(){
        
        // Adding homeScreenVC and venuesVC as a childs to the main view of the controller
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
        }
    }
}
