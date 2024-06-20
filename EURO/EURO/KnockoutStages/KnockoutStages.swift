//
//  KnockoutStages.swift
//  EURO
//
//  Created by Shounak Jindam on 04/06/24.
//

import SwiftUI

struct KnockoutStages: View {
    @State private var selectedTeamsRoundOf8: [FirstTeam?] = Array(repeating: nil, count: 8)
    @State private var selectedTeamsSemiFinal: [FirstTeam?] = Array(repeating: nil, count: 4)
    @State private var selectedTeamsFinal: [FirstTeam?] = Array(repeating: nil, count: 2)
    @State private var selectedTeamWinner: FirstTeam? = nil
    @State private var isTouched: Bool = false
    
    
    var body: some View {
        ZStack {
            FANTASYTheme.getColor(named: .CFSDKNeutral)
                .ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView([.horizontal, .vertical]) {
                    HStack {
                        RoundOf16View
                        RoundOfEightEmptyView
                        SemiFinalWithEmptyView
                        //SemiFinal
                        Final
                        Winner
                        // .frame(width: 100, height: 400)
    //                        .scrollTransition { content, phase in
    //                            content
    //                                .opacity(phase.isIdentity ? 1 : 0.3)
    //                                .scaleEffect(x: phase.isIdentity ? 2.0 : 0.3,
    //                                             y: phase.isIdentity ? 1.0 : 0.3)
    //                        }
                    }
                }
            }
//            .scrollTargetLayout()
//            .scrollTargetBehavior(.paging)
            .onTapGesture {
                isTouched = true
            }
        }
    }
    
    var RoundOfEight: some View {
            VStack {
                Text("Round of 8")
                    .foregroundColor(.cfsdkWhite)
                    .font(.largeTitle)
                    .padding()
                ForEach(0..<4, id: \.self) { index in
                    if let team1 = selectedTeamsRoundOf8[index * 2], let team2 = selectedTeamsRoundOf8[index * 2 + 1] {
                        rectangle(firstTeam: team1, secondTeam: team2, round: .semiFinal, matchIndex: index, selectedTeams: $selectedTeamsSemiFinal)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    } else {
                        emptyRectangle(round: .semiFinal, selectedTeams: $selectedTeamsSemiFinal)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
        
        var RoundOfEightEmptyView: some View {
            VStack {
                Text("Round of 8")
                    .foregroundColor(.cfsdkWhite)
                    .font(.largeTitle)
                    .padding()
                ForEach(0..<8){ index in
                    if index % 2 == 0 {
                        EmptyView()
                    } else {
                        Spacer()
                        emptyRectangle(round: .semiFinal, selectedTeams: $selectedTeamsSemiFinal)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
    var SemiFinal: some View {
        VStack {
            Text("Semi-Final")
                .foregroundColor(.cfsdkWhite)
                .font(.largeTitle)
                .padding()
            ForEach(0..<2, id: \.self) { index in
                if let team1 = selectedTeamsSemiFinal[index * 2], let team2 = selectedTeamsSemiFinal[index * 2 + 1] {
                    rectangle(firstTeam: team1, secondTeam: team2, round: .final, matchIndex: index, selectedTeams: $selectedTeamsFinal)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                } else {
                    emptyRectangle(round: .final, selectedTeams: $selectedTeamsFinal)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }
            }
        }
    }
    
    var RoundOf16View: some View{
        VStack {
            Text("Round of 16")
                .foregroundColor(.cfsdkWhite)
                .font(.largeTitle)
                .padding()
            ForEach(0..<8, id: \.self) { index in
                rectangle(firstTeam: FirstTeam.allCases[index * 2], secondTeam: FirstTeam.allCases[index * 2 + 1], round: .roundOf8, matchIndex: index, selectedTeams: $selectedTeamsRoundOf8)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
        }
    }
    
    var SemiFinalWithEmptyView: some View {
        VStack {
            Text("Semi-Final")
                .foregroundColor(.cfsdkWhite)
                .font(.largeTitle)
                .padding()
            ForEach(0..<2, id: \.self) { index in
                Spacer(minLength: isTouched ? 100 : 0)
                if let team1 = selectedTeamsSemiFinal[index * 2], let team2 = selectedTeamsSemiFinal[index * 2 + 1] {
                    
                    rectangle(firstTeam: team1, secondTeam: team2, round: .final, matchIndex: index, selectedTeams: $selectedTeamsFinal)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    
                } else {
                    emptyRectangle(round: .final, selectedTeams: $selectedTeamsFinal)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }
                Spacer(minLength: isTouched ? 100 : 0)
            }
        }
    }
    
    var Final: some View {
        VStack {
            Text("Final")
                .foregroundColor(.cfsdkWhite)
                .font(.largeTitle)
                .padding()
            if let team1 = selectedTeamsFinal[0], let team2 = selectedTeamsFinal[1] {
                rectangle(firstTeam: team1, secondTeam: team2, round: .winner, matchIndex: 0, selectedTeams: .constant([selectedTeamWinner]))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            } else {
                emptyRectangle(round: .winner, selectedTeams: .constant([selectedTeamWinner]))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
        }
    }
    
    var Winner: some View {
        VStack {
            Text("Winner")
                .font(.largeTitle)
                .foregroundColor(.cfsdkWhite)
                .padding()
            if let team = selectedTeamWinner {
                Text(team.rawValue)
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
    


    
    func rectangle(firstTeam: FirstTeam, secondTeam: FirstTeam?, round: Round, matchIndex: Int, selectedTeams: Binding<[FirstTeam?]>) -> some View {
        Rectangle()
            .foregroundColor(.blue).opacity(0.5)
            .frame(width: 300, height: 150, alignment: .center)
            .overlay (
                VStack {
                    Button(action: {
                        moveToNextRound(selectedTeam: firstTeam, round: round, matchIndex: matchIndex, selectedTeams: selectedTeams)
                    }) {
                        HStack {
                            FANTASYTheme.getImage(named: .FRA)
                        Text(firstTeam.rawValue)
                                .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "circle")
                            .accentColor(.black)
                    }
                }
                .padding(10)
                    
                    Divider()
                        .background (
                            Color.white
                        )
                    
                    if let secondTeam = secondTeam {
                        Button(action: {
                            moveToNextRound(selectedTeam: secondTeam, round: round, matchIndex: matchIndex, selectedTeams: selectedTeams)
                        }) {
                            HStack {
                                FANTASYTheme.getImage(named: .ENG)
                                Text(secondTeam.rawValue)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "circle")
                                    .accentColor(.black)
                            }
                        }
                        .padding(10)
                    }
                    
                    Divider()
                        .background (
                            Color.white
                        )
                    
                    Button(action: {
                        
                    }) {
                        Text("View Details")
                            .foregroundColor(.yellow)
                            .padding(5)
                    }
                }
                .padding(.bottom, 10)
            )
    }
    
    func emptyRectangle(round: Round, selectedTeams: Binding<[FirstTeam?]>) -> some View {
        Rectangle()
            .foregroundColor(.blue).opacity(0.5)
            .frame(width: 300, height: 150, alignment: .center)
            .overlay (
                VStack {
                    HStack {
//                        Image(systemName: "heart.fill")
//                        Text("")
                        Spacer()
                        Button(action: {
                            // No action needed for TBD
                        }) {
                            Image(systemName: "circle")
                                .accentColor(.black)
                        }
                    }
                    .padding(10)
                    
                    Divider()
                        .background (
                            Color.white
                        )
                    
                    HStack {
//                        Image(systemName: "heart.fill")
//                            .accentColor(.black)
//                        Text("")
                        Spacer()
                        Button(action: {
                            // No action needed for TBD
                        }) {
                            Image(systemName: "circle")
                                .accentColor(.black)
                        }
                    }
                    .padding(10)
                    
                    Divider()
                        .background (
                            Color.white
                        )
                    
                    Button(action: {
                        
                    }) {
                        Text("View Details")
                            .foregroundColor(.yellow)
                            .padding(5)
                    }
                }
                .padding(.bottom, 10)
            )
    }
    
     func calculateOpacity(scrollOffset: Double, width: CGFloat) -> Double {
           let relativeOffset = scrollOffset / width
           return max(1 - Double(relativeOffset), 0)
       }
    
    func moveToNextRound(selectedTeam: FirstTeam, round: Round, matchIndex: Int, selectedTeams: Binding<[FirstTeam?]>) {
        withAnimation {
            switch round {
            case .roundOf8:
                // Check if the selected team is already in the round of 8
                if selectedTeamsRoundOf8.contains(selectedTeam) {
                    // If the team is already in the round of 8, remove it
                    selectedTeamsRoundOf8.removeAll { $0 == selectedTeam }
                } else {
                    // Otherwise, add the selected team to the round of 8
                    if let emptyIndex = selectedTeamsRoundOf8.firstIndex(where: { $0 == nil }) {
                        selectedTeamsRoundOf8[emptyIndex] = selectedTeam
                    }
                }
            case .semiFinal:
                if let index = selectedTeamsRoundOf8.firstIndex(of: selectedTeam) {
                    selectedTeamsSemiFinal[matchIndex] = selectedTeam
                }
            case .final:
                if let index = selectedTeamsSemiFinal.firstIndex(of: selectedTeam) {
                    selectedTeamsFinal[matchIndex] = selectedTeam
                }
            case .winner:
                selectedTeamWinner = selectedTeam
            }
        }
    }

    
    
}

enum Round {
    case roundOf8
    case semiFinal
    case final
    case winner
}

enum FirstTeam: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case Albania
    case Hungary
    case Scotland
    case Serbia
    case Turkey
    case Denmark
    case Poland
    case Belgium
    case Romania
    case Croatia
    case Austria
    case Georgia
    case England
    case France
    case Germany
    case Italy
    
    var isSelected: Bool {
        get { UserDefaults.standard.bool(forKey: "\(self.rawValue)_isSelected") }
        set { UserDefaults.standard.set(newValue, forKey: "\(self.rawValue)_isSelected") }
    }
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
}


#Preview {
    KnockoutStages()
}
