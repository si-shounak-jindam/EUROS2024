//
//  GroupsView.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

//import SwiftUI
//
//struct GroupsView: View {
//    
//    @State private var thirdPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
//    @State private var firstPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
//    @State private var secondPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
//    
//    @State private var groups: [Groups] = [.init(name: "A", countries: Countries.groupA),
//                                           .init(name: "B", countries: Countries.groupB),
//                                           .init(name: "C", countries: Countries.groupC),
//                                           .init(name: "D", countries: Countries.groupD),
//                                           .init(name: "E", countries: Countries.groupE),
//                                           .init(name: "F", countries: Countries.groupF)
//                                           ]
//    @State private var progress: Double = 0
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach($groups, id: \.name) { group in
//                    GroupSelector(groupName: group.name.wrappedValue,
//                                  progress: $progress,
//                                  allTeams: group.countries)
//                        .CFSDKcornerRadius(15, corners: .allCorners)
//                        .frame(height: 350)
//                        .padding()
//                }
//                ThirdPlaceView(progress: $progress, thirdPlacedCountries: $thirdPlacedCountries,
//                               secondPlacedCountries:$secondPlacedCountries,
//                               firstPlacedCountries: $firstPlacedCountries)
//                    .padding()
//            }
//        }
//    }
//    
//    private func bindingForThirdPlacedCountry(groupName: String) -> Binding<Country?> {
//        return Binding<Country?>(
//            get: {
//                return thirdPlacedCountries[groupName] ?? nil
//            },
//            set: { newValue in
//                thirdPlacedCountries[groupName] = newValue
//            }
//        )
//    }
//    
//    private func bindingForSecondPlacedCountry(groupName: String) -> Binding<Country?> {
//        return Binding<Country?>(
//            get: {
//                return secondPlacedCountries[groupName] ?? nil
//            },
//            set: { newValue in
//                secondPlacedCountries[groupName] = newValue
//            }
//        )
//    }
//    
//    private func bindingForFirstPlacedCountry(groupName: String) -> Binding<Country?> {
//        return Binding<Country?>(
//            get: {
//                return firstPlacedCountries[groupName] ?? nil
//            },
//            set: { newValue in
//                firstPlacedCountries[groupName] = newValue
//            }
//        )
//    }
//    private func updatePlacedTeams() {
//        var firstTeams = [String: Country]()
//        var secondTeams = [String: Country]()
//        var thirdTeams = [String: Country]()
//        
//        for group in groups {
//            if let firstCountry = group.countries.first {
//                firstTeams[group.name] = firstCountry
//            }
//            if group.countries.count > 1 {
//                secondTeams[group.name] = group.countries[1]
//            }
//            if group.countries.count > 2 {
//                thirdTeams[group.name] = group.countries[2]
//            }
//        }
//        
//        firstPlacedCountries = firstTeams
//        secondPlacedCountries = secondTeams
//        thirdPlacedCountries = thirdTeams
//    }
//}
//
//extension GroupsView {
//    enum Countries {
//        static let groupA: [Country] = [
//            Country(name: "Germany", imageName: "germany"),
//            Country(name: "Scotland", imageName: "scotland"),
//            Country(name: "Hungary", imageName: "hungary"),
//            Country(name: "Switzerland", imageName: "switzerland")
//        ]
//        
//        static let groupB: [Country] = [
//            Country(name: "Spain", imageName: "spain"),
//            Country(name: "Croatia", imageName: "croatia"),
//            Country(name: "Italy", imageName: "italy"),
//            Country(name: "Albania", imageName: "albania")
//        ]
//        static let groupC: [Country] = [
//            Country(name: "Slovenia", imageName: "slovenia"),
//            Country(name: "England", imageName: "england"),
//            Country(name: "Serbia", imageName: "serbia"),
//            Country(name: "Denmark", imageName: "denmark"),
//        ]
//        static let groupD: [Country] = [
//            Country(name: "Netherlands", imageName: "netherlands"),
//            Country(name: "France", imageName: "france"),
//            Country(name: "Poland", imageName: "poland"),
//            Country(name: "Austria", imageName: "austria")
//        ]
//        static let groupE: [Country] = [
//            Country(name: "Ukraine", imageName: "ukraine"),
//            Country(name: "Slovakia", imageName: "slovakia"),
//            Country(name: "Belgium", imageName: "belgium"),
//            Country(name: "Romania", imageName: "romania")
//        ]
//        
//        static let groupF: [Country] = [
//            Country(name: "Turkey", imageName: "turkey"),
//            Country(name: "Portugal", imageName: "portugal"),
//            Country(name: "Georgia", imageName: "georgia"),
//            Country(name: "Czechia", imageName: "czechia")
//        ]
//    }
//}
//
//
//#Preview {
//    GroupsView()
//}
