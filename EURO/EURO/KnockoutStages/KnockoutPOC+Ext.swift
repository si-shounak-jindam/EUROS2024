//
//  KnockoutPOC+Ext.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI

extension KnockoutPOC {
    enum Constants {
        static let spacing: CGFloat = 10
        static let cellWidth: CGFloat = 300
        static let cellSize: CGSize = .init(width: 300, height: 40+40+40+1)
        static let firstColumnHeight: CGFloat = (cellSize.height + 10 + 10) * 8
        static let secondColumnSpacing: CGFloat = firstColumnHeight/16
    }
    
    enum ColumnSpacing: Int {
        case secondColumn = 4
        case thirdColumn = 2
        case defaultSpace
        
        var spacing: CGFloat {
            switch self {
            case .secondColumn:
                Constants.secondColumnSpacing
            case .thirdColumn:
                (Constants.firstColumnHeight - (Constants.firstColumnHeight/4))/4
            case .defaultSpace:
                .zero
            }
        }
    }
}

