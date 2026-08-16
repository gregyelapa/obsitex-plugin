```remark
Cover page as a raw LaTeX block - replace the placeholders (title, degree, author,
supervisor, date). This file has no Markdown heading on purpose: the title page
layout comes entirely from the LaTeX block below.
```

```latex
% Cover page (titlepage environment) - edit the placeholder texts below
\begin{titlepage}
\hrule
\vspace{1.8cm}
\huge
\textbf{Your Title of the Thesis}\\

\vspace{0.3cm}
\large
\textbf{Your Subtitle of the Thesis}\\

\vspace{2cm}
\textbf{Master Thesis}\\

\vfill
\normalsize
\textbf{Submitted as part of the requirements for the degree of} Master of Science in Your Program\par
\vspace{0.3cm}
\begin{tabbing}
\hspace{5cm} \= \kill
\textbf{Author} \> Your Full Name \\
\textbf{Supervisor} \> Name of the Professor \\
\textbf{Date of Submission} \> Day Month Year \\
\end{tabbing}
\end{titlepage}
```