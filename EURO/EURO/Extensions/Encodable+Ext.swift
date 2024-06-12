//
//  Encodable+Ext.swift
//  sifantasysdk
//
//  Created by Nausheen Khan on 18/04/24.
//

import Foundation

extension Encodable {
    func encodeJSON() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        let decoder = JSONDecoder()
        return (try? decoder.decode([String : String].self,
                                    from: encodeJSON())) ?? [:]
    }
}
