// Extension which hold the method loading the venues from Core Data

import UIKit
import CoreData


extension VenuesTableViewController{
    
    func loadVenuesNames(){
        // Fetch the venues from the Core Data and asign it to nearVenuesNames array
        do{
            let fetchRequest = Venues.fetchRequest() as NSFetchRequest<Venues>
            
            guard let fetchedVenuesNames = try context.fetch(fetchRequest).first?.venuesNames else {return}
            
            nearVenuesNames = fetchedVenuesNames
        }
        catch{
            print("\(error.localizedDescription)")
        }
    }
}
