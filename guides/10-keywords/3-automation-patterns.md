# Custom Automation Patterns

**Reading Time**: 20 minutes
**Skill Level**: Advanced
**Prerequisites**: [Slash Commands](2-slash-commands.md), [Custom Skills](../04-skills/3-creating-skills.md)

---

## Automate Everything! 🤖

Learn advanced patterns for automating workflows with keywords, triggers, and hooks.

---

## Auto-Trigger Patterns

### Pattern 1: Keyword-Based Triggers

Auto-invoke skills based on natural language:

`.claude/skills/code-review/SKILL.md`:
```yaml
---
name: code-review
autoTrigger:
  patterns:
    - "review.*code"
    - "check.*pr"
    - "audit.*code"
    - "look.*over.*changes"
  confidence: 0.85
---
```

**Usage:**
```bash
# All of these trigger code-review skill automatically
"Review my code for issues"
"Check this PR before I merge"
"Audit the code in auth.ts"
"Can you look over my changes?"
```

---

### Pattern 2: File Pattern Triggers

Auto-select skills based on file types. This lives in the skill itself, via the `paths` field
in its frontmatter — there is no central trigger registry:

`.claude/skills/test-runner/SKILL.md`:
```yaml
---
name: test-runner
description: Run and interpret the test suite
paths:
  - "**/*.test.ts"
  - "**/*.spec.ts"
---
```

`.claude/skills/database-migration/SKILL.md`:
```yaml
---
name: database-migration
description: Write and review database migrations
paths:
  - "**/migrations/*.sql"
---
```

Each skill declares the files it cares about, so adding a skill needs no edit anywhere else.
Keep `description` sharp regardless of `paths` — it is still what Claude reads when deciding
whether the skill is relevant.

---

### Pattern 3: Context-Based Triggers

Trigger different behaviors based on context:

`.claude/CLAUDE.md`:
```markdown
## Auto-Triggers

### Pre-Commit Hook
When committing changes:
1. Auto-run `/format`
2. Auto-run `/lint --fix`
3. Auto-run `/test`
4. Generate commit message

### Pre-PR Hook
Before creating PR:
1. Run `/review --deep`
2. Check test coverage
3. Update changelog
4. Generate PR description
```

---

## Workflow Automation

### Workflow 1: TDD Cycle

Automate test-driven development:

`.claude/workflows/tdd.md`:
```markdown
# TDD Automation

## Trigger
When user says "TDD" or "test-driven"

## Workflow
1. Ask what feature to build
2. Write failing test
3. Run test (verify failure)
4. Write minimum code to pass
5. Run test (verify success)
6. Refactor
7. Run test again
8. Commit changes
```

---

### Workflow 2: Feature Development

End-to-end feature automation:

`.claude/workflows/feature.md`:
```markdown
# Feature Development Workflow

## Trigger
`/feature <name>`

## Steps
1. Create feature branch
2. Update CLAUDE.md with feature context
3. Generate API specification
4. Implement backend
5. Write backend tests
6. Implement frontend
7. Write frontend tests
8. Run full test suite
9. Code review
10. Create PR
```

---

## Git Hooks Integration

### Pre-Commit Hook

`.claude/hooks/pre-commit.sh`:
```bash
#!/bin/bash

echo "Running pre-commit checks..."

# 1. Format code
claude "/format" || exit 1

# 2. Lint
claude "/lint --fix" || exit 1

# 3. Run tests
claude "/test --changed-files" || exit 1

# 4. Generate commit message
COMMIT_MSG=$(claude "/commit")

echo "$COMMIT_MSG" > .git/COMMIT_EDITMSG

echo "✅ Pre-commit checks passed!"
```

---

### Pre-Push Hook

`.claude/hooks/pre-push.sh`:
```bash
#!/bin/bash

echo "Running pre-push checks..."

# 1. Full test suite
claude "/test --all" || {
  echo "❌ Tests failed. Push aborted."
  exit 1
}

# 2. Security scan
claude "/security-scan" || {
  echo "⚠️  Security issues found. Continue? (y/n)"
  read -r response
  if [ "$response" != "y" ]; then
    exit 1
  fi
}

# 3. Build check
claude "/build" || {
  echo "❌ Build failed. Push aborted."
  exit 1
}

echo "✅ Pre-push checks passed!"
```

---

## CI/CD Integration

### GitHub Actions

`.github/workflows/claude-review.yml`:
```yaml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Claude Code
        run: npm install -g @anthropic/claude-code

      - name: Run Code Review
        env:
          CLAUDE_API_KEY: ${{ secrets.CLAUDE_API_KEY }}
        run: |
          claude -p "/code-review Review the changes in this PR" > review.md

      - name: Post Review as Comment
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const review = fs.readFileSync('review.md', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: review
            });
```

---

## Smart Defaults

### Set a Sensible Default Model

There is no rule engine that matches your prompt against patterns and picks a model. Model
selection has two layers, and both are explicit.

**Layer 1 — the session default**, in `.claude/settings.json`:

```json
{
  "model": "sonnet",
  "fallbackModel": "haiku"
}
```

Sonnet is the balanced default worth starting from; `fallbackModel` is what Claude Code drops
to if the primary model is unavailable.

**Layer 2 — per-behavior overrides**, declared where the behavior is defined. A search-heavy
subagent pins Haiku in its own frontmatter; a skill that reasons about architecture pins Opus
in its `SKILL.md`:

```yaml
---
name: explore
description: Search the codebase and report findings
model: haiku
---
```

That is the real version of "auto-select the optimal model": you decide once, per skill or per
subagent, at the place that already describes what the work is.

See [Model Assignment for Skills](../04-skills/4-model-assignment.md) for how far to push this.

---

## Next Steps

**Phase 3 Continuation:**
- [Cost Optimization Overview](../12-optimization/1-cost-optimization.md) - Advanced savings strategies

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
