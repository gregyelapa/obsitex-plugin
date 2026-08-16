# Special characters, escaping and rules

Characters that mean something to LaTeX are escaped automatically. **Type them normally.**

> The general rules are in `obsitex-conventions.md`. This file gives the details.

## Handled for you

```
%  &  $  #  _  ~  ^  <  >  {  }  \
```

All of these are printed as characters, not executed as commands. `~` becomes
`\textasciitilde{}`, `^` becomes `\textasciicircum{}` — the printed symbols, not accents.

**The one place this does not happen is inside inline backticks**, where the content is
passed through raw. To show a special character, leave the backticks off. See
`text-formatting.md`.

## Escaping a Markdown character

A backslash makes a Markdown character literal:

- `\*` → a real asterisk instead of italic
- `\#` → a real hash instead of a heading
- `\_` → a real underscore

**It works only before punctuation**, not before letters or digits.

## Horizontal rules

A line consisting **only** of three or more identical characters — `---`, `***` or `___` —
surrounded by blank lines becomes a full-width rule (`\rule`). Obsidian shows it in reading
view.

**`---` as the very first line of a file starts YAML frontmatter instead.** That is the one
collision to watch.

To get a dash rather than a rule, write `\---` at the start of the line.

## Dashes

Several hyphens **inside** a line are not a rule; LaTeX turns them into typographic dashes:

- `--` → en dash "–" (ranges: "pages 10–20")
- `---` → em dash "—"

These are LaTeX ligatures, not an Obsitex conversion — they happen whether you want them or
not. To keep two literal hyphens, separate them or escape one.

## Traps

- **Emoji break the compilation.** `✅` or `❌` produce `Unicode character not set up for use
  with LaTeX`, one error per occurrence; pdflatex continues and the character is simply
  missing from the PDF. On Overleaf the user sees a red error panel *and* a result, which is
  confusing. Also affects emoji in headings, where they become `___` in the label.
  **Typographic characters are safe:** `→`, `—` and `…` compile fine.
- **A `%` inside inline backticks comments out the rest of the LaTeX line** — silently
  swallowing text. This is the most damaging form of the backtick trap.
