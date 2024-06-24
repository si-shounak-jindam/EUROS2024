//
//  CountryModel.swift
//  EURO
//
//  Created by Shounak Jindam on 07/06/24.
//

import SwiftUI

struct Country: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    var isSelected = false
}



