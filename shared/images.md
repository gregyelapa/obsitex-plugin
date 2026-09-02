# Images

Embedding images from the vault as figures.

> The general rules — the three levels of a formatting answer, `dds` semantics, reading
> `00 Document Setup.md` before touching the preamble, and how to write an attachment link —
> are in `obsitex-conventions.md`. This file only gives the image-specific cases.

## An image the user pasted into the chat

**When the user pastes an image and asks for it to go into a note, read the Windows clipboard
first. Never say the image cannot be saved before having tried.** The chat attachment really is
not a file path — but the image the user just pasted came *from* the clipboard, and on Windows
it is normally still sitting there. Searching the vault for image files answers a different
question: the file does not exist yet, and that is exactly what this procedure fixes.

This is not hypothetical. A session searched the vault, found nothing, and told the user to
insert the picture through Obsidian by hand. The user had to ask "is there really no way via
the clipboard?" before it worked.

### The command

```
powershell.exe -sta -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $img = [System.Windows.Forms.Clipboard]::GetImage(); if ($img -eq $null) { 'EMPTY' } else { $img.Save('<targetpath>.png', [System.Drawing.Imaging.ImageFormat]::Png); 'OK ' + $img.Width + 'x' + $img.Height }"
```

It answers `EMPTY` or `OK <width>x<height>`, so one call tells you whether there is anything to
work with. Verified 15.08.2026: a 320×140 test image was placed on the clipboard, written to a
file by this command, and read back as the same picture.

- **In the Bash tool the `$` must be escaped** (`\$img`), otherwise the shell eats the variables
  before PowerShell sees them.
- **Keep `-sta`.** Windows PowerShell 5.1 already runs in an STA thread, so the flag changes
  nothing there (measured — both forms returned `OK 320x140`). PowerShell 7 (`pwsh`) defaults to
  MTA, where the clipboard call hands back null although an image is present. The flag costs
  nothing and makes the command independent of which PowerShell answers.
- Nothing has to be installed. `powershell.exe` and the .NET Framework assemblies are part of
  Windows.

### The procedure

1. **Save into the scratchpad first**, never straight into the vault.
2. **Read the saved file and confirm it is the image from the chat.** The clipboard is a shared
   surface and may well hold something else — a screenshot taken since, a copied cell. This step
   is what separates "I read the clipboard" from "I have the right picture".
3. **Find where attachments belong.** The setting alone does not answer this — ask three
   questions in order:
   1. Read `.obsidian/app.json` and take `attachmentFolderPath`. If it is set, that is the answer.
   2. **If the field is missing, do not jump to the vault root.** The root is Obsidian's factory
      default, but the field is absent in every vault whose owner never opened that setting — and
      that includes vaults which have kept every attachment in one folder for years. Look at the
      vault itself: a folder named `attachments` (or one that already holds the images the notes
      embed) is the established convention and beats the default. **An empty folder of that name
      still counts** — it is a place kept free, not a place nobody uses.
   3. **Setting empty and no such folder anywhere — then ask, do not fall back silently.** The
      root is the defensible answer here, and it is still usually not the one the user wants:
      an author who keeps attachments in a folder in every other vault expects it in the new one
      too, and a vault that has no images yet cannot show you that. Propose the folder rather
      than the root — "shall I create `<manuscript>/attachments` for it?" — and one line settles
      it.

   **Which level: inside the manuscript, never beside it.** Where the folder has to be created or
   chosen, it belongs *within* the manuscript folder (`Manuscript/attachments`), not in the project
   folder next to it. The reason is portability: the manuscript is the unit that gets copied,
   archived and handed on, and it has to carry everything the document needs. An attachment one
   level up survives no such move — the notes keep finding it as long as the original folder sits
   on this machine, and the copy arrives with empty figures. Nothing warns; it looks right until
   it is somewhere else. Obsitex resolves attachments across the whole vault, so this is a
   convention and not a technical constraint. Follow it when you create the folder — and follow
   an **existing** folder that contradicts it rather than reorganising someone's vault.

   **Name the folder you chose and why**, so the user can correct it in one sentence. Where the
   setting was empty, mention that Obsidian can be made to agree — *Settings → Files and links →
   Default location for new attachments*. Then the setting and the habit stop disagreeing.

   Measured 15.08.2026 across the vaults on one machine. Four of them keep every attachment in
   an `attachments` folder while `app.json` is `{}` — the setting is empty in exactly the vaults
   that have the clearest convention, because the owner never had to open it. The first version
   of this rule read that empty setting, obeyed the factory default and put two pasted
   screenshots in a vault root. **Reading the setting is necessary and not sufficient**, and in
   a fresh vault it tells you nothing at all.
4. **Name the file after the intended caption**, extension `.png`. The caption also drives the
   `\label` (see "Referring to a figure" below).
5. **Only now copy it into the vault and write the embed.** How to write the link — bare name or
   path from the vault root — is in `obsitex-conventions.md`.

### Where this does not work

| Condition | Why |
|---|---|
| Windows only | `System.Windows.Forms` does not exist on macOS or Linux |
| Session on the same machine as the clipboard | not in the web version, not in WSL, not over remote SSH |
| A desktop session must be logged in | there is no clipboard without one |

Outside those conditions the old answer is the right one: ask the user to insert the image in
Obsidian and tell you the file name.

## Syntax

```markdown
![[figure.png]]
![[figure.png|A test image]]
![A test image](attachments/figure.png)
```

- The Obsidian embed `![[figure.png]]` is the usual form; classic Markdown works too.
- The image must stand **alone in its own paragraph**. A line directly above or below it,
  with no blank line between, stops it being recognised.
- Supported: PNG, JPG/JPEG. GIF/BMP/WEBP are treated as PNG.

## Caption and size

Obsidian uses the **same** field after the pipe for both caption and display size, splitting
at the **last** pipe. Obsitex follows that rule:

| Written | Caption | Size |
|---|---|---|
| `![[img.png]]` | file name without extension | — |
| `![[img.png\|300]]` | file name without extension | 300 |
| `![[img.png\|A test image]]` | A test image | — |
| `![[img.png\|A test image\|300]]` | A test image | 300 |

Only a bare number (`300`) or width×height (`300x200`) counts as a size. Everything else stays
part of the caption — so a caption may itself contain a pipe.

**The size does not reach the PDF yet.** Obsitex recognises it and keeps it out of the caption,
but does not pass it to LaTeX: the width still comes from `figureEnvironmentText` (full text
width by default). The author therefore sees the image smaller in Obsidian than in the PDF.
**Say so** if they ask for a specific size, and change it where it actually lives: for one
figure a ` ```dds ` block before it and a second one after putting the width back, for every
figure the block in `00 Document Setup.md`.

## What it produces

A `figure` environment with `\includegraphics` and `\caption{…}`, shaped by the DDS field
`figureEnvironmentText`. Full field catalogue: `dds.md`.

On export the real image lands in an `images/` subfolder. **The exported file name comes from
the source file, the `\label` from the caption** — two separate sources, both kept unique per
run. Two images may therefore share a caption; they get distinguishable labels
(`fig:…`, `fig:…_2`).

**The caption runs through inline rendering** (since 29.08.2026), the same as a table cell:

- Special characters are safe. `Costs_A and B & 50 %` prints as written. Before that date a
  single underscore broke the build with the default template.
- `**bold**`, `*italic*`, `[[links]]` and `[@cite]` work inside a caption.
- Backticks are still the way to raw LaTeX: `` ![[img.png|Formula `$a^2$` shown]] ``. A LaTeX
  command written **without** backticks now prints as text instead of running.
- The `\label` is built from the **raw** caption, not the rendered one, so markup never lands
  inside it.

## Placement: why a figure moves

A figure is a **float**, exactly like a table, and the mechanism is the same one: `[!htbp]`,
never backwards, `[H]` from the `float` package to pin it. The full explanation lives once, in
`tables.md`, "Placement: why a table moves" — read it there before answering.

**With images the placement letter is rarely the real problem.** The template sets
`width=\textwidth`. A square picture then becomes nearly page-high and fits in no gap on any
page, so LaTeX carries it along whatever you write in the brackets. Measured, not guessed.

So when a user says an image jumped to another page, **check the size first**. Making it
narrower (see "Caption and size" above) puts it back into the running text and costs nothing.
Reach for `[H]` only when the picture is already small and still moves — pinning a page-high
figure just leaves a bigger hole.

## Referring to a figure

**Since 01.09.2026 a wikilink reaches a figure by its caption**, exactly the way it reaches a
captioned table:

| Written | Result |
|---|---|
| `[[#A test image]]` (same note) | `\vref{fig:a_test_image}` |
| `[[Note#A test image]]` | the same, across notes |
| `[[#A test image\|the test image]]` | `\hyperref[fig:a_test_image]{the test image}` |

**A bare `[[A test image]]` is NOT a figure reference, on purpose.** That namespace belongs to
note names, and a caption that happens to match a note name would silently steal the link.
Write the `#`.

**What the reader sees is "table 3 on the preceding page"**, not a bare number: the type
word comes from `cleveref`, the position from `varioref`, and the position is dropped when
the target is on the same page. Anatomy and the language trap: `links.md`.

**An image without a caption is reachable too.** The converter turns the file name into the
caption, so `![[photo.jpg]]` carries `\label{fig:photo}` and `[[#photo]]` finds it. There is no
image that cannot be referred to.

**An Obsidian block identifier reaches a figure as well** since 02.09.2026: write `^id` at the
end of the embed and reference it with `[[#^id]]`. Same output, but the link is live inside
Obsidian and survives a rewritten caption. Details and the trade-off: `links.md`.

**In Obsidian this link looks dead — that is expected, not a bug.** Obsidian resolves a `#`
only to **headings** (and `#^` to block ids); it knows nothing about captions. So the link is
painted as unresolved and hovering it says "… not found". **Obsitex still converts it
correctly** and the reference appears in the PDF. Measured 01.09.2026.

Two consequences, both silent, and worth saying out loud when a user writes one of these:

- **No click while writing.** The reference cannot be checked before converting.
- **Obsidian does not follow a renamed caption.** Change the caption and the link breaks
  without a warning; it shows up in the PDF as plain text where a number should be.

So when you edit a caption, **search the vault for links pointing at it** and update them in
the same breath. Nothing else will.

The name after `fig:` is built from the **raw** caption: lowercased, every character other than
a letter or digit becomes `_`. "A test image" → `fig:a_test_image`. Two images sharing a
caption get `fig:…` and `fig:…_2`, and a link hits the **first** of them. **Changing the caption
changes the label**, so warn the user when you edit a caption something might point at. The
wikilink form survives that edit far better than a hand-written label, which is the reason to
prefer it.

The raw command in backticks still works and remains the way out for anything the wikilink form
does not cover:

```markdown
… is shown in `\vref{fig:a_test_image}`.
```

**A figure only has a label if the template emits one.** `figureEnvironmentText` carries
`%label%` in the standard setup. A custom template without it produces no label; a wikilink to
that image then stays plain text instead of pointing at a label that does not exist. The same
holds for `pdfCmdText` (PDF embeds) and the two bibliography fields.

## When no image appears

Three silent failures, all without an error message:

- **A stray character at the end of the line** — one `]` too many and the line is no longer
  recognised as an embed. It becomes ordinary text, and the caption is printed as body text.
  No warning, because the result is valid LaTeX.
- **The image is not alone in its paragraph** (see Syntax).
- **The file does not exist in the vault** — Obsitex writes a LaTeX comment, invisible in the
  PDF.

## Traps

- **Never drop the extension.** `![[figure]]` finds nothing in Obsidian, and Obsitex may match
  a different file type entirely.
- **A duplicate file name resolves differently in the two programs.** Obsidian prefers the file
  next to the note, Obsitex takes the first one it meets while scanning — which is the
  Flexplorer order. The author sees the right image in the preview and a different one in the
  PDF. Warning 92875 reports it after conversion, but the fix is to write the path from the
  vault root (`![[figures/logo.png]]`) or, better, to use distinct file names.
- **No image mid-sentence.** Only block embeds are supported.
- A pure attachments folder creates **no** heading of its own in the document.
