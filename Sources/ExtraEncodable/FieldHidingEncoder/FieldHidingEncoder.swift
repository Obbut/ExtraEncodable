import Foundation

// These types will not be used with a FieldHidingWrappedEncodable,
// because doing so would prevent the encoding strategies from working.
//
// Wrapping them does not do anything good anyways, because it is only useful for nested types that are encoded in a keyed container, which these are not.
let blacklistedFieldHidingWrappedEncodableTypes: [Any.Type] = [
    Date.self,
    Data.self,
    Float.self,
    Double.self,
    Int.self,
    Int8.self,
    Int16.self,
    Int32.self,
    Int64.self,
    UInt.self,
    UInt8.self,
    UInt16.self,
    UInt32.self,
    UInt64.self
]

struct FieldHidingEncoder: Encoder {
    var wrapped: Encoder
    var hiddenFields: [String]
    
    init(_ encoder: Encoder, hiddenFields: [String]) {
        self.wrapped = encoder
        self.hiddenFields = hiddenFields
    }
    
    var codingPath: [CodingKey] {
        return wrapped.codingPath
    }
    
    var userInfo: [CodingUserInfoKey: Any] {
        return wrapped.userInfo
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let base = wrapped.container(keyedBy: type)
        let hidingContainer = FieldHidingKeyedEncodingContainer(base, hiddenFields: hiddenFields)
        return KeyedEncodingContainer(hidingContainer)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let originalContainer = wrapped.unkeyedContainer()
        return FieldHidingUnkeyedEncodingContainer(originalContainer, hiddenFields: hiddenFields)
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        let originalContainer = wrapped.singleValueContainer()
        return FieldHidingSingleValueEncodingContainer(originalContainer, hiddenFields: hiddenFields)
    }
}

