// Terms: the words of the ubiquitous language, with what they mean.

#import "element.typ": aliases-of, also, cited, element, key-of, part, slug, recorded-sources, sources-of

/// A term of the domain's language and its definition, shown as an entry of
/// a definition list.
///
/// ```typ
/// #term("Invoice", [A request for payment for an order.],
///   aliases: ("bill",), avoid: ("receipt",))
/// ```
///
/// - name (str): The preferred name, as people write it.
/// - definition (content): What the term means: the broader concept it is a
///   kind of, and what sets it apart, such that it could replace the term in
///   a sentence.
/// - aliases (array): Other names that mean the same, such as abbreviations.
/// - avoid (array): Words people use for it that should not be used, kept
///   so that a search for them finds the term.
/// - source (content, array): Where the knowledge comes from, such as
///   [Confirmed by the user] or link("https://…")[Ticket 42]; an array
///   for several.
/// - key (str): The term's label, `<invoice>` for "Invoice" by default.
#let term(name, definition, aliases: (), avoid: (), source: none, key: auto) = {
  let key = key-of("term", name, key)
  let aliases = aliases-of("term", name, aliases)
  let sources = sources-of("term", name, source)
  assert(type(avoid) == array and avoid.all(word => type(word) == str and word.trim() != ""), message: "the words to avoid of term \"" + name + "\" are strings, such as (\"receipt\",)")
  let admitted = (name, ..aliases).map(slug)
  let overlap = avoid.filter(word => slug(word) in admitted)
  assert(overlap.len() == 0, message: "term \"" + name + "\" both admits and avoids " + overlap.join(", "))
  let shown = {
    definition
    also(aliases)
    if avoid.len() > 0 { part("avoid")[_Avoid:_ #avoid.join(", ")] }
    cited(sources)
  }
  // A list item cannot carry a label, so the label sits on an empty
  // metadata at the start of the term's name, where links land.
  terms.item([#metadata(none)#label(key)#name], shown)
  element("term", key, name, (definition: definition, aliases: aliases, avoid: avoid, source: recorded-sources(sources)), none)
}
