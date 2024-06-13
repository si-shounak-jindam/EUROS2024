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
    
    @StateObject var scoreSheetViewModel = ScoreSheetViewModel()
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showBottomSheet: Bool = false
    
    
    @State private var countries: [Country] = [
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: "")
    ]
    
//    @State private var scoreSheetDetail: [ScoreSheetModel] = [
//        ScoreSheetModel(name: "Group Stage",
//                        description: "Predict each group's final standing.",
//                        points: "3 pts"),
//        ScoreSheetModel(name: "Knockout rounds",
//                        description: "Predict the winner of each tie.",
//                        points: "3 pts"),
//        ScoreSheetModel(name: "Contenders",
//                        description: "Get a bonus point for each semi-finalist and finalist you get right.",
//                        points: "+1 pt"),
//        ScoreSheetModel(name: "Late or edited bracket",
//                        description: "If you save after the knockout stage has started, you won't get any points.",
//                        points: "0 pts")
//    ]
    
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
                    .background {
                        FANTASYTheme.getColor(named: .groupHeaderBlue)
                    }
            } else {
                headerView
                    .padding(.vertical, 16)
                    .background {
                        FANTASYTheme.getColor(named: .groupHeaderBlue)
                    }
            }
            emptyGroup
              
        }
        .environment(\.editMode, $editMode)
        .onChange(of: countries) { _ in
                    updateThirdPlacedCountry()
                }
    }
    
    //MARK: - VIEWS
    
    var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Group " + "\(groupName)")
                    .foregroundStyle(.cfsdkAccent1)
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
                            } else {
                                Image(allTeams[index].imageName)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                            }
                        })
                        Text(allTeams[index].name.prefix(3).uppercased())
                            .foregroundStyle(.cfsdkWhite)
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
                        .foregroundStyle(.cfsdkAccent1)
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 40)
                Text("Drag teams to re-order")
                    .foregroundStyle(.cfsdkWhite)
            }
            FANTASYTheme.getImage(named: .Pattern)?
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 100)
        }
    }
    
    var emptyGroup: some View {
        VStack {
            List {
                ForEach(countries.indices, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                            .foregroundStyle(.cfsdkWhite)
                        Image(countries[index].imageName)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                        Text(countries[index].name)
                            .foregroundStyle(.cfsdkWhite)
                        
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
            .environment(\.editMode, .constant(countries.contains(where: { !$0.name.isEmpty }) ? EditMode.active : EditMode.inactive))
            .listStyle(PlainListStyle())
        }
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        countries.move(fromOffsets: indices, toOffset: newOffset)
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
    
    func updateThirdPlacedCountry() {
        if countries.count >= 3 {
            thirdPlacedCountry = countries[2]
        }   
    }
    
    var viewGroupDetailButton: some View {
        Button(action: {
            showBottomSheet.toggle()
        }, label: {
            Text("View Group \(groupName) details")
                .foregroundStyle(.cfsdkAccent1)
        })
        .sheet(isPresented: $showBottomSheet, content: {
            bottomSheet
                .presentationCornerRadius(20)
                .presentationDetents([.fraction(0.55)])
                .presentationDragIndicator(.hidden)
                .background {
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                }
        })
    }
    
    
    var bottomSheet: some View {
        ZStack {
            FANTASYTheme.getColor(named: .groupSheetBlue)
            VStack {
                HStack {
                    Text("Most popular Group \(groupName) prediction")
                        .font(.subheadline)
                        .foregroundStyle(.cfsdkWhite)
                        .padding([.top, .leading], 10)
                    Spacer()
                    Button(action: {
                        showBottomSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .tint(.cfsdkWhite)
                            .padding([.top, .trailing], 10)
                    })
                }
                .background {
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                }
                VStack {
                    ForEach(popularTeamPrediction.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .foregroundStyle(.cfsdkWhite)
                                .font(.subheadline)
                            Image(popularTeamPrediction[index].imageName)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            Text(popularTeamPrediction[index].name)
                                .foregroundStyle(.cfsdkWhite)
                            Spacer()
                        }
                        .padding()
                        Divider()
                            .background {
                                Color.white.opacity(0.5)
                            }
                    }
                    Divider()
                    HStack{
                        Button(action: {
                            scoreSheetViewModel.showScoreSheet.toggle()
                        }, label: {
                            Text("See how to score points")
                                .foregroundStyle(.cfsdkAccent1)
                        })
                        .padding()
                        Spacer()
                    }
                    .sheet(isPresented: $scoreSheetViewModel.showScoreSheet, content: {
                        ScorePointSheet()
                            .presentationCornerRadius(20)
                            .presentationDetents([.fraction(0.65)])
                            .presentationDragIndicator(.hidden)
                            .background {
                                FANTASYTheme.getColor(named: .groupSheetBlue)
                            }
                    })
                }
                
            }
        }
        .ignoresSafeArea()
    }
    
    
}


//struct GroupSelector_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupSelector(groupName: $groupName)
//    }
//}