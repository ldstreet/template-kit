
/// Type Erased Renderable struct
public struct AnyRenderable {
    
    /// stored renderable
    public var renderable: Renderable
    
    /// init
    public init(renderable: Renderable) {
        self.renderable = renderable
    }
    

}

/// Encodable conformance
extension AnyRenderable: Encodable {
    
    /// Coding keys for Encodable
    private enum CodingKeys: CodingKey {
        case renderable
    }
    
    /// Encode using the `Renderable` super encoder
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try renderable.encode(to: container.superEncoder(forKey: .renderable))
    }
}
