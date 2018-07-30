struct FieldHidingSingleValueEncodingContainer: SingleValueEncodingContainer {
    var wrapped: SingleValueEncodingContainer
    var hiddenFields: [String]
    
    init(_ container: SingleValueEncodingContainer, hiddenFields: [String]) {
        self.wrapped = container
        self.hiddenFields = hiddenFields
    }

    var codingPath: [CodingKey] {
        return wrapped.codingPath
    }
    
    mutating func encodeNil() throws {
        try wrapped.encodeNil()
    }
    
    mutating func encode(_ value: Bool) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: String) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Double) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Float) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Int) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Int8) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Int16) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Int32) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: Int64) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: UInt) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        try wrapped.encode(value)
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        let wrappedValue = FieldHidingWrappedEncodable(value: value, hiddenFields: hiddenFields)
        try wrapped.encode(wrappedValue)
    }
}
