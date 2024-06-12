//
//  ProgressBar.swift
//  EURO
//
//  Created by Shounak Jindam on 12/06/24.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 5)
                .foregroundColor(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: CGFloat(progress) * UIScreen.main.bounds.width * 0.8, height: 5)
                .foregroundColor(.cfsdkAccent1)
                .cornerRadius(10)
        }
        .padding()
    }
}
