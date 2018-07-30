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

