// The HomeScreen controller of the app

import UIKit
import MapKit
import CoreData


class HomeScreenViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    let mapView = MKMapView()
    var nearVenuesNames = [String]()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venue.jpg")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 21, weight: .regular)
        textLabel.text = "Your Venues is an APP which main goal is to find best venues near the current location on the user who use the app. Clicking on venues you will see a list with the five closest venues to you. Enjoy!!!"
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .justified
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUIViews()
        
        // Method for fetching and saving venues into CoreData
        searchVenues()
    }
    
    //MARK: - Layout and Constraints for the UI objects
    
    fileprivate func setupUIViews(){
        view.addSubview(imageView)
        
        //Setting the constraints for the containerImageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ])
        
        view.addSubview(textLabel)
        
        //Setting the constraints for the textLabel
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
    }
}


