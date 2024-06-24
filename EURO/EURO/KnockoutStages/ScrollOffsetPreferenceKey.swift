//
//  ScrollOffset.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
