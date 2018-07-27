struct FieldHidingEncoder: Encoder {
    var encoder: Encoder
    var hiddenFields: [String]
    
    init(_ encoder: Encoder, hiddenFields: [String]) {
        self.encoder = encoder
        self.hiddenFields = hiddenFields
    }
    
    var codingPath: [CodingKey] {
        return encoder.codingPath
    }
    
    var userInfo: [CodingUserInfoKey: Any] {
        return encoder.userInfo
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let base = encoder.container(keyedBy: type)
        let hidingContainer = FieldHidingKeyedEncodingContainer(base, hiddenFields: hiddenFields)
        return KeyedEncodingContainer(hidingContainer)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        return encoder.unkeyedContainer()
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        return encoder.singleValueContainer()
    }
}

fileprivate struct FieldHidingKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var container: KeyedEncodingContainer<Key>
    var hiddenFields: [String]
    
    init(_ container: KeyedEncodingContainer<Key>, hiddenFields: [String]) {
        self.container = container
        self.hiddenFields = hiddenFields
    }
    
    private func mayEncode(_ key: Key) -> Bool {
        return !(hiddenFields.contains(key.stringValue))
    }
    
    // MARK: -
    
    var codingPath: [CodingKey] {
        return container.codingPath
    }
    
    mutating func encodeNil(forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encodeNil(forKey: key)
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        guard mayEncode(key) else { return }
        try container.encode(value, forKey: key)
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        guard mayEncode(key) else {
            let container = NullEncodingContainer<NestedKey>()
            return KeyedEncodingContainer(container)
        }
        
        return container.nestedContainer(keyedBy: keyType, forKey: key)
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        guard mayEncode(key) else {
            return NullUnkeyedEncodingContainer()
        }
        
        return container.nestedUnkeyedContainer(forKey: key)
    }
    
    mutating func superEncoder() -> Encoder {
        return container.superEncoder()
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        guard mayEncode(key) else {
            return NullEncoder()
        }
        
        return container.superEncoder(forKey: key)
    }
}

fileprivate struct NullEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] = []
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {}
    mutating func encodeNil(forKey key: Key) throws {}
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedEncodingContainer(NullEncodingContainer<NestedKey>())
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return NullUnkeyedEncodingContainer()
    }
    
    mutating func superEncoder() -> Encoder {
        return NullEncoder()
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        return NullEncoder()
    }
}

fileprivate struct NullUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    var codingPath: [CodingKey] = []
    var count: Int = 0
    
    mutating func encodeNil() throws {
        count += 1
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        count += 1
        let container = NullEncodingContainer<NestedKey>()
        return .init(container)
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        count += 1
        return NullUnkeyedEncodingContainer()
    }
    
    mutating func superEncoder() -> Encoder {
        count += 1
        return NullEncoder()
    }
    
    mutating func encode<T: Encodable>(_ value: T) throws {
        count += 1
    }
    
}

fileprivate struct NullSingleValueContainer: SingleValueEncodingContainer {
    var codingPath: [CodingKey] = []
    
    mutating func encodeNil() throws {}
    mutating func encode(_ value: Bool) throws {}
    mutating func encode(_ value: String) throws {}
    mutating func encode(_ value: Double) throws {}
    mutating func encode(_ value: Float) throws {}
    mutating func encode(_ value: Int) throws {}
    mutating func encode(_ value: Int8) throws {}
    mutating func encode(_ value: Int16) throws {}
    mutating func encode(_ value: Int32) throws {}
    mutating func encode(_ value: Int64) throws {}
    mutating func encode(_ value: UInt) throws {}
    mutating func encode(_ value: UInt8) throws {}
    mutating func encode(_ value: UInt16) throws {}
    mutating func encode(_ value: UInt32) throws {}
    mutating func encode(_ value: UInt64) throws {}
    mutating func encode<T>(_ value: T) throws where T: Encodable {}
}

fileprivate struct NullEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let container = NullEncodingContainer<Key>()
        return .init(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        return NullUnkeyedEncodingContainer()
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        return NullSingleValueContainer()
    }
}
