# Solo Developer Setup

**Reading Time**: 5 minutes
**Skill Level**: Beginner to Intermediate
**Prerequisites**: Basic understanding of Claude Code

Optimal Claude Code configuration for individual developers.

---

## Goals

- **Minimize costs**: ~$5-10/day budget
- **Maximize productivity**: Fast workflows
- **High quality**: Good enough, not perfect

---

## Configuration

`.claude/settings.json`:
```json
{
  "model": "sonnet"
}
```

Sonnet as the session default is the cost/quality baseline. Everything else is a per-agent
or per-skill choice, and those live in frontmatter — there is no `agents` or `skills`
object in settings.json.

**Cheap searches** — `.claude/agents/explore.md`:
```markdown
---
name: explore
description: Fast file searches and navigation. Use when locating code before editing it.
model: haiku
---

Report the file paths and snippets that answer the question. Do not edit files.
```

**Cheap routine skills** — e.g. `.claude/skills/code-formatter/SKILL.md`:
```markdown
---
name: code-formatter
description: Apply formatting and lint fixes across changed files
model: haiku
---
```

Anything that omits `model` inherits Sonnet, so a test-generation skill needs no override.
For a deep review, don't try to configure a second model on the same skill — either invoke
the skill without an override and add a thinking keyword, or keep a separate deep-review
skill with its own `model`.

**Watching spend**: there is no budget or alert-threshold setting. Run `/usage` for the
session's token counts and locally computed cost — press `d` or `w` for 24-hour and 7-day
windows, and on Pro or Max it also shows which skills and subagents your usage went to,
flagging anything above 10%. `/context` shows what is filling the context window, and the
[Console usage page](https://platform.claude.com/usage) is the authoritative bill. Session
totals reset when `/clear` starts a new session.

---

## Daily Workflow

**Morning** (30 min):
```bash
# Check what to work on
/list-tasks

# Plan the day
claude "Review today's tasks and suggest priorities"
```

**Development** (6 hours):
```bash
# Quick iterations
/format          # Before commits
/test --quick    # Run relevant tests
/review          # Quick review
```

**End of Day** (15 min):
```bash
# Final checks
/review --deep   # Deep review of new code
/build           # Ensure build works
/commit          # Generate commit message
```

---

## Cost Breakdown

**Typical Day**:
- Searches: 20 × $0.02 = $0.40
- Formatting: 15 × $0.02 = $0.30
- Coding: 25 × $0.18 = $4.50
- Testing: 10 × $0.18 = $1.80
- Reviews: 5 × $0.08 = $0.40

**Total**: $7.40/day = $148/month

---

## Optimization Tips

1. **Use Haiku for routine tasks**
   - File searches
   - Code formatting
   - Quick reviews

2. **Batch operations**
   - Format all files at once
   - Run full test suite periodically

3. **Progressive disclosure**
   - Start with quick review
   - Only go deep when needed

4. **Cache expensive operations**
   - Re-use recent analyses
   - Don't re-analyze unchanged files

---

**Next**: [Small Team (2-5)](2-small-team.md)
