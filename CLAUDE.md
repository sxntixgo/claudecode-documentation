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
| II — Core Components    | 4 Agents, 5 Skills, 6 Commands, 7 Models            | guides/03–06      |
| III— Advanced Features  | 8–12 (Thinking, Context, Keywords, Hooks, Prompting)| guides/08–11, 17  |
| IV — Production         | 13 Optimization, 14 Security, 15 Examples           | guides/12–13, 15  |
| App A/B                 | Reference Docs, Community                           | guides/14, 16     |

## Per-Chapter Workflow (required)

Before writing each chapter's summary and bibliography:
1. Read all source `.md` files for that chapter.
2. Fetch the relevant Anthropic documentation (URLs listed in the plan).
3. Note and incorporate any content updates (model names, API details, pricing).
4. Validate/update references in the `.bib` file — remove dead links, add new ones.
5. Write the `\begin{summarybox}...\end{summarybox}` based on verified content.

## LaTeX Conventions

- Document class: `book` (12pt, twoside, openright)
- Bibliography: `biblatex` + `biber`, `refsection=chapter`
- Print chapter bibliography: `\printbibliography[heading=subbibliography]`
- Code listings: `listings` package with custom style defined in `preamble.tex`
- Diagrams: `tikz` (convert Mermaid diagrams to TikZ)
- Index: `imakeidx` — add `\index{}` for key terms
- Glossary: `glossaries-extra` — entries defined in `backmatter/glossary.tex`
- Chapter summaries: custom `summarybox` tcolorbox defined in `preamble.tex`

## Build Commands

```bash
cd book
pdflatex -interaction=nonstopmode main.tex
biber main
makeglossaries main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

## Writing Guidelines (from source)

- Progressive disclosure: simple → complex within each chapter
- Real examples in every section
- Cost transparency: always include token implications where relevant
- Cross-reference related chapters with `\cref{ch:label}`

## Official References

- Claude Code Docs: https://docs.anthropic.com/en/docs/claude-code/overview
- Anthropic Models:  https://docs.anthropic.com/en/docs/about-claude/models/overview
- MCP Specification: https://modelcontextprotocol.io/specification
- Community Skills:  https://github.com/obra/superpowers
