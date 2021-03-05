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
    @Published var filtered: [Item] = []
    
    @Published var cartItmes: [Cart] = []
    @Published var ordered = false
    
    
    
    
    
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
            
            self.filtered = self.items
            
        }
    }
    
    
    
    /*    func filterData(){
     
     
     withAnimation(.linear) {
     self.filtered = self.items.filter{
     
     return $0.itemName.lowercased().contains(self.search.lowercased())
     }
     }
     
     
     
     
     }
     */
    
    
    func addToCart(item: Item) {
        
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        let filterIndex = self.filtered.firstIndex{ (item1) -> Bool in
            return item.id == item1.id
            
        } ?? 0
        self.filtered[filterIndex].isAdded = !item.isAdded
        
        
        if item.isAdded {
            let index = getIndex(item: item, isCartIndex: true)
            if index >= 0 {
                
                self.cartItmes.remove(at: index)
                
            }
            return
        }
        
        self.cartItmes.append(Cart(item: item, quantity: 1))
        
    }
    
    
    func getIndex(item: Item,isCartIndex: Bool) ->Int{
        let index = self.items.firstIndex {
            (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        let cartindex = self.cartItmes.firstIndex {
            (item1) -> Bool in
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartindex : index
    }
    
    func calculateTotalPrice()->String {
        
        
        var price : Float = 0
        
        
        cartItmes.forEach { (item) in
            price += Float(item.quantity) * Float(truncating: NSNumber(value: item.item.itemCost))
        }
        
        return getPrice(value: price)
        
    }
    
    func getPrice(value: Float)->String {
        
        
        let format = NumberFormatter()
        
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func updateOrder(){
        
        
        let db = Firestore.firestore()
        
        if ordered {
            ordered = false
            db.collection("Users").document(Auth.auth().currentUser!.uid).delete() {
                (err) in
                
                if err != nil {
                    self.ordered = true
                }
                
            }
            
            return
            
            
        }
        
        
        var details : [[String : Any]] = []
        
        cartItmes.forEach { (Cart) in
            details.append([
                
                "item_name": Cart.item.itemName,
                "item_quantity": Cart.quantity,
                "item_Cost": Cart.item.itemCost
                
                
                
            ])
        }
        ordered = true
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            
            "ordered_food": details,
            "total_cost": calculateTotalPrice(),
            "location": GeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            
        ]) { (err) in
            
            // If error setting data, order is no longer active
            if err != nil {
                self.ordered = false
                return
            }
            
            
            
            print("success")
            
        }
        
    }
    
}

