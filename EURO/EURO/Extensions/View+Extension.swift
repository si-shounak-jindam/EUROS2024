//
//  View+Extension.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 03/04/24.
//

import SwiftUI

extension View {
    func CFSDKcornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CFSDKRoundedCorner(radius: radius, corners: corners) )
    }
    
    func CFSDKborder(radius: CGFloat,
                color: Color,
                width: CGFloat) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(color,
                        lineWidth: width)
        )
    }
}
