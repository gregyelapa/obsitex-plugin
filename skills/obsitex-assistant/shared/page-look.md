# Font and line spacing

Both live in the `latex-preamble` block of `00 Document Setup.md`, one line each. Change that
line, nothing else; never add a font package anywhere else.

Every combination below was compiled against the preamble of **all three templates**
(`simple-thesis`, `professional-thesis`, `academic-paper`) with pdflatex (MiKTeX, 12.10.2026).
**Offer nothing that is not on this list.** Two fonts that look like obvious choices failed
that test (see the end).

## The font

The templates ship with this line:

```latex
\usepackage{lmodern} % crisp Latin Modern font
```

Latin Modern is the classic LaTeX look. It is fine, and many readers recognise it at once
as "made with LaTeX". It looks thin and a little old fashioned to some.

### When the user wants a different one

**Never pick for the user.** Present the options below, in the user's language: the name,
how it looks and feels, and what it suits. Then let them choose. Change nothing before they
have chosen. Recommend Libertinus if they ask for a recommendation: it needs the smallest
change and keeps the math matching.

| Font | Looks and feels | Replaces the `lmodern` line with | Also |
|---|---|---|---|
| **Latin Modern** (current) | Classic LaTeX. Thin, elegant, a little old fashioned. | (unchanged) | |
| **Libertinus** | Warm, bookish, modern. Calm for long texts. Matching math. | `\usepackage{libertinus}` and `\usepackage{libertinust1math}` | nothing |
| **Charter** | Sturdy and very legible, also on screen and in print at small sizes. Matching math. | `\usepackage{XCharter}` and `\usepackage[xcharter]{newtxmath}` | **remove the `amssymb` line** |
| **Palatino** | Classic and elegant, like a well made book. Matching math. | `\usepackage{newpxtext}` and `\usepackage{newpxmath}` | **remove the `amssymb` line** |
| **Fira Sans** | Without serifs. Clean and technical, the most modern look. | `\usepackage[sfdefault]{FiraSans}` | formulas stay in the classic LaTeX font |
| **Lato** | Without serifs. Friendly and open. | `\usepackage[default]{lato}` | formulas stay in the classic font; **no small caps** (falls back to normal letters) |

**The `amssymb` line is not optional to remove for Charter and Palatino.** Their math packages
define the same symbols, and loading both stops the build with
`Command '\Bbbk' already defined`. The symbols themselves stay available. Comment the line out
with `%` and say why in the comment, so the user can find it again:

```latex
% \usepackage{amssymb} % not needed: newpxmath brings these symbols, and both together stop the build
```

**Say what the sans fonts do to formulas.** Fira Sans and Lato change the text only. A thesis
with many formulas will mix two styles; tell the user before they choose.

**Keep the comment style of the template:** every package line carries a comment saying what
it is for, for example `% Libertinus text font` and `% matching Libertinus math font`.

### Tested and failed: do not offer

- **Source Serif** (`sourceserifpro`) and **Source Sans** (`sourcesanspro`). Both stop the
  build together with `microtype`, which every template loads:
  `pdfTeX error (font expansion): auto expansion is only possible with scalable fonts`.

## The line spacing

The templates ship with one and a half spacing:

```latex
\usepackage[onehalfspacing]{setspace} % 1.5 line spacing
```

Change only the option in the square brackets, and the comment with it:

| Wanted | Line |
|---|---|
| single | `\usepackage[singlespacing]{setspace} % single line spacing` |
| one and a half (default) | `\usepackage[onehalfspacing]{setspace} % 1.5 line spacing` |
| double | `\usepackage[doublespacing]{setspace} % double line spacing` |
| any other value | `\usepackage{setspace}` and below it `\setstretch{1.3} % line spacing` |

Many universities prescribe the spacing, usually together with the font size and the margins,
because page limits are only fair when everybody uses the same. **Ask what their guidelines
say** if the user is unsure; never guess a value for them.
