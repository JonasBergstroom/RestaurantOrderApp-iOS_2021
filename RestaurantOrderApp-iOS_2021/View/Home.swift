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
    @Binding var isOpen: Bool
    @State var messagesOpen = false
    

    

    
  
    
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
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    
                    
                    
                    TextField("Search", text: $HomeModel.search)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                    
                    
                    VStack(spacing: 25){
                        
                        ForEach(HomeModel.filtered) {item in
                            Color.blue
                            
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                
                                
                                FoodView(item: item)
                                
                                
                                HStack {
                                    
                                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                    
                                    Button(action: {}, label: {
                                        
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                            .padding(5)
                                            .font(.system(size: 35))
                                            .background(Color("blue"))
                                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    })
                                    
                                    
                                    
                                }
                                
                                .padding(.trailing,10)
                                .padding(.top,10)
                                
                                
                                
                            })
                            .frame(width: UIScreen.main.bounds.width - 6)
                            
                        }
                        
                    }
                    
                    .padding(.top,10)
                    
                    
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
            
        }.fullScreenCover(isPresented: $messagesOpen) {
            Messages(chatroom: Chatroomss(id: Auth.auth().currentUser!.uid))
        }
        
        .onAppear(perform: {
            
            HomeModel.locationManager.delegate = HomeModel
            
            self.viewModel.createChatroom( handler: {
                self.isOpen = false
                
            })
            
            
        })
        
        .onChange(of: HomeModel.search, perform: { value in
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                if value == HomeModel.search && HomeModel.search != "" {
                    
                    
                    HomeModel.filterData()
                    
                }
                
                
            }
            
            if HomeModel.search == "" {
                
                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
                
                
            }
        })
    }
}


