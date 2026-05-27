# Claude Code — LaTeX Book Project

## Project Goal

Convert the Claude Code documentation (67 Markdown guides) into a fully typeset
LaTeX book: *Mastering Claude Code* (working title).

## Repository Layout

```
guides/          # Source Markdown (do not delete — canonical content source)
book/            # LaTeX project (output target)
  main.tex       # Master document
  preamble.tex   # Packages and global settings
  gimenezocano.sty  # Visual style (typography, admonitions, code blocks)
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
| II — Core Components    | 4 Agents, 5 Skills, 6 Commands, 7 Models            | guides/03–06      |
| III— Advanced Features  | 8–12 (Thinking, Context, Keywords, Hooks, Prompting)| guides/08–11, 17  |
| IV — Production         | 13 Optimization, 14 Security, 15 Examples           | guides/12–13, 15  |
| App A/B                 | Reference Docs, Community                           | guides/14, 16     |

## Language and Style Conventions

- **American English** throughout the book and the .bib files.
  - Use `optimization`, `summarize`, `organize`, `recognize`, `specialized`,
    `behavior`, `authorization`, `analyze`, `color`, `catalog`, `center`.
  - Do **not** use `optimisation`, `summarise`, `organise`, `colour`,
    `behaviour`, `analyse`, `centre`, `catalogue`.
- LaTeX option names should also match (`cleveref` uses `capitalize`, not
  `capitalise`).
- Body voice: present-tense, imperative or instructional ("Run X", "Claude
  reads Y"). Avoid passive constructions.
- Quotation marks in body text: LaTeX style ``…''. Straight `"…"` is only
  acceptable inside `lstlisting` blocks (where it represents real CLI input).

## Per-Chapter Workflow (required)

Before writing each chapter's summary and bibliography:
1. Read all source `.md` files for that chapter.
2. Fetch the relevant Anthropic documentation (URLs listed in the plan).
3. Note and incorporate any content updates (model names, API details, pricing).
4. Validate/update references in the `.bib` file — remove dead links, add new ones.
5. Write the `\begin{summarybox}...\end{summarybox}` based on verified content.
6. Add per-section exercises with the `exercisebox` environment, building on
   the running project from earlier chapters (see plan, Task 11a).

## Chapter Label Convention

Each `chapters/chNN-<topic>.tex` declares `\label{ch:<topic>}` — **not**
`\label{ch:chNN-<topic>}`. Other chapters cross-reference by topic name with
`\cref{ch:<topic>}`. Stub files must be updated to the topic-name form before
their chapter is referenced from elsewhere.

Currently active labels:

| File                                  | Label                       |
|---------------------------------------|-----------------------------|
| ch01-plugin-ecosystem.tex             | `ch:plugin-ecosystem`       |
| ch02-mcp-servers.tex                  | `ch:mcp-servers`            |
| ch03-prompt-basics.tex                | `ch:prompt-basics`          |
| ch04-agents.tex                       | `ch:agents`                 |
| ch05-skills.tex                       | `ch:skills`                 |
| ch06-commands.tex                     | `ch:commands`               |
| ch07-models.tex                       | `ch:models`                 |
| ch08-thinking.tex                     | `ch:thinking`               |
| ch09-context.tex                      | `ch:context`                |
| ch10-keywords.tex                     | `ch:keywords`               |
| ch11-hooks.tex                        | `ch:hooks`                  |
| ch12-advanced-prompting.tex           | `ch:advanced-prompting`     |
| ch13-optimization.tex                 | `ch:optimization`           |
| ch14-security.tex                     | `ch:security`               |
| ch15-examples.tex                     | `ch:examples`               |

## LaTeX Conventions

- Document class: `book` (12pt, twoside, openright)
- Visual style: `book/gimenezocano.sty` (loaded from `preamble.tex`).
  Provides serif body (XCharter), monospace (Inconsolata), GitHub-style
  admonitions (`note`, `tip`, `important`, `warning`, `caution`), and a
  rounded code-block style.
- Bibliography: `biblatex` + `biber`, `refsection=chapter`
- Print chapter bibliography: `\printbibliography[heading=subbibliography]`
- Code listings: `listings` via the `ghcode` style from gimenezocano.sty
- Diagrams: `tikz` (convert Mermaid diagrams to TikZ)
- Index: `imakeidx` — add `\index{}` for key terms
- Glossary: `glossaries-extra` — entries in `backmatter/glossary.tex`
- Chapter summaries: `summarybox` tcolorbox (preamble.tex)
- Chapter exercises: `exercisebox` tcolorbox (preamble.tex)

## Box Environment Reference

| Environment   | Defined in         | Purpose                                          |
|---------------|--------------------|--------------------------------------------------|
| `note`        | gimenezocano.sty   | Side note — blue admonition                      |
| `tip`         | gimenezocano.sty   | Tip — green admonition                           |
| `important`   | gimenezocano.sty   | Important — purple admonition                    |
| `warning`     | gimenezocano.sty   | Warning — amber admonition                       |
| `caution`     | gimenezocano.sty   | Caution — red admonition                         |
| `summarybox`  | preamble.tex       | End-of-chapter summary (blue)                    |
| `exercisebox` | preamble.tex       | End-of-section exercises (green)                 |

Older chapters may still use `notebox` / `warningbox`; rename to `note` /
`warning` as you touch each chapter.

## Build Commands

```bash
cd book
pdflatex -interaction=nonstopmode main.tex
biber main
makeglossaries main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

For a B&W print-ready PDF, pass `[print]` to the style file
(`\usepackage[print]{gimenezocano}` in `preamble.tex`).

## Writing Guidelines

- Progressive disclosure: simple → complex within each chapter
- Real examples in every section
- Cost transparency: include token implications where relevant
- Cross-reference related chapters with `\cref{ch:label}`
- Exercises after each major section; let them build on each other so the
  reader ends each part with a working artifact, not a list of disconnected
  drills.

## Official References

- Claude Code Docs: https://docs.anthropic.com/en/docs/claude-code/overview
- Anthropic Models:  https://docs.anthropic.com/en/docs/about-claude/models/overview
- MCP Specification: https://modelcontextprotocol.io/specification
- Community Skills:  https://github.com/obra/superpowers
