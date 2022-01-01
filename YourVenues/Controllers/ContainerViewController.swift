// Container controller which switch between the ViewControllers views by using segment control.

import UIKit

class ContainerViewController: UIViewController {
    
    let homeScreenVC = HomeScreenViewController()
    let venuesVC = VenuesTableViewController()
    
    private let segmentControl:UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Home", "Venues"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(segmentControlSwitch), for: .valueChanged)
        return segmentControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the controllers into contenier controller.
        setupVC()
        
        // Cogigure the constraints for the segment controller.
        setupSegmentConstraints()
    }
    
    
    //MARK: - Setup controllers method
    
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
    
    //MARK: - Segment Control Constraints
    
    private func setupSegmentConstraints(){
        //Setting the constraints for the segmentControl
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    //MARK: - Segment Control method
    
    @objc func segmentControlSwitch(){
        homeScreenVC.view.isHidden = true
        venuesVC.view.isHidden = true

        if segmentControl.selectedSegmentIndex == 0 {
            homeScreenVC.view.isHidden = false
            venuesVC.view.isHidden = true
        } else {
            homeScreenVC.view.isHidden = true
            venuesVC.view.isHidden = false
        }
    }
}
