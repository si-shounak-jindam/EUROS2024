//
//  KnockoutPOC3.swift
//  EURO
//
//  Created by Shounak Jindam on 19/06/24.
//

import SwiftUI

struct KnockoutPOC3: View {
    @State private var currentPage: Int = 0
    let numPages = 2

    var body: some View {
        TabView(selection: $currentPage) {
            RoundOf16Page()
                .tag(0)
            RoundOfEightPage()
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct RoundOf16Page: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                RoundOf16View()
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height)
                RoundOfEightEmptyView()
                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RoundOfEightPage: View {
    var body: some View {
        GeometryReader { geometry in
            RoundOfEightEmptyView()
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RoundOf16View: View {
    var body: some View {
        ScrollView(.vertical){
            VStack {
                ForEach(0..<8) { _ in
                    VStack {
                        Text("Team 1")
                        Spacer()
                        Text("vs")
                        Spacer()
                        Text("Team 2")
                    }
                    .padding(.all, 50)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
                }
                Spacer()
            }
            .background(Color.white)
        }
        }
}

struct RoundOfEightEmptyView: View {
    var body: some View {
        VStack {
            ForEach(0..<4) { _ in
                HStack {
                    Spacer()
                    Text("Quarterfinals")
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    KnockoutPOC3()
}
