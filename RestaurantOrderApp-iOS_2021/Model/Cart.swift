//
//  Cart.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-26.
//

import SwiftUI

struct Cart: Identifiable {
    
    // All the "Cart" variables
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
    
}
