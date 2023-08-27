//
//  ContentView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/25/23.
//

import SwiftUI
  
struct RootView: View {
    var body: some View {
        NavigationView {
            TabView {
                CarbonView()
                    .tabItem {
                        Image(systemName: "carbon.dioxide.cloud")
                        Text("Carbon")
                    }
                    .tag(1)
                WasteWaterView()
                    .tabItem {
                        Image(systemName: "water.waves")
                        Text("Water")
                    }
                    .tag(2)
            }.tint(.black.opacity(0.7)) //end tabview
        } // end nav view
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
