//
//  Item.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-17.
//

import SwiftUI

struct Item: Identifiable {
   
    // All the "Item" variables
    
    var id: String
    var itemName: String
    var itemCost: Int
    var itemDetails: String
    var itemImage: String
    var itemRatings: String
    var isAdded: Bool = false
    
}
