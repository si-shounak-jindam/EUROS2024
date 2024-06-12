//
//  GroupStages.swift
//  EURO
//
//  Created by Shounak Jindam on 06/06/24.
//

import SwiftUI

struct GroupStages: View {
    
    @State private var progress: Double = 0
    
    @State private var groupName: [String] = ["A", "B", "C", "D", "E", "F"]
    
    var body: some View {
        ZStack {
            FANTASYTheme.getColor(named: .CFSDKPrimary)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                navBar
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 80)
                sponsorImage
                ProgressBar(progress: $progress)
                groups
            }
        }
    }
    
    var groups: some View {
        ScrollView {
            VStack {
                ForEach(groupName.indices) { index in
                    GroupSelector(groupName: $groupName[index], progress: $progress)
                        .CFSDKcornerRadius(15, corners: .allCorners)
                        .frame(height: 350)
                        .padding()
                }
                ThirdPlaceView()
                    .padding()
            }
        }
    }
    
    var navBar: some View {
        ZStack {
            FANTASYTheme.getImage(named: .Pattern)?
                .resizable()
                .scaledToFill()
                .frame(height: 130)
                .clipped()
            HStack {
                Button(action: {
                    
                }, label: {
                    FANTASYTheme.getImage(named: .BackChev)?
                        .padding()
                       
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    FANTASYTheme.getImage(named: .threeLines)?
                        .padding()
                       
                })
                
            }
            .padding(.top, 80)
                
        }
    }
    
    var sponsorImage: some View {
        FANTASYTheme.getImage(named: .VisitQatar)?
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
    }
}

#Preview {
    GroupStages()
}
