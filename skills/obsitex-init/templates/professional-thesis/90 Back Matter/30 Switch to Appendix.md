# Appendix {-}

```remark
Do not delete. This file must stay before the first appendix.

From here on the appendix begins: the chapters after it are called A, B, C.
The heading "Appendix" above is the divider in front of it.
```

```latex
% following chapters are lettered A, B, C
\appendix
\crefalias{chapter}{appendix} % cross-references say "appendix B", not "chapter B"
\crefalias{section}{subappendix} % and "appendix B.1", not "section B.1"
```
