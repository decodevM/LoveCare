//
//  HomeView.swift
//  LoveCare
//
//  Created by Yacine on 9/1/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @State var isAnimatingImage: Bool = false
    @State var isMovingImage: Bool = false
    @State var isAnimatingUpOffset: Bool = false
    
    let feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                CircleGroupView(circleColor: .gray)
                Image("baby-boy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .scaleEffect(isAnimatingImage ? 1: 0.5)
                    .animation(.easeInOut(duration: 0.8), value: isAnimatingImage)
                    .offset(y: isMovingImage ? 10: -40)
                    .animation(.easeInOut(duration: 1).repeatForever().repeatForever(autoreverses: true), value: isMovingImage)
            }
            Spacer()
            Text("Having children just puts the whole world into perspective. Everything else just disappears.")
                .font(.title2)
                .foregroundColor(.gray)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .offset(y: isAnimatingUpOffset ? 0: 300)
                .animation(.easeInOut(duration: 0.8), value: isAnimatingUpOffset)
            Spacer()
            
            
            
            Button {
                playSound(sound: "success", type: "m4a")
                feedback.notificationOccurred(.success)
                isOnboarding.toggle()
            } label: {
                ZStack{
                    Capsule()
                        .fill(Color("ColorBlue"))
                    Label("Restart", systemImage: "arrow.triangle.2.circlepath.circle")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
                
            }
            .frame(height: 60)
            .offset(y: isAnimatingImage ? 0 : 300)
            .animation(.easeInOut(duration: 0.8), value: isAnimatingUpOffset)
            
            
            //            Button {
            //                // Goto onbarding view
            //            } label: {
            //                Image(systemName: "arrow.triangle.2.circlepath.circle")
            //                    .imageScale(.large)
            //                Text("Restart")
            //                    .font(.title)
            //                    .foregroundColor(.white)
            //                    .fontWeight(.medium)
            //            }
            //
            //            .buttonStyle(.borderedProminent)
            //            .buttonBorderShape(.capsule)
            //
            
        }.padding()
            .onAppear{
                isAnimatingImage = true
                isAnimatingUpOffset = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    isMovingImage = true
                }
               
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

