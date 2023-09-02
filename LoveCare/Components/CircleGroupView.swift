//
//  CircleGroupView.swift
//  LoveCare
//
//  Created by Yacine on 9/1/23.
//

import SwiftUI

struct CircleGroupView: View {
    var circleColor: Color = .gray
    
    @State var isAnimating: Bool = false
    var body: some View {
        ZStack{
            Circle()
                .stroke(circleColor.opacity(0.2),lineWidth: 40)
                
            Circle()
                .stroke(circleColor.opacity(0.2),lineWidth: 80)
                
        }.frame(width: 300,height: 300,alignment: .center)
            .scaleEffect(isAnimating ?1 : 0.5)
            
            .animation(Animation.easeInOut(duration: 0.8), value: isAnimating)
            .onAppear{
                isAnimating = true
            }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGroupView()
    }
}
