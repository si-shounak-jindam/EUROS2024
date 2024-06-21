//
//  KnockoutStages.swift
//  EURO
//
//  Created by Shounak Jindam on 20/06/24.

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

struct Matches: Hashable {
    let id = UUID()
    var team1: Team?
    var team2: Team?
}

struct Team: Hashable {
    var name: String
}

struct MatchSet {
    let set: [Matches]
}

struct MatchColumnView: View {
    let elements: Int
    let rounds: [Matches]
    @Binding var selectedTeamsFromFirstRound: [Int: String]
    let spacing: (Int) -> CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            Spacer()
            ForEach(0..<elements, id: \.self) { index in
                MatchView(
                    showLeftLine: elements != 8,
                    showRightLine: elements != 1,
                    spacing: elements == 1 ? .zero : spacing(elements),
                    index: index,
                    match: rounds[index],
                    teamOneSelection: Binding(get: {
                        selectedTeamsFromFirstRound[index] ?? String()
                    }, set: { newValue in
                        selectedTeamsFromFirstRound[index] = newValue
                    }),
                    teamTwoSelection: Binding(get: {
                        selectedTeamsFromFirstRound[index] ?? String()
                    }, set: { newValue in
                        selectedTeamsFromFirstRound[index] = newValue
                    })
                )
            }
            Spacer()
        }
        .frame(minHeight: UIScreen.main.bounds.height)
        .background (
            HStack {
                Color.clear.frame(width: 1).id(elements)
                Spacer()
            }
            .padding(.leading, -25)
        )
    }
}

struct KnockoutPOC: View {
    
    @State private var selectedTeamsFromFirstRound: [Int: String] = [:]
    
    let rounds: [Matches] = [
        Matches(team1: Team(name: ""),
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: "")),
        Matches(team1: Team(name: ""), 
                team2: Team(name: ""))
    ]
    
    @State private var offset: CGFloat = .zero
    @State private var currentOffset: CGFloat = .zero
    @State var selectedColumn: Int = 8
    
    @State private var additionalSpacing: Int = .zero
    
    func spacing(elements: Int) -> CGFloat {
        (ColumnSpacing(rawValue: elements)?.spacing ?? ColumnSpacing.defaultSpace.spacing) - (CGFloat(additionalSpacing/elements))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .center, spacing: .zero) {
                        ForEach([8, 4, 2, 1], id: \.self) { elements in
                            MatchColumnView(
                                elements: elements,
                                rounds: rounds,
                                selectedTeamsFromFirstRound: $selectedTeamsFromFirstRound,
                                spacing: spacing
                            )
                        }
                    }
                    .background(Color.black)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation {
                                    self.offset = currentOffset + gesture.translation.width
                                }
                            }
                            .onEnded { gesture in
                                withAnimation {
                                    offset = currentOffset
                                    if gesture.translation.width < .zero {
                                        if gesture.translation.width > -100 { } else {
                                            withAnimation {
                                                if offset == -300 {
                                                    self.offset = -625
                                                } else if offset == -625 {
                                                    self.offset = -950
                                                } else {
                                                    self.offset = -300
                                                }
                                                currentOffset = offset
                                            }
                                        }
                                    } else {
                                        if gesture.translation.width > 100 {
                                            withAnimation {
                                                if offset == -950 {
                                                    offset = -625
                                                } else if offset == -625 {
                                                    offset = -300
                                                } else {
                                                    offset = .zero
                                                }
                                                currentOffset = offset
                                            }
                                        }
                                    }
                                }
                            }
                    )
                }
            }
            .onChange(of: currentOffset) { newValue in
                withAnimation {
                    if newValue == -300 {
                        additionalSpacing = 200
                    } else if newValue == -625 {
                        additionalSpacing = 400
                    } else if newValue == -950 {
                        additionalSpacing = 400
                    } else {
                        additionalSpacing = .zero
                    }
                }
            }
        }
    }
}

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
