//
//  MatchView.swift
//  EURO
//
//  Created by Shounak Jindam on 21/06/24.
//

import SwiftUI

struct MatchView: View {
    let showLeftLine: Bool
    let showRightLine: Bool
    let spacing: CGFloat
    let index: Int
    let match: Matches
    
    @Binding var teamOneSelection: String
    @Binding var teamTwoSelection: String
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            RadioButton(selectedOption: $teamOneSelection, 
                        teamName: match.team1?.name ?? "",
                        teamFlag: match.team1?.teamFlag ?? "")
            Color.white.frame(height: 0.5)
            RadioButton(selectedOption: $teamTwoSelection, 
                        teamName: match.team2?.name ?? "",
                        teamFlag: match.team2?.teamFlag ?? "")
            Color.white.frame(height: 0.5)
            Button(action: {
                // Action for view details
            }) {
                Text("View details")
                    .font(.body)
                    .foregroundColor(.yellow)
            }
            .padding(10)
            .frame(height: 40)
        }
        .background(Color.blue.opacity(0.8))
        .cornerRadius(10)
        .padding(.vertical, 10)
        .padding(.vertical, spacing)
        .padding(.trailing, showRightLine ? 25 : .zero)
        .padding(.leading, showLeftLine ? 25 : .zero)
        .overlay(
            VStack(spacing: .zero) {
                HStack {
                    Spacer()
                    (index % 2 == .zero ? Color.clear : Color.white)
                        .frame(width: 0.5)
                }
                .frame(height: 50 + max(spacing, -50))
                Color.white.frame(height: 0.5)
                
                HStack {
                    Spacer()
                    if showRightLine {
                        ((index % 2 != .zero) ? Color.clear : Color.white)
                            .frame(width: 0.5)
                    } else {
                        Color.clear
                            .frame(width: 0.5)
                    }
                }
            }
        )
        .padding(.leading, showLeftLine ? .zero : 25)
        .padding(.trailing, showRightLine ? .zero : 25)
        .frame(width: 325)
    }
}



