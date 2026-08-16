# DDS — the document settings, field by field

The Dynamic Document Settings live in a ` ```dds ` block, normally in `00 Document Setup.md`.
They decide what LaTeX the converter emits.

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
| `figureEnvironmentText` | `\begin{figure}[h] … \includegraphics[width=\textwidth]{%path%} … \caption{%name%} \label{fig:%nameWithoutSC%} \end{figure}` | The whole environment |

Placeholders: `%path%` (file name on export) · `%name%` (caption) · `%nameWithoutSC%` (caption
reduced to `[A-Za-z0-9_]`, used for the label).

**The image width is set here, for every figure at once.** A per-image size written as
`![[img.png\|300]]` is recognised but not yet passed to LaTeX — see `images.md`.

## Tables

| Field | Default | Effect |
|---|---|---|
| `createTableEnvironment` | `true` | Off: a bare `tabular` without the surrounding environment |
| `tableGridHorizontal` | `true` | Draws the `\hline` rules |
| `tableGridVertical` | `true` | Draws the `\|` rules |
| `tableAlignment` | `"l"` | Alignment for columns with no `:` marker |
| `tableEnvironmentText` | `\begin{table}[h] \centering \begin{tabular}{%getcolumns%} %tablestring% \end{tabular} \end{table}` | The whole environment |

Placeholders: `%getcolumns%` (the column spec, built from the alignment row) · `%tablestring%`
(the rendered rows).

**There is no caption placeholder.** Figures have `%name%`, tables have nothing equivalent —
so a Markdown table gets no `\caption`, no `\label` and no entry in the List of Tables. See
`tables.md`.

## PDF embeds

| Field | Default | Effect |
|---|---|---|
| `createPdfCmd` | `true` | Off: PDF embeds emit nothing |
| `pdfCmdText` | `\includepdf[pages=-]{%path%}` | The command |

Placeholders: `%path%` · `%name%`. **The default does not use `%name%`**, so a caption written
as `![[file.pdf\|Text]]` is parsed and then discarded. Add `%name%` to the template if it
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
| `crossReferenceCmdText` | `\vref{%labelname%}` | The command a resolved wikilink becomes |

Placeholder: `%labelname%`. `\vref` (from `varioref`) adds the page reference automatically
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

## Changing a field for one spot only

A ` ```dds ` block before it and a second one after it, restoring the value. Anything else
inherits the change. For a genuine one-off, a raw ` ```latex ` block is usually the cleaner
answer — see "Answering a formatting wish" in `obsitex-conventions.md`.
