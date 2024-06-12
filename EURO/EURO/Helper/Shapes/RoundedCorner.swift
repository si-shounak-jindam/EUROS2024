//
//  RoundedCorner.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 03/04/24.
//

import SwiftUI

struct CFSDKRoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, 
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        return Path(path.cgPath)
    }
}
