struct FieldHidingKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var wrapped: KeyedEncodingContainer<Key>
    var hiddenFields: [String]
    
    init(_ container: KeyedEncodingContainer<Key>, hiddenFields: [String]) {
        self.wrapped = container
        self.hiddenFields = hiddenFields
    }
    
    private func mayEncode(_ key: Key) -> Bool {
        return !(hiddenFields.contains(key.stringValue))
    }
    
    var codingPath: [CodingKey] {
        return wrapped.codingPath
    }
    
    mutating func encodeNil(forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encodeNil(forKey: key)
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try wrapped.encode(value, forKey: key)
    }
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        guard mayEncode(key) else { return }
        
        if blacklistedFieldHidingWrappedEncodableTypes.contains(where: { $0 == T.self }) {
            try wrapped.encode(value, forKey: key)
        } else {
            let wrappedValue = FieldHidingWrappedEncodable(value: value, hiddenFields: hiddenFields)
            try wrapped.encode(wrappedValue, forKey: key)
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        guard mayEncode(key) else {
            let container = NullKeyedEncodingContainer<NestedKey>()
            return KeyedEncodingContainer(container)
        }
        
        let originalNestedContainer = wrapped.nestedContainer(keyedBy: keyType, forKey: key)
        let wrappedNestedContainer = FieldHidingKeyedEncodingContainer<NestedKey>(originalNestedContainer, hiddenFields: self.hiddenFields)
        return KeyedEncodingContainer(wrappedNestedContainer)
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        guard mayEncode(key) else {
            return NullUnkeyedEncodingContainer()
        }
        
        let originalNestedContainer = wrapped.nestedUnkeyedContainer(forKey: key)
        return FieldHidingUnkeyedEncodingContainer(originalNestedContainer, hiddenFields: self.hiddenFields)
    }
    
    mutating func superEncoder() -> Encoder {
        return wrapped.superEncoder()
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        guard mayEncode(key) else {
            return NullEncoder()
        }
        
        return wrapped.superEncoder(forKey: key)
    }
}
