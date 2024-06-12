//
//  Date+Ext.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 20/04/24.
//

import Foundation

enum CFSDKDateFormats: String, CaseIterable {
    case yyyyddHHmmssSSS = "yyyy-MM-dd HH:mm:ss.SSS"
    case yyyyddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case ISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case dateTimeFormat = "MM/dd/yyyy HH:mm:ss"
    case dateTimeFormat2 = "dd/MM/yyyy HH:mm:ss"
    case shortDate = "dd MMM"
    case timehHourMin = "HH:mm"
    case ddMMMyyyy = "dd MMM, yyyy"
    case weekdayTimeHourMin = "EEEE HH:mm"
}

extension Date {
    static func getDate(from dateString: String?) -> Date {
        let dateFormatter = DateFormatter()
        for format in CFSDKDateFormats.allCases {
            dateFormatter.dateFormat = format.rawValue
            if let dateString,
               let date = dateFormatter.date(from: dateString) {
                return date
            }
        }
        return Date()
    }
    
    func toString( dateFormat format  : CFSDKDateFormats ) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.string(from: self)
        }
    
    func convertUTCToLocalTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let utcDateString = dateFormatter.string(from: self)
        
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent // Use current device timezone
        let localDate = dateFormatter.date(from: utcDateString)!
        
        return localDate
    }
}
