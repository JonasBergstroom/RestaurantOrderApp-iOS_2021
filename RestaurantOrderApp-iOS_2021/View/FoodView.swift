//
//  FoodView.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-17.
//

import SwiftUI
import SDWebImageSwiftUI

struct FoodView: View {
    
    var item: Item
    var body: some View {
        
        VStack {
            
            
            WebImage(url: URL(string: item.itemImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
            
            
            HStack(spacing: 8) {
                Text(item.itemName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                
                ForEach(1...5,id: \.self) {index in
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.itemRatings) ?? 0 ?
                                            Color("blue") : .blue)
                    
                    
                    
                }
                
                
                
                
                
                
                
            }
            
            HStack {
                
                Text(item.itemDetails)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                
                
                
            }
        }
        
        
        
    }
}
