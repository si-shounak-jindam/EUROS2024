//
//  RadioButtons.swift
//  EURO
//
//  Created by Shounak Jindam on 21/06/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selectedOption: String
    var label: String?

    var body: some View {
        HStack(alignment: .center) {
            if let label = label {
                Text(label)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Spacer()
            Image(systemName: selectedOption == label ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
        }
        .padding(.horizontal, 5)
        .background(
            Color.black.opacity(0.01)
                .onTapGesture {
                    if selectedOption == label {
                        self.selectedOption = String()
                    } else {
                        self.selectedOption = self.label ?? String()
                    }
                }
        )
        .frame(height: 40)
    }
}

