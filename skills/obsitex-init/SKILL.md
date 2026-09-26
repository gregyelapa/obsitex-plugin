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
| Folder names on disk (project folders, the manuscript) | **chat** |
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
   the bundled Flexplorer plugin files and its seed `data.json` ("Install the Flexplorer
   plugin" below) and the three Folder notes files downloaded from their author ("Install the
   Folder notes plugin" below).

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
     It ships as one template with one file per chapter; a folder per chapter (the default
     of the splitting question in block 3) is built from it by rule.
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
    **Three options, default two levels.** Asked for **every** template, and produced the
    same way for all of them: every template ships flat and is transformed by rule after
    copying. **A folder sketch on every option.** Wording, the
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
│  00 Document Setup         │
│  Front Matter         ›    │
│  Main Matter          ▾    │
│     Switch to Main Matter  │
│     Introduction      ›    │
│     Methodology       ›    │
│     Conclusion             │
│  Back Matter          ›    │
└────────────────────────────┘
 exactly the document order,
 rearrange by dragging
```

*B — numbers in the file names:*

```
┌────────────────────────────┐
│  10 Front Matter      ›    │
│  20 Main Matter       ▾    │
│     30 Introduction   ›    │
│     50 Methodology    ›    │
│     10 Switch to Main…     │
│     80 Conclusion          │
│  90 Back Matter       ›    │
│  00 Document Setup         │
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
| Folder notes | downloaded from its author, then guided activation | the same: it does not depend on the ordering |
| Reordering | drag & drop in Obsidian | rename the file (see the renaming rules in the report) |

In **variant A**, strip the leading `^\d+\s+` from every file and folder name while
copying — including the top-level folders (`Organisation`, `Manuscript`, `Research`, `Interviews`,
`Data`, `Exports`) and the three area folders (`Front Matter`, `Main Matter`, `Back Matter`). The single
exception is `00 Document Setup.md`: it must sort first even when the add-on is not running,
because the converter reads its settings at the position where they stand. Mention this in
the report in one sentence — it is the reason that one file looks different from the rest.

**Watch the chapter folders while stripping.** When a chapter becomes a folder, the folder
and its title file carry the same name (`30 Introduction/30 Introduction.md`). The converter
recognises the title file *by* that match, so both must be stripped together
(`Introduction/Introduction.md`). Strip only one and the file turns into an ordinary
section — silently, with the chapter title landing on the wrong level. The trap is easy to
hit, because the skill creates the folder and its file itself rather than copying them.

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
**every** template. The skill produces the answer the same way for all of them: **copy the
flat template, then build the folders from the rules below** ("Building it by rule").

Every template therefore has two kinds of files:

| Kind | Which files | What happens after copying |
|---|---|---|
| **Fixed** | `00 Document Setup.md`, and in `professional-thesis` everything in `Front Matter/` and `Back Matter/` plus `Switch to Main Matter.md` | the shape never changes. Only the gaps are filled in (cover data, citation style, language) |
| **Chapters** (sections without chapters) | the body files: in `professional-thesis` the other files in `Main Matter/`, in the flat templates the files named in the table under "Building it by rule" | stay as they are for one file per part; become folders by rule for two or three levels |

The fixed files hold the raw LaTeX (cover page, lists, bibliography, the switches). They are
copied and never rebuilt, because a model rewriting them loses backslashes (see "Hard
rules"). The chapter files hold only headings and placeholder text, and nothing is lost when
they are split.

**Why one flat template and no second, nested one** (decided 26.09.2026): until v1.46.0
`professional-thesis` shipped twice, flat and nested. The two copies drifted apart (the
nested one had sections the flat one lacked), and every change had to be made twice. The flat
template now carries every section as `##`, so the rules give exactly the old nested shape:
measured with the converter, the LaTeX of both shapes is identical apart from the labels.

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

**When a file becomes a folder, its level stays the same.** The folder takes the place where
the file stood, and the file moves inside it under the folder's own name: its **folder note**,
which keeps the level the single file had. Only the other files in the folder sit one level
below that folder note. A folder without a folder note adds no
level at all (`shared/headings.md`).

**Two terms, used everywhere in this file:** a folder with a folder note is a **structure
folder** (it adds a level); a folder without one is a **grouping folder** (it only groups
files). A chapter folder is simply a structure folder on the chapter level.

### How sections are placed

Notation: **B** = a section *without* subsections (a leaf), **A** = a section *with*
subsections (a branch).

**One rule covers every case: a leaf is a file, a branch is a folder with its folder note.**
Both sit directly in the folder of their parent, in document order. There is **no** extra folder
between a chapter and its sections: the chapter's folder note already puts everything else in
the folder one level lower.

```
BBABA   →   30 Introduction/
                30 Introduction.md          # Introduction   → chapter (folder note)
                10 Motivation.md            # Motivation     → section
                20 Problem Statement.md     # …              → section
                30 Research Design/                           ← a branch
                    30 Research Design.md   # …              → section (folder note)
                    10 Sampling.md          # …              → subsection
                40 Scope.md                 # …              → section
                50 Outlook/ …
```

**Why a branch gets a folder:** it takes its children along when it is moved. **Why a leaf
gets none:** one folder per section would be pure packaging — that was the first design, and
users reported it as too nested.

**"After" and "below" follow from the tree.** A new section *after* X goes into the same folder
as X. A new section *below* X goes into X's folder; if X is still a single file, it first
becomes a folder (`X.md` → `X/X.md`, its `#` unchanged).

**No grouping folder between a chapter and its sections.** Up to v1.45.0 this skill put the
leaves into a folder `Subchapters` /
`Unterkapitel` / `Subsections`, because the old converter rule needed it to create the section
level. It no longer does, and with the Obsidian plugin Folder notes such a folder shows up in
the file list as a level of its own that the PDF does not have. **Do not create one.** A vault
that already has them works unchanged; leave them alone unless the user asks.

**Elsewhere a grouping folder is fine** wherever the user wants one:
`Front Matter`, `Main Matter`, `Back Matter`, or any folder just to keep files tidy. It adds no
level (`shared/headings.md`), so it never changes the PDF.

**Growing a section into a folder** is a move, not a rewrite: create a folder with the file's
exact name next to it and move the file inside. It becomes the folder note, its `#` stays as
it is. The new subsections go into that folder as files of their own; a `##` block cut out of
the folder note into its own file loses one `#`. Tell the user this — it is the reason the
structure exists.

**The three area folders `Front Matter`, `Main Matter` and `Back Matter` are grouping folders
as well** (`professional-thesis` only). They carry no folder note and add no level: every file
directly inside them becomes a chapter, and a chapter folder inside `Main Matter` has its own
folder note as usual. An appendix that outgrows one file may become a folder with its folder
note right there in `Back Matter`. Its folder note stays a chapter, its parts become sections
(`shared/headings.md`, "When an appendix outgrows one file"). **The one thing never to do
there:** give a file the folder's own name. `Front Matter/Front Matter.md` would be a folder
note and push everything else in `Front Matter` one level down. This is why the switch files
are called `Switch to Front Matter` and `Switch to Main Matter`, never just `Front Matter`.

**The options — three of them, default is two levels:**

- **One file per chapter (flat).** Simplest to look at; a long chapter becomes a long file,
  and its sections sit inside it as `##`. → the template as it is copied
- **A folder per chapter, two levels (default).** The chapter is a folder with its own
  folder note; the sections are separate files right next to it, in the same folder.
  → the template, then "Building it by rule"
- **Three levels.** As above, plus: a section that has subsections of its own becomes a
  folder with its folder note, and its subsections are files inside it, so it takes its parts
  along when moved.
  → as above; the template ships with two levels of headings, so the third level is built on
  top after copying.

**A "level" here is a heading level that gets its own files** — not a folder in the tree.
`Front Matter`, `Main Matter` and `Back Matter` are grouping folders and never count.

The two-level shape mixes both styles on purpose: five chapters become folders with their
sections as files inside, `80 Conclusion and Future Work.md` stays a single file with its two
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
>    10 Motivation.md                     ## Motivation
>    20 Problem Statement.md              ## Problem Statement
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
levels down the left edge — that is what makes "two levels" mean anything. The folder note is
marked as the chapter's own text, right in the sketch. **The three sketches stand here in dialog
order** (recommendation first), which is not the order of the chat message — that is exactly
what the letters are for.

*A — two levels (recommended):*

```
Level 1   30 Introduction/            ← the chapter
             30 Introduction.md          its own text (named like the folder)
Level 2      10 Motivation.md         ← a section, its own file
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
Level 2      10 Motivation/           ← grew on its own, so it gets a folder
                10 Motivation.md
Level 3         10 Background.md
             20 Problem Statement.md
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
  file — the two-level shape does exactly that with `80 Conclusion and Future Work.md` — and
  the skill builds no folders in `Front Matter` and `Back Matter`, so sections there are always
  inside their file. "Most" is the honest word.
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

### Building it by rule — every template

No nested template exists. Copy the flat template **verbatim** as always, then transform it.
Everything below follows [[VAULT_BAUWEISE]] R1 to R6 (renumbered on 26.09.2026; the old
grouping-folder rules are history there); nothing here is new mechanics.

With chapters (`professional-thesis`) a file inside a chapter folder is a **section**. Without
chapters (`simple-thesis`, `academic-paper`) `#` is already a `\section`, so the files inside a
folder are **subsections**. When you talk about them, use the word that fits, never
"subchapter".

**Which files become folders** — body files only:

| Template | becomes a folder | stays a single file |
|---|---|---|
| `professional-thesis` | in `Main Matter/`: `30 Introduction`, `40 Background and Related Work`, `50 Methodology`, `60 Results`, `70 Discussion` | `Switch to Main Matter`, `80 Conclusion and Future Work`, everything in `Front Matter/` and `Back Matter/` |
| `simple-thesis` | `60 Introduction`, `70 Literature Review` | Cover Page, Abstract, the three lists, `80 Conclusion`, Bibliography, Appendix |
| `academic-paper` | `20 Introduction`, `30 Methods`, `40 Results`, `50 Discussion` | Abstract, `60 Conclusion`, Bibliography |

In `professional-thesis` the chapter folders are built **inside `Main Matter/`**, where the
chapter files already lie. `Main Matter/` is a grouping folder and stays one; it never gets a
file of its own name.

**Conclusion deliberately stays flat** in every template — it shows the user that both shapes
coexist in one document and produce the same output. Point that out; it is the cheapest way to
teach the rule.

Front matter, lists and the bibliography never become folders: they carry no substructure. The
appendix stays one file too — an appendix nobody rearranges is better structured with `##`
inside (see "When an appendix outgrows one file" in `shared/headings.md`).

**The transformation, per file** (R2, R3, R1 in that order):

1. Create the folder with the file's exact name: `60 Introduction/`.
2. Move the file into it, name unchanged → it becomes the **folder note** and carries the
   heading of that level (R3). Its single `#` stays a single `#`: a file that becomes a
   folder keeps its level (R2).
3. Move each `##` block out of the folder note into its own file **next to it, in the same
   folder**, named after the heading, and **turn the `##` into a single `#`** (R1). Anything
   above the first `##` — the lead-in — stays in the folder note. No extra folder in between.
4. If the file has no `##` blocks (in `simple-thesis` and `academic-paper` most of them do
   not; in `professional-thesis` every one has them), create two placeholder section files in
   the same style the template uses elsewhere, so the user sees the shape and can fill it.
5. **`professional-thesis` only: two remarks change with the shape.** In the flat template
   they explain the `##`; in the folder shape they must explain the folder. Write them in the
   chat language, like every remark.
   - In the folder note `Introduction`, keep the first sentence of the remark ("Introduce the
     topic: …") and replace the rest with:

     ```
     This file is named like its folder, so it is the chapter's folder note: it carries
     the chapter title, and everything else in this folder belongs under it. The sections
     of this chapter are separate files right next to it, in this folder.

     The rule this template follows: a .md file NEVER starts with more than one #.
     One # always means "the level of the folder I am in". So every file reads the same
     way no matter how deep it sits, and you never count # signs. The level comes from
     where the file lies, which is why moving a file never means editing its headings.

     When a section grows its own subsections, give it its own folder: create a folder
     with the SAME name as the section file, move the file into it, and put the new
     subsection files next to it. That keeps the section and its parts together when you
     move them.

     If you rename this folder, rename this file with it. A folder without a file of its
     own name no longer counts as a level.
     ```

   - In `Conclusion and Future Work`, which stays a file, add this below the existing text of
     its remark:

     ```
     This chapter is deliberately a single file, not a folder. Short chapters do not need
     one. You can mix both styles in the same thesis: a folder where a chapter grows long,
     a plain file where it stays short. Both start with one # and both become a chapter,
     because a file that becomes a folder keeps its level.

     Its two sections live inside this file as ##. That is allowed and often the better
     choice for a short chapter: fewer files, everything on one screen.

     If it does grow: make a folder named like this file, move the file into it, and move
     each ## section into its own file in that folder, dropping one # on the way. This
     file's own # stays exactly as it is: in the folder it becomes the folder note and
     keeps the chapter level.
     ```

   All other remarks stay as they are.

Number prefixes follow the ordering variant, decided in the last question: variant B numbers
the new files `10 `, `20 `, `30 ` in steps of ten; variant A leaves them without prefixes.

**Check before you finish:** every file starts with exactly one `#`, every new folder holds a
file of the same name, and no structure folder sits inside another one: two levels is
the whole budget here (`#` in the folder note = the part itself, the other files in the folder
= one level below). The area folders `Front Matter`, `Main Matter` and `Back Matter` are storage
folders and do not count; a chapter folder inside `Main Matter` is where it belongs.

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

That is not exotic. In the default template a chapter is a folder, a section file next to its
folder note starts at `\section`, so a `###` written while drafting lands on `\subsubsection` — already
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
commented, write `tocdepth` only for *one level shallower*, and then the value is the class
default minus one: **`1` with chapters** (`scrbook` default 2), **`2` without chapters**
(`article` default 3). Never copy the `1` across. In an `article` it keeps only the `1.`
entries, which is *two* levels shallower than `1.1.1` and not what the user picked
(defaults measured for all six classes, `Gliederung_Dimensionen.md`).

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
- **Three area folders, three switch files.** The manuscript holds `00 Document Setup.md` and
  three grouping folders, written as two words each: `Front Matter/`, `Main Matter/`,
  `Back Matter/`. None of them has a folder note, so none adds a level.

  ```
  10 Front Matter/
      10 Switch to Front Matter.md      \frontmatter   first in the folder
      20 Cover Page.md … 80 List of Abbreviations.md
  20 Main Matter/
      10 Switch to Main Matter.md       \mainmatter    first in the folder
      30 Introduction.md … 80 Conclusion and Future Work.md
  90 Back Matter/
      10 About Back Matter.md           explains only, may be deleted
      20 Bibliography.md
      30 Switch to Appendix.md          \appendix      before the first appendix
      40 Survey Questionnaire.md … 60 Declaration of Authorship.md
  ```

  The switch files carry pure LaTeX switches and must keep their position. In variant A they
  are `Front Matter/Switch to Front Matter.md`, `Main Matter/Switch to Main Matter.md` and
  `Back Matter/Switch to Appendix.md`, and their position then rests entirely on the
  Flexplorer order. `About Back Matter` holds only a remark: it controls nothing and produces
  nothing in the PDF.
- **Never a file with the name of its area folder.** `Front Matter/Front Matter.md` would be a
  folder note and push everything else in the folder one level down. That is why the switch
  files are called `Switch to …`.
- **The names of the three area folders and of the four structure files stay English in every
  chat language**, exactly as the older `Frontmatter` and `Backmatter` always did. They are
  fixed names that the assistant and the documentation refer to, not the author's own notes.
  Only their remark texts follow the chat language (see "German adaptation").
- **Spelling in every text:** front matter, main matter, back matter, as two words. Written
  together only as the LaTeX commands `\frontmatter`, `\mainmatter`.
- Prefixless front matter chapters (`# Abstract`, `# Acknowledgements`, `# List of
  Abbreviations`) are automatically unnumbered with a ToC entry — do **not** add `{-}`
  there. In the back matter, `{-}` on a chapter heading emits KOMA's `\addchap`
  (unnumbered + ToC + running header) — used by References, Appendix and Declaration.
- `simple-thesis` has none of this. Its `95 Appendix.md` is an ordinary unnumbered section
  without `\appendix` (the `article` class has no front and main matter), and it stays that way.

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
| Auto-generated titles (ToC, List of Figures, List of Tables) | **do not touch** — the latex blocks stay as they are; babel translates the printed titles itself |
| File names | optional cosmetic rename (file names never create headings); keep the numbering scheme of the chosen variant. **Not** for the three area folders and the four structure files of `professional-thesis`: those keep their English names (see "professional-thesis specifics") |

#### The remarks of the four structure files in a German chat

Do not translate these four freely. Use the wording below **verbatim**, it is agreed
(26.09.2026). The German term follows the English one in brackets: Front Matter (Vorspann),
Main Matter (Hauptteil), Back Matter (Schlussteil). Replace only the ` ```remark ` block; the
` ```latex ` block and the `# Appendix {-}` line stay as they are (the heading itself follows the
document language, see the table above).

`Switch to Front Matter`:

```
Nicht löschen. Diese Datei muss zuoberst in diesem Ordner stehen.

Die Front Matter (Vorspann) ist alles vor dem ersten Kapitel: Titelblatt,
Vorwort, Zusammenfassung, Verzeichnisse. Im PDF sind die Seitenzahlen hier
römisch (i, ii, iii), und die Kapitel haben keine Nummer.
Danach kommt die Main Matter, die eigentliche Arbeit.
```

`Switch to Main Matter`:

```
Nicht löschen. Diese Datei muss zuoberst in diesem Ordner stehen.

Die Main Matter (Hauptteil, auf Englisch oft auch "body") ist die
eigentliche Arbeit, von der Einleitung bis zum Schluss. Ab hier beginnen
die Seitenzahlen neu bei 1, und die Kapitel werden nummeriert (1, 2, 3).
Danach kommt die Back Matter im Ordner Back Matter.
```

`About Back Matter`:

```
Diese Datei erklärt nur. Sie steuert nichts und darf gelöscht werden.

Die Back Matter (Schlussteil) ist alles nach der eigentlichen Arbeit:
Literaturverzeichnis, weitere Verzeichnisse und Anhang. Die Kapitel hier
haben keine Nummer. Der Anhang beginnt erst mit "Switch to Appendix".
Ab dort heissen die Kapitel A, B, C.
```

`Switch to Appendix`:

```
Nicht löschen. Diese Datei muss vor dem ersten Anhang stehen.

Ab hier beginnt der Anhang: Die Kapitel danach heissen A, B, C.
Die Überschrift "Appendix" oben ist das Trennblatt davor.
```

In a German document the heading above reads `# Anhang {-}`; then write "Anhang" instead of
"Appendix" in the last sentence as well.

## Install the Flexplorer plugin

The thesis itself is written **in Obsidian** — Claude Code is the technical layer beside
it, working on the same files — so every scaffold gets the vault layer. Obsidian's core
file explorer always lists folders above files, so the visible order would not match the
document order (confusing especially for professional-thesis, where each switch file must
sit first in its folder, above the chapter folders). Flexplorer fixes the display and adds
drag & drop reordering — the
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
2. Otherwise copy `main.js`, `manifest.json`, `styles.css` **and `LICENSE`** from
   `assets/flexplorer/` (in this skill folder) to `{projectFolder}/.obsidian/plugins/flexplorer/`.
   The licence is MIT, and MIT asks for its notice in every copy, so it travels along.
3. Write the seed `data.json` next to them — see "Seed the Flexplorer order" below.
4. Do **not** write anything else under `.obsidian` — no `community-plugins.json`, no
   app or workspace settings. Enabling the plugin is the user's click, see below. (The one
   other thing that goes there is Folder notes, see "Install the Folder notes plugin".)

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
             ├─ Flexplorer            ( ●— )   ← switch on
             └─ Folder notes          ( ●— )   ← switch on, if it was installed

then: Ctrl+P (Mac: Cmd+P) → "Reload app without saving"   ← without this the order stays hidden
```

The command is called "Anwendung neu laden ohne zu speichern" in a German Obsidian. Typing
"reload" (or "neu laden") into the palette finds it. Closing Obsidian and opening it again works
just as well; the reload is simply quicker (measured 25.09.2026, both plugins, first activation).

Explain the security notice instead of glossing over it: community plugins are third-party
code, Obsidian asks once whether they may run at all — that consent is deliberate and must
never be pre-set through a config file.

**The reload is part of the instruction, not an afterthought.** Switching the add-on on
leaves the file tree exactly as it was — folders on top, everything alphabetical — because
the tree was already built. Say this *before* the user looks, otherwise the unchanged sidebar
reads as a broken setup (measured 16.08.2026: it did).

Only **then ask for confirmation**: does `00 Document Setup` sit at the top, with the chapters
in document order? If the user is unsure whether the plugin is running at all, a simpler
check: right-click a file — the entries *Pin* and *Hide* only appear with Flexplorer active.

**If the order is wrong,** ask first whether the reload was really done — that is the
common cause, and rewriting the file fixes nothing. If it was, have the user close Obsidian
completely and open it again once. Only if the order is still wrong: have the user close
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
      "customOrder": ["00 Document Setup.md", "Front Matter", "Main Matter",
                      "Back Matter", "README.md", "refs.bib"]
    },
    "Manuscript/Front Matter": {
      "sortOrder": "custom",
      "customOrder": ["Switch to Front Matter.md", "Cover Page.md", "Abstract.md"]
    },
    "Manuscript/Main Matter": {
      "sortOrder": "custom",
      "customOrder": ["Switch to Main Matter.md", "Introduction", "Methodology",
                      "Conclusion and Future Work.md"]
    },
    "Manuscript/Back Matter": {
      "sortOrder": "custom",
      "customOrder": ["About Back Matter.md", "Bibliography.md",
                      "Switch to Appendix.md", "Survey Questionnaire.md"]
    }
  },
  "newItemPlacement": "bottom"
}
```

Rules for building it:

- Keys are folders only — never files. The project folder is the key `"/"`; every other key
  is a folder path relative to it, with `/` separators (e.g. `Manuscript/Back Matter`).
- The example is shortened with chapters left out. The real seed lists every child.
- **Each switch file comes first in its folder, and `About Back Matter.md` first in
  `Back Matter`.** In variant A nothing but this seed keeps `\frontmatter` and `\mainmatter`
  in front of the chapters.
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
- **In a structure folder the folder note comes first**, even when its number would
  sort it later: `"Manuscript/Main Matter/Introduction": ["Introduction.md", "Motivation.md",
  "Problem Statement.md", "Research Questions.md"]`. Obsitex puts it first anyway; the
  seed only makes the file list agree.
- Include only folders where the order matters. Skip the project folders that hold just a
  README (`20 Research`, `30 Interviews`, …) — there is nothing to sort there.
- With the manuscript-only opt-out, the manuscript files are the children of `"/"` and the
  subfolder keys lose the `10 Manuscript/` prefix.
- Keep `"newItemPlacement": "bottom"` — it is the actual cause of the reversal and also
  makes files the user adds later appear at the bottom instead of jumping to the top.
- Names must match the files on disk exactly (including the German renames, if applied).
  A wrong name is not fatal — the plugin drops unknown entries and appends the real file —
  but it costs the intended order for that item.

## Install the Folder notes plugin

Obsitex uses the Obsidian plugin **Folder notes** by Lost Paul. It shows a folder and its
folder note as **one** entry, with everything in the folder indented below it, which is
exactly how the converter assigns levels (`shared/headings.md`). Its "Sync folder name"
renames folder and folder note together and so guards the one silent trap of that rule. It is
installed in **both** ordering variants.

**Download it from its author. Never bundle it.** Folder notes is AGPL-3.0. Shipping its
`main.js` from this repository would oblige us to keep its source available; downloading it
from the author's own release page means we distribute nothing. So there is no
`assets/folder-notes/`, and there must never be one.

After scaffolding:

1. If `{projectFolder}/.obsidian/plugins/folder-notes/` already exists, leave it completely
   untouched and note it in the report.
2. Otherwise download the three files of the pinned version **1.8.26** into that folder:

   ```
   https://github.com/LostPaul/obsidian-folder-notes/releases/download/1.8.26/main.js
   https://github.com/LostPaul/obsidian-folder-notes/releases/download/1.8.26/manifest.json
   https://github.com/LostPaul/obsidian-folder-notes/releases/download/1.8.26/styles.css
   ```

   Use `curl -fsSL -o <file> <url>`; curl ships with Windows 10 and later, macOS and Linux.
   The `-f` matters: without it a missing file is saved as an error page instead of failing.
3. **Check the SHA256 of all three** (`sha256sum`, on macOS `shasum -a 256`, in PowerShell
   `Get-FileHash -Algorithm SHA256`):

   ```
   main.js        83d7b91819abac39626349c1b20aef2503a7cb4339334d52115650aec011a216
   manifest.json  d68704cb787fb687a3d6261a77e93d39c9409ef1dab4e37bfc67a6f96b493536
   styles.css     c736732880c7737a30f713d5496f36612a4f64cce96bab0315397ce14b975f6b
   ```

4. **If a download fails or a hash differs,** delete `.obsidian/plugins/folder-notes/`
   completely (a half-installed plugin is worse than none) and say so in the report: the user
   can install it later in Obsidian under Settings → Community plugins → Browse → "Folder
   notes" by **Lost Paul** (similar names exist). The vault works without it; only the file
   list looks less tidy. Do not retry in a loop, and do not fetch the files from anywhere else.
5. Write nothing else. **No `data.json`:** the plugin's defaults are exactly what Obsitex needs
   (name template `{{folder_name}}`, storage location "Inside the folder", "Sync folder name"
   on). No `community-plugins.json` either; switching it on is the user's click (see "Wrap up").

**The pin does not need to chase upstream.** The plugin id `folder-notes` is registered in
Obsidian's community store, so Obsidian's plugin manager offers updates once the user has
switched it on. Change the pinned version only for a reason, and change the three hashes in
the same edit.

## The project `CLAUDE.md` — what the next session will not know

Everything you learned in the interview lives in **this session only**. The next one starts
cold: it finds the result on disk and nothing about the decisions that produced it. Two
things follow, and the second is the one that bites.

1. **The assistant may not start at all.** It is triggered by its description. "Write me
   chapter 3" reads as a content request, so the skill can stay silent and the session then
   writes into a manuscript file without knowing any convention — wrapped paragraphs, typed
   quotation marks. A `CLAUDE.md` in the project folder is loaded by Claude Code on its own,
   independently of that matching.
2. **A file tree shows a state, never a rule.** A later session sees flat files and cannot
   tell "deliberately flat" from "nobody has tidied up yet". It helpfully creates a subfolder
   and breaks a decision it never saw.

So offer to write one. **Offer, never write it silently** — a permanent control file in
someone's own vault is an intervention, and it is asked for in one sentence at the end of
the wrap-up: *"Shall I put a small `CLAUDE.md` into the project folder? It tells a later
session what this project is, so it does not have to guess."* If they decline, say once that
the decisions then live only in the file tree, and drop it.

### What goes in, and what must not

The file has to survive years in a vault you can never reach again. **An outdated rule is
worse than no rule, because it actively teaches something false.** Three sorts of knowledge,
and only two of them belong in the file:

| Sort | Examples | In the file? |
|---|---|---|
| Stands in `00 Document Setup.md` | document language, `documentLevelIndex`, numbering and contents depth, cover data | **no** — a pointer only |
| Measurable on disk | ordering variant, folder depth, manuscript name, scaffold yes/no | yes, **with a date** |
| Nowhere readable | chat language, the *intention* behind a choice | yes, it cannot go stale |
| The conventions themselves | how to write a table, quotation marks, line breaks | **never** — the plugin carries those and can be updated, this file cannot |

The third row is the actual treasure, and the reason the file exists at all.

### The shape

Frontmatter for the facts, prose for the rest. Not a JSON file beside it: JSON is not loaded
automatically, carries no "why" (it has no comments), and the user never sees it. The
frontmatter keys stay **English and unchanged** even in a German project — they are anchors a
later session recognises, not prose. Everything a human reads follows the chat language.

- **`skip: true` must be the first property.** With the project scaffold the file sits
  outside the manuscript and would be ignored anyway; with the opt-out the project folder
  *is* the manuscript, and without `skip` the file becomes a section of the thesis. Write it
  in both cases, it costs nothing and is right everywhere.
- Fill in the real values from the interview. Use `~` for a key that does not apply.

```
---
skip: true
obsitex-manuscript: Manuskript
obsitex-template: professional-thesis
obsitex-ordering: A
obsitex-scaffold: true
obsitex-levels: 2
obsitex-chat-language: de
obsitex-created: 2026-09-03
---
```

| Key | Meaning |
|---|---|
| `obsitex-manuscript` | folder name of the manuscript, as it is on disk |
| `obsitex-template` | `professional-thesis`, `simple-thesis`, `academic-paper`. (Projects built before v1.47.0 may carry `professional-thesis-nested`: the same template, then shipped as a second copy. It means `professional-thesis`; the shape is in `obsitex-levels`.) |
| `obsitex-ordering` | `A` (Flexplorer carries the order) or `B` (number prefixes carry it) |
| `obsitex-scaffold` | `true` with the project folders, `false` with the opt-out |
| `obsitex-levels` | the answer to question 10, **counted exactly as its sketches count**: `1` one file per chapter (B), `2` a folder per chapter (A), `3` three levels (C). A grouping folder (`Front Matter`, `Main Matter`, `Back Matter`) is **never** a level |

**`obsitex-levels` uses the scale of question 10 and no other.** The user chose a number of
*levels* in a dialog that labels them down the left edge. Counting folders on disk gives a
different number for the same answer (option A has one folder on the path but two *levels*;
option B has no folder and is level 1). Two scales for one key make the check below fire on a
vault that is exactly as agreed. **How to measure it on disk:** take the deepest Markdown file,
count the folders above it that have a folder note (a file with the folder's own name inside),
then add one. A folder note does not count its own folder. Grouping folders (`Front Matter`,
`Main Matter`, `Back Matter`, in older vaults `Frontmatter` and `Backmatter`, and the
`Unterkapitel`-style grouping folders of vaults built before v1.46.0) have no folder note, so
they never count. That is exactly how Obsitex itself finds the level.
`Einleitung.md` → 1 · `Einleitung/Einleitung.md` → 1 · `Einleitung/Motivation.md` → 2 ·
`Main Matter/Einleitung/Motivation.md` → 2 · `Einleitung/Motivation/Hintergrund.md` → 3 · in an
older vault `Einleitung/Unterkapitel/Motivation.md` → 2.
| `obsitex-chat-language` | the language the user works in, which is also the language of the folder names |
| `obsitex-created` | the date of this run |

### The body — six to ten lines, in the chat language

Write these points, no more. Plain sentences, no dashes, and nothing the plugin already
teaches:

1. This is an Obsitex project: the Markdown in the manuscript becomes a LaTeX document
   and a PDF.
2. **Only the Markdown files inside the manuscript become the document.** Name the folder.
3. `00 Document Setup.md` decides how the document looks. **It is the truth, read it, never
   answer from a remembered template.**
4. For anything about formatting there is the Obsitex plugin for Claude Code. Use it instead
   of guessing.
5. The intention behind the structure decisions, in one sentence each, and only where there
   was one. *"The user deliberately chose no subfolders."* Skip a decision that was just the
   default.
6. **The ranking, verbatim in meaning:** if this file and the disk disagree, the disk wins.
   This file says what was agreed once, not what is true now.
7. **The check, with its trigger:** *before you create a file or a folder inside the
   manuscript, count its levels on disk (deepest file, then the folders above it that hold a
   file with their own name, plus one; a file with its folder's name does not count its own
   folder). If that differs from
   `obsitex-levels`, ask before writing, and update this file with the answer.* Write the
   counting rule into the file in these plain words, because the next session reads this
   file, not the skill.

Point 7 needs the trigger. Without it the check either never happens or happens on every
question about a table, and both are wrong: the ordering and the depth matter when something
is **created**, not when something is explained.

### Never overwrite an existing `CLAUDE.md`

The user may have written their own, before or after the scaffold. The "project folder
already holds `.md` files" stop at the top of this skill does **not** catch the second case,
and their file may hold months of their own instructions. Losing it is the worst outcome this
section can produce, so the procedure is fixed:

**Step 1 — look, always.** Before anything else, list the project folder and check for a
`CLAUDE.md`. Not from memory, not from what the scaffold wrote: read the directory. **Look
one level up as well** — with the box shape (a project folder inside a larger vault) the
user's own `CLAUDE.md` can sit in the parent. A file up there is never touched; if one is
found, say so and write yours in the project folder as usual, so the two do not contradict
each other.

**Step 2 — pick the branch by what you found, and with it the tool.**

| Found | What you write | Tool |
|---|---|---|
| no `CLAUDE.md` in the project folder | the whole file as above | `Write` |
| a `CLAUDE.md` is there | **only** a block between two markers | `Read` first, then `Edit` |

- **`Write` on an existing `CLAUDE.md` is forbidden.** It replaces the file completely, and
  the user's own instructions are gone without a trace. The same goes for any shell
  redirection (`>`, `>>`, `tee`) — the "never write a `.md` through the shell" rule below
  covers that anyway, and here the reason is a second one.
- **On an existing file:** leave every line of it untouched. Append the marker block at the
  end. On a later run, replace what is between the markers and nothing else, never the file
  around them. Their own frontmatter stays theirs, so put the facts as a small table inside
  the block instead, and say in one sentence that `skip: true` belongs in their frontmatter
  if the file sits inside the manuscript.
- **Markers already present?** Then a previous run wrote them. Replace only what is between
  them and leave the rest, however much of it there is.

```
<!-- obsitex:start -->
… the Obsitex lines …
<!-- obsitex:end -->
```

Obsidian does not display HTML comments, so the two marker lines stay invisible to the user.

**Step 3 — say which branch you took.** One sentence in the report: either "I wrote a new
`CLAUDE.md`" or "you already had one, so I only appended a block to it and left the rest
alone". The user cannot check what they cannot see.

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
- **Never `Write` over a `CLAUDE.md` that already exists.** Look for one before you write,
  in the project folder and one level up. Found one? Then `Read` it and `Edit` only the block
  between the two markers. It may hold months of the user's own instructions, and `Write`
  replaces the whole file without a trace. Procedure: "Never overwrite an existing
  `CLAUDE.md`" above.
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
- **Every folder meant as a level gets its folder note**, the file with the folder's exact
  name; that is what makes it a structure folder. Without it the folder adds no level, silently. Rename folder and folder note together.
  **Never give a file inside `Front Matter`, `Main Matter`, `Back Matter` or any other storage
  folder that folder's name** — it would turn the grouping folder into a level and push
  everything else in it one level down.
- **In `professional-thesis` the switch files stay first:** `Switch to Front Matter` at the top
  of `Front Matter`, `Switch to Main Matter` at the top of `Main Matter` (above every chapter
  folder), `Switch to Appendix` before the first appendix chapter.
- **Never create a grouping folder** (`Subchapters`, `Unterkapitel`, `Subsections`) between a
  chapter and its sections. Sections are files directly in the chapter folder.
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
- **`professional-thesis` only: the three areas, in two or three plain sentences.** The
  manuscript is split into front matter (everything before the first chapter), main matter
  (the actual work, from the introduction to the conclusion) and back matter (bibliography and
  appendix). Each area folder starts with a switch file: it must stay first and must not be
  deleted. `About Back Matter` only explains and may be deleted. In a German chat add the
  German term in brackets: Front Matter (Vorspann), Main Matter (Hauptteil), Back Matter
  (Schlussteil).
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
  3. Under "Installed plugins", find "Flexplorer" in the list and toggle it on, and
     "Folder notes" as well if it was installed.
  4. **Reload Obsidian once:** Ctrl+P (Mac: Cmd+P), type "reload", choose "Reload app
     without saving" ("Anwendung neu laden ohne zu speichern"). Switching the add-on on is not
     enough — the file tree has already been built by then, and the prepared order only takes
     effect after a reload. (Closing and reopening Obsidian does the same.)
  **Say what the user will see, or they will think the setup failed** (measured 16.08.2026 —
  it did read as a defect): until step 4, the explorer keeps showing folders above files in
  alphabetical order, exactly as before. The order itself is ready and correct from the
  moment the files are written; the reload is what makes it visible. Afterwards it can be
  changed by drag & drop. Updates come through Obsidian's plugin manager; deleting
  `.obsidian/plugins/flexplorer/` removes the plugin entirely.
- **Folder notes, whenever it was installed.** In variant B give steps 1 to 4 above for
  "Folder notes" alone. Until the reload in step 4 each folder note still shows as a line of
  its own; that is expected. Then say three things, briefly:
  - leave its settings as they are;
  - never press "Rename existing folder notes", "Switch" or "Create folder notes for all
    folders";
  - never Ctrl-click `Front Matter`, `Main Matter`, `Back Matter` or `attachments`: that click
    creates a folder note there, and inside `Front Matter` it would push every file one level
    down.

  If the download failed, say that instead, with the way to install it by hand (see "Install
  the Folder notes plugin", step 4).
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
- **Last, and as a question:** offer the project `CLAUDE.md` (see the section above). One
  sentence, at the very end, after everything else has been reported. Say what it is for in
  plain words: a later conversation starts without any memory of this interview, and this
  file tells it what the project is. Write it only if they say yes.
