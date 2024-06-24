//
//  SponsorView.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI

struct SponsorView: View {
    var body: some View {
        FANTASYTheme.getImage(named: .VisitQatar)?
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
    }
}

#Preview {
    SponsorView()
}
