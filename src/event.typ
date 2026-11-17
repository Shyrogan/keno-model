// Events: what happens in the domain that its people care about.

#import "element.typ": aliases-of, also, check-local, cited, element, fields-list, key-of, numbered, references, recorded-sources, sources-of

/// Something that happened that the domain's people care about, named in
/// the past tense, such as "Order placed".
///
/// ```typ
/// #event("Order placed", [A customer confirmed their basket.],
///   about: <order>,
///   payload: (number: [The order's number.]))
/// ```
///
/// - name (str): What happened, in the past tense.
/// - description (content): When it happens and what it means.
/// - about (label, array): The elements it concerns, such as the entity
///   it happens to: labels of this page, or `at(...)` for another page.
/// - payload (dictionary): What it carries, each field's name and meaning.
/// - aliases (array): Other names that mean the same, such as "Checkout".
/// - source (content, array): Where the knowledge comes from, such as
///   [Confirmed by the user] or link("https://…")[Ticket 42]; an array
///   for several.
/// - key (str): The event's label, `<order-placed>` for "Order placed" by
///   default.
#let event(name, description, about: (), payload: (:), aliases: (), source: none, key: auto) = {
  let key = key-of("event", name, key)
  let aliases = aliases-of("event", name, aliases)
  let sources = sources-of("event", name, source)
  let about = references(about, "the about of event \"" + name + "\"")
  assert(type(payload) == dictionary, message: "the payload of event \"" + name + "\" is a dictionary of field names and meanings, such as (number: [The order's number.])")
  let body = {
    description
    also(aliases)
    if payload.len() > 0 { fields-list(payload.pairs()) }
    cited(sources)
  }
  check-local(about, "event \"" + name + "\"")
  element("event", key, name, (description: description, aliases: aliases, about: about, payload: payload, source: recorded-sources(sources)), numbered("event", [Event], key, name, body))
}
