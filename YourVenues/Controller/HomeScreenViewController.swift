

import UIKit
import MapKit

class HomeScreenViewController: UIViewController {
    
    static var homeScreenVC = HomeScreenViewController()
    
    let mapView = MKMapView()
    
    var venuesArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        let screenSize = UIScreen.main.bounds
        let image = UIImage(named: "venue.jpg")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width  , height: 370)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 380, width: 300, height: 300)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 19.0)
        label.text = "Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum "
        label.textColor = .black
        view.addSubview(label)
        
    }
}
