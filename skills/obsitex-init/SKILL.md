---
name: obsitex-init
description: Set up a new Obsitex writing project in an Obsidian vault — scaffolds a research project structure (project, research, interviews, data, exports) around the manuscript as Professional Thesis (scrbook), Simple Thesis, or Academic Paper (LaTeX preamble, DDS settings, ordered chapter files, bibliography), ready for the Obsitex Markdown-to-LaTeX converter.
disable-model-invocation: true
argument-hint: "[project folder]"
---

# Obsitex Init — scaffold a new thesis / paper vault

Obsitex is a web app that converts an Obsidian vault (Markdown on OneDrive) into a LaTeX
document and PDF. This skill lays down everything the converter needs — document settings
(DDS), LaTeX preamble, and an ordered set of chapter files — so the user only fills in content.

## Two words, used everywhere

Use exactly these two terms — in this file, in the chat, in the report and in the READMEs.
Never invent synonyms ("target folder", "root folder", "the `10 Thesis` folder"); the whole
point is that the user hears the same word every time.

- **project folder** (de: *Projektordner*) — the folder the whole work lives in. Obsidian
  opens *this* one, so it is also the vault; `.obsidian` (and later `.git`) sit here.
- **the manuscript** (de: *das Manuskript*) — the subfolder Obsitex turns into the document.
  Its name on disk depends on the template (`Thesis`, `10 Thesis`, `Paper`), the term does
  not. Everything outside it never reaches the PDF.

The remaining folders get **no collective term** — name them individually (Organisation,
Research, Interviews, Data, Exports) or say "the other folders in the project folder".

## Which language governs what — one rule

> **What the reader of the PDF sees follows the document language.
> What only the author ever sees follows the chat language.**

| | Language |
|---|---|
| Headings, body text, everything printed | **document** |
| The conversation, questions, the final report | **chat** |
| Folder names on disk (project folders, the manuscript, collector folders) | **chat** |
| The `README.md` in each project folder | **chat** |
| ` ```remark ` blocks inside manuscript files | **chat** |

**Why folder names go with the chat language:** no folder name ever reaches the PDF — only
`#` lines create headings. The person who reads `20 Research` in the sidebar every day is the
author. Someone writing an English thesis while working in German should get German folders
and German notes; that combination is common, and the reverse assignment gets it wrong.

In the usual case both answers are the same language and nothing differs. The rule only bites
when they diverge — which is exactly where it matters.

**Say what you did.** One sentence in the final report, so the user can overrule without
having been asked a ninth question: *"I set the folders and notes up in German, because that
is the language we are speaking — tell me if you would rather have them in English."*

Without the project scaffold (opt-out) there is only one folder, which is project folder and
manuscript at once — then just say "your folder".

## Before you start

1. Read `shared/obsitex-conventions.md` from this plugin — the `shared/` folder sits in the
   plugin root, one level above the `skills/` folder this file is in. It defines the Markdown
   dialect the Obsitex converter understands, and it lists the topic files to consult when a
   specific element comes up. **Never write Markdown constructs outside those conventions** —
   Obsidian may render them, but the converter will not.
2. Determine the **project folder**: use `$ARGUMENTS` if given, otherwise the current
   working directory if the user clearly started there on purpose — otherwise ask. With
   the project scaffold (default) the manuscript becomes a subfolder of it; with the
   opt-out the template files go directly into it.
3. If the project folder already contains `.md` files, stop and ask before writing anything.
4. Never write Obsidian's own configuration — no `app.json`, `community-plugins.json`,
   workspace or appearance settings. **The only things you write under `.obsidian`** are
   the bundled Flexplorer plugin files and its seed `data.json`, both described in
   "Install the Flexplorer plugin" below.

## Interview — keep it short

**Assume the user does not know LaTeX.** Everything they read — questions, option
descriptions, the final report — must be plain everyday language: talk about pages,
chapters, headings, page numbers and the table of contents, not about document classes,
packages, environments or DDS. Where a technical name is unavoidable, put it in
parentheses after the plain wording.

**Step 1 — languages first.** Before anything else, ask these two questions together in a
single AskUserQuestion dialog:

1. **Chat language** — which language should the conversation use? If the user has
   already visibly written in a language in this session, offer that language as the top
   option — or skip this question and simply use it.
2. **Document language** — which language will the thesis/paper be written in? It may
   differ from the chat language. **No default** — list English first, then German.
   Affects babel options, DDS quotation marks, and the visible headings (see adaptation
   table below). English and German are fully supported; if the user picks another
   language, say honestly that it is untested and adapt generically (babel option, DDS
   quotation marks, translated headings).

From here on, communicate in the chat language — including the remaining questions.

**Step 2 — these nine questions** (AskUserQuestion works well), then use defaults and tell
the user everything can be changed later. All nine apply to every template:

3. **Top structural level — chapters or sections?** Ask this *before* the template
   question; it decides which templates remain. Details and the illustration the user
   needs: see "Chapters or sections" below.
4. **Template** — only the ones matching the previous answer:
   - with chapters → `professional-thesis` (numbered chapters, front matter with roman
     page numbers, lettered appendices — for master theses and dissertations). This is
     currently the only one; skip the question and say in one sentence what they get.
     It ships in two shapes, picked by the next question: `professional-thesis-nested`
     (default — a folder per chapter) and `professional-thesis` (one file per chapter).
   - without chapters → `simple-thesis` (cover page, table of contents, lists of figures
     and tables, chapters, bibliography, appendix — for seminar papers and shorter
     theses) or `academic-paper` (lean: abstract, chapters, bibliography — no cover
     page, no table of contents).
5. **How the parts are split up** — one file each, or a folder of files? **Default: a
   folder per part, two levels.** Asked for **every** template, but produced differently:
   `professional-thesis` has two shipped shapes, the flat templates are transformed by
   rule after copying. Wording, reasoning and the rules: see "Splitting into folders"
   below.
6. **Numbering depth** — how deep should headings be numbered? Default and recommendation:
   up to `1.1.1` in every class. **The option list differs with and without chapters** —
   see "Sectioning depth" below for both tables, the reasoning, and the cross-reference
   limitation that has to be named with the recommendation.
7. **Contents list depth** — same depth as the numbering, or one level shallower? Never
   deeper. Which one is recommended follows from the previous answer; see "Sectioning
   depth" below.
8. **Project structure** — full project scaffold (recommended default): six top-level
   folders for the whole research project, with the manuscript in its own subfolder
   (see "Project scaffold" below) — or manuscript only, files straight into the folder.
   **Introduce the two terms here**, because without them the choice cannot be judged. Say
   it roughly like this, in the chat language: *"A thesis is more than its text. I would set
   up a **project folder** that holds everything — and inside it **the manuscript**, the
   only folder Obsitex turns into your document. Next to it come folders for organisation
   (proposal, schedule, meeting notes), research, interviews, data and exports. Whatever
   you write outside the manuscript never lands in the PDF — which is exactly what keeps
   the document clean."*
9. **Citation style** — numeric (default), author–year, or verbose. Maps to the biblatex
   `style=` option in the preamble.
10. **Cover data** (professional-thesis and simple-thesis) — title, subtitle, document
    type (e.g. Seminar Paper / Master Thesis), degree program, author, supervisor. Offer
    to keep the placeholders if the user does not want to decide now.
11. **How the file order is controlled — variant A or B.** Ask this **last**, but before
    scaffolding: it decides the file names. See "Ordering: variant A or B" below.

## Ordering: variant A or B (last question)

Obsidian shows the files of the vault in one list, and Obsitex converts them in exactly
that order. There are two ways to control it, and they lead to different file names — so
the answer must be known before any file is written.

**Recommend A clearly** — not only as a parenthesis in the option label, but in the
message next to the question ("I'd strongly recommend the first one"). Still no automatic
default: the user chooses.

- **A — "Change the order freely by drag & drop" (strongly recommended).** A small
  Obsidian add-on (Flexplorer) does the sorting; the skill brings it along and walks the
  user through switching it on. File names stay clean, without numbers.
- **B — "Control the order through the file names".** Nothing to install. Every file gets
  a number in front (10, 20, 30 …), and reordering means renaming.

Show the difference the same way as for the chapters question — **as a chat message before
the call, and as `preview` on both options** (never only in `description`):

*Variant A:*

```
┌────────────────────────────┐
│  00 Document Setup               │
│  Frontmatter          ›    │
│  Main Matter               │
│  Introduction              │
│  Methodology               │
│  Results                   │
│  Backmatter           ›    │
└────────────────────────────┘
 exactly the document order,
 rearrange by dragging
```

*Variant B:*

```
┌────────────────────────────┐
│  10 Frontmatter       ›    │
│  90 Backmatter        ›    │
│  00 Document Setup               │
│  20 Main Matter            │
│  30 Introduction           │
│  50 Methodology            │
│  60 Results                │
└────────────────────────────┘
 folders always on top,
 rest sorted by number
```

Variant B's mockup must show the folders on top — that is what Obsidian really does
without the add-on, and the user should see it before choosing, not afterwards.

Say in the option descriptions, short and in plain words: with A the names stay clean and
reordering is one drag; the order then lives in a settings file of the add-on. With B
nothing extra is installed and the order is visible in the names themselves; the gaps
between 10, 20, 30 exist so a new chapter can be squeezed in as 25 without renaming the
rest.

**What follows from the answer**

| | A | B |
|---|---|---|
| File names | no number prefixes — **except `00 Document Setup.md`**, which keeps its `00 ` | number prefixes in steps of ten, as the templates carry them |
| Flexplorer | plugin files + seed `data.json`, then guided activation | not installed at all, no `data.json`, no existing-vault question |
| Reordering | drag & drop in Obsidian | rename the file (see the renaming rules in the report) |

In **variant A**, strip the leading `^\d+\s+` from every file and folder name while
copying — including the top-level folders (`Organisation`, `Thesis`, `Research`, `Interviews`,
`Data`, `Exports`) and the manuscript subfolders (`Frontmatter`, `Backmatter`). The single
exception is `00 Document Setup.md`: it must sort first even when the add-on is not running,
because the converter reads its settings at the position where they stand. Mention this in
the report in one sentence — it is the reason that one file looks different from the rest.

**Watch the chapter folders while stripping.** In the nested template a chapter folder and
its title file carry the same name (`30 Introduction/30 Introduction.md`). The converter
recognises the title file *by* that match, so both must be stripped together
(`Introduction/Introduction.md`). Strip only one and the file turns into an ordinary
section — silently, with the chapter title landing on the wrong level. **The same applies to
the folders built by rule** in the flat templates — there the trap is easier to hit, because
the folder and its file are created by the skill rather than copied.

## Chapters or sections (ask before the template)

This is the first real decision about the document, so present it properly — **no
default**, the user should choose consciously. **Write everything in plain everyday
language**: the user may never have seen LaTeX. Do not use words like documentclass,
scrbook, article, `\frontmatter` or DDS in the question — say "chapters", "page", "table
of contents", "numbering". Ask in the chat language, and translate the mockups too.

### Ask it as a question about the structure, never about the wording

**The trap:** "Chapters or sections?" on its own reads like a naming choice — as if the user
were picking what to *call* the parts. What is actually being decided is where the outline
**starts**, and everything below shifts with it.

Use a stem that carries that. In German the agreed wording is:

> **Beginnt deine Gliederung mit Kapiteln oder mit Abschnitten?**

In English, the same shape: *"Does your outline start with chapters or with sections?"* —
the verb "start" does the work; it locates the decision at the top of the hierarchy without
having to name a hierarchy at all. **Then explain the difference**, using the mockups and the
list further down.

**Say "your document", not "your work".** In German especially, *„deine Arbeit"* is too vague
— it also just means *task* — and it collides with the manuscript folder's name. *„dein
Dokument"* is unambiguous and is what actually comes out at the end.

### How to ask it — the illustration is mandatory

The two page mockups below are the point of this question; a text-only question fails it.
Show them **twice**, both steps are required:

1. **Print the side-by-side comparison as a normal chat message directly before calling
   AskUserQuestion** (translated into the chat language, inside a fenced code block so the
   monospace alignment survives). This guarantees the user sees it even if the interface
   does not render option previews.
2. **Then call AskUserQuestion with a `preview` on each of the two options** — the mockup
   of that option plus a two-line caption. Both options must carry a `preview`; only then
   does the dialog switch to the side-by-side layout with the mockup next to the list.
   Never paste a mockup into `description` instead — `description` stays short (two or
   three sentences, see the difference list below); the mockup belongs in `preview`.

Keep the mockups roughly like this:

*With chapters:*

```
┌────────────────────────┐
│                        │
│                        │
│                        │
│  2                     │
│  Methods               │
│  ──────────────────    │
│                        │
│  2.1 Data collection   │
│  Lorem ipsum dolor …   │
└────────────────────────┘
 always starts on a new
 page, title sits low
```

*Without chapters:*

```
┌────────────────────────┐
│  … previous text.      │
│                        │
│  2  Methods            │
│                        │
│  2.1 Data collection   │
│  Lorem ipsum dolor     │
│  sit amet, consetetur  │
│  sadipscing elitr, …   │
└────────────────────────┘
 runs on within the text,
 no page break
```

Put the differences below into the **chat message** of step 1, as a short list in the
user's own words. Each option `description` gets only the two most decisive ones — the
look and **the level consequence** — in two or three sentences; do not cram all five in.
The level consequence belongs in the option itself, not only in the list: it is the half
of this decision the mockups cannot show, and the reason the question is not about wording.
Roughly:

> *With chapters — like a book.* Each main part starts on a new page with a large number.
> Below it you still have section, subsection and more.
>
> *With sections — like an essay.* The main parts run on within the text, no page break.
> One outline level less below.

- **Look:** with chapters, every chapter starts on a fresh page and its title sits far
  down the page with a big number above it; without chapters, headings simply continue
  in the running text.
- **One more level of depth:** with chapters, `#` is a chapter, `##` a section, `###` a
  subsection — numbers like 2.1.3.4 are possible. Without chapters, `#` is already a
  section, so the useful depth ends one level earlier.
- **Length of the document:** for a short paper (roughly under 30 pages) chapters create a
  lot of empty space; from about 40–50 pages they give the document structure. A rule of
  thumb, not a rule.
- **Roman page numbers at the front:** with chapters, title page, abstract and the
  tables of contents are numbered i, ii, iii and the numbering restarts at 1 with the
  introduction — what a bound thesis usually looks like. Without chapters the page
  numbers run through from 1.
- **Figures, tables and page headers:** with chapters, figures are counted per chapter
  (Figure 2.1, 2.2) and the page header shows the current chapter title; without
  chapters they are counted straight through (Figure 1, 2, 3).

Also tell them honestly, before they choose: **changing this later is real work** — it
affects the document setup, the appendix and page-numbering switches, and the number of
`#` signs in every chapter file. Not a single click.

## Splitting into folders (all templates)

A top-level part can be **one file** or **a folder holding several files**. Ask this for
**every** template — but the skill produces the answer in two different ways:

| Template | How the nested shape is produced |
|---|---|
| `professional-thesis` | **Template-based** — two shipped shapes, copy the matching one |
| `simple-thesis`, `academic-paper` | **Rule-based** — copy the flat template, then build the folders from the rules below |

The rule-based path exists deliberately (16.08.2026): a fourth and fifth template would have
to be kept in sync with every future preamble and convention change, and the flat formats
have only four to six body files to nest. The full rule set already exists as documentation
([[VAULT_BAUWEISE]], R1–R10) — this is the first time the skill applies it instead of
shipping its result. **Treat it as the experiment it is:** if the rule-based build proves as
reliable as the template, it is the better model for the third template too.

**Why it matters — say this, in plain words:** a part grows. Once a file holds fifty
pages, the smallest thing you can move around is the whole part, and rearranging your
argument means cutting and pasting inside a wall of text. With a folder per part each
section is its own small file, and you reorder them by dragging — Obsitex reads the level
from where a file sits, so **moving a file never means editing its headings**.

### The rule: a file never starts with more than one `#`

**This is a hard rule for everything the skill writes.** One `#` always means „the level of
the folder I am in". Every file therefore reads the same way regardless of how deep it sits,
can be moved anywhere without touching its headings, and can be turned into a folder later
without an edit.

It follows that **splitting stops at the folder limit**: where no deeper folder is allowed,
the file at that level absorbs its whole substructure as `##`, `###` — it does not hand it to
sibling files. Sibling files starting with `##` are exactly what this rule forbids.

A folder **replaces** a file, it does not sit on top of one — so the first folder level is
free, and every file inside a folder counts from the same base. Only a folder **inside** a
folder goes a step deeper.

### How sections are placed — the collector folder

The full rule set is below. Notation: **B** = a section *without* subsections, **A** = a
section *with* subsections.

**Sections go into a collector folder** — `Subchapters` in English, `Unterkapitel` in German
(folder names follow the DOCUMENT language). It carries **no** file of its own and therefore
never appears in the PDF; it exists only to create the level. One folder per section would be
pure packaging — that was the first design, and users reported it as too nested.

```
BBBBB   →   30 Introduction/
                30 Introduction.md        # Introduction   → chapter
                Subchapters/
                    10 Motivation.md      # Motivation     → section
                    20 Problem State….md  # …              → section
```

**A section that has subsections keeps its own folder** — with its own `Subchapters` inside.
That way it takes its children along when it is moved:

```
BAAA    →   Chapter/
                Chapter.md
                Subchapters/              ← the one leaf
                Branch/
                    Branch.md
                    Subchapters/          ← the branch's children
```

**A single leaf standing between branches gets its own folder**, not a second collector — it
keeps its readable name:

```
BBBABA  →   Chapter/  ·  Subchapters/ (the three leaves)  ·  Branch1/
            ·  Single Leaf/  ·  Branch2/
```

**Two or more separate leaf blocks: number the second collector.** Names must be unique in a
folder; the number is a pure discriminator and claims nothing, so it cannot go stale:

```
BBABB   →   Chapter/  ·  Subchapters/  ·  Branch/  ·  Subchapters 2/
```

**Why the grouping matters:** a folder always appears as one contiguous block in the document.
A collector may therefore only hold **consecutive** leaves — otherwise it would pull a section
out of its place and silently reorder the thesis.

**Growing a section into a folder** is a move, not a rewrite: create a folder next to
`Subchapters`, put a file with the same name inside, move the text there and drop one `#`.
Tell the user this — it is the reason the rule exists.

**One place where that does not hold: `Frontmatter` and `Backmatter` take files only** (R10).
Both are storage folders — they carry no heading and already consume the one free folder level.
Files inside them become chapters as expected, but a **folder** inside them counts as a second
level and lands one level too deep, with no warning. Breadth is free, depth is not: twenty
appendices side by side are fine, one *split* appendix is not. The limit holds whatever folder
depth the user picked for the manuscript. If an appendix does outgrow one file, either move its
folder directly into the manuscript after `Appendix.md` (`\appendix` is a switch — everything
after it becomes an appendix, whatever folder it sits in), or set `latex-heading-offset: -1` in
**every** file of that appendix.

**The options — default is two levels:**

- **One file per chapter (flat).** Simplest to look at; a long chapter becomes a long file,
  and its sections sit inside it as `##`. → template `professional-thesis`
- **A folder per chapter, two levels (default).** The chapter is a folder with its own
  chapter file; the sections are separate files in a `Subchapters` folder next to it.
  → template `professional-thesis-nested`
- **Three levels.** As above, plus: a section that has subsections of its own keeps its own
  folder (with its own `Subchapters` inside), so it takes its parts along when moved.
  → same template plus the `\setcounter` lines below; the user adds the third level as the
  work grows — the template ships with two.

The nested template mixes both styles on purpose: five chapters are folders with a
`Subchapters` folder, `80 Conclusion and Future Work.md` stays a single file with its two
sections as `##` inside. Point that out — it shows that no chapter *has* to become a folder,
and that both forms produce the same `\chapter` + `\section` in the PDF. Every file, in both
forms, starts with a single `#`.

**Why two is the default, and three the maximum** — this is not a taste question. Beyond
three folder levels the deepest files land where LaTeX stops setting headings as headings
(see "Sectioning depth" below). Two levels leave room for a `##` or `###` inside the file
before that line is reached.

### Building it by rule — `simple-thesis` and `academic-paper`

No nested template exists for these. Copy the flat template **verbatim** as always, then
transform it. Everything below follows [[VAULT_BAUWEISE]] R1–R10; nothing here is new
mechanics, only their first application by the skill.

**The collector folder is called `Subsections` / `Unterabschnitte` here, not
`Subchapters` / `Unterkapitel`.** These documents have no chapters — `#` is already a
`\section`, so its children are subsections. Using the chapter word would teach the user a
structure their document does not have. (Name follows the **document** language, like every
other folder name.)

**Which files become folders** — body files only:

| Template | becomes a folder | stays a single file |
|---|---|---|
| `simple-thesis` | `60 Introduction`, `70 Literature Review` | Cover Page, Abstract, the three lists, `80 Conclusion`, Bibliography, Appendix |
| `academic-paper` | `20 Introduction`, `30 Methods`, `40 Results`, `50 Discussion` | Abstract, `60 Conclusion`, Bibliography |

**Conclusion deliberately stays flat**, exactly as `80 Conclusion and Future Work.md` does in
the nested professional template — it shows the user that both shapes coexist in one document
and produce the same output. Point that out; it is the cheapest way to teach the rule.

Front matter, lists and the bibliography never become folders: they carry no substructure. The
appendix stays one file too — an appendix nobody rearranges is better structured with `##`
inside (see "When an appendix outgrows one file" in `shared/headings.md`).

**The transformation, per file** (R2, R3, R1 in that order):

1. Create the folder with the file's exact name: `60 Introduction/`.
2. Move the file into it, name unchanged → it becomes the **chapter file** and carries the
   heading of that level (R3). Its single `#` stays a single `#` — the folder replaced the
   file, it did not add a level (R2).
3. Create `Subsections/` **inside** that folder.
4. Move each `##` block out of the chapter file into its own file in `Subsections/`, named
   after the heading, and **turn the `##` into a single `#`** (R1). Anything above the first
   `##` — the lead-in — stays in the chapter file.
5. If the file has no `##` blocks (most of them do not in these templates), create two
   placeholder section files in the same style the template uses elsewhere, so the user sees
   the shape and can fill it.

Number prefixes follow the ordering variant, decided in the last question: variant B numbers
the new files `10 `, `20 `, `30 ` in steps of ten; variant A leaves them without prefixes.

**Check before you finish:** every file starts with exactly one `#`, every folder holds a file
of the same name, `Subsections/` holds none, and no folder sits inside another folder — two
levels is the whole budget here (`#` = section, files in `Subsections/` = subsection).

**Folder depth is not document depth.** Files inside a folder may still use `##` and `###`
for their own sub-structure; the level budget is the sum of both. Mention this so nobody
thinks two levels caps the whole document at two.

**Do not tie the numbering depth to this answer.** It used to be coupled here — three folder
levels wrote `\setcounter{secnumdepth}{3}` — and that was wrong: the depth that matters comes
from folders **plus** hashes, so a two-level user writing `###` fell through the same gap
without ever being asked. Numbering is its own question now, see below.

## Sectioning depth (all templates)

Two questions, asked **after** the template is settled — the option labels and the
recommendation depend on the document class.

**Both are asked for every template.** They used to be skipped for `simple-thesis` and
`academic-paper` on the grounds that `article`'s default is already right and the run-in
repair is KOMA-only anyway. That was the same mistake as capping the options: a user of a
flat template who writes `####` lands on `\paragraph` — unnumbered, and a `[[…]]` pointing
there fails silently. Skipping the question does not prevent that; it only withholds the fix.
The damage is the broken cross-reference, not the typography, and `\crefname` repairs it in
`article` just as well.

### Why this is asked at all

Not aesthetics. **A cross-reference to an unnumbered heading points at the wrong place.**
`[[Note]]` becomes `\vref`; with no number of its own the label carries the preceding
numbered heading's number. Measured, scrbook at its default: a `\vref` to a `\subsubsection`
prints `section 1.1.1` — the subsection above it. No error, no warning.

That is not exotic. In the default template a chapter is a folder, a file in `Subchapters`
starts at `\section`, so a `###` written while drafting lands on `\subsubsection` — already
past the line. In a flat template it takes one `#` more: `####` lands on `\paragraph`. Say
this in plain words; it is the whole reason for the question.

### Question A — numbering depth

Offer **every level the class can number** — the recommendation steers, it does not restrict.
The reason is the cross-reference: a user can write `#####` whether we offer it or not, and a
`[[…]]` pointing at that heading then fails **silently and inexplicably**. Withholding the
option does not prevent the depth, it only removes the fix. Every level a user can reach must
be numberable.

**With chapters** (`professional-thesis`, `scrbook`):

| Option (what the user sees) | LaTeX command | `secnumdepth` |
|---|---|---|
| **Up to 1.1.1** *(recommended — the LaTeX default)* | `\subsection` | 2 |
| Up to 1.1.1.1 | `\subsubsection` | 3 |
| Up to 1.1.1.1.1 | `\paragraph` | 4 |
| Up to 1.1.1.1.1.1 | `\subparagraph` | 5 — LaTeX has nothing deeper |

**Without chapters** (`simple-thesis`, `academic-paper`, `article`) — one digit fewer at
every step, because there is no `\chapter` in front. **The counter values are the same**; only
the printed number is shorter:

| Option (what the user sees) | LaTeX command | `secnumdepth` |
|---|---|---|
| **Up to 1.1.1** *(recommended — the LaTeX default)* | `\subsubsection` | 3 |
| Up to 1.1.1.1 | `\paragraph` | 4 |
| Up to 1.1.1.1.1 | `\subparagraph` | 5 — LaTeX has nothing deeper |

Both defaults print **three digits**. Never copy the counter value from one table to the
other — `\paragraph` is level 4 in *both* classes, `article` simply leaves level 0 empty.

**Recommend the first**, and give the reason with it: three levels is where the class stops
offering typographic means. From `\subsubsection` down every level has the same font size and
the same weight — only the length of the number tells them apart, so the reader counts dots.
The last two options in either table are worse still: `\paragraph` and `\subparagraph` run
into the body text instead of taking a line of their own.

**With chapters** the skill repairs that run-in (see the block below), though no repair brings
back a visible hierarchy. **Without chapters it cannot** — `\RedeclareSectionCommand` is a
KOMA command and `article` does not have it (measured: undefined control sequence). Say so in
the option text rather than letting the user discover it: the numbering and the cross-reference
are fixed, the run-in look is not, and changing that would need the `titlesec` package.

**Name the limitation with the recommendation:** at the recommended depth, links work down to
`1.1.1` and no deeper. Whoever wants to link to finer sections needs the next option.

### Question B — contents list depth

| Option | `tocdepth` |
|---|---|
| Same depth as the numbering | = `secnumdepth` |
| One level shallower | = `secnumdepth` − 1 |

**Never offer a contents list deeper than the numbering.** Its entries would sit unnumbered
at the same indent as their siblings' titles, and the indentation stops showing the hierarchy.

Which option carries the recommendation depends on answer A: at `1.1.1` recommend *same
depth* (three levels are already sparse); at `1.1.1.1` or deeper recommend *one level
shallower*, or the list outgrows a page and stops giving an overview.

### The block to write

Always write it, in every case — at the recommended depth every line stays commented out.
Comments in **English**, like the rest of the preamble, whatever the chat language was.

**Put the block at the very end of the `latex-preamble` block.** `\crefname` is defined by
`cleveref`, which the template loads late (deliberately: varioref → hyperref → cleveref).
Placed above that line it is an undefined control sequence.

**With chapters** (`professional-thesis`):

```latex
% --- Sectioning depth ---
% Without a setting, the document class default applies (scrbook: numbered to 1.1.1).
% Values up to 5 are possible:
%   3 = 1.1.1.1    4 = 1.1.1.1.1    5 = 1.1.1.1.1.1
%\setcounter{secnumdepth}{3}  % number deeper - adjust the value as needed
%\setcounter{tocdepth}{2}     % keep the contents list shallower than the numbering
% From value 4 on these are needed too (\paragraph otherwise runs into the body text,
% and a cross-reference to it prints "??"):
%\RedeclareSectionCommand[runin=false,afterskip=.5\baselineskip]{paragraph}
%\crefname{paragraph}{paragraph}{paragraphs}
% At value 5 the same again for \subparagraph:
%\RedeclareSectionCommand[runin=false,afterskip=.5\baselineskip]{subparagraph}
%\crefname{subparagraph}{subparagraph}{subparagraphs}
```

**Without chapters** (`simple-thesis`, `academic-paper`) — same counter values, one digit
fewer, and no run-in repair available:

```latex
% --- Sectioning depth ---
% Without a setting, the document class default applies (article: numbered to 1.1.1).
% Values up to 5 are possible:
%   4 = 1.1.1.1    5 = 1.1.1.1.1
%\setcounter{secnumdepth}{4}  % number deeper - adjust the value as needed
%\setcounter{tocdepth}{3}     % keep the contents list shallower than the numbering
% From value 4 on this is needed too, or a cross-reference prints "??" instead of the name:
%\crefname{paragraph}{paragraph}{paragraphs}
% At value 5 the same again for \subparagraph:
%\crefname{subparagraph}{subparagraph}{subparagraphs}
% Note: from value 4 on the heading runs into the body text instead of taking a line of its
% own. This class has no switch for that - it would need the titlesec package.
```

Uncomment exactly the lines the answers call for, and leave the rest as it stands.

**Answer A decides `secnumdepth` and the repair pairs:**

| Answer A | `secnumdepth` with chapters | without chapters | repair lines to uncomment |
|---|---|---|---|
| 1.1.1 | — leave commented, the class default does this | — leave commented | — |
| 1.1.1.1 | 3 | 4 | with chapters none · without chapters `paragraph` |
| 1.1.1.1.1 | 4 | 5 | `paragraph`, and without chapters also `subparagraph` |
| 1.1.1.1.1.1 | 5 | *(not offered — `article` stops one digit earlier)* | `paragraph` **and** `subparagraph` |

Read the column for the class actually in use. The same printed number needs a **different**
counter value in the two families — that is the one place where copying across is wrong.

**Answer B decides `tocdepth`:** same as `secnumdepth`, or one lower. Write the line whenever
`secnumdepth` was written, so the pair stays visibly consistent; if `secnumdepth` stayed
commented, write `tocdepth` only for *one level shallower* (value 1).

**The repair pairs are not optional** — they are consequences, not preferences, which is why
they are never asked about (all measured):

- without `\RedeclareSectionCommand` the heading runs into the body text; no counter changes
  that, and the command is KOMA-only
- without `\crefname` a cross-reference prints a literal `??` before the number — including
  `\vref`, because `cleveref` patches `varioref`

At value 5 **both** pairs are needed: `\subparagraph` is numbered there too and produces its
own `??` otherwise.

**Do not write an active `\setcounter` when the default is chosen.** The class default adapts
if the document class is changed later; a written value does not, and would silently produce
`1.1` after a switch to `article`.

Never let the converter inject any of this — the preamble is the single source, and
generating it here is the right place. Background and the measurements behind every claim:
`Gliederung_Dimensionen.md` in the Obsidian docs, reproducible with
`node dev/latexDepthProbes.mjs` in the app repo.

## Project scaffold (default)

A thesis is more than its manuscript — the vault is the whole workspace (analyses,
sources, interviews, planning). Obsitex converts exactly one selected folder, so the
manuscript gets its own subfolder and everything else stays out of the conversion
automatically (no `skip: true` needed outside).

Unless the user opted out, create these six folders in the project folder. Folder names
follow the **chat language** — see "Which language governs what" above; nobody but the author
ever sees them. The numbers below apply to **variant B**; in variant A drop them
(`Organisation`, `Thesis`, `Research`, …):

| English | German | Purpose |
|---|---|---|
| `00 Organisation` | `00 Organisation` | proposal/exposé, schedule, open tasks, meeting notes, supervisor feedback |
| `10 Thesis` (academic-paper: `10 Paper`) | `10 Arbeit` (academic-paper: `10 Paper`) | **the manuscript — the folder the user selects in Obsitex**; the template is copied in here |
| `20 Research` | `20 Recherche` | literature notes per source, source PDFs, interim analyses |
| `30 Interviews` | `30 Interviews` | guides, transcripts, evaluations |
| `40 Data` | `40 Daten` | raw data, analysis scripts, figure source files (draw.io, Excalidraw, …) |
| `90 Exports` | `90 Exporte` | frozen PDF states (e.g. "draft sent to supervisor") |

- Put a short `README.md` into each project folder (in the **chat language**): one or two
  sentences on what belongs there — plain Markdown, these folders are outside the
  converter, so no remark blocks and no converter conventions apply.
- The manuscript's README must state the boundary rule that actually matters:
  **only the Markdown files inside this folder become the document.** Text written in the
  other project folders never lands in the PDF, and a wikilink to a note outside this
  folder works in Obsidian but cannot become a reference in the PDF — link outward for
  working, not for citing.
- Attachments are the exception: images, PDFs and `.bib` files are resolved across the
  whole vault, so an embed may point to a file outside the manuscript. Keeping
  images and `refs.bib` inside it is still the tidier default (recommend it, do not
  present it as a hard requirement).
- Exported figures go to an `attachments/` subfolder **inside** the manuscript, never beside it
  in the project folder — the manuscript has to stay copyable as a whole. Their editable source
  files belong in the data folder. Reasoning → `shared/images.md`, "Which level".
- **Do not put `.obsidian` into the manuscript** — it belongs in the project folder
  so the whole project is one vault; see "Install the Flexplorer plugin".

## Scaffold

1. Copy every file of the chosen folder under `templates/` into the **manuscript**
   (project scaffold) or directly into the project folder (opt-out),
   **verbatim first** — the templates are tested wholes; do not improvise structure.
2. Then adapt in place:
   - **Citation style:** in `00 Document Setup.md`, set the biblatex option — **and, for the
     two non-default styles, add the matching redefinition on the next line.** The converter
     always emits `\cite{…}`, and `\cite` means something different in every biblatex style:

     | Answer | biblatex option | Extra line — **required** |
     |---|---|---|
     | numeric (default) | `style=numeric-comp` | none |
     | author–year | `style=authoryear` | `\let\cite\parencite % author-year: source in parentheses` |
     | verbose | `style=verbose` | `\let\cite\footcite % verbose: source in a footnote` |

     **Without the extra line the output is broken, and it still compiles** (measured
     14.08.2026): `authoryear` prints `… a long tradition Knuth 1984.` with no parentheses,
     and `verbose` prints the **entire reference inside the sentence** — "… a long tradition
     Donald E. Knuth. The TeXbook. Reading, MA: Addison-Wesley, 1984." Nothing warns.
   - **Cover data** (professional-thesis / simple-thesis): replace the placeholders inside
     the `latex` block of the Cover Page file.
   - **Document language German:** apply the table below.
   - **Sectioning depth (every template):** write the depth block into
     `00 Document Setup.md` according to the two answers — see "Sectioning depth" below for
     the two blocks (with and without chapters). One is written in **every** case; at the
     recommended depth all its lines stay commented out.
3. **File names according to the ordering variant:** in **B** keep the number prefixes of
   the templates (`00 `, `10 `, `20 `, … in steps of ten — the gaps are there so a chapter
   can be inserted as `25` without renaming the rest); in **A** strip them everywhere
   except from `00 Document Setup.md`.

### professional-thesis specifics (scrbook)

- The DDS uses `documentLevelIndex: 0`: one `#` becomes a **chapter**, `##` a section.
- Structural files carry pure LaTeX switches and must keep their position: `10 Frontmatter/
  10 Front Matter.md` (`\frontmatter`) before all front matter content, `20 Main Matter.md`
  (`\mainmatter`) before the first chapter, `90 Backmatter/20 Appendix.md` (`\appendix`)
  before the appendix chapters (they become A, B, C). In variant A they are
  `Frontmatter/Front Matter.md`, `Main Matter.md` and `Backmatter/Appendix.md` — their
  position then rests entirely on the Flexplorer order.
- Prefixless front matter chapters (`# Abstract`, `# Acknowledgements`, `# List of
  Abbreviations`) are automatically unnumbered with a ToC entry — do **not** add `{-}`
  there. In the back matter, `{-}` on a chapter heading emits KOMA's `\addchap`
  (unnumbered + ToC + running header) — used by References, Appendix and Declaration.

### German adaptation

| Where | Change |
|---|---|
| `00 Document Setup.md`, babel/varioref/cleveref | option `english` → `ngerman` |
| `00 Document Setup.md`, dds block | `openingQuotationMark` → `„` and `closingQuotationMark` → `“` (German quotes) |
| Visible headings in the chapter files | Abstract → Zusammenfassung · Acknowledgements → Danksagung · List of Abbreviations → Abkürzungsverzeichnis · Introduction → Einleitung · Motivation → Motivation · Background / Context → Hintergrund und Kontext · Background and Related Work → Hintergrund und Forschungsstand · Problem Statement → Problemstellung · Research Questions → Forschungsfragen · Literature Review → Literaturübersicht · Methods / Methodology → Methodik · Results → Ergebnisse · Discussion → Diskussion · Conclusion → Fazit · Conclusion and Future Work → Fazit und Ausblick · Bibliography / References → Literaturverzeichnis · Appendix → Anhang · Survey Questionnaire → Fragebogen · Interview Transcripts → Interviewtranskripte · Declaration of Authorship → Selbstständigkeitserklärung |
| Visible **placeholder texts** in the manuscript | translate to German — they are draft body text and will be printed |
| ` ```remark ` blocks | follow the **chat language**, not this table. They are never printed; the author reads them. If the chat is English and the document German, leave them English. |
| **Collector folders** | `Subchapters` → **`Unterkapitel`** (and `Subchapters 2` → `Unterkapitel 2`). Folder names follow the **chat language** (see "Which language governs what") — rename the folder AND its entry in the Flexplorer `data.json`. The folder carries no file of its own, so nothing else changes. |
| Auto-generated titles (ToC, List of Figures, List of Tables) | **do not touch** — the latex blocks stay as they are; babel translates the printed titles itself |
| File names | optional cosmetic rename (file names never create headings); keep the numbering scheme of the chosen variant |

## Install the Flexplorer plugin

The thesis itself is written **in Obsidian** — Claude Code is the technical layer beside
it, working on the same files — so every scaffold gets the vault layer. Obsidian's core
file explorer always lists folders above files, so the visible order would not match the
document order (confusing especially for professional-thesis with its Frontmatter/
Backmatter folders). Flexplorer fixes the display and adds drag & drop reordering — the
ordering mechanism Obsitex recommends.

**Only in variant A.** If the user chose B, skip this whole section including the seed:
no plugin files, no `data.json`.

**The project folder is the vault. Never look above it.** That is the definition at the top
of this file: `.obsidian` (and later `.git`) sit in the project folder. Do not walk up the
directory tree looking for an existing `.obsidian`, and do not ask the user whether there is
one.

Three reasons, all of which have cost time before:

- **Everything above the project folder is outside the skill's working directory.** Reading
  there needs the user's consent and shows them a permission prompt — for a newcomer, an
  alarming one, arriving before they know what Obsitex even wants out there.
- **A found `.obsidian` proves nothing.** Obsidian never removes it; anyone who once opened a
  folder as a vault has one there forever. A leftover and a working vault cannot be told
  apart reliably — measured on a real folder, the obvious test ("does it hold notes of its
  own?") gave the wrong answer.
- **A vault root above the project folder breaks self-containment.** `data.json` carries the
  order of the whole document. Outside the project folder it is not copied, archived or
  versioned with it — and the planned Git layer (pendency S9, which tracks `data.json` on
  purpose) could not work at all.

*Historical note, so nobody re-adds it:* this rule existed from 20.07.2026 (`fcf1161`) and
walked up from what was then called the "target folder" — the folder the user picked, which
in those days **was** the manuscript, so the vault root really did lie above it. The project
scaffold and the two-term vocabulary arrived one day later and made the project folder the
vault. The walk-up lost its purpose then; it was only reworded, never removed, and so it kept
contradicting the definition above it.

After scaffolding:

1. If `{projectFolder}/.obsidian/plugins/flexplorer/` already exists, leave it completely
   untouched (the user may run a newer version) — just note it in the report.
2. Otherwise copy `main.js`, `manifest.json`, `styles.css` from `assets/flexplorer/`
   (in this skill folder) to `{projectFolder}/.obsidian/plugins/flexplorer/`.
3. Write the seed `data.json` next to them — see "Seed the Flexplorer order" below.
4. Do **not** write anything else under `.obsidian` — no `community-plugins.json`, no
   app or workspace settings. Enabling the plugin is the user's click, see below.

**If the user wants their project inside a vault they already use**, that is a legitimate
wish — Flexplorer installed once for several projects, or a thesis living next to existing
literature notes. It is **not** offered here: it concerns a minority, it cannot be raised
without explaining vaults to someone who may not know them, and the assistant can do it later
on request. The knowledge lives in `shared/obsitex-conventions.md`.

### Guide the activation, then let the user confirm

Plugin files and seed are written **together, before the first activation** — never
afterwards. Reason: if the plugin starts without a seed, it builds its own reversed order
immediately, and the user would see exactly the broken state we are preventing (plus a
restart, plus the risk that the running plugin overwrites our file).

The clicks themselves are the user's — Claude has no access to Obsidian's UI. Walk them
through it in the chat, in their language, and sketch the path so it is easy to follow:

```
Obsidian  ⚙ Settings (bottom left)
   └─ Community plugins
        ├─ [Turn on community plugins]     ← only on a new vault, with a security notice
        └─ Installed plugins
             └─ Flexplorer            ( ●— )   ← switch on
```

Explain the security notice instead of glossing over it: community plugins are third-party
code, Obsidian asks once whether they may run at all — that consent is deliberate and must
never be pre-set through a config file.

Then **ask for confirmation** before moving on: does `00 Document Setup` sit at the top, with the
chapters in document order? If the user is unsure whether the plugin is running at all, a
simpler check: right-click a file — the entries *Pin* and *Hide* only appear with
Flexplorer active.

**If the order is wrong:** have the user close Obsidian **completely** (a running plugin
rewrites the file on the next save), write the `data.json` again, then reopen Obsidian.

## Seed the Flexplorer order

Without this file a freshly scaffolded vault displays **in reverse**. Flexplorer defaults
to `newItemPlacement: top` and gives every folder it meets a `custom` sort order with an
empty list, so it prepends each file it discovers — the first file ends up last. The user
would have to fix the sorting in every folder by hand. So write one small seed file:

`{projectFolder}/.obsidian/plugins/flexplorer/data.json`

**Skip it entirely if that file already exists** — then the user has their own order, which
always wins.

Write only two things: one entry per folder that has something to order, and the placement
switch. Everything else (per-file entries, `pinnedFiles`, `showHidden`, …) is filled in by
the plugin's own defaults on first load, so leaving it out is both correct and safer.

```json
{
  "items": {
    "/": {
      "sortOrder": "custom",
      "customOrder": ["Organisation", "Thesis", "Research",
                      "Interviews", "Data", "Exports"]
    },
    "Thesis": {
      "sortOrder": "custom",
      "customOrder": ["00 Document Setup.md", "Frontmatter", "Main Matter.md",
                      "Introduction.md", "Backmatter",
                      "README.md", "refs.bib"]
    },
    "Thesis/Frontmatter": {
      "sortOrder": "custom",
      "customOrder": ["Front Matter.md", "Cover Page.md", "Abstract.md"]
    }
  },
  "newItemPlacement": "bottom"
}
```

Rules for building it:

- Keys are folders only — never files. The project folder is the key `"/"`; every other key
  is a folder path relative to it, with `/` separators (e.g. `Thesis/Backmatter`).
- The names must match what was actually written to disk — in variant A the stripped form
  shown above, with `00 Document Setup.md` as the one exception that keeps its number.
- **Order only folders the scaffold created.** The project folder is the vault, so the `"/"`
  entry lists nothing but our own six folders. (If the assistant later moves a project into
  a vault the user already has, the keys there must carry the full path from *that* vault's
  root and must not include a `"/"` entry — a `"/"` would reorder the user's whole top
  level, because the plugin merges our list in and re-sorts everything else behind it.)
- A folder's `customOrder` lists the **names** of its direct children (files *and*
  subfolders), in the order they should appear — which is exactly the order you created
  them, i.e. the numeric prefixes ascending, with `README.md` and `refs.bib` at the end.
- Include only folders where the order matters. Skip the project folders that hold just a
  README (`20 Research`, `30 Interviews`, …) — there is nothing to sort there.
- With the manuscript-only opt-out, the manuscript files are the children of `"/"` and the
  subfolder keys lose the `10 Thesis/` prefix.
- Keep `"newItemPlacement": "bottom"` — it is the actual cause of the reversal and also
  makes files the user adds later appear at the bottom instead of jumping to the top.
- Names must match the files on disk exactly (including the German renames, if applied).
  A wrong name is not fatal — the plugin drops unknown entries and appends the real file —
  but it costs the intended order for that item.

## Hard rules

- **Write every paragraph as ONE unbroken line.** A single newline inside a paragraph
  becomes `\\` in the output — a forced line break in the middle of the printed sentence.
  Wrapping prose at 80 or 90 columns is a reflex almost everywhere else, and it is wrong
  here. Obsidian soft-wraps the display, so a wrapped paragraph and a single-line one look
  identical on screen; the damage is visible only in the PDF. This holds for the templates
  and for any body text written later. Wrapping is fine inside ` ```remark `, ` ```latex `
  and ` ```dds ` blocks. It applies to LIST ITEMS too - a wrapped item gets the same forced break.
- Only supported Markdown (see `shared/obsitex-conventions.md` and the topic files it points
  to). **If a construct appears in none of them, it is unsupported** — do not invent it, tell
  the user Obsitex does not know it and offer the nearest thing that works.
- **Never write a `.md` file whose first heading has more than one `#`.** One `#` is always
  "the level of the folder I am in". Where the folder limit stops the splitting, the file at
  that level takes its whole substructure inside itself as `##`, `###` — never as sibling
  files. This holds for every template and for anything the skill generates later.
- **Never put a folder inside `Frontmatter` or `Backmatter`** (R10). They already consume the
  one free folder level, so anything foldered inside them silently drops a level. Files only —
  however many. See "How sections are placed" for the two ways out if an appendix outgrows one
  file.
- **A heading needs no blank line before it** (since 2026-08-04). A `#` line ends the running
  paragraph on its own, exactly as in Obsidian and CommonMark. The one exception: a `#` line
  directly under a **list item** is still swallowed by the list — put a blank line there.
- **Write attachment links the way Obsidian's autocomplete would** — shortest path that is
  still unambiguous: bare name while the name is unique in the vault, vault-root folder in
  front of it as soon as it is not (`![[Kapitel 2/aufbau.png]]`). You have no autocomplete
  correcting you, so this is on you. **Never `../`** (Obsitex does not resolve it and falls
  back to the bare name, silently hitting the wrong file) and **never drop the extension**
  (`![[aufbau]]` finds nothing in Obsidian, but Obsitex may embed `aufbau.pdf` instead of the
  picture). When naming files, prefer distinct names over a second `aufbau.png`: a bare-name
  link written today becomes ambiguous the day a namesake appears, and nothing warns.
  Details → `shared/obsitex-conventions.md`, "How to write an attachment link".
- Raw LaTeX only inside ` ```latex ` blocks, always with a leading `%` comment line saying
  what the block does. Prefer Markdown wherever it can express the same thing.
- Never put backslash commands or bare special characters (`_`, `~`, `^`) in inline
  backticks — inline code is passed through raw and breaks or distorts the LaTeX output.
- Do not add preamble packages beyond the template on your own. If the user asks for a
  feature that needs one, add the `\usepackage` line to `00 Document Setup.md` with an inline
  `%` comment explaining what it is for — never inject silently.
- Guidance for the user belongs in ` ```remark ` blocks (ignored by the converter).
  Visible placeholder text must be obviously replaceable ("Replace this paragraph with …").

## Wrap up

Report to the user, in the chat language:

- The created file tree, **one line of purpose per folder**, naming the two terms again:
  which one is the project folder, which one is the manuscript.
- **The one thing that surprises people** (project scaffold only) — explain it, never assume
  it is obvious: Obsidian works on the **whole project folder**, so the order you see and
  drag around is stored once for the entire project. Obsitex, in contrast, converts **only
  the manuscript** — but takes the order of those files from that same project-level
  setting. In short: *the order is managed one level above the folder that gets converted.*
  Sketch it, using the real names:

```
Projektordner                   ← Obsidian opens this one (the vault)
├── .obsidian/…/data.json       ← the order is stored here — for everything below
├── Organisation
├── Manuskript                  ← Obsitex converts only this folder …
│   ├── 00 Document Setup
│   ├── Einleitung                   … and takes its order from above
│   └── …
├── Recherche
└── …
```

  Consequence for the user: reorder wherever it feels natural in Obsidian — it is the same
  setting either way. In Obsitex still pick the manuscript, not the project folder; the app
  finds the order by itself. (Variant B: same picture, only the order sits in the file
  names instead of that file.)
- **State it as a fact, in one sentence:** the project folder is now their Obsidian vault.
  No options, no "unless" — it is simply what was built. Do **not** raise the possibility of
  moving the project into some other vault; that concerns a minority and cannot be explained
  without teaching vaults to someone who may not need the concept at all. The assistant
  handles it if they ever ask.
- Next steps: open the project folder in Obsidian as a vault, fill in
  the chapters top-down, replace `refs.bib` with their own export (e.g. from Zotero), then
  run Obsitex — sign in, **pick the manuscript** (`Thesis` / `10 Thesis`; with the
  opt-out, the project folder itself), Convert, and export (Overleaf / download).
- **Variant A only — switching the add-on on:** the plugin files are copied in but Obsidian
  will not run them until the user does two manual clicks (Claude cannot do these — no UI access to the app, only
  the filesystem). Give this exact sequence:
  1. Settings (gear icon, bottom left) → "Community plugins" ("Community-Erweiterungen")
     in the left sidebar.
  2. If a restricted-mode notice is shown ("Community-Erweiterungen ... können ...
     Sicherheit ... gefährden"), click "Turn on community plugins" ("Community-
     Erweiterungen aktivieren"). This consent screen is intentional — never try to
     pre-set it via a config file.
  3. Under "Installed plugins", find "Flexplorer" in the list and toggle it on.
  Until both steps are done, Obsidian's explorer shows folders above files in alphabetical
  order. Once switched on, the order is already set up correctly (it was
  written along with the plugin), and it can be changed by drag & drop. Updates come
  through Obsidian's plugin manager; deleting `.obsidian/plugins/flexplorer/` removes the
  plugin entirely.
- **Variant A only — where the order lives:** the seed file written next to the plugin now
  holds the order of the whole work. It is worth keeping: do not delete it, and include it
  in backups or version control. Should it ever be lost, the files fall back to
  alphabetical order, which then has to be rebuilt by drag & drop. `00 Document Setup.md` keeps
  its number for exactly this reason — it must stay first even without the add-on, because
  the converter reads the document settings from it.
- **Variant B only — how to reorder:** rename the file; the numbers go in steps of ten so
  a new chapter fits in between (e.g. `25`) without touching the others. Obsidian lists
  folders above files, so the visible order differs from the document order — the
  conversion follows the numbers.
- **Renaming rules** (both variants, important): rename **inside Obsidian**, because only
  then are the wikilinks pointing to that file updated as well. Obsidian asks once whether
  to update them — answer **"Always update"**. Never rename in the file explorer of the
  operating system: the links keep pointing to the old name, and clicking such a link makes
  Obsidian create a **new empty file** under the old name, which hides the damage. If a
  suspiciously empty file with an old name turns up, that is what happened — delete it and
  fix the link.
- A file is excluded from the document with `skip: true` in its frontmatter.
