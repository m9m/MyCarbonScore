//
//  SwiftUIView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/26/23.
//

import SwiftUI

struct WasteWaterView: View {
    @State private var reportedConsumed : String = "0"
    @State private var scoreColor : Color = .black.opacity(0.6)
    @State private var shower = ""
    @State private var toilet = ""
    @State private var cycles = ""
    @State private var loads = ""
    private var bodyTextSize : CGFloat = 18
    private var toolTip = "The most common factors that contribute towards your water consumption are showers, toilet flushes, laundry cycles, and dishwasher loads. Those are the big factors that went into deciding your score.\n\nTo reduce your water consumption as an individual, look at these factors. Keep an eye on your minutes in the shower and use conservative shower heads. Don't use the toilet as a wastebasket and flush tissues. Also, keep an eye on how many laundry loads you are throwing in and make the most of the space in the washer. Finally, use the most of the space in your washing machine (there are also lower water consumotion appliances to consider). There's a lot of fresh water, but not unlimited. Thanks for doing your part in creating generational sustainability!"
    
    
    func sigmoid_score_calc(consumed: Float) -> Float {
        // compares the float value of tons to the average of 1.3, and returns a rating of 1-10  (1 being the best 10 is awful)
        let k : Int = 2
        return 10 * (1 / (1 + pow(2.718, (Float(-1 * k) * (consumed - 574)))))
    }
    func calculateScore(shower : String, toilet : String, cycles : String, loads : String) {
        let unwrapped_shower = Float(shower) ?? 0
        let unwrapped_toilet = Float(toilet) ?? 0
        let unwrapped_cycles = Float(cycles) ?? 0
        let unwrapped_loads = Float(loads) ?? 0
        let one:Float = (unwrapped_shower*1.8*7)
        let two:Float = (unwrapped_toilet*3*7)
        let three:Float = (unwrapped_cycles*20)
        let four:Float = (unwrapped_loads*8)
        let consumption:Float = one + two + three + four
        let consumption_rounded : Float = round(consumption)
        var sig_score : Float = sigmoid_score_calc(consumed: consumption_rounded)
        sig_score = round(sig_score * 10) / 10.0
        
        // change color of score and score #
        changeColor(sig_score: sig_score)
        if (consumption_rounded > 99) {
            reportedConsumed = String(consumption_rounded)
        } else {
            reportedConsumed = "99+"
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
            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .teal.opacity(0.6), .teal.opacity(0.6), .teal]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack () {// start main vstack
                VStack {// start header
                    HStack { // start title
                        Text("My Carbon Score")
                            .font(.custom("Fredoka", size: 30))
                    }.padding([.horizontal], 30).padding([.vertical], 10) // end title
                    Divider().padding([.horizontal], 30)
                    HStack {
                        Text("Waste Water")
                            .font(.custom("Fredoka", size: 42))
                        Image(uiImage: UIImage(named: "drop")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90)
                    }.padding([.horizontal], 30).frame(alignment: .center)
                } //end header
                HStack { // start shower
                    Text("Daily Minutes Showering").padding(5)
                    TextField(
                        "Minutes...",
                        text: $shower
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end shower
                .frame(alignment: .trailing)
                
                HStack { // start toilet
                    Text("Daily Toilet Flushes").padding(5)
                    TextField(
                        "Flushes...",
                        text: $toilet
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end toilet
                
                
                HStack { // start cycles
                    Text("Weekly Laundry Loads").padding(5)
                    TextField(
                        "Loads...",
                        text: $cycles
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end cycles
                
                
                HStack { // start loads
                    Text("Weekly Dishwasher Loads").padding(5)
                    TextField(
                        "Loads...",
                        text: $loads
                    )
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .padding(5)
                }
                .font(.custom("Fredoka", size: bodyTextSize))
                .padding([.horizontal], 15) //end loads
                
                HStack { // start buttons
                    Button("Get My Score") {
                        calculateScore(shower: shower, toilet: toilet, cycles: cycles, loads: loads)
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Enable Notifications") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            print(success ? "Authorization success" : "Authorization failed")
                            print(error?.localizedDescription ?? "")
                            if (success) {
                                
                            }
                        }
                    }
                    .colorInvert()
                    .buttonStyle(.borderedProminent)
                } // end buttons
                
                HStack { // border
                    VStack {
                        Text(reportedConsumed) // line 1
                            .font(.custom("Fredoka", size: bodyTextSize*2))
                            .padding([.horizontal], 50).padding([.top], 15).padding([.bottom],5)
                            .foregroundColor(scoreColor)
                        HStack {// main message
                            Text("You use")
                                .font(.custom("Fredoka", size: bodyTextSize))
                                .foregroundColor(.black.opacity(0.7))
                            Text(reportedConsumed)
                                .font(.custom("Fredoka", size: bodyTextSize))
                                .foregroundColor(.black.opacity(0.7))
                            Text("gal. of water.")
                                .font(.custom("Fredoka", size: bodyTextSize))
                                .foregroundColor(.black.opacity(0.7))
                        }// line 2
                        Text("The average is 574/week.") // line 3
                            .font(.custom("Fredoka", size: bodyTextSize))
                            .padding([.horizontal], 50).padding([.bottom], 15)
                            .foregroundColor(.black.opacity(0.7))
                    }.overlay(
                        RoundedRectangle(cornerRadius: 13).stroke(.black.opacity(0.6), lineWidth: 4)
                    )
                }// end border
                .padding(20)
                
                NavigationLink(destination: LearnView(bodyText: toolTip, backGround: .teal.opacity(0.6))) {
                    Text("How Can I Reduce My Usage?")
                }
                .buttonStyle(.borderedProminent)
                .colorInvert()
                
            }// end main vstack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        } // end zstack}
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WasteWaterView()
    }
}
