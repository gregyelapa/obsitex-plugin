```remark
Title block as a raw LaTeX block. Replace the placeholders (title, subtitle, authors,
institutions, e-mail, date). A paper has no separate title page: the block sits at
the top of the first page, and the abstract follows directly below it. This file has
no Markdown heading on purpose.

One author: delete the line with \and and everything after it up to the closing }.
More authors: add another \and block. The \thanks line marks the corresponding
author and prints the e-mail as a footnote.
```

```latex
% Title block (article class, no extra package). Edit the placeholder texts below.
\title{Your Title of the Paper\\[0.3em]
\large Your Subtitle of the Paper}
\author{First Author\thanks{Corresponding author: first.author@university.edu}\\
University, Department
\and
Second Author\\
University, Department}
\date{Day Month Year}
\maketitle
```
