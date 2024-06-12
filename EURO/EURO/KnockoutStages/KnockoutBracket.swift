//
//  KnockoutBracket.swift
//  EURO
//
//  Created by Shounak Jindam on 07/06/24.
//

import SwiftUI


struct KnockoutBracket: View {
    @ObservedObject var viewModel: BracketViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Text("Round of 16")
                    ForEach(viewModel.roundOf16) { team in
                        TeamView(team: team, round: 16, viewModel: viewModel)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

                VStack {
                    Text("Quarterfinals")
                    ForEach(viewModel.roundOf8) { team in
                        TeamView(team: team, round: 8, viewModel: viewModel)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

                VStack {
                    Text("Semifinals")
                    ForEach(viewModel.semiFinals) { team in
                        TeamView(team: team, round: 4, viewModel: viewModel)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

                VStack {
                    Text("Finals")
                    ForEach(viewModel.finals) { team in
                        TeamView(team: team, round: 2, viewModel: viewModel)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

struct TeamView: View {
    let team: Team
    let round: Int
    @ObservedObject var viewModel: BracketViewModel
    
    var body: some View {
        Text(team.name)
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation {
                    viewModel.moveTeamToNextRound(team: team, from: round)
                }
            }
    }
}




struct Team: Identifiable {
    let id = UUID()
    let name: String
}

class BracketViewModel: ObservableObject {
    @Published var roundOf16: [Team]
    @Published var roundOf8: [Team] = []
    @Published var semiFinals: [Team] = []
    @Published var finals: [Team] = []
    
    init(teams: [Team]) {
        self.roundOf16 = teams
    }
    
    func moveTeamToNextRound(team: Team, from round: Int) {
        switch round {
        case 16:
            roundOf8.append(team)
            if let index = roundOf16.firstIndex(where: { $0.id == team.id }) {
                roundOf16.remove(at: index)
            }
        case 8:
            semiFinals.append(team)
            if let index = roundOf8.firstIndex(where: { $0.id == team.id }) {
                roundOf8.remove(at: index)
            }
        case 4:
            finals.append(team)
            if let index = semiFinals.firstIndex(where: { $0.id == team.id }) {
                semiFinals.remove(at: index)
            }
        default:
            break
        }
    }
}

