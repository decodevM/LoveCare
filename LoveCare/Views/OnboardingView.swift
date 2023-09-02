//
//  OnboardingView.swift
//  LoveCare
//
//  Created by Yacine on 9/1/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var isAnimatingHeader: Bool = false
    @State var isAnimationFooter: Bool = false
    @State var isDragingImage: Bool = false
    
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack{
                
                // MARK: Header
                OnBoardingHeaderView(isDraging: $isDragingImage).foregroundColor(.white).offset(x: 0,y: isAnimatingHeader ? 0: -300)
                    .animation(.easeInOut(duration: 0.8), value: isAnimatingHeader)
                    .padding()
                Spacer()
                
                // MARK: Center
                OnBoardingBodyView(isDraging: $isDragingImage)
                    
                Spacer()
                
                // MARK: Footer
                OnBoardingStartButton()
                    .offset(x:0, y:isAnimationFooter ? 0 : 300)
                    .animation(.easeInOut(duration: 0.8), value: isAnimationFooter)
            }
        }.onAppear{
            isAnimatingHeader = true
            isAnimationFooter = true
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}



struct OnBoardingHeaderView: View {
    @Binding var isDraging: Bool
    var body: some View {
        VStack{
            Text(isDraging ? "& Care." : "Love").animation(.easeInOut(duration: 0.5))
                .font(.system(size: 80,weight: .bold))
            Text("Life doesn't come with a manual, it come with a mother")
                .font(.system(size: 25,weight: .regular))
        }.multilineTextAlignment(.center)
    }
}




struct OnBoardingBodyView: View{

    
    @State var isAnimating: Bool = false
    @State var offset: CGSize = .zero
    @Binding var isDraging: Bool
    var body: some View{
        ZStack{
            CircleGroupView(circleColor: .white)
                .offset(x: -offset.width)
                .rotationEffect(.degrees( Double(-offset.width / 15)))
                .blur(radius: abs(offset.width) / 5, opaque: false)
            Image("happy-pregnant")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .shadow(color: .black.opacity(0.3),radius: 8,x: 10,y:30)
                .overlay(alignment: .bottom){
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 40,weight: .ultraLight,design: .rounded))
                        .foregroundColor(.white)
                        .opacity(abs(offset.width) != 0 ? 0 : 1)
                }
                .scaleEffect(isAnimating ? 1: 0.5)
                .animation(.easeInOut(duration: 0.8), value: isAnimating)
                .onAppear{
                    isAnimating = true
                }
                .offset(x: offset.width, y: 0)
                .rotationEffect(.degrees(Double(offset.width / 15)))
                .gesture(DragGesture().onChanged({ gesture in
                    if abs(gesture.translation.width) <= 300{
                        offset = gesture.translation
                        isDraging = true
                    }
                }).onEnded({ _ in
                    withAnimation {
                        offset = .zero
                        isDraging = false
                    }
                }))
        }
        
    }
}


struct OnBoardingStartButton: View{
    @AppStorage("isOnboarding") var isOnboarding = true
    @State var offset: CGSize = .zero
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 20
    let feedback = UINotificationFeedbackGenerator()
    var body: some View{
        ZStack{
            // 1: Background
            Capsule()
                .fill(.white.opacity(0.2))
            Capsule().fill(.white.opacity(0.2))
                .padding(8)
            
            // 2: Text
            Text("Start")
                .font(.system(size: 30,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            
            // 3: Capsule Dynamic
            HStack{
                Capsule()
                    .fill(Color("ColorRed"))
                    .frame(width: 100 + offset.width)
                    
                Spacer(minLength: 0)
                
            }
            // 4: Dragable circle
            HStack{
                ZStack{
                    Circle()
                        .fill(Color("ColorRed"))
                    Circle()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    Image(systemName: "chevron.right.2")
                        .font(.system(size: 25,weight: .bold,design: .rounded))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .offset(x: offset.width)
            .animation(.easeInOut(duration: 0.5), value: offset != .zero)
            .gesture(DragGesture().onChanged({ gesture in
                if(gesture.translation.width < 0){
                    return
                }
                if gesture.translation.width > buttonWidth{
                    offset.width = buttonWidth - 100
                }
                
//                if abs(gesture.translation.width) < (buttonWidth / 2){
//
//                }else{
//                    offset.width = buttonWidth - 100
//                }
                
                offset = gesture.translation
            }).onEnded({ gesture in
                withAnimation (.easeInOut(duration: 0.5)){
                    offset.width = abs(gesture.translation.width) < ((buttonWidth-100)/2) ? 0 : buttonWidth - 100
                    
                }
                if offset.width != 0{
                    playSound(sound: "chimeup", type: "mp3")
                    feedback.notificationOccurred(.success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        isOnboarding.toggle()
                    }
                }else{
                    feedback.notificationOccurred(.error)
                }
                
            }))
        }
        .frame( width: buttonWidth, height: 100)
        .padding()
    }
}
