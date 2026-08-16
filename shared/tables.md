# Tables

GitHub-Flavored Markdown (GFM) tables — the same syntax Obsidian renders in reading view.
Obsitex turns them into a LaTeX `tabular`.

> The general rules — the three levels of a formatting answer, how a ` ```dds ` block
> behaves, and reading `00 Document Setup.md` before touching the preamble — are in
> `obsitex-conventions.md`. This file only gives the table-specific cases.

## Syntax

```markdown
| Material  | Amount | Price |
|:----------|:------:|------:|
| Screws    | 100    | 5 %   |
| Wood      | 2      | $10   |
```

- **First row** = column headers.
- **Second row** = the separator. It is mandatory — without it the block is not a table.
- Colons in the separator set the alignment per column:
  `:---` left · `:--:` centred · `---:` right.
- Cells take normal inline formatting: `**bold**`, `*italic*`, `` `code` ``, citations,
  wikilinks.
- The column count comes from the header row. Missing cells are filled in empty; extra
  cells are dropped.

## Multi-paragraph cells

A cell cannot contain a blank line. To break a line inside a cell, use `<br>`:

```markdown
| Topic | Notes |
|---|---|
| Scope | First point<br>Second point |
```

`<br>` is the **one** HTML tag that works here. Everywhere else in the document HTML tags
land raw in the PDF — see `not-supported.md`.

**It needs a paragraph column — the default template does not give you one.** Each `<br>`
becomes a paragraph break in the `.tex`, and a paragraph break only breaks a line in a
`p{…}` column. The standard `tableEnvironmentText` builds its columns from `%getcolumns%`,
which yields `l`/`c`/`r` — and an `l` cell is set in LR mode, where no line break is possible
at all. **The break is then lost without any error**: TeX ignores the paragraph break in that
mode, so both halves print on one line separated by a space, and the PDF looks merely wrong,
not broken. Measured 15.08.2026 (probe vault, converter + pdflatex): `l`/`c`/`r` → one line ·
`p{3cm}`/`p{6cm}` → two lines, as intended.

So when a cell is meant to hold more than one line, **swap the environment for that table** —
the same `dds` sandwich as everywhere else, with the reset after it:

````markdown
```dds
{"tableEnvironmentText":"\\begin{table}[h]\n    \\centering\n    \\begin{tabular}{|p{3cm}|p{6cm}|}\n        %tablestring%\n    \\end{tabular}\n\\end{table}\n\n"}
```
````

The column widths are yours to choose, and the placeholder `%getcolumns%` is deliberately
gone — that is the whole point, the alignment markers cannot produce a `p` column. For a long
table use `longtable` with `p{…}` columns the same way; it also lifts the footnote
restriction under "Traps".

## What it produces

A LaTeX `tabular`. The exact look comes from four DDS keys, not from the converter:

| DDS key | Effect |
|---|---|
| `tableGridHorizontal` | draws the horizontal rules (`\hline`) |
| `tableGridVertical` | draws the vertical rules (`\|`) |
| `tableAlignment` | default alignment for columns without a `:` marker |
| `tableEnvironmentText` | the whole surrounding environment (table / centering) |

With a full grid the column spec becomes `{|l|c|r|}`. Full field catalogue: `dds.md`.

**Changing the look from here on** — a ` ```dds ` block before the table, and one after it to
put the value back, or every later table inherits the change:

````markdown
```dds
{"tableGridVertical": false}
```
````

## Colour without giving up the Markdown table

**A LaTeX command inside a cell reaches the output verbatim**, because inline backticks are
passed through unescaped. So a table can be coloured and still be a real Markdown table —
no raw block needed.

**A grey header row** — `\rowcolor` at the start of the first header cell colours the whole
row. One backtick span, nothing else changes:

```markdown
| `\rowcolor{gray!25}` Material | Amount | Price |
|:---|:---:|---:|
| Screws | 100 | 5 % |
```

**A single cell** — `\cellcolor` in that cell. For a total, or when only some header cells
should be shaded:

```markdown
| `\cellcolor{yellow!30}` Total | `\cellcolor{yellow!30}` 220 |
```

Both verified through the converter and pdflatex: they compile clean and the colour appears.

**Prefer this over a raw block.** The author keeps a table they can edit, and Obsidian keeps
rendering it — only the one backtick span shows as code.

## Packages: tables usually need none

The standard preamble already carries `array`, `booktabs`, `tabularx`, `longtable` and
`\usepackage[table,xcdraw]{xcolor}` — the last one is what provides `\rowcolor` and
`\cellcolor`. So most table wishes need **no** new package. That list describes the template,
not necessarily this vault; check the user's own preamble.

## What a Markdown table cannot have: a caption

`tableEnvironmentText` has no caption placeholder — only `%getcolumns%` and `%tablestring%`.
Figures have `%name%`; tables have nothing equivalent. So a Markdown table gets **no
`\caption`, no `\label`, and no entry in the List of Tables**.

That is the one thing a raw block still buys, and it matters in a thesis whose front matter
has a List of Tables. **Say this out loud when it applies** and let the user choose:

| | Markdown table + `\rowcolor` | raw LaTeX block |
|---|---|---|
| Editing | a normal Markdown table | LaTeX by hand |
| Obsidian preview | renders | shows source |
| Colour | yes | yes |
| Caption, label, List of Tables | **no** | yes |

The raw-block form, when they pick it:

````markdown
```latex
% table with a caption so it appears in the List of Tables
\begin{table}[h]
    \centering
    \caption{Overview of the research design}
    \label{tab:research-design}
    \begin{tabular}{|l|c|r|}
    \hline
    \rowcolor{gray!25}
    Material & Amount & Price \\
    \hline
    Screws & 100 & 5 \% \\
    \hline
    \end{tabular}
\end{table}
```
````

The `\caption` and `\label` lines are the whole reason to choose this form.

## Traps

- **A footnote inside a `tabular` cell is swallowed by LaTeX itself.** Not an Obsitex bug —
  put the remark before or after the table instead. `longtable` does not have this problem.
- **Very wide tables overflow the text block.** LaTeX does not wrap them automatically. Set
  `tableEnvironmentText` to a `tabularx` or `longtable` environment — both packages are
  already loaded.
- **Inline backticks cut both ways.** Their content goes to LaTeX unescaped. That is what
  makes `` `\rowcolor{gray!25}` `` work — and it is why `` `snake_case` `` or `` `a^b` ``
  in a cell breaks the build or silently turns into maths. Use backticks in a cell **only**
  for a LaTeX command you mean. For literal text that merely looks technical, write it
  without backticks and let the converter escape it.

## Writing tables for a user

Keep the source readable: pad the columns so the pipes line up. Obsidian and the converter
do not care, but the author edits this file for months.
