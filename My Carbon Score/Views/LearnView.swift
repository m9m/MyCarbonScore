//
//  LearnView.swift
//  My Carbon Score
//
//  Created by Keegan Murphy on 8/26/23.
//

import SwiftUI

struct LearnView: View {
    var bodyText : String
    var backGround : Color
    var body: some View {
        VStack {
            VStack () {// start main vstack
                HStack { // start title
                    Text("My Emissions are High...\nHow CAn I Reduce Them?")
                        .font(.custom("Fredoka", size: 30))
                }.padding([.horizontal], 30).padding([.vertical], 10) // end title
                Divider().padding([.horizontal], 30)
            } //end header
            
            Text("Daily Driving Milage").padding(5)
                .font(.custom("Fredoka", size: 20))
                .padding([.horizontal], 15) //end miles
            Spacer()
            
            
        }.background(backGround) // end zstack
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView(bodyText: "hi", backGround: .green)
    }
}
