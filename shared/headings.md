# Headings and structure

How the chapter structure of the document comes about.

> The rules that must hold **without** looking anything up — one `#` per file, no folders in
> `Frontmatter`/`Backmatter` — are in `obsitex-conventions.md`. This file gives the details
> and the special cases.

## The two sources of a heading

**Only a `#` line creates the heading _text_.** File names and folder names never do.

**The folder decides the _level_.** A file directly in the manuscript starts at the top; a
file inside a folder starts one step lower.

| Markdown | LaTeX (article DDS, file not in a folder) | Level |
|---|---|---|
| `# Title` | `\section` | 1 |
| `## Title` | `\subsection` | 2 |
| `### Title` | `\subsubsection` | 3 |

With the scrbook DDS (`documentLevelIndex: 0`, professional-thesis) the whole table shifts up
one: `#` → `\chapter`, `##` → `\section`.

Full formula: `documentLevel = structureLevel + (number of #) − 1 + latex-heading-offset`.

## A folder REPLACES a file, it does not sit on top of one

Where `Introduction.md` was a chapter, `Introduction/` **is** that chapter — the level is
unchanged. Only a folder **inside** a folder goes one step deeper.

```
Introduction/
    Introduction.md            → # Introduction   (chapter)
    Subchapters/
        Background.md          → # Background     (section)
        Research Question.md   → # …              (section)
```

Every file starts with a **single** `#`, sections included. Their level comes from where they
sit, not from counting hashes. That is what the `Subchapters` collector folder is for: it
creates the section level **once**, for all sections together. It carries no file of its own
and appears nowhere in the PDF.

A section that gets subsections of its own keeps its **own** folder with its own
`Subchapters` inside — so it takes its children along when moved.

**Both styles produce identical LaTeX.** `## Background` inside the chapter file and
`# Background` in a sibling file are the same thing. Moving a finished file changes its level
with no text edit; *cutting* a section out of a file costs one `#`.

## Depth

**Every class numbers three printed digits by default** — `1.1.1`. Which command that is
differs, the result does not:

| Class | `secnumdepth` | deepest numbered |
|---|---|---|
| `book` · `scrbook` · `report` · `scrreprt` | 2 | `\subsection` → `1.1.1` |
| `article` · `scrartcl` | 3 | `\subsubsection` → `1.1.1` |

`tocdepth` carries the same value. There is no "unset" state — only the class default, and it
**adapts** if the document class is later changed. A value written into the preamble does not.

Below that line a heading still appears, in bold, at its place. What it loses is the number
and the contents entry.

### The part that actually breaks

**A cross-reference to an unnumbered heading points at the wrong place.** `[[Note]]` becomes
`\vref`, and with no number of its own the label carries the *preceding* numbered heading's
number. Measured, scrbook at its default:

```
vref to subsection:     section 1.1.1     correct
vref to subsubsection:  section 1.1.1     wrong
vref to paragraph:      section 1.1.1     wrong
```

No error, no warning — the PDF looks fine. So: **with the default, link to headings down to
`1.1.1` and no deeper.** Anyone who wants to link deeper has to number deeper.

### Numbering deeper

```latex
\setcounter{secnumdepth}{3}   % scrbook: also number \subsubsection (1.1.1.1)
```

**`tocdepth` is a separate switch and may be set independently** — the two are conventionally
equal but need not be. One rule holds: **never let the contents list go deeper than the
numbering.** Its entries would then sit unnumbered at the same indent as their siblings'
titles, and the indentation stops showing the hierarchy.

Numbering deep while keeping the contents list shallow is a good combination; the reverse is
not.

### From `\paragraph` on, two more lines are required

```latex
\setcounter{secnumdepth}{4}   % scrbook: also number \paragraph (1.1.1.1.1)
\RedeclareSectionCommand[runin=false,afterskip=.5\baselineskip]{paragraph}
\crefname{paragraph}{paragraph}{paragraphs}
```

At `secnumdepth 5` — `\subparagraph`, the deepest level LaTeX has — the same pair is needed
a second time, with `subparagraph` in place of `paragraph`. Without it that level prints its
own `??`.

**In `article` only the `\crefname` half exists.** `\RedeclareSectionCommand` is a KOMA
command and is undefined there, so the run-in look stays (the `titlesec` package would be
needed for it). The cross-reference, which is the part that actually misleads a reader, is
repaired either way. Note also that `article` reaches these levels one `#` sooner: `####` is
already `\paragraph`.

- **Without the `\RedeclareSectionCommand`** the heading runs into the body text — it does not
  get a line of its own. That is how the class defines `\paragraph`, and no counter changes
  it. The command is **KOMA-only**; standard classes need `titlesec` instead.
- **Without the `\crefname`** a cross-reference prints a literal `??` instead of the name:
  `?? 1.1.1.1.1 on the previous page`. This hits `\vref` as well, because `cleveref` patches
  `varioref`.

Run-in and numbering are independent: a `\paragraph` runs into the text whether numbered or
not. The number only makes the contradiction visible.

**Advise against going this deep.** From `\subsubsection` down, every level has the same font
size and the same weight — even with `runin=false`. Only the length of the number tells them
apart, so the reader has to count dots. Three levels is where the class stops offering
typographic means.

### `tocdepth` outranks `{-}`

A heading marked `{-}` below the `tocdepth` line gets **no** contents entry, although the
converter emits `\addcontentsline` correctly. LaTeX discards it when the list is typeset.
Raise `tocdepth` if such a heading has to appear.

### Folder depth is not document depth

Inside a file you may still use `##` and `###`, and folder depth plus hash count add up. Two
folder levels plus a `###` inside the file already reach `\subsubsection`.

## Unnumbered headings

Attributes at the end of the `#` line:

```markdown
# Preface {-}                                → unnumbered, but IN the table of contents
# Internal note {.unnumbered .unlisted}      → unnumbered and NOT in the table of contents
```

`{-}` and `{.unnumbered}` are the same thing. In a KOMA class (scrbook) `{-}` on chapter or
section level emits `\addchap` / `\addsec` — unnumbered, ToC entry, running header.

**In the front matter no attribute is needed:** chapters between `\frontmatter` and
`\mainmatter` are unnumbered with a ToC entry automatically.

The older `latex-title:` / `latex-numbered:` frontmatter keys no longer exist. Use the
attributes.

## Shifting a whole file

`latex-heading-offset: N` in the frontmatter shifts every heading level in that file by N.
`-1` pulls a file back up one level, `1` pushes it down.

## When an appendix outgrows one file

`Frontmatter` and `Backmatter` take **files only** — a folder inside them lands one level too
deep, silently. Breadth is free, depth is not: twenty appendices side by side are fine, one
*split* appendix is not.

Two ways out:

- **Move it out of `Backmatter`** and put its folder directly in the manuscript, after the
  file carrying `\appendix`. Everything after that switch becomes an appendix, whatever folder
  it sits in — only the order has to be right.
- **Set `latex-heading-offset: -1`** in **every** file of that appendix. Forget it in one file
  added later and that file sits silently at the wrong level.

For an appendix nobody touches again — interview transcripts, raw data — the simplest answer
is usually to leave it as **one** file and structure it with `##` inside.

## Traps

- **A file with no `#` line is not linkable.** `[[Note]]` aims at the target's first heading;
  without one the link becomes plain text. See `links.md`.
- **A heading needs no blank line before it** — except directly under a **list item**, where
  the list swallows it.
- **Renaming a heading breaks every wikilink pointing at it**, silently.
- **Never write a file that starts with `##`.** It works, but the file can no longer be turned
  into a folder later without editing its text.
- Warnings: `92700` a folder has headings but none on its own level → the folder level stays
  untitled · `92710` folder nesting plus `#` reach past `\subparagraph` → clamped.
