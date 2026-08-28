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
Never invent synonyms ("target folder", "root folder", "the thesis folder"); the whole
point is that the user hears the same word every time.

- **project folder** (de: *Projektordner*) — the folder the whole work lives in. Obsidian
  opens *this* one, so it is also the vault; `.obsidian` (and later `.git`) sit here.
- **the manuscript** (de: *das Manuskript*) — the subfolder Obsitex turns into the document.
  On disk it carries that same name, whatever the template: `Manuscript` (de: `Manuskript`),
  or `10 Manuscript` in variant B. Everything outside it never reaches the PDF.

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

## Open with this

Before the first question, greet the user with the text below, **in the chat language**. The
English wording here is the original; translate it, never paste it untranslated into a German
conversation. This is the one place where the two central terms are introduced, so do not
shorten it away and do not fold it into the first question.

Five things to adapt, then send it as one message:

- **The address `www.obsitex.com` is translated into nothing and dropped from nothing.** It is
  the one place the user is told where the app actually lives, and someone who reads the
  greeting and then looks for Obsitex has no other pointer.
- **The example names in the sketch follow the chat language** (`Thesis` / `Masterarbeit`,
  `Manuscript` / `Manuskript`, …), exactly like the folders you will create later.
- **Re-align the dotted lines** after translating. They are aligned with fixed-width
  characters, so a longer word pushes them out of line.
- **Do not number the folders in the sketch.** Variant A or B is the last question of the
  interview, so the answer is not known yet; "roughly like this" covers it.
- **Project scaffold opt-out:** if the user has already made clear they want a single folder,
  drop the sketch and the two bullet points under it. There is only one folder then, and
  nothing to distinguish; say "your folder" instead.

The wording:

<!-- greeting -->

**Setting up your writing project**

I am your personal Obsitex assistant. AI-supported writing starts before the first word here,
and it does not stop until the PDF is done. I know the logic of the converter: which Markdown
becomes a heading, a numbered figure or a citation, and which one quietly falls apart on the
way. That is two jobs, and I do both.

- **Now: setting the work up.** A few questions, then your thesis has its shape before you
  write the first word. Chapters, sections, bibliography and layout are all in place.
- **Later: writing it.** You never have to call me by name. Just ask how something is done.
  Say you want a table with a grey header row, and you get the table plus the one line that
  produces the shading. The same goes for a figure with a caption, a citation, a footnote or a
  cross-reference to a chapter.

Obsitex builds the finished document. It is a web app at **www.obsitex.com** that turns your
Obsidian vault into LaTeX and a PDF: numbered chapters, a table of contents, figures and
tables with captions, cross-references and a bibliography from your reference manager. You
write in Markdown, the app does the typesetting. No LaTeX knowledge needed, and you can send
the result to Overleaf if you ever want to hand-tune it.

I will build a workspace for the whole thesis, not just for the text. Roughly like this:

```
Thesis                    ←── THE PROJECT FOLDER
│
├── Organisation .......... schedule, tasks, feedback
│
├── Manuscript            ←── THE MANUSCRIPT
│
├── Research .............. literature notes, source PDFs
├── Interviews ............ guides, transcripts
├── Data .................. raw data, figure source files
└── Exports ............... PDF versions you send out
```

Six folders. Two of them have names you will hear from me again and again:

- **The project folder** is the whole work. Obsidian opens this one, so this is your vault.
- **The manuscript** is the one subfolder Obsitex converts. This folder, and nothing else,
  becomes your PDF.

The other four are yours to fill as you go. Nothing you put in them ever reaches the PDF, and
that is exactly the point: your notes, your data and your transcripts stay out of the document
without any effort from you.

A few short questions and I will lay it out for you.

<!-- /greeting -->

## Interview — keep it short

**Assume the user does not know LaTeX.** Everything they read — questions, option
descriptions, the final report — must be plain everyday language: talk about pages,
chapters, headings, page numbers and the table of contents, not about document classes,
packages, environments or DDS. Where a technical name is unavoidable, put it in
parentheses after the plain wording.

**Block 1 — languages first.** Before anything else, ask these two questions together in a
single AskUserQuestion dialog:

1. **Chat language** — which language should the conversation use? **Always ask this, and
   always inside the same dialog as the document language.** If the user has already written
   in a language in this session, put that language first as the top option, but still let
   them confirm it. **Never skip the question, never infer the answer silently** — the chat
   language also decides the folder names on disk, and a decision that visible must not be
   made behind the user's back. A dialog that shows only one question is the bug, not a
   shortcut.
2. **Document language** — which language will the thesis/paper be written in? It may
   differ from the chat language. **No default** — list English first, then German.
   Affects babel options, DDS quotation marks, and the visible headings (see adaptation
   table below). English and German are fully supported; if the user picks another
   language, say honestly that it is untested and adapt generically (babel option, DDS
   quotation marks, translated headings).

From here on, communicate in the chat language — including the remaining questions.

**Blocks 2 and 3 — these nine questions** (AskUserQuestion works well), then use defaults
and tell the user everything can be changed later. All nine apply to every template. Keep the
blocks in this order: first what the finished document looks like, then how Obsitex lays the
files out and keeps them in order.

**The numbers are the order, not a list.** Ask 3, 4, 5, 6, 7, 8, then 9, 10, 11. **Question 8,
the cover data, is the one that drifts:** it is the only free-text question, it needs no
decision, and after it the interview is over, so it reads like a natural closing question. It is
not one. It says what the document *is*, which is block 2, and block 3's whole promise is that
the document is settled before the files come up. Measured 26.08.2026: it was asked after
question 11, as "almost done, one more thing".

### One question per dialog

**Every question from 3 on opens its own AskUserQuestion. The language pair is the only
exception.** So: one dialog for questions 1 and 2 together, then one dialog each. Ten in all,
nine when the template question falls away.

AskUserQuestion can hold four questions at once, and bundling would save clicks. Do not use it.
**The reason is the chat message.** Every question here is prepared by a message written for it
— a sketch, a comparison, a tip. A bundled dialog opens on the first tab while the message
belongs to all of them, and the second question arrives with nothing in front of it. The user
reads a message and answers the question that message prepared. That is the whole mechanism.

**Why the languages may share one dialog:** they are one decision in two halves, asked before
any explanation exists, and neither carries a sketch. Nothing precedes them that could get lost.

**What bundling cost when it was allowed** — kept here because each one shipped and was found by
the user, not by review:

- **The contents-list depth beside the numbering depth.** Its options and its recommendation are
  both written out of the numbering answer. Side by side, they could only be phrased
  conditionally ("at 1.1.1 I recommend this, from 1.1.1.1 on that"), leaving the user to work
  out which half applied — exactly the work the dialog exists to take off their hands.
- **The project structure beside the splitting.** The two heaviest questions of the interview,
  each needing its own picture, arriving as two tabs. The second tab opened while the user was
  still reading the first sketch.
- **Across the block boundary.** Blocks 2 and 3 promise that the document is settled before the
  files come up. A dialog that opens on the contents list with the folder split in the next tab
  breaks that promise in the one place the user actually looks.

**One tip per dialog** still holds (see "Tips" below) — with one question per dialog it is
simply never in question again.

### Option letters — the anchor between the message and the dialog

**Every question that carries a mockup labels its options `A`, `B`, `C`, in the chat message
and in the dialog alike.** The four are: chapters or sections, the project structure, the
splitting, variant A or B.

The letter exists because the two lists need not be in the same order. The chat message is free
to run from coarse to fine, the dialog has to put the recommended option first (the topmost
option holds the focus when the dialog opens, so a quick confirmation must land on the
recommendation). Without an anchor the user has to match sketch to button themselves. With one,
both orders can be right at the same time.

Three rules, or it makes things worse instead of better:

- **The letter always sits directly in front of the name, never on its own.** "A, the folder per
  chapter" — never "take A". A bare letter sends the reader back up to look it up, which is the
  work the letter was supposed to remove.
- **Letters, not numbers.** The splitting question already counts levels 1, 2, 3. An "option 3"
  next to "three levels" is a trap.
- **The same letter for the same thing in both places**, whatever the order. `A` in the sketch
  and `A` in the dialog, even when `A` sits second in the message and first in the dialog.

The letters are per question. Question 11 uses `A` and `B` too, for something else entirely —
that is fine, they live in different dialogs, and the rule above keeps every mention readable
on its own.

**Block 2 — how the document looks**

3. **Top structural level — chapters or sections?** Ask this *before* the template
   question; it decides which templates remain. Details and the illustration the user
   needs: see "Chapters or sections" below.
4. **Template** — only the ones matching the previous answer:
   - with chapters → `professional-thesis` (numbered chapters, front matter with roman
     page numbers, lettered appendices — for master theses and dissertations). This is
     currently the only one; skip the question and say in one sentence what they get.
     It ships in two shapes, picked by the splitting question in block 3:
     `professional-thesis-nested` (default — a folder per chapter) and
     `professional-thesis` (one file per chapter).
   - without chapters → `simple-thesis` (cover page, table of contents, lists of figures
     and tables, chapters, bibliography, appendix — for seminar papers and shorter
     theses) or `academic-paper` (lean: abstract, chapters, bibliography — no cover
     page, no table of contents).
5. **Numbering depth** — how deep should headings be numbered? Default and recommendation:
   up to `1.1.1` in every class. **The option list differs with and without chapters** —
   see "Sectioning depth" below for both tables, the reasoning, and the cross-reference
   limitation that has to be named with the recommendation.
6. **Contents list depth** — same depth as the numbering, or one level shallower? Never
   deeper. Asked **after** answer 5 is in, because the option labels and the recommendation are
   both written out of it; see "Sectioning depth" below.
7. **Citation style** — numeric (default), author–year, or verbose. Maps to the biblatex
   `style=` option in the preamble. Send this tip with the question (see "Tips" below):
   *"💡 **Tip:** If your university asks for a different style, just tell me. It is one word
   in the setup and every citation in the document follows."*
8. **Cover data** (professional-thesis and simple-thesis) — title, subtitle, document
   type (e.g. Seminar Paper / Master Thesis), degree program, author, supervisor. Offer
   to keep the placeholders if the user does not want to decide now. Send this tip with the
   question (see "Tips" below): *"💡 **Tip:** No final title yet? Leave the placeholders
   standing. Tell me any time and I will fill them in."*

**Block 3 — how Obsitex lays the files out and orders them**

This block goes from large to small: first the whole project folder, then how its parts are
split up, then the order of the single files.

9. **Project structure** — full project scaffold (recommended default): six top-level
   folders for the whole research project, with the manuscript in its own subfolder
   (see "Project scaffold" below) — or manuscript only, files straight into the folder.
   **A folder sketch on both options.** Wording and the two sketches:
   see "Project scaffold" → "How to ask it" below.
10. **How the parts are split up** — one file per part, or a folder of files, and how deep?
    **Three options, default two levels.** Asked for **every** template, but produced
    differently: `professional-thesis` has two shipped shapes, the flat templates are
    transformed by rule after copying. **A folder sketch on every option.** Wording, the
    sketches, the depth note and the rules: see "Splitting into folders" below.
11. **How the file order is controlled — variant A or B.** Ask this **last**, but before
    scaffolding: it decides the file names. See "Ordering: variant A or B" below.

## Tips — the hint element

Some settings are worth naming while the user decides, but they must not become a paragraph
nobody reads. For those there is **one** recognisable element: a quote block opened by a light
bulb.

```
> 💡 **Tip:** the sentence, in the chat language.
> A second line at most.
```

**What a tip says, always:** *this is adjustable, tell me and I will change it.* Nothing else.
No reasoning, no LaTeX command, no package name. The command is the skill's business, never the
user's.

Rules, so the element keeps working:

- **At most one tip per question.** Two in a row and the eye starts skipping them, which is the
  very problem this element solves.
- **Two or three lines**, never more.
- It sits **directly under the message it belongs to**, never collected at the end.
- **Never inside `description` or `preview` of an option.** A tip must not tilt a choice. It is
  the reassurance that the choice is not final.
- **A tip that holds for only one of the options says so in its own bold label**, before the
  first word of the sentence: *"Tip, if you go with chapters:"*. Standing under a comparison
  list, an unlabelled tip reads as if it applied to both sides.
- Translate the word "Tip" into the chat language (German: "Tipp"), and keep the tip text free
  of dashes like the rest of the user-facing wording.

Four questions carry a tip today: chapters or sections, numbering depth, citation style and the
cover data. Each one is written out at its own question.

## Ordering: variant A or B (last question)

Obsidian shows the files of the vault in one list, and Obsitex converts them in exactly
that order. There are two ways to control it, and they lead to different file names — so
the answer must be known before any file is written.

**Recommend A clearly** — not only as a parenthesis in the option label, but in the
message next to the question ("I'd strongly recommend the first one"). Still no automatic
default: the user chooses.

- **`A: Change the order freely by drag & drop` (strongly recommended).** A small
  Obsidian add-on (Flexplorer) does the sorting; the skill brings it along and walks the
  user through switching it on. File names stay clean, without numbers.
- **`B: Control the order through the file names`.** Nothing to install. Every file gets
  a number in front (10, 20, 30 …), and reordering means renaming.

The letters are the user's here too, not just the skill's shorthand — they go into the labels
and above the two sketches, exactly as in the other three mockup questions (see "Option
letters").

Show the difference the same way as for the chapters question — **as a chat message before
the call, and as `preview` on both options** (never only in `description`):

*A — drag & drop:*

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

*B — numbers in the file names:*

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
copying — including the top-level folders (`Organisation`, `Manuscript`, `Research`, `Interviews`,
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
— it also just means *task*. *„dein Dokument"* is unambiguous and is what actually comes out
at the end.

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

*A — with chapters:*

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

*B — without chapters:*

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

> *A — with chapters, like a book.* Each main part starts on a new page with a large number.
> Below it you still have section, subsection and more.
>
> *B — with sections, like an essay.* The main parts run on within the text, no page break.
> One outline level less below.

**The dialog labels carry the same letters**, `A: With chapters` and `B: With sections` (see
"Option letters" above). This question has no recommendation, so the two orders match anyway —
the letters are here because all four mockup questions use them, and a system that holds only
sometimes is not one.

- **Look:** with chapters, every chapter starts on a fresh page and its title sits far
  down the page with a big number above it; without chapters, headings simply continue
  in the running text.
- **How many heading levels you get:** chapters add a level at the top, so a document with chapters
  can go six heading levels deep and one without chapters five. Name both numbers and stop
  there — which `#` becomes what, and how deep it is worth going, are not questions for this
  point in the interview.
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

**Send one tip with the chat message of step 1** (the element and its rules: see "Tips"
above). It belongs directly under the difference list, because the large gap above a chapter
title is the one thing in the mockup that looks final and is not:

> 💡 **Tip, if you go with chapters:** That big gap above each chapter title is the classic
> book look. If it feels too much like a book to you, tell me later and I will move the titles
> up, for all chapters at once.

**How you keep that promise** (do not explain this to the user): the line already sits in the
preamble of both professional templates, commented out. Uncomment
`\RedeclareSectionCommand[beforeskip=-1\baselineskip, afterskip=1\baselineskip]{chapter}`
in `00 Document Setup.md`. It is a KOMA command, so it exists with chapters only.

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

**The options — three of them, default is two levels:**

- **One file per chapter (flat).** Simplest to look at; a long chapter becomes a long file,
  and its sections sit inside it as `##`. → template `professional-thesis`
- **A folder per chapter, two levels (default).** The chapter is a folder with its own
  chapter file; the sections are separate files in a `Subchapters` folder next to it.
  → template `professional-thesis-nested`
- **Three levels.** As above, plus: a section that has subsections of its own keeps its own
  folder (with its own `Subchapters` inside), so it takes its parts along when moved.
  → same template plus the `\setcounter` lines below; the template ships with two, so the
  third level is built on top after copying.

**A "level" here is a heading level that gets its own files** — not a folder in the tree. The
collector folder carries no heading and therefore never counts. Count it and every number in
this skill shifts by one.

The nested template mixes both styles on purpose: five chapters are folders with a
`Subchapters` folder, `80 Conclusion and Future Work.md` stays a single file with its two
sections as `##` inside. Point that out — it shows that no chapter *has* to become a folder,
and that both forms produce the same `\chapter` + `\section` in the PDF. Every file, in both
forms, starts with a single `#`.

### How to ask it — a sketch per option, then the depth note

**Use the word from question 3**: "chapter" for the templates with chapters, "section" for the
flat ones. A third word for the same thing is how this question loses people.

**The chat message before the dialog** does two things: it puts the two shapes side by side,
and it says they produce the **same PDF**. The second half is what takes the weight out of the
question — the answer decides how the user works, not how the document looks.

> A chapter grows. So the question is whether a chapter is one file, or a folder with several
> files in it.
>
> ```
> A  A folder per chapter             B  One file per chapter
>
> 30 Introduction/                    30 Introduction.md
>    30 Introduction.md                   # Introduction
>    Subchapters/                         ## Motivation
>       10 Motivation.md                  ## Problem Statement
>       20 Problem Statement.md
>
> 3 files. Reorder without cutting.   1 file. Reorder by cutting and pasting.
>
> C  Like A, one level deeper: a section that grows can have its own folder too.
> ```
>
> All three give exactly the same PDF:
>
> ```
> 1     Introduction
> 1.1   Motivation
> 1.2   Problem Statement
> ```
>
> So you are choosing how you work, not how the document looks. And if a section grows big
> later, it gets its own folder then. Nothing has to be settled about that now.

**C belongs in the message too, not only in the dialog.** It is a third of the choice, and a
letter with nothing to point back to is worse than no letter. One line is enough — the full
sketch is in its `preview`.

**Then AskUserQuestion with three options, each carrying a `preview`.** The previews label the
levels down the left edge — that is what makes "two levels" mean anything. The collector folder
is marked as not being a level, right in the sketch. **The three sketches stand here in dialog
order** (recommendation first), which is not the order of the chat message — that is exactly
what the letters are for.

*A — two levels (recommended):*

```
Level 1   30 Introduction/            ← the chapter
             30 Introduction.md          its own text
             Subchapters/                collector, not a level of its own
Level 2         10 Motivation.md      ← a section, its own file
                20 Problem Statement.md
```

*B — one file per chapter:*

```
Level 1   30 Introduction.md          ← the whole chapter
             # Introduction
             ## Motivation            ← a section, just a line inside
             ## Problem Statement
```

*C — three levels:*

```
Level 1   30 Introduction/
             30 Introduction.md
             Subchapters/
Level 2         10 Motivation/        ← grew on its own, so it gets a folder
                   10 Motivation.md
                   Subchapters/
Level 3               10 Background.md
```

Labels and `description`, two lines each, in dialog order:

- **`A: A folder per chapter, two levels` (recommended)** — "Most sections become files of
  their own, so you rearrange them without cutting text."
- **`B: One file per chapter`** — "One file per chapter, with all its sections written inside
  it. Reordering sections means cutting and pasting text."
- **`C: Three levels`** — "Subsections can become files of their own too. For long work with a
  fine structure."

**Two things the first two lines deliberately do not say**, because both would be untrue:

- **Not "every section".** A section with no structure of its own may stay inside the chapter
  file — the nested template does exactly that with `80 Conclusion and Future Work.md` — and
  R10 forbids folders in `Frontmatter` and `Backmatter` altogether, so sections there are
  always inside their file. "Most" is the honest word.
- **Not "reorder by dragging".** Dragging belongs to the drag & drop variant of **question 11**
  — three questions later, and not the same letters as the ones above. Pick the other one there
  and the order comes from the number in the file name, so reordering is renaming. This option
  must not promise something that has not been decided yet. All three lines therefore compare
  the one thing that holds either way: whether you have to cut text.

**After the answer, send the depth note** as plain chat text — not as a tip (a tip may only say
"this is adjustable", see "Tips"). Hardly anyone wants every level as folders. The note is not
there to sell the depth; it is there so the ceiling is visible and the system stops looking
arbitrary.

*With chapters:*

> Deeper is possible. Folders nest as far down as your document class has headings.
>
> **Your work has chapters, so there are six levels:** chapter, section, subsection,
> sub-subsection, paragraph, subparagraph. LaTeX has nothing below that.
>
> Folder depth and `#` lines add up: a file on level 2 with a `##` inside it sits on level 3.
>
> Want to go deeper at some point? Tell me and I will set up what it takes.

*Without chapters* — the same note, one level lower throughout, because the chapter in front is
missing:

> **Your work has no chapters, so there are five levels:** section, subsection, sub-subsection,
> paragraph, subparagraph.

**Keep the note to the levels themselves.** What "what it takes" means — numbering has to be
deepened past level 3 or a cross-reference points at the wrong place, and from level 5 (level 4
without chapters) the heading runs into the body text — is a LaTeX matter, not a folder matter.
Two warnings about typesetting inside a question about folders is more than the user can hold,
and the numbering was already settled in block 2. **Say it only if the user actually goes
deeper**, and then follow "Sectioning depth" below.

**Three levels is as deep as the skill builds.** Deeper is the user's own move later, and the
note is what turns it into a move they can make instead of a wall they run into. Beyond three,
the deepest files land where LaTeX stops setting headings as headings and the numbering
question has to be reopened — see "Sectioning depth" below. Two levels leave room for a `##` or
`###` inside the file before that line is reached, which is why two is the default.

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

**Send one tip with question A** (the element and its rules: see "Tips" above):

> 💡 **Tip:** Numbers that run deep quickly make a text look technical. If it bothers you once
> you see the PDF, tell me and I will change the depth.

### Question B — contents list depth

**Opened after answer A is in** — answer A is what makes this question answerable at all. Like
every question here it gets its own dialog (see "One question per dialog").

| Option | `tocdepth` |
|---|---|
| Same depth as the numbering | = `secnumdepth` |
| One level shallower | = `secnumdepth` − 1 |

**Label the options with the actual numbers, not with a comparison.** Option 1 is answer A's
number as it stands; option 2 is that number with one segment taken off (`1.1.1` → `1.1`).
That arithmetic is the same with and without chapters. The comparison belongs in the
description line underneath, where it explains the number instead of replacing it. After
answer A = `1.1.1`, in the chat language:

> **Also down to 1.1.1** *(recommended)*
> As deep as the numbering. Three levels stay easy to take in.
>
> **Only down to 1.1**
> One level shallower than the numbering.

**Exactly one option carries the recommendation, and answer A decides which:** at `1.1.1`
recommend *same depth* (three levels are already sparse); at `1.1.1.1` or deeper recommend
*one level shallower*, or the list outgrows a page and stops giving an overview. Never write
both cases into the option texts — that is the conditional wording the split exists to avoid.

**Never offer a contents list deeper than the numbering.** Its entries would sit unnumbered
at the same indent as their siblings' titles, and the indentation stops showing the hierarchy.

### The block to write

Always write it, in every case — at the recommended depth every line stays commented out.
Comments in **English**, like the rest of the preamble, whatever the chat language was.

**One exception, and it is not a comment: the two words inside `\crefname` are printed.** They
follow the **document** language, so in a German document the block carries
`\crefname{paragraph}{Absatz}{Absätze}` and
`\crefname{subparagraph}{Unterabsatz}{Unterabsätze}`. Write the block in the document language
from the start; do not write English and translate later. Leaving the English pair in a German
document raises no error — it prints `paragraph 1.1.1.1.1` in the middle of a German sentence
(measured 26.08.2026). Every other level looks after itself: a reference to a `\subsection`
prints `Abschnitt 1.1.1` on its own, because `cleveref` ships the German names.
`\paragraph` and `\subparagraph` are the two it does not know — which is why they are the only
ones that need a `\crefname`, and the only ones that can come out in the wrong language.

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

### How to ask it — point back, then show both folders

The two terms are **not** introduced here. The greeting already did that, with the same sketch
(see "Open with this"). Repeating the introduction reads as if the user had not been paying
attention. **Point back to it instead**, then let the two sketches carry the choice.

The chat message before the dialog, in the chat language, roughly:

> Back to the two folders from the beginning. Now you decide whether I actually lay them out
> that way.
>
> The **project folder** holds everything. **The manuscript** is the one folder inside it that
> becomes your PDF. Anything outside stays out of the document, without you doing a thing.

Then AskUserQuestion with **a sketch as `preview` on both options** — same mechanics as the
chapters question: both options need one, or the dialog does not switch to the side-by-side
layout. Example names follow the chat language, folder numbers are left out (variant A or B is
not settled yet).

*A — full project scaffold (recommended):*

```
Master Thesis/          ←── the vault you open in Obsidian
├── Organisation/
├── Manuscript/         ←── this one becomes your PDF
├── Research/
├── Interviews/
├── Data/
└── Exports/
```

*B — manuscript only:*

```
Master Thesis/          ←── the vault, and the manuscript in one
├── 00 Document Setup.md
├── Introduction.md
├── Methodology.md
└── …

everything in here becomes your PDF
```

Labels and `description`, two lines each:

- **`A: Full project scaffold` (recommended)** — "Six folders for the whole project. Only the
  manuscript becomes the PDF, everything else stays out by itself."
- **`B: Manuscript only`** — "One folder, just the text files. Notes, sources and data you file
  somewhere else yourself."

**Name the two sketches `A` and `B` in the chat message as well** (see "Option letters"), so
the sketch above and the button below are visibly the same thing.

Unless the user opted out, create these six folders in the project folder. Folder names
follow the **chat language** — see "Which language governs what" above; nobody but the author
ever sees them. The numbers below apply to **variant B**; in variant A drop them
(`Organisation`, `Manuscript`, `Research`, …):

| English | German | Purpose |
|---|---|---|
| `00 Organisation` | `00 Organisation` | proposal/exposé, schedule, open tasks, meeting notes, supervisor feedback |
| `10 Manuscript` | `10 Manuskript` | **the manuscript — the folder the user selects in Obsitex**; the template is copied in here |
| `20 Research` | `20 Recherche` | literature notes per source, source PDFs, interim analyses |
| `30 Interviews` | `30 Interviews` | guides, transcripts, evaluations |
| `40 Data` | `40 Daten` | raw data, analysis scripts, figure source files (draw.io, Excalidraw, …) |
| `90 Exports` | `90 Exporte` | frozen PDF states (e.g. "draft sent to supervisor") |

- **The manuscript folder carries the same name for every template** — never `Thesis`,
  never `Paper`, never `Arbeit`. The user hears "the manuscript" and sees `Manuskript`; one
  word for one thing is the whole point of the two terms above.
- Put a short `README.md` into each project folder (in the **chat language**): one or two
  sentences on what belongs there — plain Markdown, these folders are outside the
  converter, so no remark blocks and no converter conventions apply.
- **The manuscript's README needs `skip: true` as its first property** — it is the one README
  that lies *inside* the converted folder, so without it the explanatory text becomes a section
  of the thesis (measured 16.08.2026: it did). Write the frontmatter first, then the text:

  ```
  ---
  skip: true
  ---
  ```

  Let the file teach its own mechanism: name `skip: true` in the text as the way to take any
  file out of the document temporarily, and say that this README carries it. The other READMEs
  sit outside the manuscript and need nothing.
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
   Copy with a plain `cp`, never by reading a template and writing its content out again.
2. Then adapt in place **with the Edit tool, never through the shell** (see "Hard rules":
   the shell eats one backslash of every `\\` pair and silently flattens the cover page):
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
| `00 Document Setup.md`, **babel** | option `english` → `english, main=ngerman`. `english` **stays in the list**, and `main=` names the document language explicitly so the order inside the brackets does not matter. Dropping `english` breaks the build under TeX Live 2026: varioref always executes its own `english` option, and without babel's English `\extrasenglish` is an empty shell (`\relax`) that varioref turns into an endless self-call at `\begin{document}`. Put the reason on the line so it can be removed later: `% english only for latex2e#2112 (varioref under TL2026), obsolete once v1.6j ships`. Fixed upstream in varioref v1.6j, LaTeX release 2026-11-01. |
| `00 Document Setup.md`, **varioref/cleveref** | option `english` → `ngerman` (these two really do switch over) |
| `00 Document Setup.md`, **`\crefname` in the sectioning-depth block** | `{paragraph}{paragraph}{paragraphs}` → `{paragraph}{Absatz}{Absätze}`, and `{subparagraph}{subparagraph}{subparagraphs}` → `{subparagraph}{Unterabsatz}{Unterabsätze}`. These two words are **printed**, unlike the comments around them. Applies whether the lines are commented out or live — a commented line is the one someone uncomments later. All other levels need nothing: `cleveref` ships the German names and prints `Abschnitt 1.1.1` by itself. Measured 26.08.2026. |
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

then: close Obsidian and open it again      ← without this the order stays hidden
```

Explain the security notice instead of glossing over it: community plugins are third-party
code, Obsidian asks once whether they may run at all — that consent is deliberate and must
never be pre-set through a config file.

**The restart is part of the instruction, not an afterthought.** Switching the add-on on
leaves the file tree exactly as it was — folders on top, everything alphabetical — because
the tree was already built. Say this *before* the user looks, otherwise the unchanged sidebar
reads as a broken setup (measured 16.08.2026: it did).

Only **then ask for confirmation**: does `00 Document Setup` sit at the top, with the chapters
in document order? If the user is unsure whether the plugin is running at all, a simpler
check: right-click a file — the entries *Pin* and *Hide* only appear with Flexplorer active.

**If the order is wrong,** ask first whether Obsidian was really restarted — that is the
common cause, and rewriting the file fixes nothing. Only if it was: have the user close
Obsidian **completely** (a running plugin rewrites the file on the next save), write the
`data.json` again, then reopen Obsidian.

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
      "customOrder": ["Organisation", "Manuscript", "Research",
                      "Interviews", "Data", "Exports"]
    },
    "Manuscript": {
      "sortOrder": "custom",
      "customOrder": ["00 Document Setup.md", "Frontmatter", "Main Matter.md",
                      "Introduction.md", "Backmatter",
                      "README.md", "refs.bib"]
    },
    "Manuscript/Frontmatter": {
      "sortOrder": "custom",
      "customOrder": ["Front Matter.md", "Cover Page.md", "Abstract.md"]
    }
  },
  "newItemPlacement": "bottom"
}
```

Rules for building it:

- Keys are folders only — never files. The project folder is the key `"/"`; every other key
  is a folder path relative to it, with `/` separators (e.g. `Manuscript/Backmatter`).
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
  subfolder keys lose the `10 Manuscript/` prefix.
- Keep `"newItemPlacement": "bottom"` — it is the actual cause of the reversal and also
  makes files the user adds later appear at the bottom instead of jumping to the top.
- Names must match the files on disk exactly (including the German renames, if applied).
  A wrong name is not fatal — the plugin drops unknown entries and appends the real file —
  but it costs the intended order for that item.

## Hard rules

- **Never write a `.md` file through the shell.** An unquoted heredoc (`<<EOF`), `echo`,
  `printf` or a `sed` replacement eats one backslash of every pair: `\\` silently becomes
  `\`. In a ` ```latex ` block that deletes the forced line break the `\\` stands for, and in
  a ` ```dds ` block it breaks the JSON. **Nothing warns**, because damaged LaTeX still
  compiles: on the cover page the three `tabbing` lines then print on top of each other
  (measured 24.08.2026, professional-thesis). Use the file tools (Write, Edit) for every
  `.md` file. Copy templates with a plain `cp`, which does not touch the content, and edit
  the copy afterwards. Whenever you touched a file that holds a ` ```latex ` or ` ```dds `
  block, compare it against its template before you report done:
  `grep -c '\\\\' "<file>"` must give the same number for both.
- **Write every paragraph as ONE unbroken line.** A single newline inside a paragraph
  becomes `\\` in the output — a forced line break in the middle of the printed sentence.
  Wrapping prose at 80 or 90 columns is a reflex almost everywhere else, and it is wrong
  here. Obsidian soft-wraps the display, so a wrapped paragraph and a single-line one look
  identical on screen; the damage is visible only in the PDF. This holds for the templates
  and for any body text written later. Wrapping is fine inside ` ```remark `, ` ```latex `
  and ` ```dds ` blocks. It applies to LIST ITEMS too - a wrapped item gets the same forced break.
- **Ask the eleven questions in their numbered order.** No question is held back for the end
  because it feels like a good closing question. The cover data (8) is the one this happens to,
  and it happened: asked after question 11, as "almost done, one more thing". It belongs in
  block 2, before a single file question.
- **One question per dialog, from question 3 on.** Never two in one AskUserQuestion, however
  well they seem to pair. Each one is prepared by a chat message written for it; a second tab
  arrives with nothing in front of it. The language pair is the only exception, and it is the
  next rule.
- **The first dialog always carries both language questions.** Chat language and document
  language, together, before anything else. Reading the chat language off what the user has
  written so far is an offer for the top option, never a reason to drop the question: it also
  names the folders on disk. One question alone in that dialog means the rule was broken.
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

Write your answers without dashes, neither the long one (em dash) nor the short one (en dash).
Use a full stop, a comma, a colon or brackets instead. A dash pushes a side thought into the
middle of a sentence, and the sentence then has to be read twice. Hyphens in compound words
are fine. This applies to what you say, never to what the user has written.

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
  run Obsitex — sign in, **pick the manuscript** (`Manuscript` / `10 Manuscript`; with the
  opt-out, the project folder itself), Convert, and export (Overleaf / download).
- **Variant A only — switching the add-on on:** the plugin files are copied in but Obsidian
  will not run them until the user does this by hand (Claude cannot — no UI access to the app, only
  the filesystem). Give this exact sequence:
  1. Settings (gear icon, bottom left) → "Community plugins" ("Community-Erweiterungen")
     in the left sidebar.
  2. If a restricted-mode notice is shown ("Community-Erweiterungen ... können ...
     Sicherheit ... gefährden"), click "Turn on community plugins" ("Community-
     Erweiterungen aktivieren"). This consent screen is intentional — never try to
     pre-set it via a config file.
  3. Under "Installed plugins", find "Flexplorer" in the list and toggle it on.
  4. **Close Obsidian and open it again.** Switching the add-on on is not enough — the file
     tree has already been built by then, and the prepared order only takes effect on the
     next start.
  **Say what the user will see, or they will think the setup failed** (measured 16.08.2026 —
  it did read as a defect): until step 4, the explorer keeps showing folders above files in
  alphabetical order, exactly as before. The order itself is ready and correct from the
  moment the files are written; the restart is what makes it visible. Afterwards it can be
  changed by drag & drop. Updates come through Obsidian's plugin manager; deleting
  `.obsidian/plugins/flexplorer/` removes the plugin entirely.
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
