//
//  CartView.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-28.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.presentationMode)  var present
    
    var body: some View {
        VStack{
            
            HStack(spacing: 20) {
                
                Button(action: {present.wrappedValue.dismiss()}) {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.black)
                    
                    
                }
                
                Text("My cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                
                Spacer()
            }
            .padding()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(spacing: 0) {
                    
                    ForEach(homeData.cartItmes) {item in
                        
                        Text(item.item.itemName)
                        
                    }
                    
                    
                }
                
                
                
            }
            
            
            VStack {
                
                HStack {
                    
                    
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(homeData.calculateTotalPrice())
                        
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Text("KR")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                }
                .padding([.top,.horizontal])
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    
                    
                    Text("Checkout")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        
                        .background(
                            
                            LinearGradient(gradient: .init(colors: [Color("Lightblue"),Color("Blue")]), startPoint: .leading, endPoint: .trailing)
                            
                            
                            
                            
                        )
                        
                        .cornerRadius(15)
                    
                    
                }
                
                
                
                
                
            }
            
            .background(Color.white)
            
            
            
        }
        
        .background(Color("gray").ignoresSafeArea())
        
        
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
    }
}

