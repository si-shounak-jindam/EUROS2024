//
//  ThirdPlaceView.swift
//  EURO
//
//  Created by Shounak Jindam on 05/06/24.
//

import SwiftUI

struct ThirdPlaceView: View {
    
    @EnvironmentObject var roundManager: RoundManager
    
    @State private var selectedTeams: Set<String> = []
    @State private var showKnockoutSheet: Bool = false
    @State private var showKnockoutBracket: Bool = false
    
    @Binding var thirdPlacedCountries: [String: Country?]
    @Binding var secondPlacedCountries: [String: Country?]
    @Binding var firstPlacedCountries: [String: Country?]
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
                .background (
                    FANTASYTheme.getColor(named: .thirdPlaceHeader)
                )
                .CFSDKcornerRadius(10, corners: [.topLeft, .topRight])
            teamsWithThirdPlace
                .background (
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                )
                .padding(.horizontal, 6)
                .CFSDKcornerRadius(15, corners: [.bottomLeft, .bottomRight])
            if selectedTeams.count < 4 {
                Text("You still need to predict 4 best 3rd-placed teams")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
        }
        .sheet(isPresented: $showKnockoutSheet) {
            knockoutStageBottomSheet
//                .presentationCornerRadius(20)
//                .presentationDetents([.fraction(0.2)])
//                .presentationDragIndicator(.hidden)
                .background (
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                )
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
                .foregroundColor(.cfsdkWhite)
            Text("The four with the most points will progress to the knockout stage")
                .font(.subheadline)
                .foregroundColor(.cfsdkWhite)
        }
        .padding()
    }
    
    var teamsWithThirdPlace: some View {
        VStack(spacing: 0) {
            ForEach(thirdPlacedCountries.keys.sorted(), id: \.self) { groupName in
                if let country = thirdPlacedCountries[groupName] {
                    HStack {
                        Button(action: {
                            if selectedTeams.contains(country?.name ?? .blank) {
                                selectedTeams.remove(country?.name ?? .blank)
                            } else if selectedTeams.count < 4 {
                                selectedTeams.insert(country?.name ?? .blank)
                            }
                        }) {
                            Image(systemName: selectedTeams.contains(country?.name ?? .blank) ? "circle.fill" : "circle")
                                .foregroundColor(.white)
                        }
                        Image(country?.imageName ?? .blank)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                        Text(country?.name ?? .blank)
                            .foregroundColor(.cfsdkWhite)
                        Spacer()
                        Text("Group \(groupName)")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    Divider()
                        .background(Color.white)
                }
            }
        }
    }
    
    var knockoutStageBottomSheet: some View {
        ZStack {
            FANTASYTheme.getColor(named: .groupSheetBlue)
            VStack {
                Text("Good Work!")
                    .foregroundColor(.cfsdkWhite)
                Text("Now Let's move on to the Knockout Stage!")
                    .foregroundColor(.cfsdkWhite)
                Button(action: {
                    showKnockoutBracket = true
                }, label: {
                    Text("Continue")
                        .foregroundColor(.cfsdkNeutral)
                        .padding(.horizontal, 140)
                        .padding(.vertical, 15)
                        .background (
                            FANTASYTheme.getColor(named: .CFSDKAccent1)
                        )
                        .CFSDKcornerRadius(10, corners: .allCorners)
                })
               
            }
        }
        .fullScreenCover(isPresented: $showKnockoutBracket, content: {
            KnockoutPOC(thirdPlacedCountries: $thirdPlacedCountries,
                        secondPlacedCountries: $secondPlacedCountries,
                        firstPlacedCountries: $thirdPlacedCountries)
        })
        .ignoresSafeArea()
    }
}
