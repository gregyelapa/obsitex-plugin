# ObsitexPlugin — a Claude Code plugin (not an Obsidian plugin)

This repo is the **Obsitex plugin for Claude Code**. It helps a user set up and write a
thesis as an Obsidian vault that the Obsitex web app converts to LaTeX and PDF.

**It is not an Obsidian plugin.** It never appears in Obsidian's interface. Do not look for
`manifest.json` — that is Obsidian's convention. This plugin is described by
`.claude-plugin/plugin.json`.

## Naming: always say which environment

Two different plugins come up in this project, and the confusable pair is not the plugins
but the words *Obsitex* and *Obsidian*. So put the name first and the environment last:

- **Flexplorer** plugin **in Obsidian** — controls the file order in the user's vault
- **Obsitex** plugin **in Claude Code** — this repo

Never write the bare word "the plugin". It is ambiguous, and it has already caused a wrong
answer: asked for "the Obsitex plugin version", a session searched the filesystem for
Obsidian plugins and reported that no such plugin exists.

## Where things are

```
.claude-plugin/
  plugin.json          name + VERSION            ← the version lives here
  marketplace.json     makes this repo an installable source
shared/                the converter knowledge — ONE source, both skills read it
  obsitex-conventions.md   always read at the start of a skill
  tables.md, …             read only when that topic comes up
skills/
  obsitex-init/        command obsitex:init — scaffolds a new vault, runs once
  obsitex-assistant/   starts by itself — companion while writing
```

`ls` hides dot-directories. Use `ls -a`, or read `.claude-plugin/plugin.json` directly.

## The one structural rule

**`shared/` is the single source of the converter knowledge. Never copy a rule into a
skill folder.** Two copies drift, and that drift has already produced a real defect: a
formatting rule existed in one conventions file and not the other, so text was written that
broke the PDF. `skills/obsitex-init/references/` was merged into `shared/` and deleted for
exactly this reason.

Where a rule must reach Claude **without** anything being looked up — because the situation
gives no reason to look anything up — it belongs in the `SKILL.md` of both skills as a hard
rule, with the explanation in `shared/`. The paragraph rule ("write every paragraph as one
unbroken line") is the worked example.

### Splitting `shared/`: conventions vs. topic file

The dividing question is **not** the subject but: *does Claude stumble on it by himself?*

| | `obsitex-conventions.md` — always read | `<topic>.md` — read on demand |
|---|---|---|
| Test | Would he go wrong **without ever looking it up**? | Does he need it only **while doing** it? |
| Character | prohibitions and triggers | instructions |
| Example | "paragraphs on one line" · "`<sub>` lands raw in the PDF" | what a table looks like, which keys it has |
| Length | one line per case | as long as it needs to be |

Two rules follow, and both are there because a violation already cost real work:

1. **A generic mechanism is written once, in the conventions.** A topic file names only its
   own concrete case, never the principle. `tables.md` does not explain what the three levels
   of a formatting answer are — it says "a grey header is level 2, and here is how".
2. **A topic file does not explain an element twice.** When a topic file is added, the
   compact version in the conventions shrinks to what must fire without a lookup; the depth
   **moves**, it is not copied.

Full reasoning, the measured token costs and the incidents behind these rules:
`PLUGIN_WISSENSARCHITEKTUR.md` in the Obsidian docs.

## Development loop — edits do NOT take effect immediately

The installation is a **git clone of GitHub**, not a link to this folder. Changing a file
here changes nothing until it is published:

```
1. edit
2. bump "version" in .claude-plugin/plugin.json
3. git add / commit / push
4. claude plugin update obsitex@obsitex      ← the full id, "obsitex" alone fails
5. restart the session                        ← a running session keeps its old copy
```

**When step 4 fails with `EPERM … rename … obsitex -> obsitex.bak`**, something on Windows is
holding the marketplace folder — an editor with a file from it open is enough, and opening one
to read a rule is the usual way it happens. `update` renames the folder and cannot.

**Shortest fix, measured 15.08.2026 — delete the folder and repeat the update:**

```
rm -rf ~/.claude/plugins/marketplaces/obsitex     # the CLI itself asks for this
claude plugin update obsitex@obsitex              # now succeeds, re-clones the folder
```

If the deletion itself fails, something really is holding it: close the editor tabs pointing
into that folder and try again.

**`claude plugin marketplace add` alone does nothing here** — while the marketplace is declared
in `~/.claude/settings.json` under `extraKnownMarketplaces`, it counts as registered even with
the folder gone. The command answers "already on disk — declared in user settings" and clones
nothing. The four-command sequence below therefore only helps once that declaration is gone:

```
claude plugin uninstall obsitex@obsitex
claude plugin marketplace remove obsitex
claude plugin marketplace add gregyelapa/ObsitexPlugin
claude plugin install obsitex@obsitex
```

**Always verify against the installed copy, never the repo.** The two drift by design:

```
node -e "console.log(require('C:/Users/gmass/.claude/plugins/marketplaces/obsitex/.claude-plugin/plugin.json').version)"
```

Reading the version from this repo answers a different question and has already produced a
wrong answer — a session reported the new version as installed while the clone was one behind.

**Do not read the clone while an update is running.** `update` deletes the folder and writes it
again; in between it is simply absent. A check landing in that gap reports "the folder is gone"
and invites a repair that is not needed — that happened on 15.08.2026. Repeat the check instead
of concluding anything from one miss.

**Three copies, three questions — do not mix them up:**

| Question | Where to look |
|---|---|
| What have I just written? | this repo |
| What will the **next** session load? | `~/.claude/plugins/marketplaces/obsitex` (the one-liner above) |
| What is **this** session using? | the version it started with — **there is no reliable way to read it back** |

The last one is why a restart is needed and `/clear` is not: a running session keeps the cache
folder it started from, whatever the clone says. **`/clear` empties the conversation, not the
loaded skills.**

**Do not try to read the running version off the cache.** Every folder under
`cache/obsitex/obsitex/` carries an `.in_use` marker — measured 15.08.2026, all fifteen of them
from `0.1.0` to `1.7.0`. The marker says nothing about which one is live. If it matters, restart
and start from a known state.

This is deliberate: it makes local testing behave exactly like a stranger's installation.
The earlier junction (`~/.claude/skills/obsitex-init` → this folder) was removed with the
move to a plugin; it would install the same skill a second time.

Useful checks: `claude plugin validate .` · `claude plugin details obsitex` (component
inventory and per-skill token cost) · `claude plugin marketplace list` (shows whether the
source is GitHub or a local directory).

## Verifying converter behaviour — measure, do not assume

The Obsitex app repo (`C:\Users\gmass\dev\Obsitex`, read-only from here unless the task says
otherwise) has a headless harness that runs the real pipeline over any vault:

```
node dev/vaultPipelineHarness.mjs "<vaultDir>" --pdf --outdir "<buildDir>"
```

Build a throwaway vault with the construct in question plus a control case without it, run
it to PDF, and look. Two claims in this repo were wrong before being measured that way — one
about a package that was already loaded, one about colour being impossible in a Markdown
table. **Never write a rule into `shared/` from reasoning alone.**

## Project documentation

Vision, implementation decisions and the plugin's own pendencies (S1, S2, …) live in the
Obsidian vault, not here: `Second Brain/01 Projekte/Obsitex/ObsitexPlugin/` — entry point
`00_PLUGIN_INDEX.md` — start with `PLUGIN_WISSENSARCHITEKTUR.md` before adding anything to
`shared/`. The app's own docs are one level up in the same folder. Commits are
journalled in `00_Cockpit/GIT_HISTORY.md`.

That path exists on the maintainer's machine only. **Nothing inside `shared/` or `skills/`
may point at it** — the whole purpose of the plugin carrying its own knowledge is that it
works on a stranger's machine.
