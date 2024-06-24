//
//  GroupViewModel.swift
//  EURO
//
//  Created by Shounak Jindam on 13/06/24.
//


import SwiftUI

class GroupSelectorViewModel: ObservableObject {
    @Published var countries: [Country] = [
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: ""),
        Country(name: "", imageName: "")
    ]
    
    @Published var allTeams: [Country] = []
    @Published var thirdPlacedCountry: Country? = nil
    
    @Published var showBottomSheet: Bool = false
    
    @Published var editMode: EditMode = .active
    
    @Published var popularTeamPrediction: [Country] = [
        Country(name: "England", imageName: "ENG"),
        Country(name: "Spain", imageName: "ESP"),
        Country(name: "Germany", imageName: "GER"),
        Country(name: "France", imageName: "FRA")
    ]
    
    // Move countries in the list
    func move(indices: IndexSet, newOffset: Int) {
        countries.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    // Add a country if needed
    func addCountryIfNeeded(_ country: Country) {
        if let index = countries.firstIndex(where: { $0.name.isEmpty && !$0.isSelected }) {
            countries[index] = country
            countries[index].isSelected = true
            
            if let teamIndex = allTeams.firstIndex(of: country) {
                allTeams[teamIndex].isSelected = true
            }
        }
    }
    
    // Update the third placed country
    func updateThirdPlacedCountry() {
        if countries.count >= 3 {
            thirdPlacedCountry = countries[2]
        }
    }
}

