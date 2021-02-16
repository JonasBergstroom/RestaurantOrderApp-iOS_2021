//
//  HomeViewModel.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//

import SwiftUI
import CoreLocation


class Location {
    
}
class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    @Published var userLocation : CLLocation!
    @Published var userAdress = ""
    @Published var noLocation = false
    @Published var showMenu = false

    
    
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
}
