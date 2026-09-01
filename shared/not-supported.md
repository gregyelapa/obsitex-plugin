# Not supported — and what to write instead

The dangerous cases: **Obsidian renders them, the PDF does not, and nothing warns.** They
compile cleanly, so neither an error message nor a test catches them — only reading the PDF
does.

> The short list is in `obsitex-conventions.md` and is always loaded. This file gives the
> replacements.

## HTML tags

Only `<u>` works in body text, and `<br>` inside a table cell. Every other tag is escaped and
printed as visible text — `H<sub>2</sub>O` appears literally in the PDF.

| Written | Write instead |
|---|---|
| `<sub>2</sub>` | `` `\textsubscript{2}` `` — core LaTeX, no package |
| `<sup>2</sup>` | `` `\textsuperscript{2}` `` |
| `<b>`, `<i>` | `**bold**`, `*italic*` |
| `<mark>` | `==highlight==` |
| `<center>` | a raw block with `\begin{center}…\end{center}` |
| `<br>` in body text | a real line break (a newline **is** a `\\`) or a new paragraph |

Subscripts and superscripts are the painful ones: Markdown has **no** other syntax for them,
and a scientific thesis cannot avoid them — formulas, units, exponents. The backtick form is
the answer, and it needs no preamble change.

## Setext headings

```markdown
Title
=====
```

Produces body text **plus** the underline printed as a visible row of `=` characters, with a
forced break in front. And because no heading is created, there is **no `\label`** — every
wikilink aiming at it breaks.

**Write `# Title`.** Watch for this when the user pastes Markdown from elsewhere; it is the
most common import form.

## Reference links

```markdown
See the [documentation][docs].

[docs]: https://example.com
```

The reference stays as literal `[documentation][docs]`, **and** the definition line — invisible
in Obsidian, it is pure plumbing — is printed as its own paragraph. Not just a missing link,
but visible debris.

**Write `[documentation](https://example.com)`.** The same applies to the short form
`[docs][]`.

## Autolinks in angle brackets

`<https://example.com>` does become a link — but the angle brackets stay **visible** around it.

**Write the bare URL** (it is linked automatically) or `[text](url)`.

## Nested emphasis

`*italic **bold** italic*` is not supported: the tokenizer works left to right with one rule
per construct and cannot balance them. Obsidian renders it, Obsitex breaks it.

**Split it into separate spans**, or write the whole phrase as a raw block.

## Emphasis across a line break

A `**…**` pair whose halves sit on two lines is not recognised — the asterisks print as text.
This is the **least detectable defect in the whole converter**: it compiles, Obsidian shows it
correctly, and a golden-file comparison only says "changed", not "wrong".

**Keep each paragraph on one line** and it cannot happen.

## Emoji

Emoji are **not removed**. They go into the `.tex` exactly as you typed them, and Obsitex warns
you about them: the conversion result names every note that contains one. What it cannot do is
make them work, and there are two separate problems.

`✅` and `❌` produce `Unicode character not set up for use with LaTeX`, one error per
occurrence. pdflatex carries on and emits a PDF with the character missing. And an editor may
refuse to let you edit a file that holds an emoji. Overleaf does, for the whole file, because of
a single character.

If either gets in your way, replace the characters in your vault and export again. A future
engine (LuaLaTeX or XeLaTeX with an emoji font) can print them, which is why nothing is deleted
on your behalf.

**Typographic characters are safe:** `→`, `—`, `…`, `©`, `®`, `™` and `°` compile fine, and so
does everything mathematical. It is only real emoji.

## Note transclusion

`![[Note]]` does **not** insert the content of another note. The literal text `![[Note]]`
appears in the PDF — deliberately, so it is noticed.

**Write the content where it belongs**, or link to it with `[[Note]]`.

## Several sources in one citation

`[@a; @b]` is not supported. **Write** `` `\cite{a,b}` ``.

## Block references

`[[Note#^blockid]]` is not resolved; the note name is shown. Link to a **heading**, a **table
caption** or an **image caption** instead — see `links.md`, `tables.md`, `images.md`.
