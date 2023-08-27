//
//  CarbonView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/26/23.
//

import SwiftUI
import UserNotifications

struct CarbonView: View {
    @State private var reportedTons : String = "0.0"
    @State private var scoreColor : Color = .black.opacity(0.6)
    @State private var miles = ""
    @State private var servings = ""
    @State private var power = ""
    @State private var heat = ""
    private var bodyTextSize : CGFloat = 18
    private var toolTip = "The most common factors that contribute towards your carbon footprint are transportation, meat and beef consumption, electricity usage, and gas usage. Those are the big factors that went into deciding your score.\n\nTo improve your carbon footprint as an individual, look at these factors. Use public transportation and carpool. Eat more vegetables and swap the beef for poultry. Turn off lights and turn down AC to reduce your power usage. Finally, keep an eye on your gas usage and turn down the heat when you leave the house. The Earth can take a lot of hits...but not forever! Thanks for doing your part!"
    
    func sendNotif() {
        let content = UNMutableNotificationContent()
        content.title = "Nature's Calling!"
        content.body = "Let's Review Your Carbon Score for the Month!"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*7, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func sigmoid_score_calc(tons: Float) -> Float {
        // compares the float value of tons to the average of 1.3, and returns a rating of 1-10  (1 being the best 10 is awful)
        let k : Int = 2
        return 10 * (1 / (1 + pow(2.718, (Float(-1 * k) * (tons - 1.3)))))
    }
    func calculateScore(miles : String, servings : String, power : String, heat : String) {
        let unwrapped_miles = Float(miles) ?? 0
        let unwrapped_servings = Float(servings) ?? 0
        let unwrapped_power = Float(power) ?? 0
        let unwrapped_heat = Float(heat) ?? 0
        let one:Float = (unwrapped_miles*30.0*404.0/453.592)
        let two:Float = (unwrapped_servings*3*30)
        let three:Float = (unwrapped_power*0.822/0.169)
        let four:Float = (unwrapped_heat*11.7/1.395)
        let tons:Float = one + two + three + four
        let tons_rounded : Float = round(tons * 100 / 2000) / 100.0
        var sig_score : Float = sigmoid_score_calc(tons: tons_rounded)
        sig_score = round(sig_score * 10) / 10.0
        
        // change color of score and score #
        changeColor(sig_score: sig_score)
        if (tons_rounded < 99) {
            reportedTons = String(tons_rounded)
        } else {
            reportedTons = "99+"
        }
    }
    
    func changeColor (sig_score: Float) {
        // determine a color from the 0-10 emission level
        switch sig_score {
            case 8..<10.1:
                scoreColor = .red
            case 6..<8:
                scoreColor = .red.opacity(0.8)
            case 4..<6:
                scoreColor = .orange.opacity(0.7)
            case 2..<4:
                scoreColor = .black.opacity(0.6)
            case 0..<2:
                scoreColor = .black.opacity(0.6)
            default:
                scoreColor = .black.opacity(0.6)
        }
    }
    
    var body: some View {
        ZStack{
            // set background
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
                    Text("Monthly Electricity Bill").padding(5)
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
                    Text("Monthly Gas Bill").padding(5)
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
                
                HStack { // start buttons
                    Button("Get My Score") {
                        calculateScore(miles: miles, servings: servings, power: power, heat: heat)
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Enable Notifications") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            print(success ? "Authorization success" : "Authorization failed")
                            print(error?.localizedDescription ?? "")
                            if (success) {
                                print("Sent notif")
                                sendNotif()
                            }
                        }
                    }
                    .colorInvert()
                    .buttonStyle(.borderedProminent)
                } // end buttons
                
                HStack { // border
                    VStack {
                        Text(reportedTons) // line 1
                            .font(.custom("Fredoka", size: bodyTextSize*2))
                            .padding([.horizontal], 50).padding([.top], 15).padding([.bottom],5)
                            .foregroundColor(scoreColor)
                        HStack {// main message
                            Text("You emit")
                                .font(.custom("Fredoka", size: bodyTextSize))
                                .foregroundColor(.black.opacity(0.7))
                            Text(reportedTons)
                                .font(.custom("Fredoka", size: bodyTextSize))
                                .foregroundColor(.black.opacity(0.7))
                            Text("tons of CO2.")
                                .font(.custom("Fredoka", size: bodyTextSize))
                                .foregroundColor(.black.opacity(0.7))
                        }// line 2
                        Text("The average is 1.3/ week.") // line 3
                            .font(.custom("Fredoka", size: bodyTextSize))
                            .padding([.horizontal], 50).padding([.bottom], 15)
                            .foregroundColor(.black.opacity(0.7))
                    }.overlay(
                        RoundedRectangle(cornerRadius: 13).stroke(.black.opacity(0.6), lineWidth: 4)
                    )
                }// end border
                .padding(20)
                
                NavigationLink(destination: LearnView(bodyText: toolTip, backGround: .green.opacity(0.6))) {
                    Text("How Can I Reduce My Emissions?")
                }
                .buttonStyle(.borderedProminent)
                .colorInvert()
                
            }// end main vstack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
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
