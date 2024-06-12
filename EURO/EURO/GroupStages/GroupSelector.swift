//
//  GroupSelector.swift
//  EURO
//
//  Created by Shounak Jindam on 03/06/24.
//

import SwiftUI

struct GroupSelector: View {
    
    @Binding var groupName: String
    @Binding var progress: Double
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showBottomSheet: Bool = false
    @State private var showScoreSheet: Bool = false
    
    @State private var countries: [Country] = [
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: "")
    ]
    
    @State private var scoreSheetDetail: [ScoreSheetModel] = [
        ScoreSheetModel(name: "Group Stage",
                        description: "Predict each group's final standing.",
                        points: "3 pts"),
        ScoreSheetModel(name: "Knockout rounds",
                        description: "Predict the winner of each tie.",
                        points: "3 pts"),
        ScoreSheetModel(name: "Contenders",
                        description: "Get a bonus point for each semi-finalist and finalist you get right.",
                        points: "+1 pt"),
        ScoreSheetModel(name: "Late or edited bracket",
                        description: "If you save after the knockout stage has started, you won't get any points.",
                        points: "0 pts")
    ]
    
    @State private var editMode: EditMode = .active
    
    @State private var allTeams: [Country] = [
        Country(name: "England", imageName: "ENG"),
        Country(name: "Spain", imageName: "ESP"),
        Country(name: "Germany", imageName: "GER"),
        Country(name: "France", imageName: "FRA")
    ]
    
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
                    .padding(.horizontal, 0)
                    .background {
                        FANTASYTheme.getColor(named: .groupHeaderBlue)
                    }
            } else {
                headerView
                    .padding(.vertical, 16)
                    .padding(.horizontal, 0)
                    .background {
                        FANTASYTheme.getColor(named: .groupHeaderBlue)
                    }
            }
            emptyGroup
                .padding(.top, 0)
        }
        .environment(\.editMode, $editMode)
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
    
    var viewGroupDetailButton: some View {
        Button(action: {
            showBottomSheet.toggle()
        }, label: {
            Text("View Group A details")
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
                    Text("Most popular Group E prediction")
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
                            showScoreSheet.toggle()
                        }, label: {
                            Text("See how to score points")
                                .foregroundStyle(.cfsdkAccent1)
                        })
                        .padding()
                        Spacer()
                    }
                    .sheet(isPresented: $showScoreSheet, content: {
                        scorePointSheet
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
    
    var scorePointSheet: some View {
        ZStack {
            FANTASYTheme.getColor(named: .CFSDKPrimary3)
            VStack {
                HStack {
                    Text("How to Score Points")
                        .font(.title3.bold())
                        .foregroundStyle(.cfsdkWhite)
                        .padding([.top, .leading], 20)
                    Spacer()
                    Button(action: {
                        showScoreSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .tint(.cfsdkWhite)
                            .padding([.top, .trailing], 10)
                    })
                    
                }
                Divider()
                    .background {
                        Color.white.opacity(0.5)
                    }
                ForEach(scoreSheetDetail.indices, id: \.self) { index in
                    HStack {
                        Text(scoreSheetDetail[index].name)
                            .font(.title3.bold())
                            .foregroundStyle(.cfsdkWhite)
                            .padding([.top, .leading], 10)
                        Spacer()
                        Text(scoreSheetDetail[index].points)
                            .font(.title3.bold())
                            .foregroundStyle(scoreSheetDetail[index].points == "0 pts" ? .cfsdkAccentError: .cfsdkWhite)
                            .padding([.top, .trailing], 10)
                    }
                    HStack{
                        Text(scoreSheetDetail[index].description)
                            .font(.subheadline)
                            .foregroundStyle(.cfsdkWhite).opacity(0.7)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    .padding(.leading,10)
                    Divider()
                        .background {
                            Color.white.opacity(0.5)
                        }
                }
                
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text("Read full article")
                            .foregroundStyle(.cfsdkAccent1)
                    })
                    .padding()
                    Spacer()
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
