//
//  ThirdPlaceView.swift
//  EURO
//
//  Created by Shounak Jindam on 05/06/24.
//

import SwiftUI

struct ThirdPlaceView: View {
    
    @State private var selectedTeams: Set<String> = []
    
    @State private var showKnockoutSheet: Bool = false
    
    let teams = [
        ("Switzerland", "Group A", "ENG"),
        ("Finland", "Group B", "ESP"),
        ("Ukraine", "Group C", "ESP"),
        ("Czechia", "Group D", "GER"),
        ("Slovakia", "Group E", "ENG"),
        ("Portugal", "Group F", "FRA")
    ]
    
    var body: some View {
        VStack(spacing: 0){
            headerView
                .background {
                    FANTASYTheme.getColor(named: .thirdPlaceHeader)
                }
                .CFSDKcornerRadius(10, corners: [.topLeft,.topRight])
            teamsWithThirdPlace
                .background {
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                }
                .padding(.horizontal,6)
                .CFSDKcornerRadius(15, corners: [.bottomLeft,.bottomRight])
            if selectedTeams.count < 4 {
                Text("You still need to predict 4 best 3rd-placed teams")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.top, 20)
            }
        }
        .sheet(isPresented: $showKnockoutSheet) {
            knockoutStageBottomSheet
                .presentationCornerRadius(20)
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.hidden)
                .background {
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                }
        }
        .onChange(of: selectedTeams) { newValue in
            if newValue.count == 4 {
                showKnockoutSheet = true
            }
        }
    }
    
    var headerView: some View {
        VStack(spacing: 10) {
            Text("Predict the four best third-placed teams")
                .font(.title3)
                .foregroundStyle(.cfsdkWhite)
            Text("The four with the most points will progress to the knockout stage")
                .font(.subheadline)
                .foregroundStyle(.cfsdkWhite)
        }
        .padding()
    }
    
    var teamsWithThirdPlace: some View {
        VStack(spacing: 0) {
            ForEach(teams, id: \.0) { team in
                HStack {
                    Button(action: {
                        if selectedTeams.contains(team.0) {
                            selectedTeams.remove(team.0)
                        } else if selectedTeams.count < 4 {
                            selectedTeams.insert(team.0)
                        }
                    }) {
                        Image(systemName: selectedTeams.contains(team.0) ? "circle.fill" : "circle")
                            .foregroundColor(.white)
                    }
                    Image(team.2)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(.circle)
                    Text(team.0)
                        .foregroundColor(.cfsdkWhite)
                    Spacer()
                    Text(team.1)
                        .foregroundColor(.gray)
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                Divider()
                    .background(Color.white)
            }
        }
    }
    
    var knockoutStageBottomSheet: some View {
        ZStack {
            FANTASYTheme.getColor(named: .groupSheetBlue)
            VStack {
                Text("Good Work!")
                    .foregroundColor(.cfsdkWhite)
                Text("Now Lets move on the Knockout Stage!")
                    .foregroundColor(.cfsdkWhite)
                Button(action: {
                    
                }, label: {
                    Text("Continue")
                        .foregroundStyle(.cfsdkNeutral)
                        .padding(.horizontal, 140)
                        .padding(.vertical, 15)
                        .background {
                            FANTASYTheme.getColor(named: .CFSDKAccent1)
                        }
                        .CFSDKcornerRadius(10, corners: .allCorners)
                })
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ThirdPlaceView()
}
