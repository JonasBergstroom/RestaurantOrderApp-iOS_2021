//
//  Home.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//
import SwiftUI

struct Home: View {
    var body: some View {

        VStack(spacing: 10) {

            HStack(spacing: 15) {


                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {

                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.blue)
                })


                Text("Deliver to")
                    .foregroundColor(.black)


                Text("Adress..")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)

            }
            .padding([.horizontal,.top])

            Divider()

            Spacer()


        }



    }
}
