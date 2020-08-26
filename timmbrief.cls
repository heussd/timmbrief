\ProvidesClass{timmbrief}[2020]
\LoadClass[german, justify]{latex-letter/tfbrief}

\usepackage[ngerman]{babel}


\usepackage[utf8x]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{libertine}
\usepackage{cmap}


\def\vcardfromname{vcard.tex not generated}
\def\vcardfromstreet{vcard.tex not generated}
\def\vcardfromcitycode{vcard.tex not generated}
\def\vcardfromcity{vcard.tex not generated}
\def\vcardfromcityshort{vcard.tex not generated}
\def\vcardfrommobile{vcard.tex not generated}
\def\vcardfromemail{vcard.tex not generated}
\input{vcard.tex}
\fromname{\vcardfromname}
\fromdegreepre[Dr.]{Dr.}
%\fromdegreepost[Ph.\,D.]{}
\fromstreet[\vcardfromstreet]{\vcardfromstreet}
\fromcity[\vcardfromcityshort]{\vcardfromcity}
\fromcitycode{\vcardfromcitycode}
\frommobile{\vcardfrommobile}
\fromemail{\vcardfromemail}

\settowidth{\fromwidth}{Filler–\vcardfromcitycode \vcardfromcity}


\usepackage{xstring}
\newcommand{\documentfilename}{\StrSubstitute[0]{\jobname}{"}{}}
\subject{\documentfilename}

\usepackage{graphicx}
\newcommand{\signed}{
    \vspace{-2.0cm}{
    \rotatebox{2}{
        \setmainfont[SizeFeatures={Size=50}]{Bellamy Signature}
        \fontdimen2\font=3pt
        \vcardfromname
    }
}}
