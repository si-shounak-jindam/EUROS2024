//
//  ScoreSheetViewModel.swift
//  EURO
//
//  Created by Shounak Jindam on 13/06/24.
//

import SwiftUI

class ScoreSheetViewModel: ObservableObject {
    
    @Published var showScoreSheet: Bool = false
    
    @Published var scoreSheetDetail: [ScoreSheetModel] = [
        ScoreSheetModel(name: "Group Stage",
                        description: "Predict each group's final standing.",
                        points: "3 pts"),
        ScoreSheetModel(name: "Knockout rounds",
                        description: "Predict the winner of each tie.",
                        points: "3 pts"),
        ScoreSheetModel(name: "Contenders",
                        description: "Get a bonus point for each semi-finalist and finalist you get right.",
                        points: "+1 pt"),
        ScoreSheetModel(name: "Late or edited bracket",
                        description: "If you save after the knockout stage has started, you won't get any points.",
                        points: "0 pts")
    ]
}
