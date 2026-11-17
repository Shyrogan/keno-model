// Invariants: the rules of the domain that can never be broken.

#import "element.typ": aliases-of, also, check-local, cited, element, key-of, numbered, part, references, recorded-sources, sources-of

/// A rule that always holds, by the domain's own definitions, such as
/// "an invoice's total is the sum of its lines".
///
/// ```typ
/// #invariant("Total of lines", [An invoice's total is the sum of its lines.],
///   about: (<invoice>, at("/terms/line", <line>)))
/// ```
///
/// - name (str): A short name for the rule.
/// - statement (content): The rule, as a sentence that is true or false.
/// - about (label, array): The elements it constrains: labels of this
///   page, or `at(...)` for another page.
/// - because (content): Why it holds, when that is not obvious.
/// - aliases (array): Other names people give the rule.
/// - source (content, array): Where the knowledge comes from, such as
///   [Confirmed by the user] or link("https://…")[Ticket 42]; an array
///   for several.
/// - key (str): The invariant's label, from its name by default.
#let invariant(name, statement, about: (), because: none, aliases: (), source: none, key: auto) = {
  let key = key-of("invariant", name, key)
  let aliases = aliases-of("invariant", name, aliases)
  let sources = sources-of("invariant", name, source)
  let about = references(about, "the about of invariant \"" + name + "\"")
  let body = {
    statement
    if because != none { part("because")[_Because:_ #because] }
    also(aliases)
    cited(sources)
  }
  check-local(about, "invariant \"" + name + "\"")
  element("invariant", key, name, (statement: statement, aliases: aliases, about: about, because: because, source: recorded-sources(sources)), numbered("invariant", [Invariant], key, name, body))
}
