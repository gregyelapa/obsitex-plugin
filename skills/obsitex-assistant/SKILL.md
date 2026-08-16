---
name: obsitex-assistant
description: Formatting and writing help inside an Obsidian vault that Obsitex converts to LaTeX/PDF. Use when the user asks how to write something so the converter handles it (table, image, citation, footnote, heading, list, cross-reference), when they want a specific look in the finished PDF, or when text is about to be written into a manuscript file. Not for discussing the content or the argument of the work itself.
---

# Obsitex assistant

The user is writing a thesis or paper as Markdown in an Obsidian vault. Obsitex converts
that vault into LaTeX and a PDF. Your job is to make sure everything that lands in those
files is something the converter actually understands.

## Before you write or advise

1. **Read `00 Document Setup.md` from the user's own manuscript — always, not only for
   package questions.** It is the one file that says what this project *is*, and two things
   in it change the meaning of what you write:
   - **`documentLevelIndex`** decides what a `#` becomes. `0` → `\chapter`, `1` → `\section`.
     Never call a `#` a "section" without having looked; in a scrbook project it is a chapter.
   - **the preamble** decides which packages exist. Loading one twice with different options
     is a hard LaTeX error, not a warning.

   **Never answer from the template you remember.** The user has been editing this file for
   months. Reading it costs about ninety lines; guessing costs a broken PDF.
2. **Read `shared/obsitex-conventions.md`** from this plugin — the `shared/` folder sits in
   the plugin root, one level above the `skills/` folder this file is in. It carries the
   overview, the signpost to the topic files, and the list of constructs that silently go
   wrong.
3. **Follow the signpost.** When the request is about a specific element, read that topic
   file before answering. Do not answer a table question from memory when `tables.md` exists.
4. **Never invent syntax.** If a construct appears in neither the overview nor a topic file,
   say plainly that Obsitex does not support it and offer the nearest thing that works.

## Working in the user's vault

- **Creating a note is two steps, never one.** A new `.md` file that nothing points at is
  invisible to the order: write the file **and** enter it in the Flexplorer `data.json` —
  procedure below. Ask first where it goes; do not choose folder, position and name yourself.
- **Do not rename or move a note on your own.** Both break every wikilink pointing at it
  (resolution is file-name based, `links.md`), on top of the `data.json` entry. Only on an
  explicit request, and then all three in one operation: file, entry, and every link that
  named it.
- **Never hand back a task you can do.** When the next step is unclear — which note an
  attachment belongs in, where a new one goes — ask one structured question. Explaining the
  Obsidian route instead leaves the user with half-finished work; that has happened twice
  (`images.md` for the attachment folder, `pdf-embeds.md` for the note after it).
- **An attachment is simpler than a note.** An image, a PDF or a `.bib` file carries no
  heading, stands in no wikilink and has no place in the Flexplorer order — so saving one into
  the vault costs a single step. When the user pastes an **image** into the chat, read the
  Windows clipboard (**procedure in `shared/images.md`**); a **PDF** arrives with its file
  name, so search the disk for it instead (**`shared/pdf-embeds.md`**). Never answer "I cannot
  save the file" without having tried. Saving it and stopping there is no better: the same
  file then goes on to the branch above — which note does it belong in.
- Editing the **content** of an existing file is fine.
- **Match the file naming you find.** Number prefixes (`30 Methodology.md`) mean the order is
  carried by the names; no prefixes mean the Flexplorer plugin in Obsidian carries it. Never
  mix the two.

### Entering a new note in the Flexplorer order

Only in a vault whose order the Flexplorer plugin carries — with number prefixes in the file
names there is nothing to enter, the name alone places the file.

`{vaultRoot}/.obsidian/plugins/flexplorer/data.json`, key `items`. Every key is a folder:
`"/"` for the vault root, otherwise its path **from the vault root** (`"Thesis/Backmatter"`).
Insert the new file name into that folder's `customOrder` array, at the position the user
asked for. Nothing else changes — per-file entries are optional, the plugin fills its own
defaults.

- **No entry for that folder, or no `"sortOrder": "custom"`?** Then the folder is not
  custom-sorted and the file name decides. Leave the file alone and say so — do not impose a
  custom order on a folder that has none.
- **A file missing from `customOrder` is not an error, and that is the danger.** It sorts to
  the **end of its folder** in the document, alphabetically among the other unlisted ones. No
  warning appears, in Obsitex or in Obsidian.
- **A pinned file goes ahead of the whole `customOrder`** — in the document too, not only in
  the sidebar.
- **Then tell the user to restart Obsidian.** Flexplorer reads `data.json` when Obsidian
  starts and keeps the order in memory; a running Obsidian never sees our entry. Two
  consequences: the sidebar shows the new note in the wrong place, and the next drag & drop
  there writes the remembered old order back over our entry. The conversion is unaffected —
  Obsitex reads the stored `data.json`, never what Obsidian holds in memory, so the PDF has
  the right order at once — which is exactly why the mismatch goes unnoticed. Closing Obsidian
  completely and reopening it makes display and file agree. Measured 15.08.2026.

## Hard rules for anything you write

- **Write every paragraph as ONE unbroken line.** A single newline inside a paragraph
  becomes `\\` in the output — a forced line break in the middle of the printed sentence.
  Wrapping prose at 80 or 90 columns is a reflex almost everywhere else, and it is wrong
  here. Obsidian soft-wraps the display, so a wrapped paragraph and a single-line one look
  identical on screen; the damage is visible only in the PDF. Check this before every write
  or edit of body text. Wrapping is fine inside ` ```remark `, ` ```latex ` and ` ```dds `
  blocks. It applies to LIST ITEMS too - a wrapped item gets the same forced break. Background: `shared/obsitex-conventions.md`.
- Only supported Markdown. When unsure, check — do not guess.
- **Never write a `.md` file whose first heading has more than one `#`.** One `#` always
  means "the level of the folder I am in".
- **Never put a folder inside `Frontmatter` or `Backmatter`.** Files only, however many.
- Raw LaTeX only inside ` ```latex ` blocks, always with a leading `%` comment saying what
  the block does. Prefer Markdown wherever it expresses the same thing.
- Never put backslash commands or bare `_`, `~`, `^` in inline backticks.
- Do not add preamble packages on your own. If a wish needs one, add the `\usepackage` line
  to `00 Document Setup.md` with a `%` comment and tell the user.
- Guidance for the user belongs in ` ```remark ` blocks (ignored by the converter).

## How to answer

Assume the user does not know LaTeX. Talk about pages, headings, tables and numbering — not
about environments, document classes or DDS keys. Where a technical name is unavoidable, put
it in parentheses after the plain wording.

When you use a raw LaTeX block, say that Obsidian will show the source in its preview
instead of a rendered table or figure. That surprises people.

Two plugins come up in this project and they are different things — always name the
environment: the **Flexplorer** plugin **in Obsidian** (file order) and the **Obsitex**
plugin **in Claude Code** (this skill). Never say just "the plugin".
