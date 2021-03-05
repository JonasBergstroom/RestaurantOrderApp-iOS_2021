//
//  Home.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//
import SwiftUI
import Firebase

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    @ObservedObject var viewModel = ChatroomsViewModel()
    @State var messagesOpen = false
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                
                
                HStack(spacing: 15) {
                    
                    // In this stack the chosen location shows and the "side menu" icon
                    
                    
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
                    
                    
                    Text(HomeModel.userAdress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.blue)
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                    
                    Button(action: {
                        
                        messagesOpen = true
                        
                    }, label:
                        {
                            Image(systemName: "message.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                            
                            
                        })
                    
                    
                    
                    
                }
                
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15) {
                    
                    // Here shows the "Search bar"
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    
                    
                    
                    TextField("Search", text: $HomeModel.search)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                    
                    // In this ScrollView all the dishes is shown
                    
                    
                    VStack(spacing: 25){
                        
                        ForEach(HomeModel.items.filter(withAnimation(.linear){{HomeModel.search.isEmpty ? true : $0.itemName.lowercased().contains(HomeModel.search.lowercased())}})) {item in
                            Color.blue
                            
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                
                                
                                FoodView(item: item)
                                
                                
                                HStack {
                                    
                                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                    
                                    
                                    Button(action: {
                                        
                                        
                                        HomeModel.addToCart(item: item)
                                    }, label: {
                                        Image(systemName: item.isAdded ? "checkmark" : "plus.circle.fill")
                                            
                                            
                                            .foregroundColor(.blue)
                                            .padding(5)
                                            .font(.system(size: 35))
                                            .background(item.isAdded ? Color.green : Color("blue"))
                                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        
                                        
                                    })
                                    
                                    
                                }
                                
                                
                                
                                
                            })
                            .frame(width: UIScreen.main.bounds.width - 6)
                            
                        }
                        
                    }
                    
                    .padding(.top,10)
                    
                    
                })
                
                
            }
            
            
            HStack {
                
                // This is the "side menu" when you click it you will be taken to the Cart icon
                
                ToCart(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
                
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea())
            
            // Closing the "side menu" when you click outside it
            .onTapGesture(perform: {
                withAnimation(.easeIn){
                    HomeModel.showMenu.toggle() }
            })
            
            // Show alert if you have not enable location in settings
            
            if HomeModel.noLocation {
                Text("Please enable location in settings!")
                    .foregroundColor(.black)
            }
            
            // Taking you to the "Chat" window
            
        }.fullScreenCover(isPresented: $messagesOpen) {
            Messages(chatroom: Chatroomss(id: Auth.auth().currentUser!.uid))
        }
        
        // Making the startup work correctly for the app
        
        .onAppear(perform: {
            
            HomeModel.locationManager.delegate = HomeModel
            
            
            
            
        })
        
    }
    
}
