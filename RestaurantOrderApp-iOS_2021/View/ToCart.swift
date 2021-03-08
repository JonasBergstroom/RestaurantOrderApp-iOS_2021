//
//  ToCart.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//

import SwiftUI

struct ToCart: View {
    
    @ObservedObject var homeData : HomeViewModel
    var body: some View {
        
        // This view is showing the "side menu"
        
        VStack {
            
            NavigationLink(destination: CartView(homeData: homeData)) {
                
                // Taking you to the "CartView" when clicked on
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.blue)
                    
                    
                    Text("Cart")
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            
            
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            
            .padding(10)
            
        }
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
        
    }
    
    
    
}

