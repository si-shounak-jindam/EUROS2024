//
//  RoundManager.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI
import Combine

class RoundManager: ObservableObject {
    @Published var rounds: [Matches] = []
}

