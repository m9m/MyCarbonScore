//
//  CarbonView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/26/23.
//

import SwiftUI

struct CarbonView: View {
    @State private var nameComponents = "0"
    var body: some View {
        ZStack{
            Color.gray
                .opacity(0.2)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("My Carbon Score")
                        .font(.custom("Fredoka", size: 38))
                    Image(uiImage: UIImage(named: "leaf")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75)
                }
                
                TextField(
                    "Field 1",
                    text: $nameComponents
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                
                Text(nameComponents.debugDescription)
                    .font(.system(.body))
                Button("Schedule Notification") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        print(success ? "Authorization success" : "Authorization failed")
                        print(error?.localizedDescription ?? "")
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .border(.secondary)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        } // end zstack
    }
}

struct CarbonView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonView()
    }
}
