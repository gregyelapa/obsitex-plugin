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
`p{…}` column. The standard `tableEnvironmentText` builds its columns from `%columnspec%`,
which yields `l`/`c`/`r` — and an `l` cell is set in LR mode, where no line break is possible
at all. **The break is then lost without any error**: TeX ignores the paragraph break in that
mode, so both halves print on one line separated by a space, and the PDF looks merely wrong,
not broken. Measured 15.08.2026 (probe vault, converter + pdflatex): `l`/`c`/`r` → one line ·
`p{3cm}`/`p{6cm}` → two lines, as intended.

So when a cell is meant to hold more than one line, **swap the environment for that table** —
the same `dds` sandwich as everywhere else, with the reset after it:

````markdown
```dds
{"tableEnvironmentText":"\\begin{table}[!htbp]\n    \\centering\n    \\begin{tabular}{|p{3cm}|p{6cm}|}\n        %tablebody%\n    \\end{tabular}\n\\end{table}\n\n"}
```
````

The column widths are yours to choose, and the placeholder `%columnspec%` is deliberately
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

## Placement: why a table moves

A table is a **float**. LaTeX does not print it at the spot in the source; it looks for a place
where the page breaks well. The author sees the table a page later, or at the top of the page
above the very sentence that announces it, and reads that as a bug. It is not. Explain the
mechanism before you change anything.

The templates set `[!htbp]`. What the letters mean and why exactly this combination was chosen:
`dds.md`, "Placement". Two facts settle most questions:

- **A float never travels backwards.** It moves down, or up to the top of the page it is
  already on, never to an earlier page.
- **A bare `[h]` is the one to avoid.** LaTeX cannot honour it, silently rewrites it to `[ht]`
  and warns once per float.

**Nailing one table down.** `[H]` from the `float` package does not negotiate. It needs a
` ```dds ` block before the table and a **second one after it** putting `tableEnvironmentText`
back, or every later table is pinned too:

````markdown
```dds
{"tableEnvironmentText": "\\begin{table}[H]\n    \\centering\n    \\begin{tabular}{%columnspec%}\n        %tablebody%\n    \\end{tabular}\n    \\caption{%caption%}\n    \\label{tab:%label%}\n\\end{table}\n\n"}
```
````

Two things to check and to say out loud when you do this:

- **`[H]` needs the `float` package. Read the user's own preamble before you assume it is
  there.** All four `obsitex-init` templates load it, but a hand-built or older
  `00 Document Setup.md` often does not (measured 29.08.2026). If it is missing, add
  `\usepackage{float}` with a `%` comment saying what it is for, and tell the user. Never
  silently — `obsitex-conventions.md`.
- A pinned table that no longer fits the rest of the page jumps to the next page whole and
  leaves the remainder of this one empty. That is the price of `[H]`.

**Build the second block from the value you actually found**, not from the example above. The
reset has to restore *this* vault's `tableEnvironmentText` character for character, so copy it
out of `00 Document Setup.md` (or out of the last `dds` block above the table) and change only
the placement letters.

**Do not try to keep a table below its text by dropping the `t`.** `[!hbp]` was measured and is
worse: floats keep their order, so one waiting table holds up every later one and they collect
at the foot of the page, far from the headings they belong to. If a table must not move, pin it.

**Going back to the standard** is the same move in reverse: one ` ```dds ` block setting
`tableEnvironmentText` back to `[!htbp]`, or removing the blocks that pinned it. Worth
offering before the manuscript is printed or handed in — gaps read worse than a table one page
on.

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

## Captions (since 29.08.2026)

A Markdown table CAN carry a caption. Write it on the line right after the table, opened
with `:`, `Table:` or `table:` and one space. This is Pandoc's spelling, not an Obsitex
invention.

```markdown
| Material | Amount | Price |
|:---------|-------:|------:|
| Screws   |    100 |   5 % |
table: Overview of the research design
```

That yields `\caption{…}` and `\label{tab:overview_of_the_research_design}`, so the table
appears in the List of Tables. **A raw LaTeX block is no longer needed for a caption.**

Four things worth knowing:

- **A blank line between table and caption is allowed but not required.** Without one the
  caption sits closer to the table in Obsidian's preview, which reads better. With one it is
  also valid Pandoc. Both produce the same LaTeX.
- **Position binds, not the pattern.** A line starting with `: ` anywhere else stays ordinary
  text. Only a line directly after a table becomes a caption.
- **The caption runs through inline rendering.** `**bold**`, `[[links]]` and `[@cite]` work
  in it. The label is built from the raw text, so markup never lands inside `\label`.
- **No caption means no `\caption{}` either.** The empty value takes the whole command with
  it. A table without a caption looks exactly as it did before.

Two tables sharing one caption get `_2`, `_3` on the label. Table labels live in their own
pot, separate from figure labels: `tab:` and `fig:` are different namespaces in LaTeX.

**Referring to a table** works like referring to a heading, since 29.08.2026:

```markdown
The split is shown in [[#Overview of the research design]].
```

That becomes `\vref{tab:overview_of_the_research_design}`. Three forms exist:

| Written | Result |
|---|---|
| `[[#Caption]]` (same note) | `\vref{tab:…}` |
| `[[Note#Caption]]` | the same, across notes |
| `[[#Caption\|the split]]` | `\hyperref[tab:…]{the split}` |

**A bare `[[Caption]]` does NOT work, on purpose.** That namespace belongs to note names. Point
at the caption after a `#`, exactly as you would at a heading.

**A table without a caption cannot be referred to at all** — no caption, no label. If a user
wants a reference, they need a caption first.

**A block identifier works on a table too** since 02.09.2026: `^id` after the table,
`[[#^id]]` to reference it. It needs a caption all the same, because the label comes from
there. Details: `links.md`.

**What the reader sees is "table 3 on the preceding page"**, not a bare number: the type
word comes from `cleveref`, the position from `varioref`, and the position is dropped when
the target is on the same page. Anatomy and the language trap: `links.md`.

**In Obsidian this link looks dead — that is expected, not a bug.** Obsidian resolves a `#`
only to **headings** (and `#^` to block ids); it knows nothing about captions. So the link is
painted as unresolved and hovering it says "… not found". **Obsitex still converts it
correctly** and the reference appears in the PDF. Measured 01.09.2026.

Two consequences, both silent, and worth saying out loud when a user writes one of these:

- **No click while writing.** The reference cannot be checked before converting.
- **Obsidian does not follow a renamed caption.** Change the caption and the link breaks
  without a warning; it shows up in the PDF as plain text where a number should be.

So when you edit a caption, **search the vault for links pointing at it** and update them in
the same breath. Nothing else will.

**Images work the same way since 01.09.2026**: `[[#Caption]]` reaches a figure and produces
`\vref{fig:…}`. An image without a caption is reachable too, because the converter makes its
file name the caption. Details in `images.md`.

A raw LaTeX block is still the answer for a table that needs a structure the DDS template
cannot express (`tabularx` for one table only, `multirow`, a sideways table). Not for a
caption.

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

### Where the table goes: the marker line

**Claude Code cannot see the cursor in Obsidian.** The two programs share nothing but the
files on disk. So a table with no stated position lands wherever you judge best, and a
correct table in the wrong section still reads as a failure to the author.

The standard way, and the one the Blueprints tool hands the user, is a **marker line**: the
author types `TABLE HERE` on a line of its own at the spot they want. Write the table in
place of that line and delete the line.

**Search the whole vault for the marker. Do not ask which file it is in.** The cards
deliberately do not carry a file name: the author knows where they typed the marker, not
what the note is called on disk ("03 Methods.md" when they think "the methods part"). A
grep over every `.md` in the vault costs nothing, measured 02.09.2026 at under a second
for 160 notes on OneDrive.

- **No marker anywhere? Then ask**, for the file and the spot in one question. Never fall
  back to the end of a file, and never pick a spot out of the surrounding prose on your own.
  One short question costs less than a table that has to be moved.
- **More than one marker?** Ask which one, and name the file and the heading each sits under
  so the question can be answered without scrolling.
- The marker is plain text. Obsidian shows it as text, Obsitex would convert it as text, and
  nothing else in the chain reacts to it.

The second way is a described spot: "after the heading Results", "after the sentence about
the sample size". It arrives when the author answers the question above, so it needs no
separate handling. Confirm in one line where you put the table.

### Building a new one: three ways in

The Blueprints tool offers three cards for a new table. They produce the same kind of table
and differ only in **how much you may ask**. Read the user's opening move and match it:

| The user arrives with … | You … | Card |
|---|---|---|
| the shape: columns, rows, headings, and says not to ask | write it, ask nothing, then name your decisions in one line | "Make an empty table" |
| nothing but the intention, and wants to be walked through it | ask about every choice that changes the look, then write | "Build a table step by step" |
| pasted content | work out the form yourself, ask only where you genuinely cannot decide | "Make a table from my content" |

**A user who did not come through a card gets way three**, unless they ask for questions.
Deciding and saying what you decided is cheaper for them than a questionnaire they did not
want.

**Way one: they told you the shape.** Everything you need is in the prompt. Write the frame
and do not ask, not even about the caption. If a heading is missing where one is obviously
needed, leave the cell empty rather than inventing a word.

**The frame gets no caption.** The user asked not to be asked, and a caption cannot be read off
an empty table. Say it in the closing line, in one sentence: the table has no caption yet, so it
does not appear in the List of Tables, and one word from them adds it. Do not leave this silent.
The author sees a finished table and has no reason to suspect that something is missing from a
list they will not look at for weeks.

**Way two: they asked to be walked through it.** This is the one place where a questionnaire
is right, because the user chose it. Ask about, in this order:

- what the columns are called, and roughly how many rows
- whether it needs a caption and a number, and what the caption says
- whether it may run over more than one page
- whether the first row should be shaded

Give an **example answer** with each question and say the example is a form, not a proposal.
Then write the table and list what you decided on your own.

**"May it run over more than one page" is a question the author can answer.** It is not the
float question in disguise: it asks about the amount of data, which they know, not about page
breaking, which they do not. A yes means `longtable`, and it also lifts the footnote
restriction under "Traps". **Still never ask whether the table should float or sit fixed** —
see the paragraph after the decision table below.

**Way three: they pasted content.** Read the columns off the data and keep the author's
wording character for character. Decide alignment and, from the number of rows, whether it has
to run over more than one page. Ask only where the data itself is ambiguous: a column that
could be a heading or a value, two candidate header rows, a unit that could belong to the
heading or to every cell.

**The caption is not one of those decisions.** If the pasted material already names the table,
with a heading above it or a first line that reads as a title, take that wording as the caption,
character for character. If it names nothing, write no caption. Say so in the closing line: none
was in the material, so the table stays out of the List of Tables and cannot be cross-referenced,
and you will add one the moment they name it. Reading that sentence and answering it costs the
author seconds. An invented caption costs far more, see the next paragraph.

**Never invent a column heading.** They are the author's own words and they end up in a thesis:
"Sample", "n", "p value" is a different table from "Group", "Count", "Share". A guessed heading
looks finished, which is exactly why it survives to the printed version. Read them off the
material where there is material, ask for them wherever you do ask, and where you can do neither
leave the cell empty.

**Never invent a caption either, and this one holds even where you ask nothing at all.** A
heading labels something that is lying in front of you. A caption is a statement about the
author's own work, and nothing in the data says what that work is. That is why a made up caption
comes out long and explanatory: it had no source, so it was built out of the surroundings.
**No caption is a valid result.** The converter simply leaves the `\caption{}` out (see "Captions"
above) and nothing breaks. An empty spot the author can fill is honest. A sentence you made up
is not, and it is the one that gets printed in the List of Tables.

**A caption that does come about is short: a noun phrase, not a sentence.** "Design of the
study", not "This table shows how the study was designed". It stands in the List of Tables
between other short lines, and it is what a cross-reference points at.

**Decide these yourself in every one of the three ways**, then name them in one line:

| Decide | Default | When to depart from it |
|---|---|---|
| Alignment per column | numbers and dates right, everything else left | the author says otherwise |
| Grid | whatever `tableGridHorizontal` / `tableGridVertical` are set to in this vault | never on your own |
| Header row | the first row, as a normal row: the Markdown table has no separate header markup | shading is a separate wish, see "Colour" above |
| Placement | leave `tableEnvironmentText` alone | never on your own |
| Caption | none, unless the author gave one or their own material names the table | never write one yourself, see above |

**Never ask whether the table should float or sit fixed.** The author does not know what a
float is, and a question they cannot answer is worse than a default. It also comes too early:
whether the placement bothers them shows up in the PDF, not while writing. If it does, the
answer is in "Placement: why a table moves" above, and it starts by explaining the mechanism.

**An empty frame still needs at least one body row**, so the author has somewhere to type and
can see the column widths. Fill it with nothing, not with sample values: a table with invented
numbers in it reads as data, and invented data in a thesis is the one mistake worth being
paranoid about.
