/// Embeds rendered views for `Templated` or `TemplatePathed` models
///
///     templatedModel(<model>)
///
/// The model must either be `Templated` or `TemplatePathed`
public final class TemplatedModel: TagRenderer {
    
    /// Creates a new `TemplatedModel` tag renderer.
    public init() {}
    
    /// See `TagRenderer`.
    public func render(tag: TagContext) throws -> EventLoopFuture<TemplateData> {
        
        try tag.requireParameterCount(1)
        
        let context = tag.parameters[0]
        
        let renderer = try tag.container.make(TemplateRenderer.self)
        
        let view: EventLoopFuture<View>
        if let templatePath = context.dictionary?["templatePath"]?.string { // `TemplatePathed`
            view = renderer.render(templatePath, context)
        } else if let template = context.dictionary?["template"]?.data { // `Templateed`
            view = renderer.render(template: template, context)
        } else {
            throw(TemplateKitError(identifier: "notRenderable", reason: "First paramater must be Templated or TemplatePathed. The data supplied does not contain a templatePath or template"))
        }
        
        /// Convert into TemplateData
        return view.map { view -> TemplateData in
            return .data(view.data)
        }
        
    }
}
