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
            
            
            VStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        
                        Text("Cart")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    
                })
                
                
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
            .background(Color.white.ignoresSafeArea())
            
        }
        
        

}

