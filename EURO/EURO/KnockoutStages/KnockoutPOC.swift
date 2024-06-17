//
//  KnockoutPOC.swift
//  EURO
//
//  Created by Shounak Jindam on 17/06/24.
//

import SwiftUI

struct KnockoutPOC: View {
    
//    let layout = [
//        GridItem(.fixed(100))
//    ]
//    
//    let layout2 = [
//        GridItem(.adaptive(minimum: 100, maximum: 100))
//    ]
//    var body: some View {
//        HStack{
//            VStack{
//                Text("Round of 16")
//                ScrollView([.horizontal, .vertical]) {
//                    EmptyView()
//                        .padding()
//                    LazyVGrid(columns: layout,alignment: .listRowSeparatorLeading, spacing: 30) {
//                        ForEach(0..<16) { index in
//                            Text("Team" + "\(index)")
//                        }
//                    }
//                }
//            }
//            
//            
//            VStack {
//                Text("Round of 8")
//                ScrollView([.horizontal, .vertical]) {
//                    LazyVGrid(columns: layout,alignment: .listRowSeparatorLeading, spacing: 30) {
//                        ForEach(0..<16) { index in
//                            if index%2 == 0 {
//                                Text("Team" + "\(index)")
//                            }                       
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    @State private var translation: CGSize = .zero
    @State private var currentView: Int = 1
    @State private var isSwiping: Bool = false
    @State private var isSecondViewVisible = true

    var body: some View {
           GeometryReader { geometry in
               ZStack {
                   // Third View
                   ThirdView()
                       .frame(width: geometry.size.width, height: isSecondViewVisible ? geometry.size.width : 0)
                       .offset(x: currentView == 3 ? translation.width : geometry.size.width)
                       .animation(.easeInOut(duration: 0.1))
                       .animation(.easeInOut, value: currentView)
                       .gesture(
                           DragGesture()
                               .onChanged { value in
                                   if currentView == 3 {
                                       self.translation = value.translation
                                   }
                               }
                               .onEnded { value in
                                   if currentView == 3 {
                                       if value.translation.width > geometry.size.width / 4 {
                                           self.currentView = 1
                                       }
                                   }
                                   self.translation = .zero
                               }
                       )
                   
                   // Second View
                   SecondView()
                       .frame(width: geometry.size.width, height: geometry.size.height)
                       .offset(x: currentView == 2 ? translation.width : (currentView == 3 ? -geometry.size.width : geometry.size.width * 0.8))
                        // Collapse when not visible
                       .animation(.easeInOut(duration: 0.1))
                       .gesture(
                           DragGesture()
                               .onChanged { value in
                                   if currentView == 2 || (currentView == 3 && value.translation.width > 0) {
                                       self.translation = value.translation
                                   }
                               }
                               .onEnded { value in
                                   if currentView == 2 {
                                       if value.translation.width < -geometry.size.width / 4 {
                                           withAnimation(.easeInOut(duration: 0.3)) {
                                               self.currentView = 3
                                           }
                                       } else if value.translation.width > geometry.size.width / 4 {
                                           self.currentView = 1
                                       }
                                   } else if currentView == 3 && value.translation.width > 0 {
                                       if value.translation.width > geometry.size.width / 4 {
                                           self.currentView = 2
                                       }
                                   }
                                   self.translation = .zero
                               }
                       )
                       .onTapGesture {
                                   withAnimation {
                                       self.isSecondViewVisible.toggle()
                                   }
                               }
                   
                   // Main View
                   MainView()
                       .frame(width: geometry.size.width * 0.8)
                       .offset(x: currentView == 1 ? translation.width : -geometry.size.width)
                       .animation(.easeInOut, value: currentView)
                       .gesture(
                           DragGesture()
                               .onChanged { value in
                                   if currentView == 1 {
                                       self.translation = value.translation
                                   }
                               }
                               .onEnded { value in
                                   if currentView == 1 {
                                       if value.translation.width < -geometry.size.width / 4 {
                                           withAnimation(.easeInOut(duration: 0.1)) {
                                               self.currentView = 2
                                               self.isSwiping = true
                                           }
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                               withAnimation(.easeInOut(duration: 0.1)) {
                                                   self.currentView = 3
                                                   self.isSwiping = false
                                               }
                                           }
                                       }
                                   }
                                   self.translation = .zero
                               }
                       )
               }
               .frame(width: geometry.size.width, height: geometry.size.height)
           }
       }
}

struct MainView: View {
    var body: some View {
        Color.blue
            .overlay(Text("Main View").foregroundColor(.white))
    }
}

struct SecondView: View {
    var body: some View {
        Color.green
            .overlay(Text("Second View").foregroundColor(.white))
    }
}

struct ThirdView: View {
    var body: some View {
        Color.red
            .overlay(Text("Third View").foregroundColor(.white))
    }
}

#Preview {
    KnockoutPOC()
}
