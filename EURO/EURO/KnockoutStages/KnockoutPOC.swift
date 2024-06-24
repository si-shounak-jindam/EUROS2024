//
//  KnockoutStages.swift
//  EURO
//
//  Created by Shounak Jindam on 20/06/24.

import SwiftUI

struct MatchColumnView: View {
    let elements: Int
    let rounds: [Matches]
    //@Binding var selectedTeamsFromFirstRound: [Int: String]
    @Binding var selectedTeams: [Int: String]
    let spacing: (Int) -> CGFloat
    let onTeamSelected: (Int, String) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            Spacer()
            ForEach(0..<elements, id: \.self) { index in
                MatchView(
                    showLeftLine: elements != 8,
                    showRightLine: elements != 1,
                    spacing: elements == 1 ? .zero : spacing(elements),
                    index: index,
                    match: rounds[index],
                    teamOneSelection: Binding(get: {
                        selectedTeams[index] ?? String()
                    }, set: { newValue in
                        selectedTeams[index] = newValue
                        onTeamSelected(index, newValue)
                    }),
                    teamTwoSelection: Binding(get: {
                        selectedTeams[index + elements] ?? String()
                    }, set: { newValue in
                        selectedTeams[index + elements] = newValue
                        onTeamSelected(index + elements, newValue)
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
    @Binding var firstPlacedCountries: [String: Country?]
    @State private var selectedTeams: [Int: String] = [:]
    
    @State private var rounds: [[Matches]] = [
        Array(repeating: Matches(team1: Team(name: ""), team2: Team(name: "")), count: 8),
        Array(repeating: Matches(team1: Team(name: ""), team2: Team(name: "")), count: 4),
        Array(repeating: Matches(team1: Team(name: ""), team2: Team(name: "")), count: 2),
        Array(repeating: Matches(team1: Team(name: ""), team2: Team(name: "")), count: 1)
    ]
    
    @State private var offset: CGFloat = .zero
    @State private var currentOffset: CGFloat = .zero
    @State private var additionalSpacing: Int = .zero
    
    func spacing(elements: Int) -> CGFloat {
        (ColumnSpacing(rawValue: elements)?.spacing ?? ColumnSpacing.defaultSpace.spacing) - (CGFloat(additionalSpacing/elements))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .center, spacing: .zero) {
                        ForEach(0..<rounds.count, id: \.self) { roundIndex in
                            MatchColumnView(
                                elements: rounds[roundIndex].count,
                                rounds: rounds[roundIndex],
                                selectedTeams: $selectedTeams,
                                spacing: spacing,
                                onTeamSelected: { index, team in
                                    updateNextRound(roundIndex: roundIndex, matchIndex: index / 2, team: team)
                                }
                            )
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
            Matches(team1: Team(name: firstPlacedCountries["A"]??.name ?? ""),
                    team2: Team(name: secondPlacedCountries["B"]??.name ?? "")),
            Matches(team1: Team(name: firstPlacedCountries["C"]??.name ?? ""),
                    team2: Team(name: secondPlacedCountries["D"]??.name ?? "")),
            Matches(team1: Team(name: firstPlacedCountries["E"]??.name ?? ""),
                    team2: Team(name: secondPlacedCountries["F"]??.name ?? "")),
            Matches(team1: Team(name: secondPlacedCountries["A"]??.name ?? ""),
                    team2: Team(name: firstPlacedCountries["B"]??.name ?? "")),
            Matches(team1: Team(name: secondPlacedCountries["C"]??.name ?? ""),
                    team2: Team(name: firstPlacedCountries["D"]??.name ?? "")),
            Matches(team1: Team(name: secondPlacedCountries["E"]??.name ?? ""),
                    team2: Team(name: firstPlacedCountries["F"]??.name ?? "")),
            Matches(team1: Team(name: thirdPlacedCountries["A"]??.name ?? ""),
                    team2: Team(name: thirdPlacedCountries["B"]??.name ?? "")),
            Matches(team1: Team(name: thirdPlacedCountries["C"]??.name ?? ""),
                    team2: Team(name: thirdPlacedCountries["D"]??.name ?? ""))
        ]
    }
    
    private func updateNextRound(roundIndex: Int, matchIndex: Int, team: String) {
        guard roundIndex < rounds.count - 1 else { return }
        let nextRoundMatchIndex = matchIndex / 2
        if matchIndex % 2 == 0 {
            rounds[roundIndex + 1][nextRoundMatchIndex].team1 = Team(name: team)
        } else {
            rounds[roundIndex + 1][nextRoundMatchIndex].team2 = Team(name: team)
        }
    }
}


