//
//  KnockoutModel.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI

struct Matches: Hashable {
    let id = UUID()
    var team1: Team?
    var team2: Team?
}

struct Team: Hashable {
    var name: String
    var teamFlag: String
}

struct MatchSet {
    let set: [Matches]
}

