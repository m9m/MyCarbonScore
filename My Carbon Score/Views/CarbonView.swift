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
func calculateScore(miles : Float, servings : Float, power : Float, heat : Float) -> Float {
    let score:Float = (miles*30*404/453.592) + (servings*3*30)+(power*0.822/0.169)+(heat*11.7/1.395)
    return round(score * 100) / 100.0
}
struct CarbonView: View {
    
    @State private var miles = ""
    @State private var servings = ""
    @State private var power = ""
    @State private var heat = ""
    private var bodyTextSize : CGFloat = 18
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .green.opacity(0.6), .green.opacity(0.6), .green]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack () {// start main vstack
                VStack {// start header
                    HStack { // start title
                        Text("My Carbon Score")
                            .font(.custom("Fredoka", size: 30))
                    }.padding([.horizontal], 30).padding([.vertical], 10) // end title
                    Divider().padding([.horizontal], 30)
                    HStack {
                        Text("Carbon Footprint")
                            .font(.custom("Fredoka", size: 42))
                        Image(uiImage: UIImage(named: "leaf")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90)
                    }.padding([.horizontal], 30).frame(alignment: .center)
                } //end header
                HStack { // start miles
                    Text("Daily Driving Milage").padding(5)
                    TextField(
                        "Miles...",
                        text: $miles
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end miles
                .frame(alignment: .trailing)
                
                HStack { // start meat
                    Text("Servings of Meat per Day").padding(5)
                    TextField(
                        "Servings...",
                        text: $servings
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end miles
                
                
                HStack { // start power
                    Text("Monthly Power Bill").padding(5)
                    TextField(
                        "$...",
                        text: $power
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end power
                
                
                HStack { // start heat
                    Text("Monthly Heat Bill").padding(5)
                    TextField(
                        "$...",
                        text: $heat
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end heat
                
                Text(heat.debugDescription)
                    .font(.system(.body))
                Button("Get My Score") {
                }
                .buttonStyle(.borderedProminent)
                .colorInvert()
                
                Button("Enable Notifications") {
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
            //.border(.secondary)
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
