//
//  ContentView.swift
//  EURO
//
//  Created by Shounak Jindam on 03/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var roundManager = RoundManager()
    var body: some View {
        GameStarterView()
            .environmentObject(roundManager)
    }
}

#Preview {
    ContentView()
}
