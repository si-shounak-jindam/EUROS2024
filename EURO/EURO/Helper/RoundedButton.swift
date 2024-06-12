//
//  RoundedButton.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 03/04/24.
//

import SwiftUI

struct RoundedButton: View {
    
    let title: String
    let borderColor: Color
    let backgroundColor: Color
    let foregroundColor: Color
    let leftIcon: Image?
    let rightIcon: Image?
    let action: () -> Void
    
    init(title: String,
         borderColor: Color = .clear,
         backgroundColor: Color,
         foregroundColor: Color,
         leftIcon: Image? = .none,
         rightIcon: Image? = .none,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
        self.rightIcon = rightIcon
        self.title = title
        self.leftIcon = leftIcon
        self.borderColor = borderColor
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: Constants.horizontalSpacing) {
                Spacer()
                if let leftIcon {
                    leftIcon
                }
                title.text
                    .font(.custom(CFSDKCustomFonts.ICCFontMedium.rawValue,
                                  fixedSize: Constants.fontSize))
                    .foregroundColor(foregroundColor)
                if let rightIcon {
                    rightIcon
                }
                Spacer()
            }
            .padding(.vertical, Constants.verticalPadding)
            .background(backgroundColor)
            .CFSDKcornerRadius(Constants.cornerRadius,
                               corners: .allCorners)
            .CFSDKborder(radius: Constants.cornerRadius,
                         color: borderColor,
                         width: Constants.boarderWidth)
        }
    }
}

extension RoundedButton {
    private enum Constants {
        static let horizontalSpacing: CGFloat = 3
        static let fontSize: CGFloat = 14
        static let verticalPadding: CGFloat = 10
        static let cornerRadius: CGFloat = ((verticalPadding * 2) + fontSize)/2
        static let boarderWidth: CGFloat = 1
    }
}
