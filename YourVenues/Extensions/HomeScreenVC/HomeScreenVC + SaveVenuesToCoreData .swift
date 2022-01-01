//  The extension hold the methods for fetching and saving vanues into CoreData

import UIKit
import MapKit

extension HomeScreenViewController{
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
}
