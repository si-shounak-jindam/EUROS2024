//
//  GameStarterView.swift
//  EURO
//
//  Created by Shounak Jindam on 04/06/24.
//

import SwiftUI

struct GameStarterView: View {
    @State private var showGroupSelector: Bool = false
    var body: some View {
        ZStack {
            FANTASYTheme.getColor(named: .CFSDKPrimary3)
                .ignoresSafeArea()
            VStack {
                TabView {
                    OnboardingView(systemImageName: FANTASYTheme.getImage(named: .onboarding1), title: "Plot the Road to the Final", desciption: "Pick the winner of each tie to build your EURO 2024 bracket")
                    OnboardingView(systemImageName: FANTASYTheme.getImage(named: .onboarding2), title: "Track your score", desciption: "Get points for every winner your guessed correctly. Can you get them all right?")
                    OnboardingView(systemImageName: FANTASYTheme.getImage(named: .onboarding3), title: "Take on your friends", desciption: "Share your bracket and challenge your friends to make their own")
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                
                
                RoundedButton(title: "Play Now", backgroundColor: .cfsdkAccent1, foregroundColor: .cfsdkNeutral) {
                    showGroupSelector = true
                }
                .padding(40)
            }
        }
        .fullScreenCover(isPresented: $showGroupSelector, content: {
            GroupStages()
        })
    }
}

struct OnboardingView: View {
    let systemImageName: Image?
    let title: String
    let desciption: String
    
    var body: some View {
        VStack(spacing: 20) {
            systemImageName?
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(title)
                .font(.headline.bold())
                .foregroundColor(.cfsdkWhite)
            
            Text(desciption)
                .multilineTextAlignment(.center)
                .foregroundColor(.cfsdkWhite)
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    GameStarterView()
}
