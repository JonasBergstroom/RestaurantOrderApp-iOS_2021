//
//  HomeViewModel.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//

import SwiftUI
import CoreLocation
import Firebase

    

class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    @Published var userLocation : CLLocation!
    @Published var userAdress = ""
    @Published var noLocation = false
    @Published var showMenu = false
    
    @Published var items: [Item] = []
    
   

    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
            
        }
        
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.userLocation = locations.last
        self.extractLocation()
        self.login()
       
        
        
    }
    
    func extractLocation() {
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) {
            (res, err) in guard let safeData = res else {
                return
            }
        
        var adress = ""
        
        adress += safeData.first?.name ?? ""
        adress += ", "
        adress += safeData.first?.locality ?? ""
        
        self.userAdress = adress
        }
    }
    
    func login() {
        
        Auth.auth().signInAnonymously{ (res, err) in
            if err != nil {
            print(err!.localizedDescription)
                return
            }
            
            
            print("Success = \(res!.user.uid)")
            
            self.getData()
        }
        
    }
    
    
    
    func getData() {
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments{ (snap, err) in
            
            guard let itemData = snap
                else{return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("itemName") as! String
                let price = doc.get("itemCost") as! Int
                let ratings = doc.get("itemRatings") as! String
                let image = doc.get("itemImage") as! String
                let details = doc.get("itemDetails") as! String
        
                
                
                return Item(id: id, itemName: name, itemCost: price, itemDetails: details, itemImage: image, itemRatings: ratings)
            })
        
    }
}
}
