//
//  ScorePointSheet.swift
//  EURO
//
//  Created by Shounak Jindam on 13/06/24.
//

import SwiftUI

struct ScorePointSheet: View {
    @StateObject private var scoreSheetViewModel = ScoreSheetViewModel()
    
    
    var body: some View {
       
            ZStack {
                FANTASYTheme.getColor(named: .CFSDKPrimary3)
                VStack {
                    HStack {
                        Text("How to Score Points")
                            .font(.title3.bold())
                            .foregroundStyle(.cfsdkWhite)
                            .padding([.top, .leading], 20)
                        Spacer()
                        Button(action: {
                            scoreSheetViewModel.showScoreSheet = false
                        }, label: {
                            Image(systemName: "xmark")
                                .tint(.cfsdkWhite)
                                .padding([.top, .trailing], 10)
                        })
                        
                    }
                    Divider()
                        .background {
                            Color.white.opacity(0.5)
                        }
                    ForEach(scoreSheetViewModel.scoreSheetDetail.indices, id: \.self) { index in
                        HStack {
                            Text(scoreSheetViewModel.scoreSheetDetail[index].name)
                                .font(.title3.bold())
                                .foregroundStyle(.cfsdkWhite)
                                .padding([.top, .leading], 10)
                            Spacer()
                            Text(scoreSheetViewModel.scoreSheetDetail[index].points)
                                .font(.title3.bold())
                                .foregroundStyle(scoreSheetViewModel.scoreSheetDetail[index].points == "0 pts" ? .cfsdkAccentError: .cfsdkWhite)
                                .padding([.top, .trailing], 10)
                        }
                        HStack{
                            Text(scoreSheetViewModel.scoreSheetDetail[index].description)
                                .font(.subheadline)
                                .foregroundStyle(.cfsdkWhite).opacity(0.7)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        .padding(.leading,10)
                        Divider()
                            .background {
                                Color.white.opacity(0.5)
                            }
                    }
                    
                    HStack{
                        Button(action: {
                            
                        }, label: {
                            Text("Read full article")
                                .foregroundStyle(.cfsdkAccent1)
                        })
                        .padding()
                        Spacer()
                    }
                }
            }
            .ignoresSafeArea()
        
    }
}

#Preview {
    ScorePointSheet()
}
