# Bibliography and citations

Embedding a `.bib` file and citing from it — direct quotations, paraphrases, block quotes.

> The general rules are in `obsitex-conventions.md`. This file gives the citation-specific
> cases.

## Placing the bibliography

Embed the `.bib` file where the list should appear, usually at the end of the document:

```markdown
![[refs.bib]]
```

One embed does **two** things: `\addbibresource{…}` goes into the preamble, and
`\printbibliography` is emitted at the embed's position — from the DDS fields
`bibliographyCmdText` and `bibliographyBodyCmd`. On export the `.bib` lands in a `bib/`
subfolder.

The standard preamble already loads `\usepackage[backend=biber, style=numeric-comp]{biblatex}`
— **no new package**. How a citation looks (`[1]` vs. "Müller 2024") is decided by the `style=`
option there, **not** by Obsitex.

**Changing the style needs a second line.** The converter always emits `\cite{…}`, and `\cite`
means something different in every biblatex style:

| Style | Extra line in the preamble | Without it |
|---|---|---|
| `numeric-comp` | none | `[1]` — correct |
| `authoryear` | `\let\cite\parencite` | `Knuth 1984` — **no parentheses** |
| `verbose` | `\let\cite\footcite` | the **whole reference inside the sentence** |

Measured 14.08.2026. Both broken forms **compile without a warning** — they are only visible
in the PDF. If a user asks to switch the citation style, add both lines and say why.

## The three citation forms

**1 — Short direct quotation, in running text.** Straight quotes plus the source:

```markdown
As Müller writes, "the market is efficient" [@mueller2024, p.~14].
```

The straight `"…"` become typographic quotes automatically (see `quotation-marks.md`). The
part after the comma is the **locator** → `\cite[p.~14]{mueller2024}`. The `~` is a
non-breaking space, so "p." and the number never split across a line.

**2 — Long direct quotation, set off as a block.** A `>` block, source at the end:

```markdown
> A longer quotation running over
> several lines.
>
> Several paragraphs are possible. [@mueller2024, p.~15]
```

Becomes an indented `quote` environment — **without** quotation marks, as is usual in academic
writing. A blank line inside the quote is a `>` alone on its line.

**3 — Paraphrase.** No quotation marks; a prenote **inside** the brackets:

```markdown
The market is generally held to be efficient [cf. @mueller2024, p.~14].
```

→ `\cite[cf.][p.~14]{mueller2024}`. The text **before** the `@` becomes the prenote, and
**there must be a space between the prenote and the `@`**.

## Traps

- **Citation keys must exist in the `.bib`.** A key that is not there prints as a question
  mark in the PDF. **Never invent keys** — read `refs.bib` first, or ask the user.
- **Several sources in one bracket (`[@a; @b]`) are not supported.** Way out: raw LaTeX in
  backticks — `` `\cite{a,b}` ``.
- **A bracket containing `@` without a space before it is not a citation** — `[name@firm.ch]`
  stays ordinary text. Useful to know, but also a reason to write email addresses outside
  brackets.
- **The bibliography needs two LaTeX passes plus biber.** If the user reports empty brackets
  or missing entries after one run, that is the cause, not the Markdown.
- **A caption on the `.bib` embed is ignored** — deliberately. `![[refs.bib|Sources]]` does
  nothing with the text.
