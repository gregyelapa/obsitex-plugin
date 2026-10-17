# Question 5 · Numbering depth

**Read this card immediately before you ask question 5, and ask it exactly as written here.**
Translate every text into the chat language. Keep the numbers (`1.1.1`, …) exactly as they are.
Do not shorten, merge or reword the options, and do not add any.

**Everything the user needs is inside the dialog.** The question text, the option labels, the
descriptions and the previews carry the recommendation, the reason, the limitation and the
reassurance. A chat message before the dialog is welcome, but nothing depends on it. If you
send one, send it as visible text in your reply, before the dialog call, never only in your
thinking.

Pick the option set by the answer to question 3: **with chapters** (`professional-thesis`) or
**without chapters** (`simple-thesis`, `academic-paper`).

---

## The dialog

The letters in the first column only name the rows of this card. The labels in the dialog
carry no letter.

**header:** `Numbering`

**question:** `How deep should headings be numbered? You can change this later.`

### Option set: with chapters (four options)

| # | label | description |
|---|---|---|
| A | `Up to 1.1.1 (recommended)` | `Chapter, section and one level below get a number. A link to a deeper heading points to the wrong place, so links work down to 1.1.1.` |
| B | `Up to 1.1.1.1` | `One more numbered level. From here on the levels look alike (same font size), only the length of the number tells them apart.` |
| C | `Up to 1.1.1.1.1` | `Two more numbered levels. Same drawback as above, with longer numbers.` |
| D | `Up to 1.1.1.1.1.1` | `The deepest numbering possible. Same drawback as above, with the longest numbers.` |

### Option set: without chapters (three options)

| # | label | description |
|---|---|---|
| A | `Up to 1.1.1 (recommended)` | `Section and two levels below get a number. A link to a deeper heading points to the wrong place, so links work down to 1.1.1.` |
| B | `Up to 1.1.1.1` | `One more numbered level. That heading runs into the first line of its paragraph instead of standing on its own line. This layout cannot change that.` |
| C | `Up to 1.1.1.1.1` | `The deepest numbering possible. Two levels run into their paragraph, as above.` |

### Previews (the same for both sets)

Put each preview on its option, in a code block. Translate the headings, keep the numbers and
the arrow.

**A**

```
1  Introduction
1.1  Background
1.1.1  Earlier studies
       Survey design        ← no number
```

**B**

```
1  Introduction
1.1  Background
1.1.1  Earlier studies
1.1.1.1  Survey design
```

**C**

```
1  Introduction
1.1  Background
1.1.1  Earlier studies
1.1.1.1  Survey design
1.1.1.1.1  Sample
```

**D** (with chapters only)

```
1  Introduction
1.1  Background
1.1.1  Earlier studies
1.1.1.1  Survey design
1.1.1.1.1  Sample
1.1.1.1.1.1  Selection
```

---

## Optional chat message before the dialog

Two short paragraphs, in the chat language. Send them as visible text, then open the dialog.

> Next: how deep your headings are numbered. I recommend up to 1.1.1. Below that, all headings
> look the same and only the length of the number tells them apart.
>
> 💡 **Tip:** Numbers that run deep quickly make a text look technical. If it bothers you once
> you see the PDF, tell me and I will change the depth.

---

## Without a question tool

Write the question, then each option on one line as `A: label. description`, then the previews
as code blocks headed by their letter, then "Reply with the letter." (see "When there is no
question tool" in `SKILL.md`).

## What happens with the answer

Not part of this card. `SKILL.md` § "Sectioning depth" → "The block to write" turns the answer
into the preamble lines.
