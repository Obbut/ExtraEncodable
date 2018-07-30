struct NullEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let container = NullKeyedEncodingContainer<Key>()
        return .init(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        return NullUnkeyedEncodingContainer()
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        return NullSingleValueEncodingContainer()
    }
}
