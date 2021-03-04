//
//  CartView.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-28.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.presentationMode)  var present


    
    var body: some View {
        VStack{
            
            HStack(spacing: 20) {
                
                Button(action: {present.wrappedValue.dismiss()}) {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.blue)
                    
                    
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
                    
                    ForEach(homeData.cartItmes) {Cart in
                        
                        HStack(spacing: 15) {
                            
                            
                            WebImage(url: URL(string: Cart.item.itemImage))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 72)
                                .cornerRadius(15)
                            
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(Cart.item.itemName)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                
                          //      Text(Cart.item.itemDetails)
                         //           .fontWeight(.semibold)
                          //          .foregroundColor(.gray)
                           //         .lineLimit(2)
                                
                                HStack(spacing: 15) {
                                    
                                    Text("\(homeData.getPrice(value: Float(Cart.item.itemCost))) Kr")
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                    
                                    
                                    Button(action: {
                                        if Cart.quantity > 1 { homeData.cartItmes[homeData.getIndex(item: Cart.item, isCartIndex: true)].quantity
                                            
                                            
                                            -= 1 }
                                        
                                    }) {
                                        
                                        
                                        Image(systemName: "minus")
                                            
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                        
                                        
                                        
                                    }
                                    
                                    
                                    Text("\(Cart.quantity)")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,10)
                                        .background(Color.black.opacity(0.06))
                                    
                                    
                                    Button(action: {
                                        
                                        homeData.cartItmes[homeData.getIndex(item: Cart.item, isCartIndex: true)].quantity
                                            
                                            += 1
                                    
                                        
                                    }) {
                                        
                                        
                                        Image(systemName: "plus")
                                            
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                        .padding()
                        .contextMenu{
                          
                            Button(action: {
                                
                                
                                
                                let index = homeData.getIndex(item: Cart.item, isCartIndex: true)
                                let itemIndex = homeData.getIndex(item: Cart.item, isCartIndex: false)
                                
                                
                                homeData.items[itemIndex].isAdded = false
                                homeData.filtered[itemIndex].isAdded = false


                                
                                homeData.cartItmes.remove(at: index)

                            }){
                                
                                
                                Text("Remove")
                                
                            }
                            
                                   
                                   
                                   
                
                        
                            
                            
                        }
                        
                        
                    
                        
                        
                        
                        
                        
                        
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
                
                
                Button(action: {homeData.updateOrder()}) {
                    
                    
                    Text(homeData.ordered ? "Cancel Order" : "Checkout")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        
                        .background(
                            
                            Color(.blue)
                            
                            
                        )
                        
                        .cornerRadius(15)
                    
                    
                }
                
                
                
                
                
            }
            
          
            
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}
