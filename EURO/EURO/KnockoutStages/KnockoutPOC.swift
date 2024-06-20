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

struct RadioButton: View {
    @Binding var selectedOption: String
    var label: String?

    var body: some View {
        HStack(alignment: .center) {
            if let label = label {
                Text(label)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Spacer()
            Image(systemName: selectedOption == label ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
        }
        .padding(.horizontal, 5)
        .background(
            Color.black.opacity(0.01)
                .onTapGesture {
                    if selectedOption == label {
                        self.selectedOption = String()
                    } else {
                        self.selectedOption = self.label ?? String()
                    }
                }
        )
        .frame(height: 40)
    }
}

struct Match: Hashable {
    let id = UUID()
    var team1: Team?
    var team2: Team?
}

struct Team: Hashable {
    var name: String
}

struct MatchSet {
    let set: [Match]
}

struct MatchView: View {
    let showLeftLine: Bool
    let showRightLine: Bool
    let spacing: CGFloat
    let index: Int
    let match: Match
    
    @Binding var teamOneSelection: String
    @Binding var teamTwoSelection: String
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            RadioButton(selectedOption: $teamOneSelection, label: match.team1?.name)
            Color.white.frame(height: 0.5)
            RadioButton(selectedOption: $teamTwoSelection, label: match.team2?.name)
            Color.white.frame(height: 0.5)
            Button(action: {
                // Action for view details
            }) {
                Text("View details")
                    .font(.body)
                    .foregroundColor(.yellow)
            }
            .padding(10)
            .frame(height: 40)
        }
        .background(Color.blue.opacity(0.8))
        .cornerRadius(10)
        .padding(.vertical, 10)
        .padding(.vertical, spacing)
        .padding(.trailing, showRightLine ? 25 : .zero)
        .padding(.leading, showLeftLine ? 25 : .zero)
        .overlay(
            VStack(spacing: .zero) {
                HStack {
                    Spacer()
                    (index % 2 == .zero ? Color.clear : Color.white)
                        .frame(width: 0.5)
                }
                .frame(height: 50 + max(spacing, -50))
                Color.white.frame(height: 0.5)
                
                HStack {
                    Spacer()
                    if showRightLine {
                        ((index % 2 != .zero) ? Color.clear : Color.white)
                            .frame(width: 0.5)
                    } else {
                        Color.clear
                            .frame(width: 0.5)
                    }
                }
            }
        )
        .padding(.leading, showLeftLine ? .zero : 25)
        .padding(.trailing, showRightLine ? .zero : 25)
        .frame(width: 325)
    }
}

struct MatchColumnView: View {
    let elements: Int
    let rounds: [Match]
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
    
    let rounds: [Match] = [
        Match(team1: Team(name: "Albania"), team2: Team(name: "Hungary")),
        Match(team1: Team(name: "Scotland"), team2: Team(name: "Serbia")),
        Match(team1: Team(name: "Türkiye"), team2: Team(name: "Denmark")),
        Match(team1: Team(name: "Poland"), team2: Team(name: "Belgium")),
        Match(team1: Team(name: "India"), team2: Team(name: "Pakistan")),
        Match(team1: Team(name: "Mumbai"), team2: Team(name: "Gujarat")),
        Match(team1: Team(name: "America"), team2: Team(name: "Honey")),
        Match(team1: Team(name: "Mister"), team2: Team(name: "Perfect"))
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
