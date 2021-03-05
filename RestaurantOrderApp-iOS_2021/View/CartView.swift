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
            
            // Cart view
            
            HStack(spacing: 20) {
                
                Button(action: {present.wrappedValue.dismiss()}) {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.blue)
                    
                    
                }
                
                Text("My cart")
                    .font(.title)
                    .fontWeight(.heavy)
                
                
                
                Spacer()
            }
            .padding()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(spacing: 0) {
                    
                    // Cart ItemView
                    
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
                                
                                
                                
                                
                                HStack(spacing: 15) {
                                    
                                    // Showing the price of the item
                                    
                                    Text("\(homeData.getPrice(value: Float(Cart.item.itemCost))) Kr")
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                    
                                    Spacer(minLength: 0)
                                    
                                    // Change the amount of the item with -1
                                    
                                    Button(action: {
                                        if Cart.quantity > 1 { homeData.cartItmes[homeData.getIndex(item: Cart.item, isCartIndex: true)].quantity
                                            
                                            
                                            -= 1 }
                                        
                                    }) {
                                        
                                        
                                        Image(systemName: "minus")
                                            
                                            .font(.system(size: 16, weight: .heavy))
                                        
                                        
                                        
                                    }
                                    
                                    
                                    Text("\(Cart.quantity)")
                                        .fontWeight(.heavy)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,10)
                                        .background(Color(UIColor.label).opacity(0.06))
                                    
                                    // Change the amount of the item with +1
                                    
                                    Button(action: {
                                        
                                        homeData.cartItmes[homeData.getIndex(item: Cart.item, isCartIndex: true)].quantity
                                            
                                            += 1
                                        
                                        
                                    }) {
                                        
                                        
                                        Image(systemName: "plus")
                                            
                                            .font(.system(size: 16, weight: .heavy))
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                        .padding()
                        .contextMenu{
                            
                            // To delete an item from the cart
                            
                            Button(action: {
                                
                                
                                
                                let index = homeData.getIndex(item: Cart.item, isCartIndex: true)
                                let itemIndex = homeData.getIndex(item: Cart.item, isCartIndex: false)
                                
                                
                                homeData.items[itemIndex].isAdded = false
                                
                                
                                
                                
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
                    
                    // Showing the total amount of all items in the cart
                    
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(homeData.calculateTotalPrice())
                        
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("KR")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                }
                .padding([.top,.horizontal])
                
                
                Button(action: {homeData.updateOrder()}) {
                    ZStack {
                        
                        // Here can you with one button press make the order an with a second press cancel it
                        
                        Color(homeData.ordered ?.red : .blue)
                        Text(homeData.ordered ? "Cancel Order" : "Checkout")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                        
                        
                        
                    }
                    .cornerRadius(15)
                    
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .fixedSize(horizontal: false, vertical: true)
                    
                }
                
                
                
                
                
            }
            
            
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}
