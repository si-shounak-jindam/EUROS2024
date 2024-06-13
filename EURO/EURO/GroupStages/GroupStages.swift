//
//  GroupStages.swift
//  EURO
//
//  Created by Shounak Jindam on 06/06/24.
//

import SwiftUI

struct Group {
    var name: String
    var countries: [Country]
}

struct GroupStages: View {
    
    @State private var progress: Double = 0
    @State private var groups: [Group] = [.init(name: "A", countries: Countries.groupA),
                                   .init(name: "B", countries: Countries.groupB),
                                   .init(name: "C", countries: Countries.groupC),
                                   .init(name: "D", countries: Countries.groupD),
                                   .init(name: "E", countries: Countries.groupE),
                                   .init(name: "F", countries: Countries.groupF)
                                          
    ]
    
    @State private var thirdPlacedCountries: [String: Country?] = ["A": nil, "B": nil, "C": nil, "D": nil, "E": nil, "F": nil]
        

    
    var body: some View {
        ZStack {
            FANTASYTheme.getColor(named: .CFSDKPrimary)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                navBar
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 80)
                sponsorImage
                ProgressBar(progress: $progress)
                groupsView
            }
        }
    }
    
    var groupsView: some View {
        ScrollView {
            VStack {
                ForEach($groups, id: \.name) { group in
                    GroupSelector(groupName: group.name.wrappedValue,
                                  progress: $progress,
                                  thirdPlacedCountry: bindingForThirdPlacedCountry(groupName: group.name.wrappedValue),
                                     allTeams: group.countries)
                        .CFSDKcornerRadius(15, corners: .allCorners)
                        .frame(height: 350)
                        .padding()
                }
                ThirdPlaceView(thirdPlacedCountries: $thirdPlacedCountries)
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
    
    var navBar: some View {
        ZStack {
            FANTASYTheme.getImage(named: .Pattern)?
                .resizable()
                .scaledToFill()
                .frame(height: 130)
                .clipped()
            HStack {
                Button(action: {
                    
                }, label: {
                    FANTASYTheme.getImage(named: .BackChev)?
                        .padding()
                       
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    FANTASYTheme.getImage(named: .threeLines)?
                        .padding()
                       
                })
                
            }
            .padding(.top, 80)
                
        }
    }
    
    var sponsorImage: some View {
        FANTASYTheme.getImage(named: .VisitQatar)?
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
    }
}

extension GroupStages {
    enum Countries {
        static let groupA: [Country] = [
            Country(name: "Germany", imageName: "germany"),
            Country(name: "Scotland", imageName: "scotland"),
            Country(name: "Hungary", imageName: "hungary"),
            Country(name: "Switzerland", imageName: "switzerland")
        ]
        
        static let groupB: [Country] = [
            Country(name: "Spain", imageName: "spain"),
            Country(name: "Croatia", imageName: "croatia"),
            Country(name: "Italy", imageName: "italy"),
            Country(name: "Albania", imageName: "albania")
        ]
        static let groupC: [Country] = [
            Country(name: "Slovenia", imageName: "slovenia"),
            Country(name: "England", imageName: "england"),
            Country(name: "Serbia", imageName: "serbia"),
            Country(name: "Denmark", imageName: "denmark"),
        ]
        static let groupD: [Country] = [
            Country(name: "Netherlands", imageName: "netherlands"),
            Country(name: "France", imageName: "france"),
            Country(name: "Poland", imageName: "poland"),
            Country(name: "Austria", imageName: "austria")
        ]
        static let groupE: [Country] = [
            Country(name: "Ukraine", imageName: "ukraine"),
            Country(name: "Slovakia", imageName: "slovakia"),
            Country(name: "Belgium", imageName: "belgium"),
            Country(name: "Romania", imageName: "romania")
        ]
        
        static let groupF: [Country] = [
            Country(name: "Turkey", imageName: "turkey"),
            Country(name: "Portugal", imageName: "portugal"),
            Country(name: "Georgia", imageName: "georgia"),
            Country(name: "Czechia", imageName: "czechia")
        ]
    }
}

#Preview {
    GroupStages()
}
