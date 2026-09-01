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

External links: `[text](https://…)` → `\href`; a bare URL in running text → `\url`, clickable.

## What does not link — and stays as readable text

None of these break anything; they simply print instead of linking:

- **A broken link** (typo, heading renamed) — the visible text stays.
- **A block reference** `[[Note#^blockid]]` — not supported; the note name is shown.
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
- **Renaming a file outside Obsidian breaks every wikilink pointing at it.** Obsidian
  updates them, the file explorer does not. Rename in Obsidian, and answer "Always update".
  If it must be done outside, update the links **and** the Flexplorer `data.json` in the
  same operation.
- **Renaming a heading breaks links to it** the same way, and nothing warns — the link
  quietly becomes plain text in the PDF.
- **`[Text][id]` reference links are not supported**, and their definition line is printed as
  a paragraph. See `not-supported.md`.
