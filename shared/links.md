# Links and cross-references

> The general rules — in particular **how to write an attachment link** — are in
> `obsitex-conventions.md`. This file covers linking to headings and external URLs.

## The core idea

**A wikilink points at a heading — a `#` line.** In the PDF it becomes a clickable
cross-reference ("Section 3.2"). The file name in the link **never appears** in the PDF; it
only says which file the heading is in. **A table caption and an image caption work the same
way** after the `#`; that is the "Traps" section below and `tables.md` / `images.md`.

| Written | Points at |
|---|---|
| `[[Note#Heading]]` | that heading in "Note" |
| `[[#Heading]]` | a heading in the **same** file |
| `[[Note]]` | the **first** heading of "Note" |
| `[[Note#Heading\|my text]]` | as above, but shows "my text" |

Files are addressed by **file name** — exactly the one Obsidian suggests while typing `[[`.
A number prefix may stay in (`[[01 Methods#Design]]`); it does not appear in the PDF.

Resolution is **path/file-name based only** (relPath · relPath without `.md` · basename,
lowercased). `title:` and `aliases:` do **not** count — there is no need to set them.

## What it produces

`\vref{label}` via the DDS field `crossReferenceCmdText`; with an alias, `\hyperref`. The
label is built path-uniquely from file path **plus** heading, byte-identical at definition and
reference — so several files with a `# Introduction` do not collide.

### What the reader actually sees — four parts, three packages

A resolved reference prints something like this (measured 01.09.2026):

```
table 3 on the preceding page
^^^^^ ^ ^^^^^^^^^^^^^^^^^^^^
type  no      position
```

1. **The type word** — from **`cleveref`**, not from `\vref`. "table", "figure", "section".
2. **The number** — from the counter, and a counter is stepped by a **caption**. No caption,
   no number (see `tables.md`).
3. **The position** — from **`varioref`**. It chooses between "on the preceding page",
   "on page 12" and **nothing at all** when the target sits on the same page. So a reference
   that reads just "figure 2" is not broken; the figure is simply on that page.
4. **The jump** — from **`hyperref`**. Invisible, but clickable.

**`\vref` on its own gives only 2 and 3.** The type word appears because the standard preamble
loads `cleveref` **after** `varioref`, and cleveref rewrites `\vref`. Measured with and without:

| Preamble | `\vref{tab:t}` prints |
|---|---|
| `varioref` only | `1` |
| `varioref` + `cleveref` | `table 1` |
| the same with `ngerman` | `Tabelle 1` |

**Two things that matter for a thesis in another language.** Both are easy to get wrong and
neither produces an error:

- **The language of the type word lives in the package options**, not in babel. Switching the
  document to German means `\usepackage[ngerman]{varioref}` **and**
  `\usepackage[noabbrev,ngerman]{cleveref}`. Change babel alone and the text stays German
  while every reference keeps saying "table".
- **`noabbrev` is not decoration.** Without it cleveref abbreviates: "tab. 1" instead of
  "table 1". The standard preamble sets it.

External links: `[text](https://…)` → `\href`; a bare URL in running text → `\url`, clickable.

## What does not link — and stays as readable text

None of these break anything; they simply print instead of linking:

- **A broken link** (typo, heading renamed) — the visible text stays.
- **A block reference to a paragraph** `[[Note#^id]]` — not a target. Only figures and tables
  carry a label of their own; a paragraph would inherit the section's number. The id itself is
  removed from the text either way, and the converter logs warning 92876. Figures and tables
  DO work this way, see below.
- **A note transclusion** `![[Note]]` — the content is **not** inserted; `![[Note]]` appears
  visibly as text so the author notices.
- **A file with no `#` heading at all** is not linkable. `[[Note]]` needs a first heading to
  aim at.

## `[[…]]` vs. `![[…]]` — do not mix them up

- `[[…]]` = **reference**, a jump to a heading.
- `![[…]]` = **embed**. For **files** (`![[image.png]]`, `![[appendix.pdf]]`,
  `![[refs.bib]]`) the content is embedded — see `images.md`, `pdf-embeds.md`,
  `bibliography.md`. For **notes** it does not work (see above).

## Traps

- **Headings, captioned tables and figures can be targets, nothing else.** A table or an image
  is reached by its caption after a `#`: `[[#Overview of the design]]` or
  `[[Note#Overview of the design]]` (tables since 29.08.2026, images since 01.09.2026; see
  `tables.md` and `images.md`). A table with no caption has no label and cannot be reached; an
  image without one still can, because the converter makes its file name the caption. **A bare
  `[[Overview of the design]]` is none of these** — that namespace belongs to note names, so
  the `#` is required. **Paragraphs still cannot be linked.**
- **A link to a caption looks dead inside Obsidian.** Obsidian resolves `#` only to headings,
  so it paints a caption link as unresolved and says "not found" on hover. Obsitex converts
  it correctly anyway. The cost is real though: no click while writing, and Obsidian does not
  follow a renamed caption. See `tables.md` and `images.md`.

## Block identifiers: the form that lives in Obsidian too

Obsidian names a single block with `^id` at the end of it, and writes that id **by itself** the
moment somebody picks a block from the `[[Note#^` autocomplete. Since 02.09.2026 Obsitex reads
it:

```markdown
![[figure.png|Sample distribution]]
^dist

Shown in [[#^dist]].
```

```latex
\begin{figure}[!htbp]
  \includegraphics[width=\textwidth]{./images/figure.png}
  \caption{Sample distribution}
  \label{fig:sample_distribution}
\end{figure}

Shown in \vref{fig:sample_distribution}.
```

**No second `\label`.** The figure already has one from its caption; the id is just a second
name for it. The output is identical to `[[#Sample distribution]]`.

**Three positions all work** (measured in Obsidian): on its own line after the block, on its own
line after a **blank** line, and appended to the block's last line. A blank line does not detach
the id from the block above it.

**When to suggest which:**

| | Caption anchor | Block identifier |
|---|---|---|
| Clickable in Obsidian while writing | no | **yes** |
| Survives a rewritten caption | **no**, breaks silently | yes |
| Readable in the markdown | **yes** | no, Obsidian invents `^a3f2b1` |

The caption is the normal way because it reads well. Reach for a block id when the author wants
to click their own references while writing, or when a caption is still in flux.

**Never on a paragraph.** See the list above: it is removed but is not a target.
- **Renaming a file outside Obsidian breaks every wikilink pointing at it.** Obsidian
  updates them, the file explorer does not. Rename in Obsidian, and answer "Always update".
  If it must be done outside, update the links **and** the Flexplorer `data.json` in the
  same operation.
- **Renaming a heading breaks links to it** the same way, and nothing warns — the link
  quietly becomes plain text in the PDF.
- **`[Text][id]` reference links are not supported**, and their definition line is printed as
  a paragraph. See `not-supported.md`.
