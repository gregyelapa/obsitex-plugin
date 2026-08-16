```remark
This file configures the whole document and must stay FIRST - hence the 00 in its name.
It holds two things: the dds block with the Obsitex converter settings (document class,
heading levels, figure/table environments, quotation marks, citation command) and the
latex-preamble block with the LaTeX packages. The converter reads the dds settings at the
position where they stand, so a later position would leave every heading before it on the
defaults. Every package line carries a comment saying what it is for - comment a line out
with a leading % if you do not need it.
This template uses the KOMA book class scrbook: top-level headings become numbered
chapters, with a front matter (roman page numbers) and a main matter (arabic).
```

```dds
{"documentClass":"\\documentclass[12pt,oneside]{scrbook} % oneside = single-sided (no blank pages, continuous numbering). Alternatives: twoside (double-sided, the book default) or openany (two-sided but chapters may start on any page)","convertQuotationMarks":true,"openingQuotationMark":"“","closingQuotationMark":"”","createFigureEnvironment":true,"figureEnvironmentText":"\\begin{figure}[h]\n    \\centering\n    \\includegraphics[width=\\textwidth]{%path%}\n    \\caption{%name%}\n    \\label{fig:%nameWithoutSC%}\n\\end{figure}\n\n","createTableEnvironment":true,"tableGridHorizontal":true,"tableGridVertical":true,"tableAlignment":"l","tableEnvironmentText":"\\begin{table}[h]\n    \\centering\n    \\begin{tabular}{%getcolumns%}\n        %tablestring%\n    \\end{tabular}\n\\end{table}\n\n","createPdfCmd":true,"pdfCmdText":"\\includepdf[pages=-]{%path%}\n","createBibliographyCmd":true,"bibliographyCmdText":"\\addbibresource{%path%}\n","bibliographyBodyCmd":"\\printbibliography[heading=none]\n","createDocumentLevel":true,"documentLevelIndex":0,"documentLevelPreFix":["","","","","","",""],"documentLevelPostFix":["","","","","","",""],"createCrossReferenceCmd":true,"crossReferenceCmdText":"\\vref{%labelname%}"}
```

```latex-preamble
% --- Encoding and language ---
\usepackage[utf8]{inputenc} % read the source file as UTF-8 (umlauts, accents)
\usepackage[T1]{fontenc} % font encoding for correct hyphenation of accented words
\usepackage[english]{babel} % language rules: hyphenation and auto-generated names
\usepackage{lmodern} % crisp Latin Modern font
\usepackage{microtype} % micro-typography: even margins, fewer overflowing lines
\usepackage{csquotes} % context-aware quotation marks (recommended with biblatex)
% --- Page layout (KOMA scrbook) ---
\usepackage[a4paper,left=3cm,right=2.5cm,top=2.5cm,bottom=2.5cm,bindingoffset=0.5cm]{geometry} % page margins plus binding correction for printing
\usepackage[onehalfspacing]{setspace} % 1.5 line spacing
\KOMAoptions{parskip=half,listof=totoc} % paragraph spacing + lists in the ToC
\usepackage[automark,headsepline]{scrlayer-scrpage} % running header and footer with chapter mark and rule
\clearpairofpagestyles % reset header and footer to empty
\ohead{\headmark} % outer header shows the current chapter title
\ofoot{\pagemark} % outer footer shows the page number
\pagestyle{scrheadings} % activate the header and footer style
% --- Optional heading tweaks (remove the leading % on a line to enable it) ---
%\RedeclareSectionCommand[beforeskip=-1\baselineskip, afterskip=1\baselineskip]{chapter} % more compact chapter headings: removes most of the large blank space above each chapter title and tightens the gap below it
%\setkomafont{disposition}{\normalcolor\bfseries} % set ALL headings (chapters, sections, ...) in the serif body font, bold, instead of the KOMA default sans-serif headings
% --- Math (required by the Obsitex converter for formulas) ---
\usepackage{amsmath} % core math environments
\usepackage{amssymb} % additional math symbols
\usepackage{bm} % bold math symbols
\usepackage{esint} % extended integral signs
\usepackage{pifont} % dingbat and symbol characters
\usepackage{textcomp} % additional text symbols
% --- Inline formatting (required by the Obsitex converter) ---
\usepackage[normalem]{ulem} % strikethrough for ~~text~~
\usepackage{soul} % highlight for ==text==
% --- Figures and tables ---
\usepackage{graphicx} % include images (includegraphics)
\usepackage{float} % the [H] specifier forces a figure or table exactly here
\usepackage{caption} % configurable figure and table captions
\usepackage{subcaption} % side-by-side subfigures labelled (a), (b), (c)
\usepackage{booktabs} % clean horizontal rules for hand-written tables
\usepackage{array} % extended column formatting
\usepackage{tabularx} % tables with automatic column widths
\usepackage{longtable} % tables spanning several pages
\usepackage[table,xcdraw]{xcolor} % colors, including colored table cells
\usepackage{framed} % shaded or framed text boxes (used by callouts)
\definecolor{shadecolor}{rgb}{0.7,0.85,1} % background color for shaded boxes
\usepackage{pdfpages} % embed external PDF files (includepdf)
\usepackage{pdflscape} % individual landscape pages for wide content
% --- Bibliography ---
\usepackage[backend=biber, style=numeric-comp]{biblatex} % bibliography engine; change the style option for another citation scheme
\setcounter{biburllcpenalty}{7000} % discourage URL line breaks after lowercase letters
\setcounter{biburlucpenalty}{8000} % same for uppercase letters
% --- Hyperlinks and cross-references (load late; varioref before hyperref, cleveref last) ---
\usepackage[english]{varioref} % smart page references used by Obsitex cross-references
\usepackage[colorlinks=true, linkcolor=black, citecolor=black, urlcolor=blue, filecolor=black]{hyperref} % clickable links and references
\usepackage[noabbrev,english]{cleveref} % cref inserts the label type (Figure, Section, ...) automatically
\urlstyle{same} % show URLs in the body font instead of monospace
% --- Pagination quality ---
\clubpenalty = 10000 % forbid a lone first line at the bottom of a page (orphan)
\widowpenalty = 10000 % forbid a lone last line at the top of a page (widow)
\displaywidowpenalty = 10000 % same, for the line before a displayed formula
\setlength{\emergencystretch}{2em} % last-resort line stretching to avoid overfull lines
```