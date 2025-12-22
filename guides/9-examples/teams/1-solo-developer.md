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

`.claude/config.json`:
```json
{
  "agents": {
    "Explore": { "model": "haiku" },
    "general-purpose": { "model": "sonnet" }
  },
  "skills": {
    "code-review": {
      "model": "haiku",
      "modelOverrides": {
        "deep": "sonnet"
      }
    },
    "test-generator": { "model": "sonnet" },
    "code-formatter": { "model": "haiku" }
  },
  "defaultModel": "sonnet",
  "costTracking": {
    "enabled": true,
    "dailyBudget": 75000,
    "alertThreshold": 0.8
  }
}
```

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
