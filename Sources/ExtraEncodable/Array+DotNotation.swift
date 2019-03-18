//
//  Array+DotNotation.swift
//  ExtraEncodable
//
//  Created by Robbert Brandsma on 18/03/2019.
//

extension Array where Element == String {
    /// Given ["details.a", "b"] and key "details", returns ["a"]
    func visibleFieldsValue(underKey key: String) -> [String]? {
        let prefix = key + "."
        
        let visibleFields: [String] = self.compactMap { candidate in
            guard candidate.hasPrefix(prefix) else {
                return nil
            }
            
            return String(candidate.dropFirst(prefix.count))
        }
        
        if visibleFields.count == 0 && self.contains(key) {
            // all fields under the field may be encoded if the field itself is included and no nested fields are specified
            return nil
        }
        
        return visibleFields
    }
    
    func containsValuesForKey(_ key: String) -> Bool {
        let prefix = key + "."
        
        for candidate in self {
            // for `key == "name"`, include "name.abc", and "name", but not "nameFirst" or "nameFirst.abc"
            if candidate.starts(with: key) && (candidate.count == key.count || candidate.starts(with: prefix)) {
                return true
            }
        }
        
        return false
    }
}
