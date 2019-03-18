struct FieldHidingWrappedEncodable<T: Encodable>: Encodable {
    var value: T
    var hiddenFields: [String]
    var visibleFields: [String]?
    
    func encode(to encoder: Encoder) throws {
        let wrappedEncoder = FieldHidingEncoder(encoder, hiddenFields: hiddenFields, visibleFields: visibleFields)
        try value.encode(to: wrappedEncoder)
    }
}
