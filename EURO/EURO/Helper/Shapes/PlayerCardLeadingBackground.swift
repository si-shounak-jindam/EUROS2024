//
//  PlayerCardLeadingBackground.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 16/04/24.
//

import SwiftUI

struct PlayerCardLeadingBackground: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint.zero)
            path.addLine(to: CGPoint(x: width - 3.5, y: .zero))
            path.addLine(to: CGPoint(x: width - 12.5, y: height/2))
            path.addLine(to: CGPoint(x: width, y: height/2 - 6))
            path.addLine(to: CGPoint(x: width - 5, y: height))
            path.addLine(to: CGPoint(x: .zero, y: height))
        }
        .frame(width: width, height: height)
    }
}
