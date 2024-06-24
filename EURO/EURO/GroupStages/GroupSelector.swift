//
//  GroupSelector.swift
//  EURO
//
//  Created by Shounak Jindam on 03/06/24.
//

import SwiftUI

struct GroupSelector: View {
    
    let groupName: String
    @Binding var progress: Double
    @Binding var thirdPlacedCountry: Country?
    @Binding var secondPlacedCountry: Country?
    @Binding var firstPlacedCountry: Country?
    
    @StateObject var scoreSheetViewModel = ScoreSheetViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showBottomSheet: Bool = false
    
    @State private var countries: [Country] = [
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: "")
    ]
    
    @State private var editMode: EditMode = .active
    
    @Binding var allTeams: [Country]
    @State private var popularTeamPrediction: [Country] = [
        Country(name: "England", imageName: "ENG"),
        Country(name: "Spain", imageName: "ESP"),
        Country(name: "Germany", imageName: "GER"),
        Country(name: "France", imageName: "FRA")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            if countries.filter({ !$0.name.isEmpty }).count == 4 {
                successHeaderView
                    .background (
                        FANTASYTheme.getColor(named: .groupHeaderBlue)
                    )
                    .CFSDKcornerRadius(20, corners: [.topLeft, .topRight])
            } else {
                headerView
                    .padding(.vertical, 16)
                    .background (
                        FANTASYTheme.getColor(named: .groupHeaderBlue)
                    )
                    .CFSDKcornerRadius(20, corners: [.topLeft, .topRight])
            }
            emptyGroup
        }
        .environment(\.editMode, $editMode)
        .onChange(of: countries) { _ in
            updatePlacedCountries()
        }
    }
    
    // MARK: - VIEWS
    
    var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Group " + "\(groupName)")
                    .foregroundColor(.cfsdkAccent1)
                Spacer()
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 40)
            HStack(spacing: 50) {
                ForEach(allTeams.indices, id: \.self) { index in
                    VStack {
                        Button(action: {
                            addCountryIfNeeded(allTeams[index])
                            if progress < 1.0 {
                                withAnimation {
                                    progress += 1/28
                                }
                            }
                        }, label: {
                            if allTeams[index].isSelected {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                                
                            } else {
                                Image(allTeams[index].imageName)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                            }
                        })
                        Text(allTeams[index].name.prefix(3).uppercased())
                            .foregroundColor(.cfsdkWhite)
                    }
                    .disabled(allTeams[index].isSelected)
                }
            }
        }
    }
    
    var successHeaderView: some View {
        HStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Group " + "\(groupName)")
                        .foregroundColor(.cfsdkAccent1)
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 40)
                Text("Drag teams to re-order")
                    .padding(.horizontal, 20)
                    .foregroundColor(.cfsdkWhite)
            }
            FANTASYTheme.getImage(named: .Pattern)?
                .resizable()
                .scaledToFit()
        }
    }
    
    var emptyGroup: some View {
        VStack {
            List {
                ForEach(countries.indices, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                            .foregroundColor(.cfsdkWhite)
                        Image(countries[index].imageName)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(25)
                            .overlay(
                                countries[index].imageName != "" ? RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2) : nil
                            )
                            .padding(.vertical,2.5)
                        Text(countries[index].name)
                            .foregroundColor(.cfsdkWhite)
                    }
                }
                .onMove(perform: move)
                .listRowBackground(FANTASYTheme.getColor(named: .CFSDKPrimary3))
                HStack {
                    Spacer()
                    viewGroupDetailButton
                    Spacer()
                }
                .listRowBackground(FANTASYTheme.getColor(named: .CFSDKPrimary3))
            }
            .frame(height: 310)
            .CFSDKcornerRadius(20, corners: [.bottomLeft, .bottomRight])
            .environment(\.editMode, .constant(countries.contains(where: { !$0.name.isEmpty }) ? EditMode.active : EditMode.inactive))
            .listStyle(PlainListStyle())
        }
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        countries.move(fromOffsets: indices, toOffset: newOffset)
        updatePlacedCountries()
    }
    
    func addCountryIfNeeded(_ country: Country) {
        if let index = countries.firstIndex(where: { $0.name.isEmpty && !$0.isSelected }) {
            countries[index] = country
            countries[index].isSelected = true
            
            if let teamIndex = allTeams.firstIndex(of: country) {
                allTeams[teamIndex].isSelected = true
            }
        }
    }
    
    func updatePlacedCountries() {
        if countries.count >= 1 {
            firstPlacedCountry = countries[0]
        }
        if countries.count >= 2 {
            secondPlacedCountry = countries[1]
        }
        if countries.count >= 3 {
            thirdPlacedCountry = countries[2]
        }
    }
    
    var viewGroupDetailButton: some View {
        Button(action: {
            showBottomSheet.toggle()
        }, label: {
            Text("View Group \(groupName) details")
                .foregroundColor(.cfsdkAccent1)
        })
        .sheet(isPresented: $showBottomSheet, content: {
            bottomSheet
                .clearModalBackground()
        })
    }
    
    var bottomSheet: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack {
                HStack {
                    Text("Most popular Group \(groupName) prediction")
                        .font(.subheadline)
                        .foregroundColor(.cfsdkWhite)
                        .padding([.top, .leading], 10)
                    Spacer()
                    Button(action: {
                        showBottomSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .accentColor(.cfsdkWhite)
                            .padding([.top, .trailing], 10)
                    })
                }
                .background(
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                )
                VStack {
                    ForEach(popularTeamPrediction.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .foregroundColor(.cfsdkWhite)
                                .font(.subheadline)
                            Image(popularTeamPrediction[index].imageName)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            Text(popularTeamPrediction[index].name)
                                .foregroundColor(.cfsdkWhite)
                            Spacer()
                        }
                        .padding()
                        Divider()
                            .background(
                                Color.white.opacity(0.5)
                            )
                    }
                    Divider()
                    HStack {
                        Button(action: {
                            scoreSheetViewModel.showScoreSheet.toggle()
                        }, label: {
                            Text("See how to score points")
                                .foregroundColor(.cfsdkAccent1)
                        })
                        .padding()
                        Spacer()
                    }
                    .sheet(isPresented: $scoreSheetViewModel.showScoreSheet, content: {
                        ScorePointSheet()
                            .clearModalBackground()
                    })
                }
            }
            .background(FANTASYTheme.getColor(named: .groupSheetBlue))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

