//
//  CarbonView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/26/23.
//

import SwiftUI

class Calculator {
    var miles : Int
    var meat : Int
    var electricity : Int

    
    init() {
        self.miles = 0
        self.meat = 0
        self.electricity = 0
    }
    
    
    
}
func calculateScore(miles : Float, servings : Float, power : Float, heat : Float) {
    //(miles*30*404.453.592) + (servings*3*30)+(power*.822/.169)+(heat*11.7/1.395)
    return
}
struct CarbonView: View {
    @State private var nameComponents = "0"
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .green.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack () {// start main vstack
                HStack { // start title
                    Text("My Carbon Score")
                        .font(.custom("Fredoka", size: 38))
                    Image(uiImage: UIImage(named: "leaf")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75)
                } // end title
                HStack {
                    Text("Miles per day").padding(5)
                    TextField(
                        "Miles...",
                        text: $nameComponents
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .padding(5)
                }.padding([.horizontal], 15)
                
                Text(nameComponents.debugDescription)
                    .font(.system(.body))
                Button("Remind Me") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        print(success ? "Authorization success" : "Authorization failed")
                        print(error?.localizedDescription ?? "")
                        if (success) {
                            
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }// end main vstack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .border(.secondary)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            //.frame(maxWidth: <#T##CGFloat?#>: .infinity, height: .infinity)
            
        } // end zstack
    }
}

struct CarbonView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonView()
    }
}
