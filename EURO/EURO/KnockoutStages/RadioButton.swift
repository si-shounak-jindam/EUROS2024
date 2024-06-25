//
//  RadioButtons.swift
//  EURO
//
//  Created by Shounak Jindam on 21/06/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selectedOption: String
    var teamName: String

    var body: some View {
        HStack {
            Text(teamName)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: selectedOption == teamName ? selectedOption.isEmpty ? "circle" : "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
        }
        .padding(.horizontal, 5)
        .background(
            Color.black.opacity(0.01)
                .onTapGesture {
                    if selectedOption == teamName {
                        self.selectedOption = ""
                    } else {
                        self.selectedOption = teamName
                    }
                }
        )
        .frame(height: 40)
    }
}

