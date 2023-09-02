//
//  ContentView.swift
//  LoveCare
//
//  Created by Yacine on 9/1/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    var body: some View {
        if isOnboarding{
            OnboardingView()
        }else{
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
