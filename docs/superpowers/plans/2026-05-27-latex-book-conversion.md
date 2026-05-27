# LaTeX Book Conversion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert the Claude Code documentation repository (67 Markdown files across 17 guide sections) into a fully structured LaTeX book with parts, chapters, per-chapter summaries, per-chapter reference lists, a glossary, and a master table of contents — with every chapter's content verified against current Anthropic documentation before writing its summary and bibliography.

**Architecture:** A `book/` directory at the repo root holds the entire LaTeX project. The main document uses the `book` class with `biblatex` (`refsection=chapter`) for per-chapter bibliographies. Chapters are one file each in `book/chapters/`; their `.bib` files live in `book/bibliography/`. The back matter contains a unified glossary (from the existing glossary source) and a full index.

**Tech Stack:** LaTeX (`book` class), `biblatex` + `biber`, `hyperref`, `listings`, `glossaries-extra`, `tikz`, `booktabs`, `geometry`, `microtype`, `cleveref`.

---

## Book Structure

```
Part I   — Getting Started with Claude Code
  Ch 1   Plugin Ecosystem          (guides/07-plugins/)
  Ch 2   MCP Servers               (guides/01-mcp-servers/ — 5 files merged)
  Ch 3   Prompt Engineering Basics (guides/02-prompt-basics/ — 2 files merged)

Part II  — Core Components
  Ch 4   Agents                    (guides/03-agents/ — 4 files merged)
  Ch 5   Skills                    (guides/04-skills/ — 5 files merged)
  Ch 6   Slash Commands            (guides/05-commands/)
  Ch 7   Model Selection           (guides/06-models/ — 5 files merged)

Part III — Advanced Features
  Ch 8   Thinking Modes            (guides/08-thinking/ — 3 files merged)
  Ch 9   Context Management        (guides/09-context/ — 3 files merged)
  Ch 10  Keywords & Triggers       (guides/10-keywords/ — 3 files merged)
  Ch 11  Hooks & Automation        (guides/11-hooks/)
  Ch 12  Advanced Prompting        (guides/17-advanced-prompting/ — 4 files merged)

Part IV  — Optimization & Production
  Ch 13  Token Optimization        (guides/12-optimization/ — 3 files merged)
  Ch 14  Security & Compliance     (guides/15-security/ — 3 files merged)
  Ch 15  Real-World Examples       (guides/13-examples/ — multiple files merged)

Appendix A  Reference Documentation (guides/14-reference/ — 6 files merged)
Appendix B  Community Resources     (guides/16-community/ — 3 files merged)

Back Matter
  Glossary    (from guides/14-reference/7-glossary.md)
  Index
  (Per-chapter bibliographies appear at the end of each chapter)
```

## File Map

```
book/
├── main.tex
├── preamble.tex
├── frontmatter/
│   ├── halftitle.tex
│   ├── titlepage.tex
│   ├── copyright.tex
│   └── preface.tex
├── chapters/
│   ├── ch01-plugin-ecosystem.tex
│   ├── ch02-mcp-servers.tex
│   ├── ch03-prompt-basics.tex
│   ├── ch04-agents.tex
│   ├── ch05-skills.tex
│   ├── ch06-commands.tex
│   ├── ch07-models.tex
│   ├── ch08-thinking.tex
│   ├── ch09-context.tex
│   ├── ch10-keywords.tex
│   ├── ch11-hooks.tex
│   ├── ch12-advanced-prompting.tex
│   ├── ch13-optimization.tex
│   ├── ch14-security.tex
│   └── ch15-examples.tex
├── appendices/
│   ├── app-a-reference.tex
│   └── app-b-community.tex
├── backmatter/
│   └── glossary.tex
└── bibliography/
    ├── ch01.bib  …  ch15.bib
    ├── app-a.bib
    └── app-b.bib
```

---

## Per-Chapter Workflow (applies to Tasks 3–9)

For **every** chapter and appendix, the worker must follow this sequence before writing content:

1. Read all source Markdown files for the chapter.
2. Fetch the relevant Anthropic documentation URL(s) listed in that task.
3. Compare the two: note model names, API details, feature availability, or pricing that has changed.
4. Write the LaTeX chapter incorporating any corrections.
5. Write the `\chapter*{Summary}` section based on the verified, updated content.
6. Write the `.bib` file — validate each URL listed in the source Markdown, add new references from the Anthropic docs, remove dead links.
7. Commit.

---

## Task 0: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Rewrite CLAUDE.md** to reflect the LaTeX book project

Replace the content of `CLAUDE.md` with:

```markdown
# Claude Code — LaTeX Book Project

## Project Goal

Convert the Claude Code documentation (67 Markdown guides) into a fully typeset
LaTeX book: *Mastering Claude Code* (working title).

## Repository Layout

```
guides/          # Source Markdown (do not delete — canonical content source)
book/            # LaTeX project (output target)
  main.tex       # Master document
  preamble.tex   # Packages and settings
  chapters/      # One .tex file per chapter (ch01–ch15)
  appendices/    # app-a-reference.tex, app-b-community.tex
  backmatter/    # glossary.tex
  bibliography/  # One .bib file per chapter/appendix
  frontmatter/   # halftitle, titlepage, copyright, preface
docs/superpowers/plans/   # Implementation plans
```

## Book Structure

| Part | Chapters | Source |
|------|----------|--------|
| I  — Getting Started    | 1 Plugin Ecosystem, 2 MCP Servers, 3 Prompt Basics | guides/07, 01, 02 |
| II — Core Components    | 4 Agents, 5 Skills, 6 Commands, 7 Models            | guides/03–06     |
| III— Advanced Features  | 8–12 (Thinking, Context, Keywords, Hooks, Prompting)| guides/08–11, 17 |
| IV — Production         | 13 Optimization, 14 Security, 15 Examples           | guides/12–13, 15 |
| App A/B                 | Reference Docs, Community                           | guides/14, 16    |

## Per-Chapter Workflow (required)

Before writing each chapter's summary and bibliography:
1. Read all source `.md` files for that chapter.
2. Fetch the relevant Anthropic documentation (URLs listed in the plan).
3. Note and incorporate any content updates.
4. Validate/update references in the `.bib` file.
5. Write the `\section*{Summary}` based on verified content.

## LaTeX Conventions

- Document class: `book` (12pt, twoside, openright)
- Bibliography: `biblatex` + `biber`, `refsection=chapter`
- Print chapter bibliography: `\printbibliography[heading=subbibliography]`
- Code listings: `listings` package with custom style
- Diagrams: `tikz` (convert Mermaid diagrams to TikZ)
- Index: `imakeidx` — add `\index{}` for key terms
- Glossary: `glossaries-extra` — entries defined in `backmatter/glossary.tex`

## Writing Guidelines (preserved from Markdown source)

- Progressive disclosure: simple → complex within each chapter
- Real examples in every section
- Cost transparency: always include token implications where relevant
- Cross-reference related chapters with `\cref{ch:label}`

## Official References

- Claude Code Docs: https://docs.anthropic.com/en/docs/claude-code/overview
- Anthropic Models:  https://docs.anthropic.com/en/docs/about-claude/models/overview
- MCP Specification: https://modelcontextprotocol.io/specification
- Community Skills:  https://github.com/obra/superpowers
```

- [ ] **Step 2: Verify the file was written correctly**

Run: `head -5 CLAUDE.md`
Expected: `# Claude Code — LaTeX Book Project`

- [ ] **Step 3: Commit**

```bash
git add CLAUDE.md
git commit -m "docs: update CLAUDE.md for LaTeX book project"
```

---

## Task 1: LaTeX Project Scaffold

**Files:**
- Create: `book/main.tex`
- Create: `book/preamble.tex`
- Create: `book/frontmatter/halftitle.tex`
- Create: `book/frontmatter/titlepage.tex`
- Create: `book/frontmatter/copyright.tex`
- Create: `book/frontmatter/preface.tex`
- Create: `book/backmatter/glossary.tex` (stub — populated in Task 10)

- [ ] **Step 1: Create directory structure**

```bash
mkdir -p book/{chapters,appendices,backmatter,bibliography,frontmatter}
```

Expected: no output (directories created silently)

- [ ] **Step 2: Create `book/preamble.tex`**

```latex
% book/preamble.tex
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}
\usepackage{microtype}
\usepackage[a4paper, margin=2.5cm, inner=3cm]{geometry}

% Bibliography - per-chapter refsections
\usepackage[
  backend=biber,
  style=authoryear,
  refsection=chapter,
  maxbibnames=6,
  doi=true,
  url=true,
  urldate=long
]{biblatex}

% Hyperlinks
\usepackage[
  colorlinks=true,
  linkcolor=blue!60!black,
  citecolor=green!50!black,
  urlcolor=blue!70!black,
  pdftitle={Mastering Claude Code},
  pdfauthor={Claude Code Documentation Project}
]{hyperref}

% Cross-references
\usepackage[nameinlink,capitalise]{cleveref}

% Code listings
\usepackage{listings}
\usepackage{xcolor}
\definecolor{codebg}{HTML}{F5F5F5}
\definecolor{codecomment}{HTML}{6A737D}
\definecolor{codestring}{HTML}{032F62}
\definecolor{codekeyword}{HTML}{D73A49}
\lstset{
  backgroundcolor=\color{codebg},
  basicstyle=\ttfamily\small,
  breakatwhitespace=false,
  breaklines=true,
  captionpos=b,
  commentstyle=\color{codecomment},
  keywordstyle=\color{codekeyword},
  stringstyle=\color{codestring},
  frame=single,
  framerule=0pt,
  rulecolor=\color{codebg},
  showstringspaces=false,
  tabsize=2,
  numbers=left,
  numberstyle=\tiny\color{gray},
  numbersep=8pt
}

% Tables
\usepackage{booktabs}
\usepackage{array}
\usepackage{longtable}

% Graphics
\usepackage{tikz}
\usetikzlibrary{shapes.geometric,arrows.meta,positioning,fit,backgrounds,calc}

% Headers and footers
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[LO]{\nouppercase{\rightmark}}
\fancyhead[RE]{\nouppercase{\leftmark}}
\renewcommand{\headrulewidth}{0.4pt}

% Glossary
\usepackage[
  toc,
  acronym,
  section=chapter,
  nonumberlist
]{glossaries-extra}

% Index
\usepackage{imakeidx}
\makeindex[columns=2, title=Index, intoc]

% Part/chapter styling
\usepackage{titlesec}
\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}

% Summary box environment
\usepackage{tcolorbox}
\tcbuselibrary{skins,breakable}
\newtcolorbox{summarybox}{
  enhanced,
  title=Chapter Summary,
  colback=blue!5!white,
  colframe=blue!40!black,
  fonttitle=\bfseries,
  breakable
}

% Callout/note environment
\newtcolorbox{notebox}[1][Note]{
  enhanced,
  title=#1,
  colback=yellow!10!white,
  colframe=yellow!60!black,
  fonttitle=\bfseries,
  breakable
}
```

- [ ] **Step 3: Create `book/main.tex`**

```latex
% book/main.tex
\documentclass[12pt,twoside,openright]{book}
\input{preamble}

% Add all bibliography resources
\addbibresource{bibliography/ch01.bib}
\addbibresource{bibliography/ch02.bib}
\addbibresource{bibliography/ch03.bib}
\addbibresource{bibliography/ch04.bib}
\addbibresource{bibliography/ch05.bib}
\addbibresource{bibliography/ch06.bib}
\addbibresource{bibliography/ch07.bib}
\addbibresource{bibliography/ch08.bib}
\addbibresource{bibliography/ch09.bib}
\addbibresource{bibliography/ch10.bib}
\addbibresource{bibliography/ch11.bib}
\addbibresource{bibliography/ch12.bib}
\addbibresource{bibliography/ch13.bib}
\addbibresource{bibliography/ch14.bib}
\addbibresource{bibliography/ch15.bib}
\addbibresource{bibliography/app-a.bib}
\addbibresource{bibliography/app-b.bib}

% Load glossary entries
\input{backmatter/glossary}
\makeglossaries

\begin{document}

%% ---------------------------------------------------------------
%% Front Matter
%% ---------------------------------------------------------------
\frontmatter
\input{frontmatter/halftitle}
\input{frontmatter/titlepage}
\input{frontmatter/copyright}
\tableofcontents
\listoffigures
\listoftables
\input{frontmatter/preface}

%% ---------------------------------------------------------------
%% Main Matter
%% ---------------------------------------------------------------
\mainmatter

\part{Getting Started with Claude Code}
\input{chapters/ch01-plugin-ecosystem}
\input{chapters/ch02-mcp-servers}
\input{chapters/ch03-prompt-basics}

\part{Core Components}
\input{chapters/ch04-agents}
\input{chapters/ch05-skills}
\input{chapters/ch06-commands}
\input{chapters/ch07-models}

\part{Advanced Features}
\input{chapters/ch08-thinking}
\input{chapters/ch09-context}
\input{chapters/ch10-keywords}
\input{chapters/ch11-hooks}
\input{chapters/ch12-advanced-prompting}

\part{Optimization and Production}
\input{chapters/ch13-optimization}
\input{chapters/ch14-security}
\input{chapters/ch15-examples}

%% ---------------------------------------------------------------
%% Appendices
%% ---------------------------------------------------------------
\appendix
\input{appendices/app-a-reference}
\input{appendices/app-b-community}

%% ---------------------------------------------------------------
%% Back Matter
%% ---------------------------------------------------------------
\backmatter
\printglossaries
\printindex

\end{document}
```

- [ ] **Step 4: Create `book/frontmatter/halftitle.tex`**

```latex
% book/frontmatter/halftitle.tex
\thispagestyle{empty}
\vspace*{\fill}
\begin{center}
  {\Huge\bfseries Mastering Claude Code}
\end{center}
\vspace*{\fill}
\cleardoublepage
```

- [ ] **Step 5: Create `book/frontmatter/titlepage.tex`**

```latex
% book/frontmatter/titlepage.tex
\thispagestyle{empty}
\begin{titlepage}
  \centering
  \vspace*{2cm}
  {\fontsize{36}{44}\selectfont\bfseries Mastering Claude Code\par}
  \vspace{1cm}
  {\Large A Complete Guide to AI-Assisted Development\par}
  \vspace{3cm}
  {\large Claude Code Documentation Project\par}
  \vfill
  {\large \the\year\par}
\end{titlepage}
```

- [ ] **Step 6: Create `book/frontmatter/copyright.tex`**

```latex
% book/frontmatter/copyright.tex
\thispagestyle{empty}
\vspace*{\fill}
\noindent
Copyright \copyright\ \the\year\ Claude Code Documentation Project.\\[6pt]
All rights reserved. Content derived from Anthropic official documentation
and community contributions. Anthropic, Claude, and Claude Code are trademarks
of Anthropic, PBC.\\[6pt]
Typeset with \LaTeX.
\cleardoublepage
```

- [ ] **Step 7: Create `book/frontmatter/preface.tex`**

```latex
% book/frontmatter/preface.tex
\chapter*{Preface}
\addcontentsline{toc}{chapter}{Preface}

This book is a comprehensive guide to Claude Code, Anthropic's official CLI
for AI-assisted software development. It consolidates the official documentation
into a coherent pedagogical progression, from fundamental concepts to advanced
production workflows.

\medskip\noindent
\textbf{Who This Book Is For.}
Developers at any experience level who want to leverage Claude Code effectively.
Beginners will find a structured path from installation through first projects;
experienced engineers will find deep dives into optimization, security, and
custom tooling.

\medskip\noindent
\textbf{How to Read This Book.}
The four parts follow a deliberate learning arc:
\begin{itemize}
  \item \textbf{Part~I} establishes the conceptual foundation.
  \item \textbf{Part~II} covers the four core building blocks.
  \item \textbf{Part~III} introduces advanced configuration and reasoning control.
  \item \textbf{Part~IV} addresses production concerns: cost, security, and real-world patterns.
\end{itemize}
Each chapter ends with a summary and a list of references verified against the
current Anthropic documentation.

\medskip\noindent
\textbf{Versions.}
Model names and pricing are verified against the Anthropic documentation as of
\today. Claude Code evolves rapidly; always consult
\url{https://docs.anthropic.com} for the latest information.
\cleardoublepage
```

- [ ] **Step 8: Create stub `book/backmatter/glossary.tex`**

```latex
% book/backmatter/glossary.tex
% Stub — populated in Task 10 (Glossary)
% Entries use \newglossaryentry and \newacronym
```

- [ ] **Step 9: Create stub `.bib` files for all chapters**

Create `book/bibliography/ch01.bib` through `book/bibliography/ch15.bib` and
`book/bibliography/app-a.bib`, `book/bibliography/app-b.bib`, each containing:

```bibtex
% Stub — populated per chapter task
```

Run this to create them:
```bash
for i in $(seq -w 1 15); do
  echo "% Stub — populated per chapter task" > book/bibliography/ch${i}.bib
done
echo "% Stub — populated per chapter task" > book/bibliography/app-a.bib
echo "% Stub — populated per chapter task" > book/bibliography/app-b.bib
```

Expected: no output

- [ ] **Step 10: Create stub chapter files** (one per chapter so `main.tex` compiles)

```bash
for ch in \
  ch01-plugin-ecosystem ch02-mcp-servers ch03-prompt-basics \
  ch04-agents ch05-skills ch06-commands ch07-models \
  ch08-thinking ch09-context ch10-keywords ch11-hooks \
  ch12-advanced-prompting ch13-optimization ch14-security ch15-examples
do
  echo "\\chapter{Stub: $ch}" > book/chapters/${ch}.tex
done
echo "\\chapter{Stub: Reference Documentation}" > book/appendices/app-a-reference.tex
echo "\\chapter{Stub: Community Resources}" > book/appendices/app-b-community.tex
```

Expected: no output

- [ ] **Step 11: Verify scaffold compiles** (requires a working LaTeX installation)

```bash
cd book && pdflatex -interaction=nonstopmode main.tex 2>&1 | tail -5
```

Expected: `Output written on main.pdf` or at minimum no fatal errors on stub content.
If `pdflatex` is unavailable, skip to the commit step and note it in a comment.

- [ ] **Step 12: Commit**

```bash
git add book/ CLAUDE.md
git commit -m "feat: add LaTeX book scaffold with preamble, main.tex, frontmatter stubs"
```

---

## Task 2: Part I — Chapter 1 (Plugin Ecosystem)

**Source files:** `guides/07-plugins/1-overview.md`
**Anthropic docs to fetch:** `https://docs.anthropic.com/en/docs/claude-code/overview`
**Files:**
- Modify: `book/chapters/ch01-plugin-ecosystem.tex`
- Modify: `book/bibliography/ch01.bib`

- [ ] **Step 1: Read source**

Read `guides/07-plugins/1-overview.md` in full.

- [ ] **Step 2: Fetch Anthropic docs**

Fetch `https://docs.anthropic.com/en/docs/claude-code/overview`.
Note any differences in plugin/extension type names, availability, or terminology.

- [ ] **Step 3: Write `book/chapters/ch01-plugin-ecosystem.tex`**

Structure:
```latex
\chapter{The Plugin Ecosystem}
\label{ch:plugin-ecosystem}

% Intro paragraph

\section{The Four Extension Types}
% Table with booktabs comparing MCP Servers, Skills, Hooks, Slash Commands

\section{MCP Servers}
% Brief; deep dive is Chapter 2

\section{Skills}
% Brief; deep dive is Chapter 5

\section{Hooks}
% Brief; deep dive is Chapter 11

\section{Slash Commands}
% Brief; deep dive is Chapter 6

\section{Choosing an Extension Type}
% Decision table

\begin{summarybox}
% 5–8 bullet points covering key takeaways, verified against fetched docs
\end{summarybox}

\printbibliography[heading=subbibliography,title={References}]
```

- [ ] **Step 4: Write `book/bibliography/ch01.bib`**

Include at minimum:
- Official Claude Code overview page (URL verified in Step 2)
- Anthropic announcement/blog post for Claude Code
- MCP Specification reference

Format example:
```bibtex
@online{anthropic-claudecode-overview,
  author       = {{Anthropic}},
  title        = {Claude Code Overview},
  year         = {2025},
  url          = {https://docs.anthropic.com/en/docs/claude-code/overview},
  urldate      = {2026-05-27}
}
```

- [ ] **Step 5: Commit**

```bash
git add book/chapters/ch01-plugin-ecosystem.tex book/bibliography/ch01.bib
git commit -m "feat: add Chapter 1 — Plugin Ecosystem with summary and references"
```

---

## Task 3: Part I — Chapter 2 (MCP Servers)

**Source files:** `guides/01-mcp-servers/1-overview.md` through `5-best-practices.md`
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/claude-code/mcp`
- `https://modelcontextprotocol.io/introduction`
**Files:**
- Modify: `book/chapters/ch02-mcp-servers.tex`
- Modify: `book/bibliography/ch02.bib`

- [ ] **Step 1: Read all five source files**

Read in order: `1-overview.md`, `2-installation.md`, `3-popular-servers.md`,
`4-creating-custom-servers.md`, `5-best-practices.md`.

- [ ] **Step 2: Fetch Anthropic docs**

Fetch both URLs. Note: verify the current MCP protocol version, whether
JSON-RPC 2.0 is still the transport, and current list of officially supported
servers.

- [ ] **Step 3: Write `book/chapters/ch02-mcp-servers.tex`**

Sections:
```
\chapter{MCP Servers}
  \section{What Is the Model Context Protocol?}
  \section{How MCP Works}          % protocol, request flow, auth
  \section{Installing MCP Servers} % CLI, manual, Docker methods
  \section{Popular Servers}        % GitHub, Perplexity, Context7, community
  \section{Creating Custom Servers}
  \section{Best Practices}         % security, performance, error handling
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

Convert Mermaid sequence diagrams to `tikzpicture` environments.
Use `lstlisting` for all JSON/bash code blocks.
Add `\index{MCP}`, `\index{JSON-RPC}`, etc. for key terms.

- [ ] **Step 4: Write `book/bibliography/ch02.bib`**

Validate each URL from `guides/01-mcp-servers/1-overview.md#references` section.
Add any new references from the fetched Anthropic docs.
Remove any URLs that return 404.

Minimum entries:
- MCP specification (`modelcontextprotocol.io/specification`)
- Claude Code MCP guide (Anthropic docs)
- Anthropic MCP announcement blog post
- MCP GitHub repository
- Context7, Perplexity MCP server repos (validate URLs)

- [ ] **Step 5: Commit**

```bash
git add book/chapters/ch02-mcp-servers.tex book/bibliography/ch02.bib
git commit -m "feat: add Chapter 2 — MCP Servers with summary and references"
```

---

## Task 4: Part I — Chapter 3 (Prompt Engineering Basics)

**Source files:** `guides/02-prompt-basics/1-overview.md`, `2-core-patterns.md`
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview`
**Files:**
- Modify: `book/chapters/ch03-prompt-basics.tex`
- Modify: `book/bibliography/ch03.bib`

- [ ] **Step 1: Read both source files**

- [ ] **Step 2: Fetch Anthropic prompt engineering docs**

Note: check whether the 4-part formula (Intent + Context + Constraints + Success)
and the 7 named patterns (CREATE, FIX, REFACTOR, REVIEW, EXPLAIN, TEST, OPTIMIZE)
match current Anthropic guidance.

- [ ] **Step 3: Write `book/chapters/ch03-prompt-basics.tex`**

Sections:
```
\chapter{Prompt Engineering Basics}
  \section{Why Prompting Matters}
  \section{The Effective Prompt Formula}
  \section{Core Prompt Patterns}    % table of 7 patterns with examples
  \section{Common Mistakes}
  \section{Cost and Time Savings}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 4: Write `book/bibliography/ch03.bib`**

Minimum entries:
- Anthropic prompt engineering guide
- Any academic or industry references cited in source Markdown

- [ ] **Step 5: Commit**

```bash
git add book/chapters/ch03-prompt-basics.tex book/bibliography/ch03.bib
git commit -m "feat: add Chapter 3 — Prompt Engineering Basics"
```

---

## Task 5: Part II — Chapters 4 & 5 (Agents, Skills)

**Source files:**
- Agents: `guides/03-agents/1-overview.md` through `4-custom-agents.md`
- Skills: `guides/04-skills/1-overview.md` through `5-advanced-patterns.md`
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/claude-code/sub-agents`
- `https://docs.anthropic.com/en/docs/claude-code/skills` (or nearest equivalent)
**Files:**
- Modify: `book/chapters/ch04-agents.tex`
- Modify: `book/bibliography/ch04.bib`
- Modify: `book/chapters/ch05-skills.tex`
- Modify: `book/bibliography/ch05.bib`

- [ ] **Step 1: Read Agents source files** (all four)

- [ ] **Step 2: Fetch Anthropic agents docs**

Verify: current built-in agent types (Explore, General-Purpose, Plan), their
correct names, tool permissions, and whether `AGENT.md` is still the config
format.

- [ ] **Step 3: Write `book/chapters/ch04-agents.tex`**

Sections:
```
\chapter{Agents}
  \section{What Are Agents?}
  \section{Built-In Agent Types}    % Explore, General-Purpose, Plan
  \section{Model Assignment}
  \section{Creating Custom Agents}  % AGENT.md structure
  \section{Agent Lifecycle}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 4: Write `book/bibliography/ch04.bib`**

- [ ] **Step 5: Read Skills source files** (all five)

- [ ] **Step 6: Fetch Anthropic skills docs**

Verify: whether `SKILL.md` is still the config format, `autoTrigger` syntax,
progressive disclosure `<details>` pattern, and marketplace location.

- [ ] **Step 7: Write `book/chapters/ch05-skills.tex`**

Sections:
```
\chapter{Skills}
  \section{What Are Skills?}
  \section{Installing Marketplace Skills}
  \section{Creating Custom Skills}     % SKILL.md frontmatter, structure
  \section{Model Assignment for Skills}
  \section{Advanced Patterns}          % progressive disclosure, testing
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 8: Write `book/bibliography/ch05.bib`**

Minimum: superpowers GitHub repo, Anthropic skills docs (if exists),
any papers on instruction-following systems cited in source.

- [ ] **Step 9: Commit**

```bash
git add book/chapters/ch04-agents.tex book/bibliography/ch04.bib \
        book/chapters/ch05-skills.tex book/bibliography/ch05.bib
git commit -m "feat: add Chapters 4–5 — Agents and Skills"
```

---

## Task 6: Part II — Chapters 6 & 7 (Commands, Models)

**Source files:**
- Commands: `guides/05-commands/1-overview.md`
- Models: `guides/06-models/1-overview.md` through `5-selection-guide.md`
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/claude-code/slash-commands`
- `https://docs.anthropic.com/en/docs/about-claude/models/overview`
**Files:**
- Modify: `book/chapters/ch06-commands.tex`, `book/bibliography/ch06.bib`
- Modify: `book/chapters/ch07-models.tex`, `book/bibliography/ch07.bib`

- [ ] **Step 1: Read Commands source**

- [ ] **Step 2: Fetch slash commands docs**

Verify: syntax, `$ARGUMENTS` variable, frontmatter fields, team workflow patterns.

- [ ] **Step 3: Write `book/chapters/ch06-commands.tex`**

Sections:
```
\chapter{Slash Commands}
  \section{What Are Slash Commands?}
  \section{Creating Commands}     % frontmatter, $ARGUMENTS
  \section{Team Workflows}
  \section{Built-In Commands}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 4: Write `book/bibliography/ch06.bib`**

- [ ] **Step 5: Read all five Models source files**

- [ ] **Step 6: Fetch current models overview**

**Critical verification:** The source uses `Haiku 4.5`, `Sonnet 4.5`, `Opus 4.5`
with pricing dated January 2025. The current model lineup is:
- `claude-opus-4-7`, `claude-sonnet-4-6`, `claude-haiku-4-5-20251001`
Fetch the models page to get current names, context windows, and pricing.
Update all model names, capabilities, and pricing tables to match current docs.

- [ ] **Step 7: Write `book/chapters/ch07-models.tex`**

Sections:
```
\chapter{Model Selection}
  \section{The Claude Model Family}  % updated names/versions
  \section{Model Capabilities}       % updated comparison table
  \section{Pricing and Cost}         % verified current pricing
  \section{Benchmarks}
  \section{Selection Decision Tree}  % TikZ diagram
  \section{Configuration}           % CLI, agent, skill assignment
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 8: Write `book/bibliography/ch07.bib`**

Minimum:
- Anthropic models overview page (current URL)
- Anthropic pricing page
- Claude 4.x announcement blog posts

- [ ] **Step 9: Commit**

```bash
git add book/chapters/ch06-commands.tex book/bibliography/ch06.bib \
        book/chapters/ch07-models.tex book/bibliography/ch07.bib
git commit -m "feat: add Chapters 6–7 — Commands and Models (with updated model info)"
```

---

## Task 7: Part III — Chapters 8, 9, 10 (Thinking, Context, Keywords)

**Source files:**
- Thinking: `guides/08-thinking/` (3 files)
- Context: `guides/09-context/` (3 files)
- Keywords: `guides/10-keywords/` (3 files)
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/build-with-claude/extended-thinking`
- `https://docs.anthropic.com/en/docs/claude-code/memory`
- `https://docs.anthropic.com/en/docs/claude-code/settings` (for keywords/hooks context)
**Files:**
- Modify: `book/chapters/ch08-thinking.tex`, `book/bibliography/ch08.bib`
- Modify: `book/chapters/ch09-context.tex`, `book/bibliography/ch09.bib`
- Modify: `book/chapters/ch10-keywords.tex`, `book/bibliography/ch10.bib`

- [ ] **Step 1: Read Thinking source files**

- [ ] **Step 2: Fetch extended thinking docs**

Verify: current thinking keyword names (`think`, `think hard`, `ultrathink`),
token budget values, whether interleaved thinking is available for Claude Code.

- [ ] **Step 3: Write `book/chapters/ch08-thinking.tex`**

Sections:
```
\chapter{Thinking Modes}
  \section{What Is Extended Thinking?}
  \section{Thinking Keywords and Budgets}
  \section{Output Modes}
  \section{When to Use Extended Thinking}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 4: Write `book/bibliography/ch08.bib`**

- [ ] **Step 5: Read Context source files**

- [ ] **Step 6: Fetch context/memory docs**

Verify: CLAUDE.md file locations, memory hierarchy levels, current memory
system behavior, whether `.claude/memory.md` is the current path.

- [ ] **Step 7: Write `book/chapters/ch09-context.tex`**

Sections:
```
\chapter{Context Management}
  \section{Context and Memory in Claude Code}
  \section{CLAUDE.md Files}          % locations, precedence, best practices
  \section{The Memory Hierarchy}     % layer diagram in TikZ
  \section{Managing Long Conversations}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 8: Write `book/bibliography/ch09.bib`**

- [ ] **Step 9: Read Keywords source files**

- [ ] **Step 10: Write `book/chapters/ch10-keywords.tex`**

Sections:
```
\chapter{Keywords and Triggers}
  \section{Thinking Keywords}
  \section{Slash Commands as Triggers}
  \section{Automation Patterns}  % PreToolUse, PostToolUse, Stop, Notification
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 11: Write `book/bibliography/ch10.bib`**

- [ ] **Step 12: Commit**

```bash
git add book/chapters/ch08-thinking.tex book/bibliography/ch08.bib \
        book/chapters/ch09-context.tex book/bibliography/ch09.bib \
        book/chapters/ch10-keywords.tex book/bibliography/ch10.bib
git commit -m "feat: add Chapters 8–10 — Thinking, Context, Keywords"
```

---

## Task 8: Part III — Chapters 11 & 12 (Hooks, Advanced Prompting)

**Source files:**
- Hooks: `guides/11-hooks/1-overview.md`
- Advanced Prompting: `guides/17-advanced-prompting/` (4 files)
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/claude-code/hooks`
- `https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview`
**Files:**
- Modify: `book/chapters/ch11-hooks.tex`, `book/bibliography/ch11.bib`
- Modify: `book/chapters/ch12-advanced-prompting.tex`, `book/bibliography/ch12.bib`

- [ ] **Step 1: Read Hooks source**

- [ ] **Step 2: Fetch hooks docs**

Verify: hook types (PreToolUse, PostToolUse, Notification, Stop), `matcher`
field syntax, environment variables available to hooks, and whether there are
new hook types not in source.

- [ ] **Step 3: Write `book/chapters/ch11-hooks.tex`**

Sections:
```
\chapter{Hooks and Automation}
  \section{What Are Hooks?}
  \section{Hook Types}             % table of all types with trigger conditions
  \section{Configuration}         % JSON structure, matcher syntax
  \section{Common Patterns}       % auto-format, test-on-save, notifications
  \section{Security Considerations}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 4: Write `book/bibliography/ch11.bib`**

- [ ] **Step 5: Read all four Advanced Prompting source files**

- [ ] **Step 6: Write `book/chapters/ch12-advanced-prompting.tex`**

Sections:
```
\chapter{Advanced Prompting}
  \section{Chain-of-Thought and Structured Reasoning}
  \section{Few-Shot Learning}
  \section{Context Optimization}  % CLAUDE.md integration, layering
  \section{Cost-Aware Prompting}  % model cascading, batch optimization
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 7: Write `book/bibliography/ch12.bib`**

- [ ] **Step 8: Commit**

```bash
git add book/chapters/ch11-hooks.tex book/bibliography/ch11.bib \
        book/chapters/ch12-advanced-prompting.tex book/bibliography/ch12.bib
git commit -m "feat: add Chapters 11–12 — Hooks and Advanced Prompting"
```

---

## Task 9: Part IV — Chapters 13, 14, 15 (Optimization, Security, Examples)

**Source files:**
- Optimization: `guides/12-optimization/` (3 files)
- Security: `guides/15-security/` (3 files)
- Examples: `guides/13-examples/` (1-overview + 5 project files + 7 workflow files + 1 team file)
**Anthropic docs to fetch:**
- `https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching`
- `https://docs.anthropic.com/en/docs/claude-code/security` (if exists, else use overview)
**Files:**
- Modify: `book/chapters/ch13-optimization.tex`, `book/bibliography/ch13.bib`
- Modify: `book/chapters/ch14-security.tex`, `book/bibliography/ch14.bib`
- Modify: `book/chapters/ch15-examples.tex`, `book/bibliography/ch15.bib`

- [ ] **Step 1: Read Optimization source files**

- [ ] **Step 2: Fetch prompt caching / optimization docs**

Verify: current token cost figures, whether prompt caching is available in
Claude Code, and current optimization strategies.

- [ ] **Step 3: Write `book/chapters/ch13-optimization.tex`**

Sections:
```
\chapter{Token Optimization}
  \section{Understanding Token Costs}
  \section{Cost Optimization Strategies}   % 4 core strategies
  \section{Advanced Techniques}            % caching, batching
  \section{Monitoring and Budgeting}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 4: Write `book/bibliography/ch13.bib`**

- [ ] **Step 5: Read Security source files**

- [ ] **Step 6: Write `book/chapters/ch14-security.tex`**

Sections:
```
\chapter{Security and Compliance}
  \section{Secrets Management}
  \section{OWASP Top 10 in AI Workflows}
  \section{Compliance Frameworks}    % GDPR, SOC 2, HIPAA
  \section{Testing and Quality Gates}
  \section{Performance Monitoring}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 7: Write `book/bibliography/ch14.bib`**

Minimum: OWASP Top 10 reference, GDPR regulation citation, SOC 2 framework.

- [ ] **Step 8: Read Examples source files**

Read the overview, then at least one project file and two workflow files.
Examples are illustrative; select representative ones rather than converting all 13.

- [ ] **Step 9: Write `book/chapters/ch15-examples.tex`**

Sections:
```
\chapter{Real-World Examples}
  \section{Project Templates Overview}
  \section{React + TypeScript Project Setup}
  \section{Python Projects (Django, FastAPI)}
  \section{Feature Development Workflow}
  \section{Bug Fixing Workflow}
  \section{Code Review Workflow}
  \section{Testing Workflow}
  \begin{summarybox}...\end{summarybox}
  \printbibliography[...]
```

- [ ] **Step 10: Write `book/bibliography/ch15.bib`**

- [ ] **Step 11: Commit**

```bash
git add book/chapters/ch13-optimization.tex book/bibliography/ch13.bib \
        book/chapters/ch14-security.tex book/bibliography/ch14.bib \
        book/chapters/ch15-examples.tex book/bibliography/ch15.bib
git commit -m "feat: add Chapters 13–15 — Optimization, Security, Examples"
```

---

## Task 10: Appendices and Glossary

**Source files:**
- Reference: `guides/14-reference/` (6 files: api-reference, troubleshooting, faq, cheat-sheet, model-selection-tree, optimization-checklist, glossary)
- Community: `guides/16-community/` (3 files)
- Glossary source: `guides/14-reference/7-glossary.md`
**Files:**
- Modify: `book/appendices/app-a-reference.tex`, `book/bibliography/app-a.bib`
- Modify: `book/appendices/app-b-community.tex`, `book/bibliography/app-b.bib`
- Modify: `book/backmatter/glossary.tex`

- [ ] **Step 1: Read all Reference source files**

- [ ] **Step 2: Write `book/appendices/app-a-reference.tex`**

Structure:
```
\chapter{Reference Documentation}
  \section{Configuration Schema Reference}  % AGENT.md, SKILL.md, config.json
  \section{Troubleshooting Guide}
  \section{Frequently Asked Questions}      % condensed from 50+ FAQ entries
  \section{Quick Reference Cheat Sheet}
  \section{Model Selection Decision Tree}   % TikZ diagram
  \section{Optimization Checklist}
  \printbibliography[...]
```

- [ ] **Step 3: Write `book/bibliography/app-a.bib`**

- [ ] **Step 4: Read Community source files**

- [ ] **Step 5: Write `book/appendices/app-b-community.tex`**

```
\chapter{Community and Contribution}
  \section{Official Resources}
  \section{Contributing to the Ecosystem}  % skills, MCP servers, docs
  \section{Best Practices Catalog}
  \printbibliography[...]
```

- [ ] **Step 6: Write `book/bibliography/app-b.bib`**

- [ ] **Step 7: Convert glossary to `book/backmatter/glossary.tex`**

Convert every term in `guides/14-reference/7-glossary.md` to a `\newglossaryentry`
or `\newacronym` entry. Example:

```latex
% book/backmatter/glossary.tex
\newglossaryentry{mcp}{
  name={Model Context Protocol (MCP)},
  description={An open standard created by Anthropic that lets Claude Code
    connect to external tools and services via a standardized JSON-RPC 2.0
    protocol. See \cref{ch:mcp-servers}.}
}

\newacronym{mcp-acronym}{MCP}{Model Context Protocol}

\newglossaryentry{skill}{
  name={Skill},
  description={A reusable instruction set stored in \texttt{SKILL.md} that
    defines how Claude should perform a specific task. Skills support progressive
    disclosure and per-skill model assignment. See \cref{ch:skills}.}
}
% ... (one entry per glossary term)
```

- [ ] **Step 8: Commit**

```bash
git add book/appendices/ book/bibliography/app-a.bib book/bibliography/app-b.bib \
        book/backmatter/glossary.tex
git commit -m "feat: add appendices A/B and full glossary"
```

---

## Task 11a: Add Per-Section Exercises to Every Chapter

**Goal:** every chapter should reinforce its concepts with practical, hands-on
exercises placed at the end of each major section. Exercises within a chapter
build on each other; where it makes sense, the running "Chapter Project"
carries across chapters so the reader ends Part II with a working
team-style configuration.

**Files:**
- Modify: `book/preamble.tex` (add `exercisebox` environment)
- Modify: every `book/chapters/ch*.tex` (insert exercise blocks)

- [ ] **Step 1: Add an `exercisebox` environment to `book/preamble.tex`**

```latex
\newtcolorbox{exercisebox}[1][Exercises]{
  enhanced,
  title=#1,
  colback=green!5!white,
  colframe=green!40!black,
  fonttitle=\bfseries,
  breakable,
  before upper={\parindent0pt}
}
```

- [ ] **Step 2: Decide on a Running Project**

Throughout chapters 1–7 the exercises build a single hypothetical project —
the team-collaboration setup for a small Node.js service:

1. **Ch 1** — scaffold a `.claude/` directory for the project.
2. **Ch 2** — add the GitHub MCP server (HTTP transport, project scope).
3. **Ch 3** — write three prompts using the seven patterns (CREATE, FIX, REVIEW)
   against the scaffolded project.
4. **Ch 4** — define a `security-reviewer` custom subagent.
5. **Ch 5** — package a `code-review` skill that uses the GitHub MCP server.
6. **Ch 6** — expose the skill as a `/review-pr` slash command.
7. **Ch 7** — annotate the skill and subagent with `model:` fields.

From chapter 8 onward, exercises become topical (per-feature) rather than
building a single artefact, since later chapters cover orthogonal concerns
(thinking, hooks, security, etc.).

- [ ] **Step 3: Add exercises to ch01–ch10 (already written)**

For each chapter, insert `\begin{exercisebox}` ... `\end{exercisebox}`
immediately before the chapter's `\begin{summarybox}`. The block contains a
short header naming what the exercises practice, then an `enumerate` of 2–4
concrete tasks. Provide expected output, commands to run, or files to create
so the reader can self-check.

Example skeleton (place at end of ch02):

```latex
\section{Exercises}
\label{sec:mcp-exercises}

\begin{exercisebox}
These exercises continue the running project from chapter 1. They assume you
have created the \texttt{.claude/} scaffold.

\begin{enumerate}
  \item Install the GitHub MCP server at project scope. Use the HTTP
        transport. Verify with \texttt{claude mcp list} that it appears
        with scope \texttt{project}.
  \item Open \texttt{.mcp.json} in your editor and confirm the URL is
        present but \emph{no} secret is stored literally. Confirm your
        environment exports \texttt{GITHUB\_PAT}.
  \item Start a Claude Code session and run \texttt{/mcp}. Complete the
        OAuth flow if prompted. Ask Claude: \emph{``List the most recent
        five issues on this repository''} and confirm Claude calls the
        GitHub tool rather than asking you for a browser URL.
\end{enumerate}
\end{exercisebox}
```

- [ ] **Step 4: Add exercises to ch11–ch15 as they are written**

Write the exercise block as part of the same task that authors the chapter,
not as a separate pass. This avoids re-reading content for context.

- [ ] **Step 5: Commit**

```bash
git add book/preamble.tex book/chapters/
git commit -m "feat: add per-section exercises to all chapters"
```

---

## Task 11: Final Integration and Compile

**Files:**
- Verify: `book/main.tex` (no changes needed if Tasks 1–10 followed correctly)
- All `book/chapters/*.tex` must have correct `\label{ch:...}` matching `\cref{}` calls

- [ ] **Step 1: Verify all chapter labels are consistent**

```bash
grep -r '\\label{ch:' book/chapters/ | sort
grep -r '\\cref{ch:' book/ | grep -v '\.bib' | sort
```

Expected: every `\cref{ch:X}` target has a matching `\label{ch:X}`.

- [ ] **Step 2: Verify all `\addbibresource` entries in `main.tex` match existing `.bib` files**

```bash
grep 'addbibresource' book/main.tex | sed 's/.*{\(.*\)}/\1/' | while read f; do
  [ -f "book/$f" ] && echo "OK: $f" || echo "MISSING: $f"
done
```

Expected: all lines print `OK`.

- [ ] **Step 3: Verify all glossary entries compile**

```bash
cd book && pdflatex -interaction=nonstopmode main.tex && biber main && makeglossaries main && pdflatex -interaction=nonstopmode main.tex && pdflatex -interaction=nonstopmode main.tex 2>&1 | grep -i 'error\|warning' | head -20
```

Expected: zero fatal errors. Warnings about undefined references are acceptable
on the first pass but should be resolved by the third pass.

- [ ] **Step 4: Verify table of contents, glossary, and index appear in PDF**

Open `book/main.pdf` and confirm:
- Front matter: title page, copyright, ToC with all 15 chapters and 2 appendices
- Each chapter ends with a References section
- Back matter: glossary entries, index

- [ ] **Step 5: Final commit**

```bash
git add book/
git commit -m "feat: complete LaTeX book — all chapters, glossary, index, references compiled"
```

---

## Verification Checklist

After all tasks complete, verify:

- [ ] `CLAUDE.md` reflects the LaTeX book project goals
- [ ] `book/main.tex` compiles to PDF without fatal errors (3-pass: pdflatex, biber, pdflatex×2)
- [ ] All 15 chapters + 2 appendices are present with content (not stubs)
- [ ] Every chapter has a `\begin{summarybox}...\end{summarybox}` section
- [ ] Every chapter has a `\printbibliography[heading=subbibliography]` call
- [ ] Every `.bib` file has ≥ 3 entries with validated URLs
- [ ] Model names throughout match current Anthropic docs (not `4.5` where superseded)
- [ ] `book/backmatter/glossary.tex` has entries for all terms from the source glossary
- [ ] Index entries (`\index{}`) appear in at least Chapters 1–5
- [ ] `book/main.pdf` contains a working table of contents with correct page numbers
