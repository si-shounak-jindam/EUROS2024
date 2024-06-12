//
//  CountryModel.swift
//  EURO
//
//  Created by Shounak Jindam on 07/06/24.
//

import SwiftUI

struct Country: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    var isSelected = false
    
    static var countriesData: [[Country]] = [groupOneCountries, groupTwoCountries, groupThreeCountries, groupFourCountries, groupFiveCountries, groupSixCountries]
    
    static var groupOneCountries: [Country] {
        [.init(name: "germany", imageName: "germany"),
         .init(name: "scotland", imageName: "scotland"),
         .init(name: "hungary", imageName: "hungary"),
         .init(name: "switzerland", imageName: "switzerland"),
        ]
    }
    
    static var groupTwoCountries: [Country] {
        [.init(name: "spain", imageName: "spain"),
         .init(name: "croatia", imageName: "croatia"),
         .init(name: "italy", imageName: "italy"),
         .init(name: "albania", imageName: "albania"),
        ]
    }
    static var groupThreeCountries: [Country] {
        [.init(name: "slovenia", imageName: "slovenia"),
         .init(name: "england", imageName: "england"),
         .init(name: "serbia", imageName: "serbia"),
         .init(name: "denmark", imageName: "denmark"),
        ]
    }
    
    static var groupFourCountries: [Country] {
        [.init(name: "netherlands", imageName: "netherlands"),
         .init(name: "france", imageName: "france"),
         .init(name: "poland", imageName: "poland"),
         .init(name: "austria", imageName: "austria"),
        ]
    }
    static var groupFiveCountries: [Country] {
        [.init(name: "ukraine", imageName: "ukraine"),
         .init(name: "slovakia", imageName: "slovakia"),
         .init(name: "belgium", imageName: "belgium"),
         .init(name: "romania", imageName: "romania"),
        ]
    }
    
    static var groupSixCountries: [Country] {
        [.init(name: "turkey", imageName: "turkey"),
         .init(name: "portugal", imageName: "portugal"),
         .init(name: "georgia", imageName: "georgia"),
         .init(name: "czechia", imageName: "czechia"),
        ]
    }
    
}



