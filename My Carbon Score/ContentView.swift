//
//  ContentView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var nameComponents = "0"
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("My Carbon Score")
                    .font(.custom("Fredoka", size: 30px))
            }
                
            TextField(
                "Field 1",
                text: $nameComponents
            )
            .padding()
            .keyboardType(.numberPad)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            
            Text(nameComponents.debugDescription)
                .font(.system(.body))
        }
        .border(.secondary)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
