# Obsitex — a Claude Code plugin for writing a thesis in Obsidian

Obsitex sets up your thesis or paper as an Obsidian vault and stays with you while you write
it, so that the Markdown you produce converts cleanly to LaTeX and PDF.

**This is a plugin for Claude Code, not for Obsidian.** It never shows up in Obsidian's
interface. It works *on* your vault from the terminal.

## What it does

**`/obsitex:obsitex-init` — set up the vault.** A short interview asks about your document
(thesis or paper, language, how deep your outline goes, whether chapters live in folders),
then writes a complete project: folders, a skeleton manuscript with real headings, a
bibliography file, and a `00 Document Setup.md` that carries the LaTeX preamble and the
conversion settings. Run once, at the start.

**`obsitex-assistant` — help while you write.** It starts on its own whenever you ask how to
format something (a table, an image, a citation, a footnote, a cross-reference) or when text
is about to be written into a manuscript file. It answers with Markdown the converter
actually understands — which is not always the Markdown Obsidian renders.

## Requirements

- **Claude Code.** The setup interview uses menus with preview illustrations and Claude
  Code's on-demand loading of skill files. Other agents will run the skill, but with a
  plainer interview.
- **Obsidian** for writing, and the **Obsitex web app** for turning the vault into a PDF.
- **Flexplorer**, an Obsidian plugin that controls file order, is recommended. `obsitex-init`
  installs a pinned copy into your vault for you — you never have to fetch it yourself.

## Install

Two commands in Claude Code. The plugin is installed once per user and is then available in
every folder:

```
/plugin marketplace add gregyelapa/obsitex-plugin
/plugin install obsitex@obsitex
```

Then run `/obsitex:obsitex-init` in the folder where the vault should be created.

## What you get

**Four scaffolds** for the manuscript:

| Scaffold | Document class | Shape |
|---|---|---|
| `professional-thesis` | scrbook | chapters as files, front and back matter |
| `professional-thesis-nested` | scrbook | chapters as folders with subchapters |
| `simple-thesis` | article | a flat sequence of sections |
| `academic-paper` | article | abstract, methods, results, discussion |

**Two ways to control the order of your document:**

- **A (recommended)** — the Flexplorer plugin in Obsidian carries the order. File names have
  no numbers, and you reorder by dragging files in the sidebar.
- **B** — no plugin. Files are numbered in steps of ten (`10 `, `20 `, …), and you reorder by
  renaming.

**A project scaffold** around the manuscript (organisation, research, interviews, data,
exports), which you can decline. In Obsitex you pick the manuscript folder; the rest is your
workspace.

## Layout

```
.claude-plugin/
├── plugin.json                 name and version
└── marketplace.json            makes this repo an installable source
shared/                         what the plugin knows about the converter
├── obsitex-conventions.md      always loaded
└── tables.md, images.md, …     loaded when that topic comes up
skills/
├── obsitex-init/               the setup command
│   ├── assets/flexplorer/      pinned copy of the Flexplorer plugin
│   └── templates/              the four scaffolds
└── obsitex-assistant/          the writing companion
```

## Terms used throughout

- **Project folder** — the whole workspace. `.obsidian` lives here.
- **Manuscript** — the subfolder Obsitex turns into the document.

When both plugins come up, the name goes first and the environment last: the **Flexplorer**
plugin **in Obsidian** versus the **Obsitex** plugin **in Claude Code**. The bare word
"plugin" is ambiguous.

## Development

The installation is a git clone of this repository, not a link to a local folder, so an edit
takes effect only after it is published:

```
1. edit
2. raise "version" in .claude-plugin/plugin.json
3. git add / commit / push
4. claude plugin update obsitex@obsitex     ← the full id; "obsitex" alone fails
5. restart the session
```

That is deliberate: a local test then behaves exactly like a stranger's installation. Further
notes for working on the plugin are in `CLAUDE.md`.

## Licence

MIT — see [LICENSE](LICENSE).

The bundled copy of Flexplorer under `skills/obsitex-init/assets/flexplorer/` is a separate
work by kh4f, also MIT; its licence travels with it in that folder.
