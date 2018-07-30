struct NullUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    var codingPath: [CodingKey] = []
    var count: Int = 0
    
    mutating func encodeNil() throws {
        count += 1
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        count += 1
        let container = NullKeyedEncodingContainer<NestedKey>()
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
