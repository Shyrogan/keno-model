// Open questions: what a session found but could not settle.

#import "element.typ": aliases-of, also, check-local, cited, element, key-of, numbered, references, recorded-sources, sources-of

/// Something that is not settled yet, kept so that the next session or a
/// person can take it up.
///
/// ```typ
/// #question("Credit notes", [Does a credit note reduce an invoice or
///   replace it?], about: <invoice>)
/// ```
///
/// - name (str): The question, in a few words.
/// - body (content): The question, and what is known so far.
/// - about (label, array): The elements it concerns: labels of this page,
///   or `at(...)` for another page.
/// - aliases (array): Other names people give the question.
/// - source (content, array): Where the knowledge comes from, such as
///   [Confirmed by the user] or link("https://…")[Ticket 42]; an array
///   for several.
/// - key (str): The question's label, from its name by default.
#let question(name, body, about: (), aliases: (), source: none, key: auto) = {
  let key = key-of("question", name, key)
  let aliases = aliases-of("question", name, aliases)
  let sources = sources-of("question", name, source)
  let about = references(about, "the about of question \"" + name + "\"")
  check-local(about, "question \"" + name + "\"")
  element("question", key, name, (body: body, aliases: aliases, about: about, source: recorded-sources(sources)), numbered("question", [Open question], key, name, {
    body
    also(aliases)
    cited(sources)
  }))
}
