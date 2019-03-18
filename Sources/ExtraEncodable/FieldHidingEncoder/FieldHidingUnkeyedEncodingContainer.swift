struct FieldHidingUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    var container: UnkeyedEncodingContainer
    var hiddenFields: [String]
    var visibleFields: [String]?
    
    var codingPath: [CodingKey] {
        return container.codingPath
    }
    
    var count: Int {
        return container.count
    }
    
    mutating func encodeNil() throws {
        try container.encodeNil()
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let originalNestedContainer = container.nestedContainer(keyedBy: keyType)
        let wrappedNestedContainer = FieldHidingKeyedEncodingContainer(originalNestedContainer, hiddenFields: self.hiddenFields)
        
        return KeyedEncodingContainer(wrappedNestedContainer)
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let originalNestedContainer = container.nestedUnkeyedContainer()
        return FieldHidingUnkeyedEncodingContainer(container: originalNestedContainer, hiddenFields: self.hiddenFields, visibleFields: visibleFields)
    }
    
    mutating func superEncoder() -> Encoder {
        let originalSuperEncoder = container.superEncoder()
        return FieldHidingEncoder(originalSuperEncoder, hiddenFields: hiddenFields)
    }
    
    mutating func encode(_ value: Bool) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: String) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Double) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Float) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int8) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int16) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int32) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int64) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        try container.encode(value)
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        if blacklistedFieldHidingWrappedEncodableTypes.contains(where: { $0 == T.self }) {
            try container.encode(value)
        } else {
            let wrappedValue = FieldHidingWrappedEncodable(value: value, hiddenFields: hiddenFields, visibleFields: visibleFields)
            try container.encode(wrappedValue)
        }
    }
}
