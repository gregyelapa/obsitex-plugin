# The cursor in Obsidian

Finding the spot where the user's cursor stands in Obsidian, and writing there.

> The marker rules (`TABLE HERE`, the short marker beside an element) are in
> `obsitex-conventions.md`, "Which element the user means: the marker". A marker wins over the
> cursor. This file is the second way: for a request that names the cursor or the marked text
> in Obsidian, and for when there is no marker.

## When to use it

- **The user points at a spot without naming it:** "here", "at my cursor", "where I am",
  "at this point", in German "hier", "an dieser Stelle", "da wo ich bin". Read the cursor. Do
  not ask where "here" is before having tried.
- **The request names the cursor or the marked text:** "where my cursor stands in Obsidian",
  "the table where my cursor stands in Obsidian", "the text I selected in Obsidian". The Blueprints tool of the app
  writes these when the user has chosen to point with Obsidian instead of a marker. Read the
  cursor, and do not search for a marker: there is none to find and none to delete.
- **A request needs a spot and no marker is found** in the vault. Read the cursor before
  asking. It turns an open question into a yes or no: "Your cursor is in `30 Methods.md`,
  after the sentence about the sample size. Shall the table go there?"

**The cursor is only as good as the click behind it.** Asked for "here", or by a request that
names the cursor, the user put it there on purpose. Found while looking for a missing marker,
it may be wherever they last typed, so confirm it in that case. Never write at a cursor you
found by accident.

## How it works

Your AI tool (Claude Code, OpenCode, …) and Obsidian are two programs. Only the **running** Obsidian knows where the
cursor is; it is in no file on disk. Obsidian has a command line, and its `eval` command runs
JavaScript inside Obsidian and prints the result. Everything below goes through it. Measured
01.10.2026 and 02.10.2026, Claude Code in VS Code, Obsidian 1.13.7 beside it, never focused.

## Before the first call

1. **Is Obsidian running?** `Get-Process Obsidian`. **If not, do not call `obsidian` at
   all.** The first command starts Obsidian, and a freshly started Obsidian puts the cursor at
   the start of the file (line 0, character 0), so the answer is worthless and the user gets
   a window they did not ask for. Fall back to the marker or to asking.
2. **Is the command line there?** If `obsidian` is not a known command, it is switched off.
   It is off by default: Settings, General, Command line interface, then follow the prompt to
   register it. Tell the user once, then fall back to asking.
3. **`Error: Command "eval" not found`** right after Obsidian started means it is not ready
   yet (measured: the same command worked a few seconds later). Wait briefly and try again
   once. Then a cursor at line 0, character 0 is likely, see below.

## Step 1: read the spot

Replace `<vault name>` with the vault folder's name and `<vault path>` with its full path,
**in lower case and with forward slashes** (`c:/users/anna/thesis`).

```
obsidian vault=<vault name> eval code="const p = app.vault.adapter.basePath.split(String.fromCharCode(92)).join('/').toLowerCase(); if (p !== '<vault path>') throw 'wrong vault: ' + p; const leaf = app.workspace.getMostRecentLeaf(); if (!leaf || leaf.view.getViewType() !== 'markdown') throw 'no markdown tab'; const ed = leaf.view.editor; const r = {file: leaf.view.file.path}; const tc = leaf.view.editMode && leaf.view.editMode.tableCell; if (tc) { const a = ed.offsetToPos(tc.table.start); const b = ed.offsetToPos(tc.table.end); r.table = {first: a.line, last: b.line, header: ed.getLine(a.line), row: tc.cell.row, col: tc.cell.col, cell: tc.cell.text}; } else { const c = ed.getCursor(); const l = ed.getLine(c.line); r.line = c.line; r.ch = c.ch; r.before = l.slice(Math.max(0, c.ch - 40), c.ch); r.after = l.slice(c.ch, c.ch + 40); if (ed.somethingSelected()) { const s = ed.getSelection(); r.selection = {from: ed.getCursor('from'), to: ed.getCursor('to'), length: s.length, text: s.slice(0, 2000)}; } } JSON.stringify(r);"
```

The answer has one of three shapes.

**A plain cursor** in the text:

```
=> {"file":"08 Formulas.md","line":19,"ch":14,"before":"A5 The formula ","after":"$E = mc^2$ is in the text."}
```

- `file` is the path **from the vault root**.
- `line` and `ch` count **from 0**. Obsidian shows line 20 where the answer says 19. Say the
  number the user sees.
- `before` and `after` are up to 40 characters on either side. **Name the spot by them**, not
  by numbers: "in `08 Formulas.md`, between 'The formula' and '$E = mc^2$'".

**A cursor inside a table cell:**

```
=> {"file":"97 Test.md","table":{"first":11,"last":14,"header":"| Year | Count |","row":2,"col":1,"cell":"44"}}
```

- `first` and `last` are the table's first and last line, **from 0**. Name the table by its
  `header` row and the file, and the cell by its content: "the table with the columns Year and
  Count, in the cell '44'".
- `row` counts the header as 0; the line `| --- |` below it is not counted.

**Marked text**, the plain-cursor answer plus a `selection`:

```
=> {"file":"30 Methods.md","line":9,"ch":123,"before":"…","after":"","selection":{"from":{"line":9,"ch":68},"to":{"line":9,"ch":123},"length":55,"text":"The sample comprised 120 people from three cantons."}}
```

- `text` is the marked text, character for character, across several lines if it spans them.
- `from` and `to` are its ends, **from 0**. `from` is always the front, whichever way the user
  dragged.
- **`length` larger than 2000:** `text` is cut off. Read the lines `from`..`to` from the file
  on disk instead.

Works the same from PowerShell and from Bash (measured). The command deliberately contains no
backslash and no `$`, so neither shell changes it on the way.

### Why exactly this command

Four obvious ways look right and fail. Do not "simplify" back to one of them.

| Instead of | What goes wrong |
|---|---|
| `append` / `prepend` of the command line | writes at the start or the end of a file only |
| `app.workspace.activeEditor` | `null` whenever Obsidian is not focused, so always from here: "no active editor" |
| `app.workspace.activeLeaf` | the last thing clicked in Obsidian, which was a **side panel** when measured, not the note |
| `getLeavesOfType('markdown')[0]` | the **first** tab, not the last used one; invisible with one tab, wrong with two |
| `getCursor()` alone, in a table | a table cell has an editor of its own. Measured 02.10.2026: right after a real click, but `line 0, ch 0` (the heading) or the **previous** cell when a cell opened without one. `editMode.tableCell` was right every time, so the command asks it first |

`getMostRecentLeaf()` is the last used tab in the main area. Measured with two tabs open: it
named the one the user had clicked into.

**`vault=` alone is not enough.** It picks the Obsidian window by name, and names repeat:
on the measuring machine five vaults were called `Projekt`. With several windows open, a
command without the path check can land in the wrong vault. **Never drop the check.** If it
fails with another path, stop, say so, and fall back to asking.

## Step 2: check the spot before trusting it

| The answer says | What it means | What you do |
|---|---|---|
| `line 0, ch 0` | very often **not a click**: the position after Obsidian (re)started or opened the file | ask, and name the file |
| `selection`, and the request is about marked text | the text the user means | work on it, step 3b |
| `selection`, and the request wants something **inserted** | the user marked text, but nothing said what for | ask whether to insert there or to replace the marked text |
| `table`, and the request is about an existing table | the table the user means | edit that table in the file, see "Changing the element at the cursor" |
| `table`, and the request wants something **inserted** | the cursor stands inside a table, where nothing new can go | ask, and name the table |
| no `selection`, and the request names marked text | the user did not mark anything, or clicked after marking | ask them to mark it again, then repeat step 1 |
| a file outside the manuscript (notes, templates) | probably not where the text belongs | ask |
| `no markdown tab` | the last tab is a canvas, a PDF or empty | ask |

Otherwise the spot stands, and when the user said "here" you need no further question.

## Step 3: write there

**Never put the text into the command itself.** It would pass through the shell, and the
shell eats backslashes (`\\` becomes `\`), the same damage the hard rule in `SKILL.md`
describes for heredocs. Instead:

1. **Write the text into a file** with the Write tool, **at an absolute path outside the
   vault**: the scratchpad directory if your session names one, otherwise the system temp
   folder (`$env:TEMP` in PowerShell, `$TEMP` in Bash, typically
   `C:\Users\<name>\AppData\Local\Temp`). **Never a bare file name.** In a session inside
   Obsidian the working directory *is* the vault, so `.obsitex-tmp.txt` lands in the
   manuscript (that happened on 02.10.2026). Delete the file after the insert. Write it
   exactly as it must appear: the command inserts the file's content character for character.
   **A table needs an empty line between itself and the text around it** (measured; for any
   other block element, its topic file says what it needs, and a heading needs none).
   Decide from step 1, not from the file you remember: the text goes
   in **at the cursor**, so the line the cursor sits on is where the first line of your text
   lands, and the line above it stays where it is. Cursor on an empty line under a paragraph?
   Then your text starts directly under that paragraph, so begin it with `\n`. Cursor at the
   end of a line of text? Begin with `\n\n`. End the text so that one empty line separates it
   from what follows. Measured 02.10.2026: a table written without the leading `\n` at a
   cursor on an empty line was glued to the sentence above and stopped being a table, in
   Obsidian and in the PDF (`tables.md`). A leading space if the cursor follows a word,
   `\n\n` around it if it is a paragraph of its own. All the rules for manuscript text apply
   (one line per paragraph, straight `"`).
2. **Insert it**, repeating the vault check and checking that file and cursor are still where
   step 1 found them. `<file>`, `<line>` and `<ch>` are the values from step 1; `<text file>`
   is the path from 1., with forward slashes.

```
obsidian vault=<vault name> eval code="const p = app.vault.adapter.basePath.split(String.fromCharCode(92)).join('/').toLowerCase(); if (p !== '<vault path>') throw 'wrong vault: ' + p; const leaf = app.workspace.getMostRecentLeaf(); if (!leaf || leaf.view.getViewType() !== 'markdown') throw 'no markdown tab'; if (leaf.view.file.path !== '<file>') throw 'other file: ' + leaf.view.file.path; const ed = leaf.view.editor; const c = ed.getCursor(); if (c.line !== <line> || c.ch !== <ch>) throw 'cursor moved: ' + JSON.stringify(c); const t = require('fs').readFileSync('<text file>', 'utf8'); ed.replaceRange(t, c); const nl = String.fromCharCode(10); const last = Math.min(ed.lineCount() - 1, c.line + t.split(nl).length); const out = []; for (let i = Math.max(0, c.line - 1); i <= last; i++) out.push((i + 1) + ': ' + ed.getLine(i)); 'inserted at line ' + (c.line + 1) + nl + out.join(nl);"
```

It prints the inserted lines plus one line on either side, **numbered as the editor shows
them** (from 1). Check that the text is there and where you meant it, **and read the first
and the last line of the answer**: they are the neighbours. A line of text directly touching
the first or last line of a table means the empty line is missing. Fix it before you report
success. Above the table: the cursor still stands in front of what you inserted (see below),
so repeat step 1 (it shows the same spot) and insert a file holding a single `\n`. Below the
table: say so and ask, rather than guessing a second position. On 02.10.2026 the answer showed exactly that, and the session reported success
anyway. A text that starts with
a line break leaves the cursor line itself empty, so never judge by that one line alone; on
02.10.2026 a session saw an empty answer from an earlier version of this command and had to
re-read the file to be sure.

**`cursor moved`** means the user clicked elsewhere between your two calls (measured: the
check fires). Do not insert at the new place on your own. Go back to step 1 and name the new
spot.

### What happens after inserting

- **Obsidian saves it to disk on its own**, within four seconds when measured. The converter
  sees it from then on. No further step.
- **The cursor stays in front of the inserted text**, it does not move past it. A second
  insert at the same cursor therefore lands **before** the first one. For several pieces in
  order, write them into one text file and insert once.
- **A backslash pair, both kinds of quotation mark, `$` and umlauts arrive unchanged**
  (measured with `[A \\ B "dq" 'sq' $x^2$ ä]`).

## Step 3b: replace the marked text

For a request about marked text: a quotation, a paraphrase, a footnote, a list made from it.
Same rules as step 3: the new text goes into a file outside the vault first, never into the
command, and it must be the **whole** replacement, the marked words included where they stay.

```
obsidian vault=<vault name> eval code="const p = app.vault.adapter.basePath.split(String.fromCharCode(92)).join('/').toLowerCase(); if (p !== '<vault path>') throw 'wrong vault: ' + p; const leaf = app.workspace.getMostRecentLeaf(); if (!leaf || leaf.view.getViewType() !== 'markdown') throw 'no markdown tab'; if (leaf.view.file.path !== '<file>') throw 'other file: ' + leaf.view.file.path; const ed = leaf.view.editor; const f = ed.getCursor('from'); const to = ed.getCursor('to'); if (f.line !== <from line> || f.ch !== <from ch> || to.line !== <to line> || to.ch !== <to ch>) throw 'selection moved: ' + JSON.stringify([f, to]); const t = require('fs').readFileSync('<text file>', 'utf8'); ed.replaceRange(t, f, to); const nl = String.fromCharCode(10); const last = Math.min(ed.lineCount() - 1, f.line + t.split(nl).length); const out = []; for (let i = Math.max(0, f.line - 1); i <= last; i++) out.push((i + 1) + ': ' + ed.getLine(i)); 'replaced at line ' + (f.line + 1) + nl + out.join(nl);"
```

The values come from step 1's `selection`. **`selection moved`** means the user marked
something else in between: go back to step 1, do not replace the new marking.

**After replacing, the new text is marked** (measured 02.10.2026). A second replace would hit
it. For a footnote, whose definition goes at the end of the file, do the replace first and
then edit the end of the file on disk, which leaves the marking alone.

## Changing the element at the cursor

For a request about an existing element ("the table where my cursor stands in Obsidian"): step 1 tells you
which one, and from there it is an ordinary edit **of the file on disk**, not through
Obsidian. Two things to watch:

- **Read the file again right before editing.** Clicking into a table makes Obsidian pad its
  columns with spaces and save that (measured 02.10.2026). The file you read earlier may be
  stale by those spaces, and an edit that expects the old text fails.
- **A table is found by `table`, every other element by the cursor line:** a heading by the
  line it stands on, a list by the item, a quotation by its paragraph. **"The heading my cursor
  stands on or below"** (the cards that add a heading next to an existing one) is the heading
  line the cursor is on, otherwise the nearest `#` line above it in the same file; a file with
  no `#` line above the cursor means asking. For an image or an
  embedded PDF the line is not measured; name the element you found and confirm it.

## What this does not cover

- **The cursor in VS Code or any other editor.** Claude Code receives a **selection** from
  VS Code, never a bare cursor. If the manuscript is open there, ask the user to mark one
  character.
- **Writing while a table cell is open.** Step 3 inserts at `getCursor()`, and inside a cell
  it is not measured where that lands. When step 1 answers with `table`, never insert; ask.
- **An image or an embedded PDF at the cursor.** Obsidian draws both as a picture in the
  note, like a table, and where the cursor stands after clicking one is not measured.
