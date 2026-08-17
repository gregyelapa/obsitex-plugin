# Obsitex Markdown conventions — overview and signpost

What the Obsitex converter (engine `native` / `converterSimple`) understands. **This file
and the topic files listed below are the complete description.** There is no other
documentation to fall back on.

**If a construct is not described here or in a topic file, treat it as unsupported.** Do
not invent it and do not assume Obsidian's rendering carries over. Tell the user that
Obsitex does not know it, and offer the nearest supported way to write it.

## Two folders — the project folder and the manuscript

Two terms, used everywhere. Never invent synonyms ("target folder", "root folder"); the user
should hear the same word every time.

- **project folder** (de: *Projektordner*) — the folder the whole work lives in. Obsidian opens
  *this* one, so it is also the vault; `.obsidian` (and later `.git`) sit here.
- **the manuscript** (de: *das Manuskript*) — the subfolder Obsitex turns into the document. On
  disk it is called `Manuscript` (de: `Manuskript`), or `10 Manuscript` where the folders are
  numbered; projects scaffolded before that rule may still carry `Thesis`, `Arbeit` or `Paper`.

What follows from the split — and what goes silently wrong when it is forgotten:

- **Only the `.md` files inside the manuscript become the document.** Text written into one of
  the other project folders (Research, Interviews, Data, …) never reaches the PDF. Nothing warns
  about it, so before writing into a note, know which side of the line it sits on.
- **A wikilink out of the manuscript works in Obsidian and becomes nothing in the PDF.** Link
  outward for working, not for citing.
- **Attachments are the exception** — images, PDFs and `.bib` files are resolved across the whole
  vault, so an embed may point outside. Keeping them **inside** the manuscript is still the rule:
  it has to stay copyable as a whole (`images.md`, "Which level").
- Without the project scaffold there is only one folder, which is project folder and manuscript
  at once. Then just say "your folder".

### Moving a project into a vault the user already has

`obsitex:init` always makes the project folder its own vault and never asks about this — the
question cannot be raised without explaining vaults to someone who may not need the concept.
But the wish is legitimate and comes up: a thesis next to existing literature notes, or
several projects sharing one Flexplorer installation. **Only act on it when the user asks.**

What has to happen, in this order:

1. Move the project folder into the existing vault (a plain folder move).
2. Merge the entries from the project's `data.json` into the existing vault's
   `.obsidian/plugins/flexplorer/data.json` — **keys get the full path from that vault's
   root**, e.g. `Projects/Master Thesis/Manuscript`. Back the file up first; it holds the order
   of everything the user already has.
3. **Drop the `"/"` entry.** In the project's own vault it listed just the six scaffold
   folders; in the bigger vault it would reorder the user's entire top level, because the
   plugin merges the list in and re-sorts everything else behind it.
4. Delete the now-duplicate `.obsidian` inside the project folder — otherwise it stays a
   vault inside a vault and the files appear in both.

Name the price plainly: the order now lives outside the project folder, so it is not copied,
archived or versioned along with it. Anyone planning to put the project under Git should stay
with a vault of their own — `data.json` belongs in the repository.

Setting a project up — folder naming, document language, the scaffold — belongs to `obsitex-init`
and is described in its own `SKILL.md`.

## Where to look things up

Read the matching file **when the topic comes up** — not in advance. Each is short.

| Topic | File |
|---|---|
| Tables, column alignment, cell contents, colour | `tables.md` |
| Bulleted, numbered and task lists | `lists.md` |
| Images, captions, referring to a figure, saving an image pasted into the chat | `images.md` |
| Embedding whole PDF documents, page orientation, saving a PDF dropped into the chat | `pdf-embeds.md` |
| Heading levels, folders, depth, unnumbered headings | `headings.md` |
| Wikilinks, cross-references, external URLs | `links.md` |
| Emphasis, line breaks, maths, the backtick trap | `text-formatting.md` |
| Citing, quoting, the `.bib` embed | `bibliography.md` |
| Footnotes and their numbering | `footnotes.md` |
| Quotation marks, nesting, the apostrophe | `quotation-marks.md` |
| Escaping, rules, dashes, emoji | `special-characters.md` |
| The 22 document settings, field by field | `dds.md` |
| Constructs that silently go wrong, and what to write instead | `not-supported.md` |
| Anything the plain syntax cannot express | see "Answering a formatting wish" below |

## Answering a formatting wish

When the user asks for something the plain syntax cannot express, there are three levels.
**Take the lowest one that reaches.**

| The wish … | Where it belongs |
|---|---|
| … applies from here on (rules, alignment, environments, quotation marks) | a ` ```dds ` block before the spot |
| … applies to this one spot and needs LaTeX | a ` ```latex ` block |
| … needs a package that is not loaded yet | the preamble in `00 Document Setup.md` |

**A `dds` block is a patch, not a replacement.** Write only the keys you change; the rest
carries over from the state above. It takes effect from that position on and never
retroactively — so put the value back afterwards, or everything below inherits the change.
Exception: `documentClass` cannot be changed mid-document (first block wins, warning 92870).
Invalid JSON leaves the state untouched.

**Before reaching for level 3, read the preamble.** Never decide from memory which packages
are loaded — open `00 Document Setup.md` in the user's own vault and look. Loading a package
twice with different options is a hard LaTeX error (`Option clash for package …`), not a
warning, and the user may have edited the preamble since the project was scaffolded.

**Never add a package silently.** If a wish really does need one, add the `\usepackage` line
with a `%` comment saying what it is for, and tell the user. It is a permanent change to the
whole document.

**Raw blocks are visible in Obsidian.** A ` ```latex ` block is passed through untouched, so
the author sees LaTeX source in the preview where they expected a table or a figure. Say so
when you use one — do not let them discover it.

## Not supported — what silently goes wrong

These are the dangerous ones: Obsidian renders them, the PDF does not. Nothing warns.

| Written | What lands in the PDF |
|---|---|
| `<sub>` `<sup>` `<mark>` `<b>` `<i>` `<center>` | the raw tag as visible text |
| `Title` + `===` / `---` on the next line (Setext) | body text **plus** the rule line |
| `[Text][id]` with `[id]: url` | the link markup **plus** the definition line as a paragraph |
| `<https://example.com>` | the link works, but the angle brackets stay visible |
| `*italic **bold** italic*` (nested emphasis) | unreliable — avoid |

`<br>` is the one exception: it works **inside a table cell** and nowhere else — but only
with a paragraph-column table template. With the default `l`/`c`/`r` columns the line break
is dropped silently. Before promising a multi-line cell, read `tables.md`,
"Multi-paragraph cells".

**What to write instead, in each case: `not-supported.md`.** Do not improvise a replacement —
`<sub>`/`<sup>` in particular have a correct answer that needs no package.

## Write each paragraph as ONE line — never wrap prose

**A single newline inside a paragraph becomes `\\` in the LaTeX output**, i.e. a forced line
break in the middle of the printed sentence. Obsidian hides this completely: it soft-wraps
the display, so a hard-wrapped paragraph and a single-line one look identical on screen.

```markdown
Right — one line, however long:
Operational property management is expected to run as one continuous chain. A tenant reports a defect, the request is recorded and triaged, and the invoice is posted.

Wrong — wrapped at 90 columns:
Operational property management is expected to run as one continuous chain. A tenant
reports a defect, the request is recorded and triaged, and the invoice is posted.
```

The second version prints with a ragged break after "tenant" and after "triaged".

**This is on you, not on the user.** Wrapping source text at 80 or 90 columns is a normal
habit almost everywhere else, and nothing in the file will look wrong afterwards. Before you
write or edit any body text, check that every paragraph is a single unbroken line.

Where it does **not** matter: inside ` ```remark `, ` ```latex ` and ` ```dds ` blocks — wrap
those freely for readability.

**It matters in list items too** (measured 14.08.2026). A continued line without a list marker
is appended to the item, but with a `\\` in front of it — the same forced break as in a
paragraph. One list item = one line.

Where a line break is genuinely wanted in the PDF (an address, a verse), the newline is the
correct tool — that is why the converter behaves this way.

## Headings and hierarchy

Details, folder levels, depth limit, attributes and the appendix special cases: `headings.md`.
What must hold without looking anything up:

- **Only `#` lines create heading _text_.** File and folder names never do — but the folder a
  file sits in sets the _level_ its headings start from.
- **A file never starts with more than one `#`.** One `#` always means "the level of the folder
  I am in". A file starting with `##` works but can never become a folder without a text edit.
- **`Frontmatter` and `Backmatter` hold files only — never folders.** A folder inside them
  lands one level too deep, silently.
- **A heading needs no blank line before it** — except directly under a **list item**, where
  the list swallows it.
- Attributes at the end of the line: `# Title {-}` → unnumbered but in the table of contents ·
  `# Title {.unnumbered .unlisted}` → unnumbered, not listed.
- scrbook structure switches (`\frontmatter`, `\mainmatter`, `\appendix`) are raw
  ` ```latex ` blocks in their own files. There is **no** `\backmatter` — `\appendix` stands
  directly before the appendix chapters, not at the top of the `Backmatter` folder.

## Frontmatter keys (YAML at top of file)

- `skip: true` or `latex-remark: true` — file is excluded from the document
- `latex-heading-offset: N` — shifts all heading levels of the file by N
- `title: …` — **ignored by the converter** (deliberately NOT a link identifier, decision
  N23; does not create a heading either)

## Code fences (tagged blocks)

- ` ```dds ` — converter settings as one JSON object (document class, environments, …)
- ` ```latex-preamble ` — LaTeX preamble content (packages), goes before `\begin{document}`
- ` ```latex ` — raw LaTeX passthrough at this position
- ` ```remark ` — ignored by the converter (use for guidance notes)
- any other fence (` ``` ` or ` ```python `) — verbatim code block in the PDF

## Inline formatting

Details, maths, the `$`-in-prices rule and what is not supported: `text-formatting.md`.

- `**bold**`, `*italic*`, `***bold italic***`, `<u>underline</u>`, `==highlight==`,
  `~~strikethrough~~` — all packages are in the standard preamble
- `_underscore emphasis_` only at word boundaries (snake_case stays literal)
- Math `$…$` / `$$…$$` is passed through untouched
- Straight quotes `"…"` are converted to typographic quotes per the DDS settings
- **Trap — inline backticks are raw LaTeX, not monospace.** Their content reaches the output
  unescaped. That is how a LaTeX command gets into a cell — and why `` `snake_case` `` or
  `` `a^b` `` breaks the build. To show a special character, leave the backticks off and let
  the converter escape it.
- **Trap — emphasis is not recognised across a line break.** The asterisks print as text. It
  compiles and Obsidian renders it correctly, so only the PDF shows it. One more reason for
  one paragraph = one line.

## Footnotes

Numbering, reuse, long footnotes and the class-dependent counter: `footnotes.md`.

- `Text[^1]` plus a definition line `[^1]: The footnote text` → `\footnote{…}`, core LaTeX.
  Short form: `Text^[The footnote text]`
- **Note-scoped:** reference and definition must be in the SAME file. Put definitions at the
  end of the note; their lines never appear in the body text
- **No block elements inside** — no list, table or image in a footnote
- **Never write a footnote number by hand.** LaTeX assigns them, and with a book class they
  restart per chapter

## Citations and bibliography

Quotation forms, prenotes, locators and the `.bib` embed: `bibliography.md`.

- `[@key]` → cite · `[@key, 25]` → with page · `[cf. @key, 25]` → with prenote
- `![[refs.bib]]` registers the file **and** prints the bibliography at that spot
- **Never invent citation keys.** A key that is not in `refs.bib` turns into a question mark
  in the PDF — read the file or ask

## Links and embeds

- `[text](url)` → `\href` · bare URL → `\url`
- `[[Note]]` / `[[#Heading]]` → cross-reference (`\vref`) to the target's first heading
- `[[Note|alias]]` → `\hyperref` with the alias text
- Wikilink resolution is **file-name/path based only** (relPath · relPath without `.md` ·
  basename, lowercased) — `title:`/`aliases:` do not count. Renaming a file outside
  Obsidian therefore breaks wikilinks pointing to it: update all referencing links (and
  the Flexplorer `data.json` entry) in the same operation.
- `![[image.png]]` → figure environment (per DDS) · `![[file.pdf]]` → embedded PDF pages

### How to write an attachment link

Obsidian's own autocomplete gets this right on its own: it inserts the **shortest path
that is still unambiguous** — a bare name while the name is unique, the vault-root path
in front of it as soon as it is not. **When you write files yourself there is no
autocomplete to correct you, so follow the same rule by hand:**

- name unique in the vault → bare name is fine (`![[refs.bib]]`)
- name occurs more than once → put the folder in front, **from the vault root**
  (`![[Kapitel 2/aufbau.png]]`), never just the bare name
- **never** use `../` — Obsitex does not resolve it. It silently falls back to matching
  the bare file name, so the link lands on *some* file of that name, not the intended
  one. This is what Obsidian writes under "Relative path to file"; leave that setting
  alone (Obsitex reads the default "Shortest path when possible" correctly)
- **never** drop the extension. `![[aufbau]]` finds nothing in Obsidian, but Obsitex
  strips extensions when matching and may embed `aufbau.pdf` where a picture belongs

The bare-name case is not permanently safe, and nothing warns about it: a link written
while the name was unique stays as it is when a second file of that name appears later.
Obsidian then resolves it to the neighbouring file, Obsitex to whichever it scanned
first — a silent divergence. So prefer distinct file names (`aufbau-anlage.png` over a
second `aufbau.png`) rather than relying on the link being rewritten.

## Block elements

- Paragraphs, nested lists (`-` / `1.`), task lists (`- [ ]` / `- [x]`), GFM tables
  (multi-paragraph cells via `<br>`, needs a `p{…}` column — `tables.md`)
- `> quote` → quote environment · `> [!note] Title` callout → shaded box
- `---` / `***` / `___` alone on a line → horizontal rule (careful: `---` as the very
  first line of a file starts YAML frontmatter instead)

## Document order and structure

- Order: Flexplorer plugin data if present, otherwise **alphabetical**. Two set-ups:
  variant A = Flexplorer carries the order, file names without numbers (except
  `00 Document Setup.md`); variant B = no plugin, numbers in steps of ten carry the order
- One `00 Document Setup.md` per project holds the `dds` + `latex-preamble` blocks
- Never add preamble packages silently — edit `00 Document Setup.md` visibly, with a `%` comment
