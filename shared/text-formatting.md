# Text and formatting

Emphasis, line breaks, maths, and the backtick trap.

> The general rules are in `obsitex-conventions.md` — including the paragraph rule, which is
> the most important thing on this page. This file gives the details.

## Emphasis

| Written | LaTeX | Result |
|---|---|---|
| `**bold**` or `__bold__` | `\textbf{…}` | bold |
| `*italic*` or `_italic_` | `\textit{…}` | italic |
| `***bold italic***` | `\textbf{\textit{…}}` | bold italic |
| `<u>underlined</u>` | `\underline{…}` | underlined |
| `==highlight==` | `\hl{…}` (soul) | highlighted |
| `~~strikethrough~~` | `\sout{…}` (ulem) | struck through |

`soul` and `ulem` are in the standard preamble — **no new package**.

`<u>` is the **only** HTML tag that works in body text; Markdown has no underline, and
Obsidian uses the same tag. Everything else lands raw in the PDF — see `not-supported.md`.

**Underscore emphasis only works at word boundaries.** `snake_case` stays literal, which is
what you want. Asterisks have no such guard: `word*part*` does become italic.

**Not supported: nested emphasis** like `*italic **bold** italic*`. The tokenizer works
left to right with one rule per construct and cannot balance them. Obsidian renders it,
Obsitex breaks it. Split it into separate spans, or use a raw block.

**Also not supported: emphasis spanning a line break.** `_renderInline` works line by line,
so a `**…**` pair whose halves sit on two lines is not recognised — the asterisks are printed
as text. It compiles cleanly and Obsidian renders it correctly, so **nothing catches this
but reading the PDF.** One more reason for the one-line-per-paragraph rule.

## Line breaks

A **single** newline inside a paragraph becomes a hard break (`\\`) — this matches Obsidian's
"strict line breaks: off". A **blank line** starts a new paragraph.

This is deliberate: a line break in the source is *content*, not formatting. It is also the
reason paragraphs must be written as one line. See `obsitex-conventions.md`.

## Maths

`$…$` inline and `$$…$$` display are passed through to LaTeX untouched — Obsidian maths
*is* LaTeX.

**Prices do not break formulas.** A `$` pair only opens a formula when all three hold:

1. no space after the opening `$`
2. no space before the closing `$`
3. no digit after the closing `$`

A formula also ends at the end of the line at the latest. "costs $5, plus $10" survives as
text because of rule 3. **Obsitex behaves exactly like Obsidian here** — what the author sees
as a formula in the preview becomes one in the PDF. To be certain, write `\$`.

## The backtick trap — read this before using backticks

**Inline backticks are NOT monospace text. Their content is passed to LaTeX raw.**

That is a feature when you mean it: `` `\newpage` `` or `` `\rowcolor{gray!25}` `` in a table
cell reach the output as commands. It is a defect when you do not:

- `` `snake_case` `` → `_` starts a subscript, or breaks the build
- `` `a^b` `` → `^` starts a superscript
- `` `#` ``, `` `$` ``, `` `%` ``, `` `&` ``, `` `{` `` → LaTeX commands, not characters

**To show a special character literally, leave the backticks off.** The converter escapes it
correctly on its own. Use backticks only for a LaTeX command you actually mean.

There is no monospace/verbatim inline form. If the user wants code-looking text, either
accept the plain escaped version or write `` `\texttt{…}` `` deliberately.

## Traps

- **Emphasis over a line break is silent** (see above) — the single most invisible defect in
  this file, because it compiles and Obsidian shows it right.
- **Emoji break the compilation.** `✅` or `❌` produce `Unicode character not set up for use
  with LaTeX` — one error per occurrence. pdflatex carries on and emits a PDF with the
  character simply missing. Typographic characters are **not** affected: `→`, `—` and `…`
  compile fine. Avoid emoji in body text and headings.
