// Entities: the things of the domain that keep an identity over time.

#import "element.typ": aliases-of, also, cited, element, fields-list, key-of, numbered, recorded-sources, sources-of

/// A thing of the domain with an identity that lasts while its attributes
/// change, such as an order or a customer.
///
/// ```typ
/// #entity("Purchase order", [What a customer asks to buy, from placing to
///   delivery.],
///   aliases: ("PO",),
///   attributes: (
///     number: [Identifies the order; never changes.],
///     lines: [What is bought, one line per product.],
///   ))
/// ```
///
/// - name (str): The entity's name, as the domain's language says it.
/// - description (content): What it is and what identifies it.
/// - aliases (array): Other names that mean the same, such as abbreviations.
/// - attributes (dictionary): Each attribute's name and what it holds.
/// - source (content, array): Where the knowledge comes from, such as
///   [Confirmed by the user] or link("https://…")[Ticket 42]; an array
///   for several.
/// - key (str): The entity's label, `<purchase-order>` for "Purchase order"
///   by default.
#let entity(name, description, aliases: (), attributes: (:), source: none, key: auto) = {
  let key = key-of("entity", name, key)
  let aliases = aliases-of("entity", name, aliases)
  let sources = sources-of("entity", name, source)
  assert(type(attributes) == dictionary, message: "the attributes of entity \"" + name + "\" are a dictionary of names and descriptions, such as (number: [Identifies the order.])")
  let body = {
    description
    also(aliases)
    if attributes.len() > 0 { fields-list(attributes.pairs()) }
    cited(sources)
  }
  element("entity", key, name, (description: description, aliases: aliases, attributes: attributes, source: recorded-sources(sources)), numbered("entity", [Entity], key, name, body))
}
