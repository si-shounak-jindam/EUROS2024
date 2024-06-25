//
//  KnockoutStages.swift
//  EURO
//
//  Created by Shounak Jindam on 20/06/24.

import SwiftUI

struct MatchColumnView: View {
    let elements: Int
    let rounds: [Matches]
    @Binding var selectedTeams: [Int: String]
    let spacing: (Int) -> CGFloat
    let onTeamSelected: (Int, String) -> Void
    @Binding var winnerLogo: String
    
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            Spacer()
            ForEach(0..<elements, id: \.self) { index in
                if !winnerLogo.isEmpty && rounds.count == 1 {
                    HStack {
                        Image(winnerLogo)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        FANTASYTheme.getImage(named: .Trophy)?
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    .padding(10)
                    .padding(.top, -170)
                }
                MatchView(
                    showLeftLine: elements != 8,
                    showRightLine: elements != 1,
                    spacing: elements == 1 ? .zero : spacing(elements),
                    index: index,
                    match: rounds[index],
                    teamOneSelection: Binding(get: {
                        selectedTeams[index * 2] ?? ""
                    }, set: { newValue in
                        selectedTeams[index * 2] = newValue
                        selectedTeams[index * 2 + 1] = ""
                        onTeamSelected(index, newValue)
                    }),
                    teamTwoSelection: Binding(get: {
                        selectedTeams[index * 2 + 1] ?? ""
                    }, set: { newValue in
                        selectedTeams[index * 2 + 1] = newValue
                        selectedTeams[index * 2] = ""
                        onTeamSelected(index, newValue)
                    })
                )
            }
            Spacer()
        }
        .frame(minHeight: UIScreen.main.bounds.height)
        .background (
            HStack {
                Color.clear.frame(width: 1).id(elements)
                Spacer()
            }
                .padding(.leading, -25)
        )
    }
}


import SwiftUI

struct KnockoutPOC: View {
    @Binding var thirdPlacedCountries: [String: Country?]
    @Binding var secondPlacedCountries: [String: Country?]
    @Binding var progress: Double
    @Binding var firstPlacedCountries: [String: Country?]
    @State private var selectedTeams: [[Int: String]] = [[:], [:], [:], [:]]
    
    @State private var rounds: [[Matches]] = [
        Array(repeating: Matches(team1: Team(name: "", teamFlag: ""), team2: Team(name: "", teamFlag: "")), count: 8),
        Array(repeating: Matches(team1: Team(name: "", teamFlag: ""), team2: Team(name: "", teamFlag: "")), count: 4),
        Array(repeating: Matches(team1: Team(name: "", teamFlag: ""), team2: Team(name: "", teamFlag: "")), count: 2),
        Array(repeating: Matches(team1: Team(name: "", teamFlag: ""), team2: Team(name: "", teamFlag: "")), count: 1)
    ]
    
    @State private var offset: CGFloat = .zero
    @State private var currentOffset: CGFloat = .zero
    @State private var additionalSpacing: Int = .zero
    @State private var winnerLogo: String = ""
    let tournamentStages: [String] = ["Round of 16", "Round of 8", "Semi Final", "Final"]
    
    func spacing(elements: Int) -> CGFloat {
        (ColumnSpacing(rawValue: elements)?.spacing ?? ColumnSpacing.defaultSpace.spacing) - (CGFloat(additionalSpacing/elements))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            VStack(spacing: .zero) {
                NavigationBar()
                ProgressBar(progress: $progress)
            }
            .edgesIgnoringSafeArea(.top)
            .background(Color.black)
            
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .center, spacing: .zero) {
                        ForEach(0..<rounds.count, id: \.self) { roundIndex in
                            VStack(alignment: .center, spacing: .zero) {
                                Spacer()
                                Text(tournamentStages[roundIndex])
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
//                                if roundIndex == rounds.count - 1, !winnerLogo.isEmpty {
//                                    HStack {
//                                        Image(winnerLogo)
//                                            .resizable()
//                                            .frame(width: 30, height: 30)
//                                            .clipShape(Circle())
//                                        FANTASYTheme.getImage(named: .Trophy)?
//                                            .resizable()
//                                            .frame(width: 150, height: 150)
//                                    }
//                                    .padding()
//                                }

                                var selected: Binding<[Int:String]> {
                                    Binding {
                                        selectedTeams[roundIndex]
                                    } set: { value in
                                        selectedTeams[roundIndex] = value
                                    }
                                }
                                
                                MatchColumnView(
                                    elements: rounds[roundIndex].count,
                                    rounds: rounds[roundIndex],
                                    selectedTeams: selected,
                                    spacing: spacing,
                                    onTeamSelected: { matchIndex, team in
                                        updateNextRound(roundIndex: roundIndex,
                                                        matchIndex: matchIndex,
                                                        team: team)
                                    },
                                    winnerLogo: $winnerLogo
                                )
                            }
                        }
                    }
                    .background(Color.black)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation {
                                    self.offset = currentOffset + gesture.translation.width
                                }
                            }
                            .onEnded { gesture in
                                withAnimation {
                                    offset = currentOffset
                                    if gesture.translation.width < .zero {
                                        if gesture.translation.width > -100 { } else {
                                            withAnimation {
                                                if offset == -300 {
                                                    self.offset = -625
                                                } else if offset == -625 {
                                                    self.offset = -950
                                                } else {
                                                    self.offset = -300
                                                }
                                                currentOffset = offset
                                            }
                                        }
                                    } else {
                                        if gesture.translation.width > 100 {
                                            withAnimation {
                                                if offset == -950 {
                                                    offset = -625
                                                } else if offset == -625 {
                                                    offset = -300
                                                } else {
                                                    offset = .zero
                                                }
                                                currentOffset = offset
                                            }
                                        }
                                    }
                                }
                            }
                    )
                }
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
            .onChange(of: currentOffset) { newValue in
                withAnimation {
                    if newValue == -300 {
                        additionalSpacing = 200
                    } else if newValue == -625 {
                        additionalSpacing = 400
                    } else if newValue == -950 {
                        additionalSpacing = 400
                    } else {
                        additionalSpacing = .zero
                    }
                }
            }
        }
        .onAppear {
            populateFirstRound()
        }
    }
    
    
    private func populateFirstRound() {
        rounds[0] = [
//            Matches(team1: Team(name: (firstPlacedCountries["A"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (secondPlacedCountries["B"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (firstPlacedCountries["C"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (secondPlacedCountries["D"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (firstPlacedCountries["E"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (secondPlacedCountries["F"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (secondPlacedCountries["A"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (firstPlacedCountries["B"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (secondPlacedCountries["C"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (firstPlacedCountries["D"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (secondPlacedCountries["E"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (firstPlacedCountries["F"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (thirdPlacedCountries["A"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (thirdPlacedCountries["B"])??.name ?? "", teamFlag: "")),
//            Matches(team1: Team(name: (thirdPlacedCountries["C"])??.name ?? "", teamFlag: ""),
//                    team2: Team(name: (thirdPlacedCountries["D"])??.name ?? "", teamFlag: ""))
            Matches(team1: Team(name: "Portugal", teamFlag: "Portugal" ),
                    team2: Team(name: "Italy", teamFlag: "Italy")),
            Matches(team1: Team(name: "Poland", teamFlag: "Poland"),
                    team2: Team(name: "Spain", teamFlag: "Spain")),
            Matches(team1: Team(name: "Croatia", teamFlag: "Croatia"),
                    team2: Team(name: "France", teamFlag: "France")),
            Matches(team1: Team(name: "England", teamFlag: "England"),
                    team2: Team(name: "Denmark", teamFlag: "Denmark")),
            Matches(team1: Team(name: "Germany", teamFlag: "Germany"),
                    team2: Team(name: "Hungary", teamFlag: "Hungary")),
            Matches(team1: Team(name: "Slovenia", teamFlag: "Slovenia"),
                    team2: Team(name: "Belgium", teamFlag: "Belgium")),
            Matches(team1: Team(name: "Slovakia", teamFlag: "Slovakia"),
                    team2: Team(name: "Ukraine", teamFlag: "Ukraine")),
            Matches(team1: Team(name: "Romania", teamFlag: "Romania"),
                    team2: Team(name: "Turkey", teamFlag: "Turkey"))
        ]
    }
    
    private func updateNextRound(roundIndex: Int, matchIndex: Int, team: String) {
            guard roundIndex < rounds.count - 1 else {
                if roundIndex == rounds.count - 1 {
                    winnerLogo = team
                }
                return
            }
            
            let nextRoundMatchIndex = matchIndex / 2
            
            if matchIndex % 2 == 0 {
                rounds[roundIndex + 1][nextRoundMatchIndex].team1 = Team(name: team, teamFlag: team)
            } else {
                rounds[roundIndex + 1][nextRoundMatchIndex].team2 = Team(name: team, teamFlag: team)
            }
        }
}


