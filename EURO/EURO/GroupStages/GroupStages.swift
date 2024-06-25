//
//  GroupStages.swift
//  EURO
//
//  Created by Shounak Jindam on 06/06/24.
//

import SwiftUI

struct Groups: Equatable {
    var name: String
    var countries: [Country]
}

struct GroupStages: View {
    
    @StateObject private var roundManager = RoundManager()
    
    @State private var progress: Double = 0
    @State private var groups: [Groups] = [.init(name: "A", countries: Countries.groupA),
                                           .init(name: "B", countries: Countries.groupB),
                                           .init(name: "C", countries: Countries.groupC),
                                           .init(name: "D", countries: Countries.groupD),
                                           .init(name: "E", countries: Countries.groupE),
                                           .init(name: "F", countries: Countries.groupF)
    ]
    
    @State private var thirdPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
    @State private var firstPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
    @State private var secondPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
    
    
    var body: some View {
        ZStack {
            FANTASYTheme.getColor(named: .CFSDKPrimary)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                NavigationBar()
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 80)
                SponsorView()
                ProgressBar(progress: $progress)
                groupsView
            }
        }
        .onAppear {
            updatePlacedTeams()
        }
        .onChange(of: groups) { _ in
            updatePlacedTeams()
        }
    }
    
    private func updatePlacedTeams() {
        var firstTeams = [String: Country]()
        var secondTeams = [String: Country]()
        var thirdTeams = [String: Country]()
        
        for group in groups {
            if let firstCountry = group.countries.first {
                firstTeams[group.name] = firstCountry
            }
            if group.countries.count > 1 {
                secondTeams[group.name] = group.countries[1]
            }
            if group.countries.count > 2 {
                thirdTeams[group.name] = group.countries[2]
            }
        }
        
        firstPlacedCountries = firstTeams
        secondPlacedCountries = secondTeams
        thirdPlacedCountries = thirdTeams
    }
    
    var groupsView: some View {
        ScrollView {
            VStack {
                ForEach($groups, id: \.name) { group in
                    GroupSelector(groupName: group.name.wrappedValue,
                                  progress: $progress,
                                  thirdPlacedCountry: bindingForThirdPlacedCountry(groupName: group.name.wrappedValue),
                                  secondPlacedCountry: bindingForSecondPlacedCountry(groupName: group.name.wrappedValue),
                                  firstPlacedCountry: bindingForFirstPlacedCountry(groupName: group.name.wrappedValue),
                                  allTeams: group.countries)
                        
                        .padding()
                }
                ThirdPlaceView(progress: $progress, 
                               thirdPlacedCountries: $thirdPlacedCountries,
                               secondPlacedCountries:$secondPlacedCountries,
                               firstPlacedCountries: $firstPlacedCountries)
                    .padding()
            }
        }
    }
    
    private func bindingForThirdPlacedCountry(groupName: String) -> Binding<Country?> {
        return Binding<Country?>(
            get: {
                return thirdPlacedCountries[groupName] ?? nil
            },
            set: { newValue in
                thirdPlacedCountries[groupName] = newValue
            }
        )
    }
    
    private func bindingForSecondPlacedCountry(groupName: String) -> Binding<Country?> {
        return Binding<Country?>(
            get: {
                return secondPlacedCountries[groupName] ?? nil
            },
            set: { newValue in
                secondPlacedCountries[groupName] = newValue
            }
        )
    }
    
    private func bindingForFirstPlacedCountry(groupName: String) -> Binding<Country?> {
        return Binding<Country?>(
            get: {
                return firstPlacedCountries[groupName] ?? nil
            },
            set: { newValue in
                firstPlacedCountries[groupName] = newValue
            }
        )
    }
}

extension GroupStages {
    enum Countries {
        static let groupA: [Country] = [
            Country(name: "Germany", imageName: "Germany"),
            Country(name: "Scotland", imageName: "Scotland"),
            Country(name: "Hungary", imageName: "Hungary"),
            Country(name: "Switzerland", imageName: "Switzerland")
        ]
        
        static let groupB: [Country] = [
            Country(name: "Spain", imageName: "Spain"),
            Country(name: "Croatia", imageName: "Croatia"),
            Country(name: "Italy", imageName: "Italy"),
            Country(name: "Albania", imageName: "Albania")
        ]
        static let groupC: [Country] = [
            Country(name: "Slovenia", imageName: "Slovenia"),
            Country(name: "England", imageName: "England"),
            Country(name: "Serbia", imageName: "Serbia"),
            Country(name: "Denmark", imageName: "Denmark"),
        ]
        static let groupD: [Country] = [
            Country(name: "Netherlands", imageName: "Netherlands"),
            Country(name: "France", imageName: "France"),
            Country(name: "Poland", imageName: "Poland"),
            Country(name: "Austria", imageName: "Austria")
        ]
        static let groupE: [Country] = [
            Country(name: "Ukraine", imageName: "Ukraine"),
            Country(name: "Slovakia", imageName: "Slovakia"),
            Country(name: "Belgium", imageName: "Belgium"),
            Country(name: "Romania", imageName: "Romania")
        ]
        
        static let groupF: [Country] = [
            Country(name: "Turkey", imageName: "Turkey"),
            Country(name: "Portugal", imageName: "Portugal"),
            Country(name: "Georgia", imageName: "Georgia"),
            Country(name: "Czechia", imageName: "Czechia")
        ]
    }
}

#Preview {
    GroupStages()
}

