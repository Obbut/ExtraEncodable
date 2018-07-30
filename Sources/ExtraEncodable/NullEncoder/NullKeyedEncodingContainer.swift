struct NullKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] = []
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {}
    mutating func encodeNil(forKey key: Key) throws {}
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedEncodingContainer(NullKeyedEncodingContainer<NestedKey>())
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
