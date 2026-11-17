// Decisions: the choices behind a design, with what led to them.

#import "element.typ": aliases-of, check-local, element, fields-list, key-of, numbered, references, recorded-sources, sources-of

// Where a decision stands, after Nygard's architecture decision records.
#let statuses = ("proposed", "accepted", "rejected", "deprecated", "superseded")

/// A design choice and why it was made.
///
/// ```typ
/// #decision("Version pages one by one",
///   problem: [Two writers must not overwrite each other.],
///   outcome: [Each page keeps its own history of revisions.],
///   consequences: [A change across pages is several writes.],
///   options: ([Version the whole knowledge base, like a git commit.],),
///   supersedes: at("/decisions/history", <one-history>))
/// ```
///
/// - name (str): The choice, in a few words.
/// - problem (content): The problem and the forces at play.
/// - outcome (content): What was decided.
/// - consequences (content): What follows, good and bad.
/// - options (array): The other options that were weighed and set aside.
/// - status (str): One of "proposed", "accepted", "rejected",
///   "deprecated" or "superseded"; "accepted" by default.
/// - supersedes (label, array): The decisions this one replaces: labels of
///   this page, or `at(...)` for another page.
/// - aliases (array): Other names people give the decision.
/// - source (content, array): Where the knowledge comes from, such as
///   [Confirmed by the user] or link("https://…")[Ticket 42]; an array
///   for several.
/// - key (str): The decision's label, from its name by default.
#let decision(
  name,
  problem: none,
  outcome: none,
  consequences: none,
  options: (),
  status: "accepted",
  supersedes: (),
  aliases: (),
  source: none,
  key: auto,
) = {
  let key = key-of("decision", name, key)
  let aliases = aliases-of("decision", name, aliases)
  let sources = sources-of("decision", name, source)
  assert(status in statuses, message: "the status of decision \"" + name + "\" is one of " + statuses.join(", "))
  assert(outcome != none, message: "decision \"" + name + "\" takes its outcome: what was decided")
  assert(type(options) == array, message: "the options of decision \"" + name + "\" are an array, such as ([Version the whole base.],)")
  let supersedes = references(supersedes, "the supersedes of decision \"" + name + "\"")
  let rows = (
    ([Status], [#status]),
    ..if aliases.len() > 0 { (([Also], aliases.join(", ")),) },
    ..if problem != none { (([Problem], problem),) },
    ([Decision], outcome),
    ..if consequences != none { (([Consequences], consequences),) },
    ..if options.len() > 0 { (([Set aside], list(..options)),) },
    ..if sources.len() > 0 { (([Source], sources.join("; ")),) },
  )
  check-local(supersedes, "decision \"" + name + "\"")
  element(
    "decision",
    key,
    name,
    (problem: problem, outcome: outcome, consequences: consequences, options: options, status: status, supersedes: supersedes, aliases: aliases, source: recorded-sources(sources)),
    numbered("decision", [Decision], key, name, fields-list(rows)),
  )
}
