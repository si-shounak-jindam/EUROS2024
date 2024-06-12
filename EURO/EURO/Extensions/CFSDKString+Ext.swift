//
//  String+Ext.swift
//  sifantasysdk
//
//  Created by Nausheen Khan on 03/04/24.
//

import SwiftUI

extension String {
    static let blank = ""
    static let dash = "-"
    static let newLine = "\n"
    
//    mutating func CFSDKappendBusterQueryItem(type: CFSDKBusterHelper.CFSDKBusterType?) {
//        guard let type, var urlComponents = URLComponents(string: self) else { return }
//        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
//        var value = CFSDKBusterHelper.shared.getBusterFor(type: type)
//        if self.contains("/feeds/live/mixapi") { value = "\(Date().timeIntervalSince1970.rounded())" }
//        let queryItem = URLQueryItem(name: CFSDKQueryItems.buster.rawValue, value: value)
//        queryItems.append(queryItem)
//        urlComponents.queryItems = queryItems
//        self = urlComponents.url?.absoluteString ?? .blank
//    }
    
    var text: some View {
        Text(self)
    }
    
    func roundToDecimalDigits(_ digits: Int) -> String {
        if let number = Double(self),
           number != .zero {
            let remainder = number/Double(Int(number))
            if remainder == 1 {
                return String(describing: Int(number))
            }
            let roundedNumber = String(format: "%.\(digits)f", number)
            return roundedNumber
        } else {
            return self
        }
    }
    
    func roundToDecimalDigitsOne() -> String {
        if let number = Double(self),
           number != .zero {
            let remainder = number/Double(Int(number))
            let roundedNumber = String(format: "%.\(1)f", remainder)
            return roundedNumber
        } else {
            return self
        }
    }
    
    // Global function to format and validate date strings
    func formatDateString(inputFormat: String? = nil, outputFormat: String) -> String {
        let inputFormatType:String =  inputFormat ?? "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormatType
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // Consistent parsing
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "en_US") // Adjust locale as needed
        
        // Parse the original date string into a Date object
        if let date = inputFormatter.date(from: self) {
            // Check if the original date string can be recreated from the parsed Date object using the same input format
            let reFormattedString = inputFormatter.string(from: date)
            if reFormattedString == self {
                // Convert the Date object into the new string format
                return outputFormatter.string(from: date)
            } else {
                return "Input format does not match the original date string."
            }
        } else {
            // Handle case where date parsing fails
            return "Invalid date"
        }
    }
    
    /// Check for emojis
    func hasEmoji() -> Bool {
        for character in self {
            for scalar in character.unicodeScalars {
                if scalar.properties.isEmoji {
                    if scalar.properties.isEmojiPresentation {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func containsOnlySpecialCharacters() -> Bool {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{};:'\"\\|`~,.<>/?")
        return self.rangeOfCharacter(from: specialCharacterSet.inverted) == nil
    }
    
    func hasAlphabets() -> Bool {
        let alphabetCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return self.rangeOfCharacter(from: alphabetCharacterSet) != nil
    }
    
    func hasNumbers() -> Bool {
        let numberCharacterSet = CharacterSet(charactersIn: "0123456789")
        return self.rangeOfCharacter(from: numberCharacterSet) != nil
    }
    
    func hasSpecialCharacters() -> Bool {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{};:'\"\\|`~,.<>/?;")
        return self.rangeOfCharacter(from: specialCharacterSet) != nil
    }
    
    func isValidInput() -> Bool {
        return !self.isEmpty && (self.hasAlphabets() || self.hasNumbers() || self.hasSpecialCharacters())
    }
    
//    var getTranslation: String {
//        CFSDKTranslationKeys(rawValue: self)?.textValue ?? .blank
//    }
//    
//    var getDirectTranslation: String {
//        CFSDKUtils.shared.translationData?[self] ?? .blank
//    }
}
