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
  obsitex-init/        command /obsitex:obsitex-init — scaffolds a new vault, runs once
  obsitex-assistant/   starts by itself — companion while writing
```

`ls` hides dot-directories. Use `ls -a`, or read `.claude-plugin/plugin.json` directly.

**Write the commands in full: `/obsitex:obsitex-init` and `/obsitex:obsitex-assistant`.** The
name reads *plugin : command*, and both are called obsitex, so it looks doubled and invites a
shortened `obsitex:init`. That form does not exist. It stood in three files here and reached
the public Notion handbook from them (12.09.2026), where a reader would have typed it and
nothing would have happened.

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

### The template preamble is an original, not a copy

Since 30.09.2026 the ` ```latex-preamble ` block of the templates is the **source** for the
Obsitex app as well (its Iron Rule 4). The app's regression fixture
(`dev/Obsitex/dev/fixtures/TestVault/00 Document Setup.md`) and the SpecialTopicsVault copy the
`simple-thesis` preamble character for character. So when a preamble line changes here:

1. change it in **all three** templates (`academic-paper` is identical to `simple-thesis`,
   `professional-thesis` adds the KOMA part);
2. copy the new `simple-thesis` block into the app's fixture, run
   `node dev/vaultPipelineHarness.mjs --pdf`, then `--update` if only the preamble moved;
3. carry it into the SpecialTopicsVault (German: `english, main=ngerman` for babel, `ngerman`
   for varioref and cleveref).

The DDS block is different: its original stays in the app (`defaultDdsSettings`, mirrored in
`STANDARD_DOCUMENT_SETUP.md`), and the templates deviate from it on purpose in three fields.

## Two repositories — the workbench and the shop window

| | Repo | Holds | Who sees it |
|---|---|---|---|
| **workbench** | `gregyelapa/ObsitexPlugin` (private) | the full history, **every** version | the maintainer |
| **shop window** | `gregyelapa/obsitex-plugin` (public, MIT) | **one commit per published release** | everyone; this is what users install from |

Work happens here, in the workbench — the loop below is unchanged. A version becomes public
only when the maintainer says so:

```
bash tools/publish-release.sh --dry-run    # what would go out
bash tools/publish-release.sh              # one commit "Release vX.Y.Z" + tag
```

The script publishes the **committed** state (it refuses to run on a dirty tree), through a
release clone at `../ObsitexPluginRelease`. **It appends, it never rewrites.** Installed users
update by pulling, and a rewritten public history would break that — so the public repo grows
a list of releases, never the intermediate versions. Not every version has to be published;
skipping one is normal.

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
claude plugin marketplace add gregyelapa/obsitex-plugin
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

## Testing `obsitex-init` without clicking

`tools/init-tests/run.mjs` runs the real skill without a window, once per answer sheet:

```
node tools/init-tests/run.mjs --list              # the test cases
node tools/init-tests/run.mjs TF02                # one run, then its checks
node tools/init-tests/run.mjs                     # all of them
node tools/init-tests/run.mjs TF02 --check <dir>  # checks only, on an existing run (free)
node tools/init-tests/run.mjs TF02 --dry-run      # prepare the folder, print the command
node tools/init-tests/run.mjs TF02 --model haiku  # with another model; a check confirms it from the log
```

It starts `claude -p` with `--plugin-dir` pointing at **this repo** (so no plugin update is
needed, and the check "plugin loaded from this repo" fails loudly if the cache was used),
hands the answer sheet over as system prompt and forbids `AskUserQuestion`. The answer sheets
and their checks live in the Obsidian docs, `ObsitexPlugin/Init-Testfaelle/`: per case an
`INIT_TFxx_<name>.md` (goes to the run) and an `INIT_TFxx_vorbereitung.md` (never does; its
` ```fixture <path> ` blocks are placed in the project folder first, its ` ```checks ` block is
evaluated after). Runs land in `../ObsitexPluginTestruns/<date-time>/`, one folder per case,
with `lauf.jsonl`, `bericht.md` and `zusammenfassung.md`.

- **A run costs real money** (measured 1.93 and 3.91 USD) and takes minutes. Change a check?
  Re-evaluate with `--check`, do not re-run.
- **What it cannot test:** whether the skill *asks* well. Test mode switches exactly that off.
- **A Claude session may not start it itself** (the auto-mode classifier blocks launching an
  agent that writes without asking). The maintainer starts it; Claude reads the results.
- The folder is `export-ignore` in `.gitattributes`, so `publish-release.sh` keeps it out of
  the public repo.
- **Runs are shielded from the maintainer's profile** (since 18.09.2026): they start with
  `--setting-sources project,local`, because `~/.claude/settings.json` grants every session the
  docs folder, where the test cases and their expected results live. A fixed check,
  "Lauf blieb aus der Doku draussen", fails any run whose tool calls name a path in the docs.
- **Never pass `--check` a path you have not confirmed exists.** Until 17.09.2026 an empty value
  fell through to real runs, and a Claude session started two paid TF02 runs that way. The
  script now aborts, but the rule above still holds: from a session, `--list`, `--dry-run` and
  `--check` only.

**The same script tests `obsitex-assistant`** (since 17.09.2026, S17). A case is **one** file
`T<letter><n>_<name>.md` in `ObsitexPlugin/Assistant-Testfaelle/` (`TT` = tables). Only its
prompt reaches the run, which works inside the project folder. Blocks: ` ```vault <target> `
(copy a folder of this repo, e.g. a template) · ` ```append <path> ` (e.g. the marker
`TABLE HERE`) · ` ```card <id> ` (the prompt is that Blueprints card, read from the app's
`promptLibrary.js`, so a changed card is tested as it is now) · ` ```fill <PLACEHOLDER> ` ·
` ```prompt ` (literal instead of a card). Extra checks: `not-matches`, `build-contains` /
`build-lacks` (files of the `pdf` build, e.g. `main.lot`), `skill-used`, `read`. Full list: the
head of `run.mjs`. **After every assistant run, update two places in the docs:** the
"Ergebnisse" table in the case file, and the "Test" column of `Blueprints/BLUEPRINTS_UEBERSICHT.md`
(status sign and date). Nothing updates the overview on its own.

## Project documentation

Vision, implementation decisions and the plugin's own pendencies (S1, S2, …) live in the
Obsidian vault, not here: `Second Brain/01 Projekte/Obsitex/ObsitexPlugin/` — entry point
`00_PLUGIN_INDEX.md` — start with `PLUGIN_WISSENSARCHITEKTUR.md` before adding anything to
`shared/`. The app's own docs are one level up in the same folder. Commits are
journalled in `00_Cockpit/GIT_HISTORY.md`.

That path exists on the maintainer's machine only. **Nothing inside `shared/` or `skills/`
may point at it** — the whole purpose of the plugin carrying its own knowledge is that it
works on a stranger's machine.
