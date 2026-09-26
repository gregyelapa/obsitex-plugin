# Headings and structure

How the chapter structure of the document comes about.

> The rules that must hold **without** looking anything up — one `#` per file, a folder and
> its folder note are renamed together — are in `obsitex-conventions.md`. This file gives
> the details and the special cases.

## The two sources of a heading

**Only a `#` line creates the heading _text_.** File names and folder names never do.

**The folder note decides the _level_.** The folder note is the file inside a folder that
has exactly the folder's name: `Introduction/Introduction.md`. It carries the folder's
heading, and everything else in that folder sits **one level below** it. A folder without a
folder note (`Subchapters`, `Frontmatter`, `Backmatter`) adds no level: its files sit as if
they lay in the folder above.

So the level of a file is **the number of folders with a folder note above it**. A heading
file does not count its own folder. A file directly in the manuscript starts at the top.

| Markdown | LaTeX (article DDS, file at the top) | Level |
|---|---|---|
| `# Title` | `\section` | 1 |
| `## Title` | `\subsection` | 2 |
| `### Title` | `\subsubsection` | 3 |

With the scrbook DDS (`documentLevelIndex: 0`, professional-thesis) the whole table shifts up
one: `#` → `\chapter`, `##` → `\section`.

Full formula: `documentLevel = structureLevel + (number of #) − 1 + latex-heading-offset`,
where `structureLevel` is the count of folders with a folder note described above.

## The folder note: what makes a folder a level

Where `Introduction.md` was a chapter, `Introduction/Introduction.md` **is** that chapter — the
folder note keeps the level the single file had. Everything else in the folder belongs
**under** it:

```
Introduction/
    Introduction.md            → # Introduction   (chapter, the folder note)
    Background.md              → # Background     (section)
    Research Question.md       → # …              (section)
```

Every file starts with a **single** `#`, sections included. Their level comes from where they
sit, not from counting hashes.

**What counts as a folder note:** the same name as its folder, case ignored, number prefix
included. `30 Introduction/30 Introduction.md` is one, `30 Introduction/Introduction.md` is
not. Obsitex always puts it first in its folder, whatever the order says. No other name
counts: an `index.md` or `_index.md` is an ordinary file like any other in the folder.

**The word comes from the Obsidian plugin Folder notes**, and with that plugin's default
settings (name template `{{folder_name}}`, storage location "Inside the folder") its folder
note is exactly the file Obsitex counts. Where the two differ, Obsitex does not count it: a
folder note stored **next to** the folder ("In the parent folder"), or one saved as `.canvas`
or `.base` instead of `.md`. So if the user has Folder notes, never suggest changing its name
template or its storage location. The plugin's "Sync folder name" setting renames folder and
folder note together, which is exactly what the first trap below needs. That is tested for a
rename done **inside Obsidian** only. When **you** rename a folder on disk, do not rely on it:
rename the folder note in the same step.

**A folder without folder note is only storage.** `Frontmatter` and `Backmatter` are the usual
ones; a user may add others just to keep files tidy. Vaults set up by `/obsitex:obsitex-init`
before v1.46.0 also keep their sections in a collector folder called `Subchapters`
(`Unterkapitel`, `Subsections`, … depending on the language); newer ones put the sections
directly into the chapter folder. Either way such a folder adds no level and never appears in
the PDF: `Introduction/Subchapters/Background.md` and `Introduction/Background.md` are both
sections. Follow what the vault does: where the sibling sections sit in `Subchapters`, a new
one goes there too. Never create a collector folder in a vault that has none, and never remove
one unasked.

A section that gets subsections of its own becomes a folder with its own folder note — so it
takes its children along when moved.

**Both styles produce identical LaTeX.** `## Background` inside the folder note and
`# Background` in a file next to it (or in its `Subchapters`) are the same thing. Moving a
finished file changes its level with no text edit; *cutting* a section out of a file costs
one `#`.

**Two traps come with this rule, both silent:**

- **A folder renamed without its folder note stops counting.** `Theory/` holding
  `Foundations.md` has no folder note any more, so everything else inside moves up one level
  and `Foundations.md` loses its place at the front. Always rename folder and folder note
  together.
- **A file named like a storage folder turns it into a level.** `Frontmatter/Frontmatter.md`
  would push the cover page, the abstract and everything else in `Frontmatter` one level
  down. Never give a file inside `Frontmatter`, `Backmatter` or a collector folder that
  folder's name.

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

**The two words inside `\crefname` are printed, so they follow the DOCUMENT language.** In a
German document the line reads:

```latex
\crefname{paragraph}{Absatz}{Absätze}
\crefname{subparagraph}{Unterabsatz}{Unterabsätze}
```

Leaving the English pair in a German document does not produce an error — it produces
`paragraph 1.1.1.1.1` in the middle of a German sentence (measured 26.08.2026, scrbook with
`main=ngerman`). **Every other level takes care of itself:** a reference to a `\subsection`
prints `Abschnitt 1.1.1` without anything being declared, because `cleveref` ships the German
names. `\paragraph` and `\subparagraph` are the two it does not know, which is why they are the
only ones needing a `\crefname` — and the only ones that can end up in the wrong language.

**`\crefname` only works in the preamble.** After `\begin{document}` it is ignored without a
warning and the `??` stays (measured the same day).

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

Inside a file you may still use `##` and `###`, and folder depth plus hash count add up. A
section file inside a chapter folder plus a `###` inside it already reaches `\subsubsection`.

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

`Frontmatter` and `Backmatter` have no folder note, so they add no level. An appendix that
outgrows one file becomes a folder with its folder note, right where it is in `Backmatter`:

```
Backmatter/
    Appendix.md                      ```latex \appendix
    Interviews/
        Interviews.md                → # Interviews     (appendix chapter)
        Interview A.md               → # Interview A    (section)
```

The folder note stays a chapter, its parts become sections. `\appendix` is a switch:
everything after it becomes an appendix, whatever folder it sits in — only the order has to be
right.

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
- Warnings: `92700` a folder's folder note has no `#` of its own while the folder holds
  headings → the folder level stays untitled · `92710` folder nesting plus `#` reach past
  `\subparagraph` → clamped.
