//
//  CFSDKColorName.swift
//  sifantasysdk
//
//  Created by Milind Trivedi on 02/04/24.
//

import Foundation
import SwiftUI

enum CFSDKColorName : String, CaseIterable {
    
    case CFSDKWhite = "CFSDKWhite"
    case CFSDKPrimary = "CFSDKPrimary"
    case CFSDKPrimary2
    case CFSDKPrimary3
    case CFSDKSecondary
    case CFSDKSecondary2
    case CFSDKSecondary3
    case CFSDKSecondary4
    case CFSDKNeutral
    case CFSDKNeutral2
    case CFSDKNeutral3
    case CFSDKNeutral4
    case CFSDKNeutral5
    case CFSDKNeutral6
    case CFSDKNeutral7
    case CFSDKAccentError
    case CFSDKAccentSuccess
    case CFSDKAccentWarning
    case CFSDKAccent1
    case CFSDKRole_40386B
    case CFSDKCTAAccentSuccess
    case CFSDKCTAAccent1
    case CFSDKBlack_1A1A1A
    case CFSDKBackground2
    case groupSheetBlue
    case thirdPlaceHeader
    case groupHeaderBlue
    
    var name: String { self.rawValue }
    
}


