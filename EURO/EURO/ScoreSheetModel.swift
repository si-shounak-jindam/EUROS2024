//
//  ScoreSheetModel.swift
//  EURO
//
//  Created by Shounak Jindam on 07/06/24.
//

import SwiftUI

struct ScoreSheetModel: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let points: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ScoreSheetModel, rhs: ScoreSheetModel) -> Bool {
        lhs.id == rhs.id
    }
}

