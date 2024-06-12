//
//  CFSDKDouble+Ext.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 02/05/24.
//

import Foundation

extension Double {
    public func roundedPlaces(_ decimals: Int = 1) -> Double {
        (self * Double((10 * decimals))).rounded() / Double((10 * decimals))
      }
}
