# DDS — the document settings, field by field

The Dynamic Document Settings live in a ` ```dds ` block, normally in `00 Document Setup.md`.
They decide what LaTeX the converter emits.

> **The values in the tables below are shown readable, with ONE backslash.** In the actual
> JSON block every one of them is doubled (`"\\begin"`); a single backslash makes the JSON
> invalid and the whole block is dropped without a warning. See `obsitex-conventions.md`.

> **How a `dds` block behaves** — patch not replacement, effective from its position on,
> never retroactive — is in `obsitex-conventions.md`. This file is the catalogue: what each
> field does and what the templates set it to.

There are **22 fields**. All three templates agree on every one of them except `documentClass`
and `documentLevelIndex`.

## Document class

| Field | Default | Effect |
|---|---|---|
| `documentClass` | `\documentclass[12pt,oneside]{scrbook}` (professional-thesis) · `\documentclass[12pt]{article}` (simple-thesis, academic-paper) | The complete `\documentclass` line, written out |

**This is the one field a later `dds` block cannot change.** The first block that sets it
wins; a later attempt is dropped and logged as warning 92870. There is exactly one class per
document — and it silently decides things that look unrelated, such as whether footnotes
restart per chapter (`footnotes.md`).

## Heading levels

| Field | Default | Effect |
|---|---|---|
| `createDocumentLevel` | `true` | Off: `#` lines produce **no** heading command at all |
| `documentLevelIndex` | `0` (scrbook) · `1` (article) | Where level 1 starts. `0` → `#` becomes `\chapter`, `1` → `\section` |
| `documentLevelPreFix` | seven empty strings | Text inserted **before** the heading, one entry per level |
| `documentLevelPostFix` | seven empty strings | Text inserted **after** the heading and its `\label` |

The two arrays are indexed by level, so `documentLevelPreFix[0]` applies to the top level. A
`\newpage` before every chapter would go in there — but check first whether the class already
does it.

## Figures

| Field | Default | Effect |
|---|---|---|
| `createFigureEnvironment` | `true` | Off: images emit nothing |
| `figureEnvironmentText` | `\begin{figure}[!htbp] … \includegraphics[width=\textwidth]{%path%} … \caption{%caption%} \label{fig:%label%} \end{figure}` | The whole environment |

Placeholders: `%path%` (folder and file name on export, relative to `main.tex`) ·
`%filename%` (the bare file name with its extension, no folder — for a preamble that already
sets `\graphicspath`) · `%caption%` (the caption after inline rendering: special characters
escaped, `**bold**` and `[[links]]` resolved, backticks still raw) · `%label%` (the same
caption, but from the RAW text, reduced to `[A-Za-z0-9_]` and lowercased).

The same four work in `pdfCmdText`, `bibliographyCmdText` and `bibliographyBodyCmd`.

**Placement is `[!htbp]` in every template.** The `!` switches off LaTeX's fill rules, so
"here" succeeds far more often than with a plain `[htbp]`; the four letters keep every escape
open, so floats can never pile up into `Too many unprocessed floats`. **A bare `[h]` is the one
to avoid** — LaTeX cannot honour it and silently rewrites it to `[ht]`, with a warning per
float. If a user wants a figure or table nailed to the exact spot, `[H]` does that, but it
needs `\usepackage{float}` in the preamble and leaves a gap when the object no longer fits
the page. A large image is the usual reason a float travels: at `width=\textwidth` a square
image is nearly page-high and fits nowhere in running text. Reducing the width helps more than
any placement letter.

**Changing the placement for ONE object needs two blocks.** Like every `dds` key, the
environment holds from its position to the end of the document, so a block that switches to
`[H]` needs a second block after the object putting the value back. Otherwise every later
figure or table is pinned too, and nothing warns. Worked example: `tables.md`, "Placement:
why a table moves".

**The image width is set here, for every figure at once.** A per-image size written as
`![[img.png\|300]]` is recognised but not yet passed to LaTeX — see `images.md`.

## Tables

| Field | Default | Effect |
|---|---|---|
| `createTableEnvironment` | `true` | Off: a bare `tabular` without the surrounding environment |
| `tableGridHorizontal` | `true` | Draws the `\hline` rules |
| `tableGridVertical` | `true` | Draws the `\|` rules |
| `tableAlignment` | `"l"` | Alignment for columns with no `:` marker |
| `tableEnvironmentText` | `\begin{table}[!htbp] \centering \begin{tabular}{%columnspec%} %tablebody% \end{tabular} \caption{%caption%} \label{tab:%label%} \end{table}` | The whole environment |

Placeholders: `%columnspec%` (the column spec, built from the alignment row) · `%tablebody%`
(the rendered rows) · `%caption%` and `%label%` (from a caption line after the table, since
29.08.2026 — see `tables.md`).

**An empty value removes the whole command**, not just the placeholder. A table without a
caption therefore emits no `\caption{}` and no `\label{}`, and the line each sat on goes
with it. That is why the two lines can stand in the template unconditionally.

Brace counting does the removal, so `\caption{\textbf{%caption%}}` works: with a caption it
prints bold, without one the whole `\caption` goes, `\textbf` included. A pattern-based
removal would leave `\caption{}` behind.

## PDF embeds

| Field | Default | Effect |
|---|---|---|
| `createPdfCmd` | `true` | Off: PDF embeds emit nothing |
| `pdfCmdText` | `\includepdf[pages=-]{%path%}` | The command |

Placeholders: `%path%` · `%caption%`. **The default does not use `%caption%`**, so a caption written
as `![[file.pdf\|Text]]` is parsed and then discarded. Add `%caption%` to the template if it
should be used.

`pages=-` means all pages. Anything else in the brackets — a page range, `landscape=true` for a
landscape source — is a changed template: one block before the embed, one after it restoring the
default. Written out in `pdf-embeds.md`.

## Bibliography

| Field | Default | Effect |
|---|---|---|
| `createBibliographyCmd` | `true` | Off: a `.bib` embed emits nothing |
| `bibliographyCmdText` | `\addbibresource{%path%}` | Goes into the **preamble** |
| `bibliographyBodyCmd` | `\printbibliography[heading=none]` | Emitted at the **embed's position** |

One `.bib` embed therefore produces two different outputs in two different places.
`heading=none` is deliberate: the heading comes from the author's own `#` line, otherwise it
would appear twice.

**The citation style is not a DDS field.** It is the `style=` option of `\usepackage{biblatex}`
in the preamble.

## Cross-references

| Field | Default | Effect |
|---|---|---|
| `createCrossReferenceCmd` | `true` | Off: falls back to plain `\ref` |
| `crossReferenceCmdText` | `\vref{%labelref%}` | The command a resolved wikilink becomes |

Placeholder: `%labelref%`. `\vref` (from `varioref`) adds the page reference automatically
("on the next page"); `\cref` from `cleveref` would insert the type name ("Section 3.2")
instead. Both packages are loaded.

## Quotation marks

| Field | Default | Effect |
|---|---|---|
| `convertQuotationMarks` | `true` | Off: a straight `"` stays straight |
| `openingQuotationMark` | `"` | Inserted for every **odd** `"` |
| `closingQuotationMark` | `"` | Inserted for every **even** `"` |

The counting mechanism and its traps: `quotation-marks.md`. Note that these keys do **not**
affect `\enquote{}` — that takes its characters from the babel language.

## The placeholder names changed on 29.08.2026

There are **seven**, and each says where its value goes: `%caption%` · `%label%` ·
`%labelref%` · `%path%` · `%filename%` · `%tablebody%` · `%columnspec%`.

The old names are **gone**, not deprecated: `%name%`, `%nameWithoutSC%`,
`%filenameWithoutSC%`, `%tablestring%`, `%getcolumns%`, `%labelname%`. A vault written before
that date still carries them, and the failure is silent — the old name stays in the LaTeX as
text, and its percent sign turns the rest of that line into a comment, so the line vanishes
from the PDF with no error.

**The one visible trace is warning 92895**, which names the field and the token and appears in
the result banner after an export. If a user reports a missing `\caption`, a missing image
line or a table that lost its columns, and their vault predates that date: look at
`00 Document Setup.md` first. Every ` ```dds ` block in the vault has to be checked, not just
that one file.

## Changing a field for one spot only

A ` ```dds ` block before it and a second one after it, restoring the value. Anything else
inherits the change. For a genuine one-off, a raw ` ```latex ` block is usually the cleaner
answer — see "Answering a formatting wish" in `obsitex-conventions.md`.
