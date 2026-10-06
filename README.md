# Obsitex skills: write a thesis in Obsidian, get a LaTeX PDF

Obsitex sets up your thesis or paper as an Obsidian vault and stays with you while you write
it, so that the Markdown you produce converts cleanly to LaTeX and PDF.

These are two **Agent Skills** for an AI coding tool such as Claude Code, Codex or OpenCode.
They are **not an Obsidian plugin** and never show up in Obsidian's interface. They work *on*
your vault, next to Obsidian.

## What they do

**`obsitex-init` sets up the vault.** A short interview asks about your document (thesis or
paper, language, how deep your outline goes, whether chapters live in folders), then writes a
complete project: folders, a skeleton manuscript with real headings, a bibliography file, and
a `00 Document Setup.md` that carries the LaTeX preamble and the conversion settings. Run it
once, at the start. It only runs when you call it.

**`obsitex-assistant` helps while you write.** It starts on its own whenever you ask how to
format something (a table, an image, a citation, a footnote, a cross-reference) or when text
is about to be written into a manuscript file. It answers with Markdown the converter actually
understands, which is not always the Markdown Obsidian renders.

## Requirements

- **An AI coding tool that reads Agent Skills.** Tested with **Claude Code** and **OpenCode**.
  **Codex** reads the same skill folders but has not been tested yet. In Claude Code the setup
  interview shows menus with sketches; in other tools it asks the same questions as plain text.
- **Obsidian** for writing, and the **Obsitex web app** for turning the vault into a PDF.
- **Flexplorer**, an Obsidian plugin that controls file order, is recommended. `obsitex-init`
  installs a pinned copy into your vault for you. You never have to fetch it yourself.
- **Folder notes**, an Obsidian plugin that shows a folder and its folder note as one entry.
  `obsitex-init` downloads it for you from its author's release page (it is not part of this
  repository). If the download fails, you can install it in Obsidian yourself.

## Install

Pick your tool. The easiest way is one message in its chat; the exact commands are below it.

### Claude Code

Send this message in a Claude Code chat:

```
Install the Obsitex plugin for Claude Code from this repository: https://github.com/gregyelapa/obsitex-plugin
```

Or run these two commands in a terminal:

```
claude plugin marketplace add gregyelapa/obsitex-plugin
claude plugin install obsitex@obsitex
```

The first command installs nothing. It only makes this repository known as a source of
plugins (a *marketplace*, which is no more than a list of what is on offer here). The second
command installs the one plugin on that list. `obsitex@obsitex` looks doubled because it reads
*plugin@marketplace*, and here both carry the same name. Claude Code asks you to trust the
repository first. That is expected: a plugin brings code with it.

**Start:** `/obsitex-init` in the folder where the vault should be created. If another command
already has that name, use the full form `/obsitex:obsitex-init`.

**Update:** `claude plugin update obsitex@obsitex` (the full id; `obsitex` alone fails), then
restart the session. `/clear` is not enough: it empties the conversation, not the loaded
plugin.

### Codex and OpenCode

Both read skills from the folder `~/.agents/skills/`. Send this message in the chat:

```
Install the Obsitex skills from https://github.com/gregyelapa/obsitex-plugin. Copy the folders skills/obsitex-init and skills/obsitex-assistant into ~/.agents/skills/ and replace older copies.
```

Or by hand: download this repository and copy the two folders `skills/obsitex-init` and
`skills/obsitex-assistant` into `~/.agents/skills/` (on Windows
`C:\Users\<you>\.agents\skills\`). Copy each folder as a whole. Each one carries its own
`shared/` folder with the converter knowledge, and does not work without it.

Then restart the tool, so that it loads the new skills.

**Start:** in Codex, `$obsitex-init`. In OpenCode, ask for it by name: "Use the obsitex-init
skill to set up my thesis." Do this in the folder where the vault should be created.

**Update:** send the same message again. It replaces the two folders.

## What you get

**Three scaffolds** for the manuscript:

| Scaffold | Document class | Shape |
|---|---|---|
| `professional-thesis` | scrbook | chapters in three areas: front matter, main matter, back matter |
| `simple-thesis` | article | a flat sequence of sections |
| `academic-paper` | article | title block, abstract with keywords, methods, results, discussion |

Each of them can be set up with one file per chapter (or section), or with a folder per
chapter and its sections as files inside.

**Two ways to control the order of your document:**

- **A (recommended):** the Flexplorer plugin in Obsidian carries the order. File names have no
  numbers, and you reorder by dragging files in the sidebar.
- **B:** no plugin. Files are numbered in steps of ten (`10 `, `20 `, …), and you reorder by
  renaming.

**A project scaffold** around the manuscript (organisation, research, interviews, data,
exports), which you can decline. In Obsitex you pick the manuscript folder; the rest is your
workspace.

**An `AGENTS.md`** in the project folder, if you want one. It tells every new chat what was
decided during setup and that the Obsitex assistant is there. Claude Code, Codex and OpenCode
all read it on their own. If you already have a `CLAUDE.md`, it stays yours: it only gets one
line, `@AGENTS.md`, so that Claude Code reads both.

## Layout

```
skills/
├── obsitex-init/               the setup skill
│   ├── SKILL.md
│   ├── shared/                 what the skills know about the converter
│   ├── assets/flexplorer/      pinned copy of the Flexplorer plugin
│   └── templates/              the three scaffolds
└── obsitex-assistant/          the writing companion
    ├── SKILL.md
    └── shared/                 the same converter knowledge
.claude-plugin/                 only for Claude Code: makes this repo installable as a plugin
```

## Terms used throughout

- **Project folder:** the whole workspace. `.obsidian` lives here.
- **Manuscript:** the subfolder Obsitex turns into the document.

When both come up, the name goes first and the environment last: the **Flexplorer** plugin
**in Obsidian** versus the **Obsitex** skills **in your AI tool**. The bare word "plugin" is
ambiguous.

## Licence

MIT, see [LICENSE](LICENSE).

The bundled copy of Flexplorer under `skills/obsitex-init/assets/flexplorer/` is a separate
work by kh4f, also MIT; its licence travels with it in that folder and into every vault it is
installed in.

Folder notes by Lost Paul (AGPL-3.0) is **not** included. `obsitex-init` downloads it
unmodified from https://github.com/LostPaul/obsidian-folder-notes at setup time.
