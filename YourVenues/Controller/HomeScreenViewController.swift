

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenSize = UIScreen.main.bounds
        let image = UIImage(named: "1")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width  , height: 370)
        view.addSubview(imageView)
        
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 380, width: 300, height: 300)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 19.0)
        label.text = "Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum dolorium Lorem ipsum "
        view.addSubview(label)
        
        self.view = view
    }
    
    
    
}
