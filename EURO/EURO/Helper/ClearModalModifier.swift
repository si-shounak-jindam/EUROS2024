//
//  ClearModalModifier.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 04/04/24.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return ClearBackgroundViewUIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

class ClearBackgroundViewUIView: UIView {
    override func layoutSubviews() {
        guard let parentView = superview?.superview else {
           // GameLogger.print("ERROR: Failed to get parent view to make it clear")
            return
        }
        parentView.backgroundColor = .clear
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}
