//
//  Home.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//
import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
       ZStack {
            VStack(spacing: 10) {
                
                HStack(spacing: 15) {
                    
                    
                    Button(action: {
                        withAnimation(.easeIn) {
                            HomeModel.showMenu.toggle()
                        }
                    }, label: {
                        
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.blue)
                    })
                    
                    
                    Text(HomeModel.userLocation == nil ? " Locating... " : "Deliver to")
                        .foregroundColor(.black)
                    
                    
                    Text(HomeModel.userAdress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.blue)
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15) {
                    
                    
                    TextField("Search", text: $HomeModel.search)
                    
                    if HomeModel.search != "" {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            
                            
                            
                        })
                        .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                   
                    
                    VStack(spacing: 25){
                        
                        
                        ForEach(HomeModel.items) {item in
                            
                            Text(item.itemName)
                          
                                
                            
                        }
                        
                        
                    }
                })
                
                
            }
        
        
        HStack {
            
            
            ToCart(homeData: HomeModel)
                .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
            Spacer(minLength: 0)
            
        }
        .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea())
        
        .onTapGesture(perform: {
            withAnimation(.easeIn){
                HomeModel.showMenu.toggle() }
        })
        
        
            
            if HomeModel.noLocation {
                Text("Please enable location in settings!")
                    .foregroundColor(.black)
            }
            
        }
      
       .onAppear(perform: {
            
            HomeModel.locationManager.delegate = HomeModel
            
            
            
            
        })
        
  
        
    }
}


