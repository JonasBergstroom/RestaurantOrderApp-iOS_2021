//
//  ContentView.swift
//  RestaurantOrderApp-iOS_2021
//
//  Created by Jonas Bergström on 2021-02-16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // "Home" View is the one that show when start the app
        
        NavigationView {
            Home()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
