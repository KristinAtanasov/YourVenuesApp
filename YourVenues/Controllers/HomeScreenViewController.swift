// The HomeScreen controller of the app

import UIKit
import MapKit

class HomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        
        // Creates UIImageView with venue image on aspectFill mode.
        let image = UIImage(named: "venue.jpg")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width  , height: 300)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        //Creates UILabel with About Us text.
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 300 , width: 300, height: 300)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 21.0)
        label.text = "Your Venues is an APP which main goal is to find best venues near the current location on the user who use the app. Clicking on venues you will see a list with the five closest venues to you. Enjoy!!!"
        label.textColor = .black
        view.addSubview(label)
    }
}
