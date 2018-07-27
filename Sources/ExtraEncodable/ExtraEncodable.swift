/// An `Encodable` type that can encode extra data and/or prevent fields from being encoded.
///
/// This type only works with a `base` and `extraData` that encode to a keyed encoding container.
public struct ExtraEncodable<Base: Encodable>: Encodable {
    var base: Base
    var extraData: Encodable?
    var hiddenFields: [String]
    
    /// - parameter base: The base instance to encode. If no other parameters are provided, encoding this `ExtraEncodable` will have the same effect as encoding `base`.
    /// - parameter extraData: Extra data that will be encoded, overlaying the encoded data from `base`.
    /// - parameter hiddenFields: An array of keys that will be prevented from encoding
    public init(base: Base, extraData: Encodable? = nil, hiddenFields: [String] = []) {
        self.base = base
        self.extraData = extraData
        self.hiddenFields = hiddenFields
    }
    
    public func encode(to encoder: Encoder) throws {
        let hidingEncoder: Encoder
        if hiddenFields.count > 0 {
            hidingEncoder = FieldHidingEncoder(encoder, hiddenFields: hiddenFields)
        } else {
            hidingEncoder = encoder
        }
        
        try base.encode(to: hidingEncoder)
        if let extraData = extraData {
            try extraData.encode(to: hidingEncoder)
        }
    }
}
