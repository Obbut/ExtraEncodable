/// An `Encodable` type that can encode extra data and/or prevent fields from being encoded.
///
/// This type only works with a `base` and `extraData` that encode to a keyed encoding container.
public struct ExtraEncodable<Base: Encodable>: Encodable {
    var base: Base
    var extraData: Encodable?
    var hiddenFields: [String]
    var visibleFields: [String]?
    
    /// - parameter base: The base instance to encode. If no other parameters are provided, encoding this `ExtraEncodable` will have the same effect as encoding `base`.
    /// - parameter extraData: Extra data that will be encoded, overlaying the encoded data from `base`.
    /// - parameter hiddenFields: An array of keys that will be prevented from encoding
    /// - parameter visibleFields: If set, only fields whose names are in the given array will be encoded. All other fields are omitted. This only works for top level fields.
    public init(base: Base, extraData: Encodable? = nil, hiddenFields: [String] = [], visibleFields: [String]? = nil) {
        self.base = base
        self.extraData = extraData
        self.hiddenFields = hiddenFields
        self.visibleFields = visibleFields
    }
    
    public func encode(to encoder: Encoder) throws {
        let hidingEncoder: Encoder
        if hiddenFields.count > 0 || visibleFields != nil {
            hidingEncoder = FieldHidingEncoder(encoder, hiddenFields: hiddenFields, visibleFields: visibleFields)
        } else {
            hidingEncoder = encoder
        }
        
        try base.encode(to: hidingEncoder)
        if let extraData = extraData {
            try extraData.encode(to: hidingEncoder)
        }
    }
}
