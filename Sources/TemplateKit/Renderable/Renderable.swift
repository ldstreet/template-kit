import Service

/// Renders the encodable model into a View
public protocol Renderable: Encodable {
    
    /// Renders a view using the information found in the Renderable model.
    ///
    /// - parameters:
    ///     - renderer: Renderer used for rendering model into `View`
    /// - returns: `Future` containing the rendered `View`.
    func render(using renderer: TemplateRenderer) throws -> Future<View>
}

/// Provides the model with a template
public protocol Templated {
    
    /// Template
    var template: String { get }
}

/// Default implementation of Renderable when model is Templated
extension Renderable where Self: Templated {
    
    /// Uses template to render model into view
    public func render(using renderer: TemplateRenderer) throws -> Future<View> {
        guard let data = template.data(using: .utf8) else {
            throw(TemplateKitError(identifier: "badTemplateString", reason: "Template string could not be converted to data."))
        }
        return renderer.render(template: data, self)
    }
}


/// Provides the model with the path to the template
public protocol TemplatePathed {
    
    /// Path to template
    var templatePath: String { get }
}

/// Default implementation of Renderable when model is TemplatePathed
extension Renderable where Self: TemplatePathed {
    
    /// Uses template path to render model into view
    public func render(using renderer: TemplateRenderer) throws -> Future<View> {
        return renderer.render(templatePath, self)
    }
}


