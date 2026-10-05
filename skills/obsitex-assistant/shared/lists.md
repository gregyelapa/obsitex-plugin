# Lists

Bulleted and numbered lists, nested to any depth, plus Obsidian task lists.

> The general rules are in `obsitex-conventions.md`. This file only gives the list-specific
> cases.

## Syntax

```markdown
- First point
- Second point with **bold**
    - Sub-point a
    - Sub-point b
- Third point

1. Step one
2. Step two
```

- Bulleted: the line starts with `- `, `* ` or `+ `
- Numbered: the line starts with `1. ` (or `1) `)
- **Nesting** through indentation — one tab or about four spaces per level
- Items take the usual inline formatting: `**bold**`, `*italic*`, `` `code` ``, `$maths$`,
  citations, wikilinks

Becomes `\begin{itemize}` / `\begin{enumerate}`; sub-points become nested lists.

## Task lists

Obsidian task lists reach the PDF as printed boxes:

```markdown
- [ ] Write chapter 3
- [x] Literature reviewed
    - [ ] One sub-point still open
```

An open item becomes an empty box ☐, a done one a crossed box ⊠ — the same information the
checkbox carries in Obsidian. Nesting and inline formatting work as in any list.

**Only `[ ]` and `[x]` are boxes.** Anything else in the brackets — for example `[/]` from an
Obsidian task plugin — stays as literal text and gets an ordinary bullet. A real square
bracket at the start of an item (`- [Note] …`) is safe: it is not turned into a box.

The box symbols come from `amssymb`, which the standard preamble already loads. **No new
package.**

## Traps

All three were measured on 14.08.2026, not inferred.

**One item = one line.** A continued line without a list marker *is* appended to the item —
but with a `\\` in front of it, the same forced break as in a paragraph:

```latex
\item First item that runs on\\
and continues on this line
```

The paragraph rule therefore applies inside lists too. Do not wrap items to a column width.

**A blank line inside a list silently restarts the numbering.** It closes the list and opens
a new one, and LaTeX numbers every `enumerate` from 1:

```markdown
1. Alpha
2. Beta

3. Gamma          ← prints as 1., not 3.
4. Delta
```

Nothing warns, and it compiles. If a numbered list must be interrupted by a paragraph, tell
the user the count will restart.

**A `#` heading directly under a list item is swallowed by the list** and does not become a
heading. This is the one place where a blank line before a heading is still required.

**Indent sub-points consistently.** Mixed indentation (tabs on one line, spaces on the next)
can confuse the nesting.
