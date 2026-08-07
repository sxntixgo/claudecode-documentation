# Changelog

All notable changes to this documentation will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Nothing yet.

## [3.0.0] - 2026-08-07

**Why a major version**: this release removes documentation for APIs that do not
exist. Anyone who followed the previous guides created files Claude Code never
reads and ran commands that do not resolve, so the corrections are breaking for
existing readers even though no software changed.

### Added

**Prompt Engineering** (6 guides)
- `guides/02-prompt-basics/` — the four-part prompt formula and seven core patterns
- `guides/17-advanced-prompting/` — chain-of-thought, few-shot, context optimization, cost-aware prompting

**Context Engineering**
- `guides/09-context/4-context-engineering.md` — the runtime counterpart to the existing
  CLAUDE.md authoring guides. Attention budget and context rot, subagent context isolation,
  just-in-time retrieval, compaction versus clearing, and diagnosis with `/context` and `/usage`.

**Loops and Scheduling**
- `guides/03-agents/6-loops-and-scheduling.md` — the counterpart to orchestration: how a single
  agent keeps going without a prompt each step. `/goal` (condition-driven, including the
  evaluator's blind spot — it only sees the conversation), `/loop` (interval-driven, three
  modes, `loop.md`), cron scheduling with its jitter and seven-day expiry, polling versus
  Monitor and Channels, and the routines/desktop/`/loop` comparison for unattended work.

**Orchestration**
- `guides/03-agents/5-orchestration-patterns.md` — multi-agent topology using the
  graph-engineering vocabulary, scoped to what Claude Code actually provides. Fan-out/fan-in,
  pipelines, supervisor delegation, nested delegation, and verification, plus the real
  concurrency limits and an explicit statement of where Claude Code stops.

### Fixed — Documented APIs That Did Not Exist

A verification pass against the official Claude Code documentation found several
mechanisms documented throughout these guides that do not exist. Readers following them
would have created files Claude Code never reads and run commands that do not resolve.

- **`.claude/config.json`** (52 references, 23 files) — never a Claude Code file. Migrated to
  `.claude/settings.json`, restructuring the schemas that do not map across: per-agent models
  live in `.claude/agents/<name>.md` frontmatter, per-skill models in the skill's own
  `SKILL.md`, and `hooks`/`permissions`/`env` stay as real settings keys.
- **`costTracking`, `cost-log.json`, `budgets`, `teamBudgets`, `dailyBudget`** — no local cost
  tracking or budget enforcement exists. Replaced with `/usage` (which does per-skill,
  per-subagent, per-plugin attribution), `/context`, the Console usage page, and
  OpenTelemetry export. Spend caps are organization-level only.
- **`claude --skill=<name>` and `@claude/skill-testing`** — skills are invoked with
  `/skill-name`, or `claude -p "/skill-name ..."` non-interactively. The npm package does not exist.
- **`modelOverrides`** — a skill has one model. Cascades are separate skills, or the `effort` dial.
- **Fabricated frontmatter fields** — removed `version`, `author`, `category`, `tags`,
  `options`, `dependencies`, `requiredTools`, `mcpServers`, `costEstimate`, `approvalRequired`
  from SKILL.md, and `constraints`/`allowedPaths`/`deniedPaths`/`timeout` from agent files.
  Documented the real fields the guides had omitted, including `when_to_use`, `paths`,
  `effort`, `disallowed-tools`, `user-invocable`, and `context: fork`.
- **`CLAUDE_CONFIG_PATH`, `defaultModel`, `defaultSkillModel`** — settings paths are fixed per
  scope; the model key is `model`.
- **Exact-match skill testing** — `diff -q` and snapshot assertions were recommended against
  model-generated output, which fails on harmless rewording while missing real regressions.
  Replaced with the real evaluation framework: `evals/evals.json`, with-skill versus
  without-skill baseline comparison, assertion plus rubric grading, benchmark pass rate
  against tokens, and trigger-accuracy tuning via `skill-creator`.
- **Unsourced quality benchmarks** — tables asserting figures such as "97% quality" with no
  methodology, and contradicting themselves. Replaced with task-type guidance and
  instructions to measure.

### Changed
- Model pricing updated to current rates (Haiku $1/$5, Sonnet $3/$15, Opus $5/$25 per 1M tokens)
- `guides/05-commands/1-overview.md` documents that custom commands and skills are now one
  system — `.claude/commands/deploy.md` and `.claude/skills/deploy/SKILL.md` both create `/deploy`
- CLAUDE.md size guidance corrected to under 200 lines
- Memory documentation corrected: there is no `.claude/memory.md`. Auto memory lives at
  `~/.claude/projects/<project>/memory/`, where `MEMORY.md` loads at 200 lines or 25KB

### Planned
- Go microservices template
- Rust project template
- Additional skill templates and examples

## [2.1.0] - 2025-12-22

> Previously published as `1.0.0`, which duplicated the 2025-01-10 entry and
> placed this release out of order. Renumbered to reflect that it followed 2.0.0.

### Milestone: Complete Production-Ready Documentation

**Summary**: All phases (0-5) complete. Comprehensive, production-ready documentation covering all Claude Code features from fundamentals to advanced optimization.

### Added - Documentation Foundation (Phases 0-5)

**Phase 0: Foundation**
- README.md - Repository overview and quick start
- INTRODUCTION.md - Learning paths and navigation guide
- TABLE_OF_CONTENTS.md - Complete navigation with 13 sections
- DOCUMENTATION_PLAN.md - Complete roadmap and plan

**Phase 1: Core Components** (14 guides)
- MCP Servers guides (5 guides) - Installation, popular servers, custom servers
- Agents guides (4 guides) - Built-in agents, custom agents, model assignment
- Skills guides (5 guides) - Creating skills, marketplace, advanced patterns

**Phase 2: Advanced Configuration** (13 guides)
- Model selection guides (5 guides) - Haiku, Sonnet, Opus comparison and selection
- Thinking modes guides (2 guides) - Extended thinking, keywords reference
- Context management guides (3 guides) - CLAUDE.md files, memory hierarchy
- Keywords & Triggers guides (3 guides) - Overview, slash commands, automation patterns

**Phase 3: Optimization** (6 guides)
- Token optimization guides (3 guides) - Cost optimization, advanced techniques, monitoring

**Phase 4: Examples & Templates** (12 guides)
- Python project templates (Django, FastAPI, Flask)
- Workflow guides (7 workflows) - Feature development, bug fixing, code review, refactoring, documentation, performance, testing
- Team configurations - Solo developer setup

**Phase 5: Reference & Production** (13 guides)
- API reference, troubleshooting guide, FAQ, cheat sheet
- Security & compliance, testing & quality, performance monitoring
- Quick reference tools (model selection tree, optimization checklist, glossary)
- Community resources, contribution guide, best practices catalog

### Documentation Statistics
- **Total Guides**: 58 comprehensive guides
- **Total Content**: 100,000+ words
- **Reading Time**: ~20 hours of content
- **Code Examples**: 200+ working examples
- **Diagrams**: 30+ Mermaid diagrams
- **Coverage**: 100% of Claude Code features
- **Production Readiness**: 100%

### Quality Improvements
- Fixed 37+ broken links in navigation
- Added consistent section numbering (1-13)
- Complete pedagogical rationale for all sections
- Added metadata to all guides
- Complete learning checkpoint progression
- Added Community & Contribution section

## [2.0.0] - 2025-01-15

### Added - Phase 5: Reference & Advanced Topics
- **Complete API Reference** (guides/14-reference/1-api-reference.md)
  - AGENT.md schema with complete examples
  - SKILL.md schema with frontmatter specification
  - config.json schema with all options
  - Hook specifications for all hook types
  - Slash command schema
  - CLAUDE.md structure guidelines
  - Environment variables reference
  - File locations guide

- **Troubleshooting Guide** (guides/14-reference/2-troubleshooting.md)
  - MCP server issues (loading, authentication, timeout)
  - Agent and subagent issues (timeout, model assignment, debugging)
  - Skill loading issues (invocation, progressive disclosure)
  - Token and cost issues (high usage, context exceeded)
  - Configuration issues (syntax, CLAUDE.md loading)
  - Git and version control issues (hooks, branch naming)
  - Performance issues (slow response, high memory)
  - Installation and setup issues

- **Comprehensive FAQ** (guides/14-reference/3-faq.md)
  - 50+ questions across 8 categories
  - General questions about Claude Code
  - MCP server questions
  - Agent questions
  - Skill questions
  - Model questions
  - Context management questions
  - Optimization questions
  - Customization questions

- **Quick Reference Cheat Sheet** (guides/14-reference/4-cheat-sheet.md)
  - One-page printable reference
  - Command line commands
  - Model pricing table
  - Thinking keywords reference
  - Agent types overview
  - Config examples
  - Optimization checklist
  - Common patterns
  - Troubleshooting quick fixes

- **CHANGELOG.md** - This file
- **Expanded Phase 5 in DOCUMENTATION_PLAN.md**
  - 11 major sections with 25+ deliverables
  - Complete specifications for all Phase 5 content

### Changed
- Updated DOCUMENTATION_PLAN.md with comprehensive Phase 5 specifications

## [1.0.0] - 2025-01-10

### Added - Phases 0-4: Complete Foundation

#### Phase 0: Documentation Foundation
- **README.md** - Repository overview and quick start
- **TABLE_OF_CONTENTS.md** - Master navigation with reading paths
- **INTRODUCTION.md** - Comprehensive 15-page introduction
- **Documentation Professor Skill** - Active skill for writing documentation

#### Phase 1: Foundation Documentation (14 guides)
- **MCP Servers** (5 guides)
  - 1-overview.md - Conceptual foundation with Mermaid diagram
  - 2-installation.md - CLI, manual, and Docker installation
  - 3-popular-servers.md - Catalog of available servers
  - **4-creating-custom-servers.md** - Complete TypeScript creation guide
  - 5-best-practices.md - Security, performance, monitoring

- **Agents** (4 guides)
  - 1-overview.md - Agent types with Mermaid diagram
  - 2-built-in-agents.md - Explore, General-Purpose, Plan deep dive
  - 3-model-assignment.md - Cost optimization (50-60% savings)
  - **4-custom-agents.md** - Creating specialized agents

- **Skills** (5 guides)
  - 1-overview.md - Progressive disclosure pattern
  - 2-marketplace-skills.md - Installing and using marketplace skills
  - **3-creating-skills.md** - SKILL.md structure and creation
  - 4-model-assignment.md - Per-skill model optimization
  - 5-advanced-patterns.md - Composition, testing, versioning

#### Phase 2: Advanced Configuration (13 guides)
- **Models** (5 guides)
  - 1-overview.md - Complete comparison of Haiku, Sonnet, Opus
  - 2-haiku.md - Speed demon deep dive
  - 3-sonnet.md - All-around workhorse
  - 4-opus.md - Maximum reasoning power
  - 5-selection-guide.md - Decision frameworks

- **Thinking Modes** (3 guides)
  - 1-overview.md - Reasoning depth control
  - 2-keywords.md - Complete keyword reference
  - 3-output-modes.md - Thought process visibility

- **Context Management** (3 guides)
  - 1-overview.md - Context hierarchy
  - 2-claude-md.md - CLAUDE.md structure
  - 3-memory-hierarchy.md - Multi-tier optimization

#### Phase 3: Optimization (6 guides)
- **Keywords & Triggers** (3 guides)
  - 1-overview.md - Keywords and automation overview
  - **2-slash-commands.md** - Creating slash commands
  - 3-automation-patterns.md - Workflows, hooks, CI/CD

- **Token Optimization** (3 guides)
  - 1-cost-optimization.md - 10 principles, 70-80% savings
  - 2-advanced-techniques.md - Expert-level strategies
  - 3-monitoring-budgeting.md - ROI tracking

#### Phase 4: Examples & Templates (5 guides)
- 1-overview.md - Examples overview
- projects/1-react-typescript.md - Complete React template
- projects/2-nodejs-api.md - Node.js API template
- workflows/1-feature-development.md - 6-phase workflow
- teams/1-solo-developer.md - Solo developer setup

### Summary of 1.0.0 Release
- **38 comprehensive guides** created
- **4 creation guides** delivered (MCP, Agents, Skills, Slash Commands)
- **20,000+ lines** of documentation
- **900 minutes** of reading content (15 hours)
- **70-80% cost savings** strategies documented
- **Production-ready** documentation ecosystem

---

## Documentation Statistics

### Total Content (as of 2.0.0)
- **42 guides** (38 from 1.0.0 + 4 new in 2.0.0)
- **25,000+ lines** of markdown
- **1,100+ minutes** of reading content
- **4 creation guides** (MCP, Agents, Skills, Slash Commands)
- **1 active skill** (Documentation Professor)
- **Complete API reference**
- **Comprehensive troubleshooting guide**
- **50+ FAQ answers**
- **Quick reference cheat sheet**

### Coverage
- ✅ MCP Servers (complete)
- ✅ Agents (complete)
- ✅ Skills (complete)
- ✅ Models (complete)
- ✅ Thinking Modes (complete)
- ✅ Context Management (complete)
- ✅ Keywords & Triggers (complete)
- ✅ Token Optimization (complete)
- ✅ Examples & Templates (5 templates)
- ✅ Reference Documentation (API, FAQ, Troubleshooting, Cheat Sheet)
- 🚧 Additional Templates (in progress)
- 🚧 Additional Workflows (in progress)
- 🚧 Security & Compliance (planned)
- 🚧 Testing & Quality (planned)
- 🚧 Community Resources (planned)

---

## Update Schedule

### Regular Updates
- **Major updates**: Within 1 week of Claude Code releases
- **Minor updates**: Weekly for community contributions
- **Quarterly reviews**: Comprehensive review and testing of all examples
- **Annual refresh**: Major documentation refresh and reorganization

### Monitoring
- Track Claude Code release notes
- Monitor community forum questions
- Review GitHub issue reports
- Collect user feedback
- Update based on usage patterns

---

## Contributing

Want to help improve this documentation?

### How to Contribute
1. **Report Issues**: Found an error? [Open an issue](https://github.com/your-repo/issues)
2. **Suggest Content**: Missing documentation? Suggest new guides
3. **Submit PRs**: Fix typos, improve examples, add templates
4. **Share Feedback**: Let us know what's helpful or confusing

### Contribution Areas
- ✅ Fix typos and grammar
- ✅ Improve code examples
- ✅ Add real-world use cases
- ✅ Create new project templates
- ✅ Write workflow guides
- ✅ Add troubleshooting solutions
- ✅ Expand FAQ answers

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## Maintainers

**Primary Maintainer**: Documentation Team

**Contributors**: Community submissions welcome!

**Questions?**: Open an issue or contact the team

---

## License

This documentation is provided under [MIT License](LICENSE).

Feel free to use, share, and adapt with attribution.

---

**Stay Updated**: Watch this repository for new releases and updates!

**Feedback**: Your input makes this documentation better. Share your thoughts!
