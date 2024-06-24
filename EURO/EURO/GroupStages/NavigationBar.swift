//
//  NavigationBar.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
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
}

#Preview {
    NavigationBar()
}
