struct FieldHidingWrappedEncodable<T: Encodable>: Encodable {
    var value: T
    var hiddenFields: [String]
    
    func encode(to encoder: Encoder) throws {
        let wrappedEncoder = FieldHidingEncoder(encoder, hiddenFields: hiddenFields)
        try value.encode(to: wrappedEncoder)
    }
}
