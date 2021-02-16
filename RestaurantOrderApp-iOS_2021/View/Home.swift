//
//  Home.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//
import SwiftUI

struct Home: View {

    @StateObject var HomeModel = HomeView()

    var body: some View {

        VStack(spacing: 10) {

            HStack(spacing: 15) {


                Button(action: {}, label: {

                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.blue)
                })
                
                
                Text("Deliver to")
                    .foregroundColor(.black)


                Text("Address..")
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

            Spacer()


        }
        
        
        
    }
}
