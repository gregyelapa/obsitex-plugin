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

Pick your tool. The easiest way is one message in its chat. **You do not need git.** The
message downloads this repository as a zip archive and copies two folders out of it.

**Updating works the same way:** send the same message again. It replaces the two folders.
Then restart the tool, so that it loads the new version.

Each skill folder holds a file `VERSION` with the installed version number.

### Claude Code

Claude Code reads skills from the folder `~/.claude/skills/`. Send this message in a Claude
Code chat:

```
Install the Obsitex skills for Claude Code. No git is needed. Download https://github.com/gregyelapa/obsitex-plugin/archive/refs/heads/main.zip, unpack it, and copy the folders skills/obsitex-init and skills/obsitex-assistant into ~/.claude/skills/, replacing older copies. If claude plugin list shows an Obsitex plugin, remove it first with claude plugin uninstall obsitex@obsitex and claude plugin marketplace remove obsitex. If no download tool works, tell me how to do it by hand. At the end, show the contents of ~/.claude/skills/obsitex-init/VERSION. Then tell me to restart Claude Code before I use the skills.
```

**If you installed Obsitex as a Claude Code plugin before** (up to version 1.66): the message
removes the old plugin first, so the skills do not exist twice. The plugin needed git, and a
plugin installed without git never received an update.

**Start:** `/obsitex-init` in the folder where the vault should be created.

### Codex and OpenCode

Both read skills from the folder `~/.agents/skills/`. Send this message in the chat:

```
Install the Obsitex skills. No git is needed. Download https://github.com/gregyelapa/obsitex-plugin/archive/refs/heads/main.zip, unpack it, and copy the folders skills/obsitex-init and skills/obsitex-assistant into ~/.agents/skills/, replacing older copies. If no download tool works, tell me how to do it by hand. At the end, show the contents of ~/.agents/skills/obsitex-init/VERSION. Then tell me to restart this tool before I use the skills.
```

**Start:** in Codex, `$obsitex-init` (or `/skills` and pick it from the list). In OpenCode,
`/obsitex-init`. Do this in the folder where the vault should be created. Neither tool starts
it on its own when you only describe what you want.

### By hand

1. Download https://github.com/gregyelapa/obsitex-plugin/archive/refs/heads/main.zip and
   unpack it.
2. Copy the two folders `skills/obsitex-init` and `skills/obsitex-assistant` into your tool's
   skills folder:
   - Claude Code: `~/.claude/skills/` (on Windows `C:\Users\<you>\.claude\skills\`)
   - Codex and OpenCode: `~/.agents/skills/` (on Windows `C:\Users\<you>\.agents\skills\`)
3. Restart the tool.

Copy each folder as a whole. Each one carries its own `shared/` folder with the converter
knowledge, and does not work without it.

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
│   ├── VERSION                 the version number
│   ├── shared/                 what the skills know about the converter
│   ├── assets/flexplorer/      pinned copy of the Flexplorer plugin
│   └── templates/              the three scaffolds
└── obsitex-assistant/          the writing companion
    ├── SKILL.md
    ├── VERSION
    └── shared/                 the same converter knowledge
.claude-plugin/                 kept for earlier plugin installations, so they still update
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
