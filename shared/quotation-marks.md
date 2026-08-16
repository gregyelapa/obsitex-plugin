# Quotation marks

> The general rules are in `obsitex-conventions.md`. This file explains the counting
> mechanism, which causes more surprises than any other conversion.

## How the conversion works — the whole logic

Obsitex converts **only the straight double `"`**, and it does not track whether a quote is
open. It simply counts:

> **Odd `"` → opening. Even `"` → closing.**

```
He said "yes" and she said "no".
        1   2             3    4
        ↓   ↓             ↓    ↓
        «   »             «    »
```

Which characters are inserted comes from the DDS keys `openingQuotationMark` /
`closingQuotationMark`. **The count runs across the whole document** — a quote left open in
chapter 2 keeps acting in chapter 3.

**One stray `"` inverts everything after it.** All following pairs come out backwards, and it
usually only shows up in the finished PDF.

## Three ways to write quotes

**1 — Type straight `"`.** Convenient; the converter does the rest. Fine for plain
sequential quotes.

**2 — Type the real characters yourself** (`«…»`, `„…"`). They pass through untouched. Safer
in a long document, and required for straight `"` in the PDF (inches, code).

**3 — `\enquote{…}` in backticks.** `csquotes` is in the standard preamble and knows the
levels itself, so nesting is automatic and a missing brace is a build error rather than a
silent inversion. **But:** special characters inside are not escaped, so a `%` or `&` in the
quote breaks the build; the characters come from the babel language, not from the DDS keys;
and another backtick in the same paragraph pairs wrongly. Powerful but brittle.

## Nested quotes — the mixed form

**Obsitex cannot detect nesting**, because a straight `"` looks identical at both ends and
carries no level information. `"outer "inner" more"` counts the third mark as a closer.

The missing information can only come from the author. **Write the inner marks yourself and
leave the outer pair as `"`** — characters you type do not affect the count:

```markdown
"The term ‹internal control system› is used narrowly here."
```

| Level | Switzerland | Germany | English |
|---|---|---|---|
| outer (type `"`) | `«` `»` | `„` `"` | `"` `"` |
| **inner (type yourself)** | `‹` `›` | `‚` `'` | `'` `'` |

This is the most comfortable way to nest: only two characters by hand.

## The apostrophe

Obsitex converts **only** the double `"`. The single `'` always passes through — deliberately,
because in English it is the apostrophe. `don't`, `it's`, `Anna's` come out correctly;
LaTeX makes a typographic apostrophe by itself. Intervening here would break every second
English sentence.

**But `'` is useless as an inner quote:** LaTeX always sets it as a *closing* mark, so
`'inner'` becomes `'inner'` with the opening one facing the wrong way. Type the real
characters instead.

**The LaTeX way of writing an opening single quote is a backtick — and that does not work in
Obsidian**, where a backtick starts inline code. If real code sits in the same paragraph, the
backticks pair wrongly and the text between them vanishes as raw LaTeX.

## Traps

- **Autocorrect is the most common cause of mixed quotes in one document.** Obsitex reacts
  only to the straight `"`. If the editor or the operating system has already converted it to
  `"` or `„`, those characters pass through unchanged — so part of the document has `«»` and
  part has `""`, with no warning. **Obsidian itself replaces nothing**; the culprit is almost
  always **text pasted from Word**, LibreOffice, macOS or iOS.
  *Check:* search the Markdown for `"` and `„`. Anything found did not come from the keyboard.
- **Counting is document-wide.** When you add or remove a quotation mark anywhere, everything
  after it can flip. Say so if you edit text containing quotes.
- **A `dds` change of the quote characters is not retroactive** — quotes above keep the old
  marks.
