// The controller which hold the methods for fetching, saving and loading the venues data

import UIKit
import MapKit
import CoreData


class VenuesNetworkController{
    
    // Reference to the VenuesNetworkController
    static let VNController = VenuesNetworkController()
    
    // Reference to persistent container context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Create a MapView Object
    let mapView = MKMapView()
    
    var nearVenuesNames = [String]()
    var coreDataVenuesNames = [String]()
    
    
    // Search for near venues based on a current location
    func searchVenues(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Venue"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            let nearFindedVenues = response.mapItems
            
            for venue in nearFindedVenues{
                guard let venueName = venue.name else {return}
                self.nearVenuesNames.append(venueName)
            }
            
            let coreDataVenues = Venues(context: self.context)
            coreDataVenues.venuesNames = self.nearVenuesNames
            
            self.saveVenues()
        }
    }
    
    func saveVenues(){
        // Save the data into Core Data model
        do {
            try self.context.save()
        }
        catch{
            print("\(error.localizedDescription)")
        }
    }
    
    func loadVenuesNames(){
        // Fetch the venues from the Core Data and asign it to venuesNames array
        do{
            let fetchRequest = Venues.fetchRequest() as NSFetchRequest<Venues>
            
            guard let fetchedVenuesNames = try context.fetch(fetchRequest).first?.venuesNames else {return}
            
            coreDataVenuesNames = fetchedVenuesNames
        }
        catch{
            print("\(error.localizedDescription)")
        }
    }
}

