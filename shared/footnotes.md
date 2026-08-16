# Footnotes

> The general rules are in `obsitex-conventions.md`. This file covers the numbering, which
> is the part that surprises people.

## Syntax

```markdown
A claim that needs a source[^1].

[^1]: The explanation.
```

Short form, no definition needed: `Text^[The explanation.]`

Becomes `\footnote{…}` — core LaTeX, **no package**.

- The footnote text takes inline formatting, `[@key]` citations and `[[wikilinks]]`, but
  **no block elements** — no list, table or image inside a footnote.
- Put the definitions at the **end of the note**. They may stand after their reference, and
  their lines never appear in the body text.

## Long footnotes

A definition may run over several **indented** continuation lines. They are joined with a
space into **one continuous sentence**:

```markdown
[^1]: A longer explanation that
    is written over two lines.
```

This is the **opposite** of body text, where a line break stays a line break. The indentation
means "still part of the footnote", not "break here".

## The same footnote in several places

Reusing a name produces **one** footnote, and both places carry the same number:

```markdown
First place[^rule] … and later the same remark again[^rule].

[^rule]: This explanation applies to both.
```

Do not duplicate the definition to achieve this.

## Scope: one note

A reference and its definition must be in the **same file** — Obsidian's rule. Every file may
start again at `[^1]` without collisions.

- A reference whose definition is missing stays as **visible literal text** `[^name]`,
  deliberately, so the error is noticed in the PDF instead of vanishing.
- A definition nobody references produces nothing.

## Numbering — the part that catches people out

**LaTeX assigns the numbers**, not Obsidian and not Obsitex. Three different things are easy
to confuse:

| Where | What you see |
|---|---|
| In the Markdown | your `[^1]` — a **name**. `[^lima]` would be just as valid |
| In Obsidian | counts from 1 **per note**, in the order the references appear |
| In the PDF | counts from 1 **per chapter** (`scrbook`, `book`, `report`) or continuously (`article`) |

The identifier says nothing about position: write `[^3]` before `[^1]` in the text and
Obsidian still shows 1 for the first.

**Whether the counter resets at a chapter is decided by the document class**, not by Obsitex
and not by the footnote:

| Class | Numbering |
|---|---|
| `article`, `scrartcl` | continuous — no chapters to reset at |
| `book`, `report`, `scrbook`, `scrreprt` | restart at every chapter |

**Switching the document class silently changes the footnote numbering.** Moving a thesis from
`article` to `scrbook` gives chapter-wise numbers without anyone touching a footnote.

**Do Obsidian and the PDF agree?** Usually yes — *if one file is exactly one chapter*, which is
the normal case with `documentLevelIndex: 0` and one `#` per file. It diverges as soon as that
breaks: one chapter split over two files (Obsidian restarts, the PDF does not), or two `#`
lines in one file (Obsidian counts on, the PDF restarts).

To change the behaviour, one line in the preamble — not a converter setting:

```latex
\counterwithout{footnote}{chapter}   % continuous through the whole document
\counterwithin*{footnote}{chapter}   % restart per chapter (scrbook default)
```

## Traps

- **Never write a footnote number by hand.** A "see footnote 3" typed from what Obsidian
  shows is wrong as soon as a footnote is added before it — and with chapter-wise numbering it
  is not even unique. Use the same identifier twice, or `` `\label{fn:mine}` `` in the footnote
  and `` `\ref{fn:mine}` `` at the referring spot.
- **A footnote inside a `tabular` cell is lost by LaTeX itself.** Put the remark before or
  after the table. `longtable` does not have this problem.
- **Do not put a whole paragraph in a footnote.** It is body text, usually one or two
  sentences.
