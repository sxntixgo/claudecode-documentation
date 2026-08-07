# Haiku 4.5 Deep Dive

**Reading Time**: 15 minutes
**Skill Level**: Beginner to Intermediate
**Prerequisites**: [Model Overview](1-overview.md)

---

## Master the Speed Demon ⚡

Haiku 4.5 is Claude's fastest, most cost-effective model. Learn when and how to use it for maximum efficiency.

---

## When Haiku Excels

### ✅ Perfect Use Cases

**1. File Operations**
```bash
# Find files matching a pattern
claude --model=haiku "Find all TypeScript files importing React"
# Speed: 2-3s, Cost: $0.01-0.02

# List files in directory structure
claude --model=haiku "Show me the project structure"
# Speed: 1-2s, Cost: $0.01
```

**2. Code Formatting**
```bash
# Format with Prettier
claude --model=haiku "Format all JavaScript files with Prettier"
# Speed: 3-5s, Cost: $0.02-0.03
# Quality: Perfect (rule-based execution)

# Organize imports
claude --model=haiku "Sort and organize imports in src/app.ts"
# Speed: 2s, Cost: $0.01
```

**3. Pattern Matching and Searches**
```bash
# Find usage patterns
claude --model=haiku "Find all functions using async/await"
# Speed: 3s, Cost: $0.02

# Search for specific code patterns
claude --model=haiku "List all TODO comments in the codebase"
# Speed: 2s, Cost: $0.01
```

**4. Simple Transformations**
```bash
# Convert var to const/let
claude --model=haiku "Convert all var declarations to const or let"
# Speed: 4s, Cost: $0.02

# Update API endpoints
claude --model=haiku "Replace all /api/v1/ with /api/v2/"
# Speed: 2s, Cost: $0.01
```

---

## When to Avoid Haiku

### ❌ Not Suitable For

**Complex Logic**
```bash
# Bad: Architecture design
claude --model=haiku "Design a microservices architecture"
# Result: Oversimplified, misses critical considerations
# Use Opus instead
```

**Deep Code Understanding**
```bash
# Bad: Refactoring
claude --model=haiku "Refactor this to use design patterns"
# Result: May miss context and introduce bugs
# Use Sonnet or Opus instead
```

**Edge Cases**
```bash
# Bad: Security analysis
claude --model=haiku "Audit code for security vulnerabilities"
# Result: Misses subtle vulnerabilities
# Use Sonnet or Opus instead
```

---

## Configuration Examples

### Subagent Configuration

Each subagent carries its own model. `.claude/agents/code-searcher.md`:
```markdown
---
name: code-searcher
description: Locates files, symbols, and usage patterns across the codebase
model: haiku
tools: Read, Glob, Grep
---

Report file paths with line numbers. Do not modify files.
```

To make Haiku the session default instead, set it in `.claude/settings.json`:
```json
{
  "model": "haiku"
}
```

### Skill Configuration

`.claude/skills/code-formatter/SKILL.md`:
```yaml
---
name: code-formatter
model: haiku  # Perfect for rule-based formatting
---
```

---

## Cost Savings Examples

**Scenario: Daily Development**

| Task | Haiku Cost | Sonnet Cost | Savings |
|------|------------|-------------|---------|
| 20 file searches | $0.40 | $2.40 | 83% |
| 15 formatting ops | $0.30 | $1.80 | 83% |
| 10 import fixes | $0.20 | $1.20 | 83% |
| **Total** | **$0.90** | **$5.40** | **83%** |

**Annual Savings**: $1,643 per developer!

---

## Performance Tips

**1. Batch Operations**
```bash
# Good: Batch multiple files
claude --model=haiku "Format all files in src/"

# Less efficient: One at a time
claude --model=haiku "Format src/app.ts"
claude --model=haiku "Format src/index.ts"
# ...
```

**2. Use for Exploration**
```bash
# First: Quick exploration with Haiku
claude --model=haiku "What files handle authentication?"

# Then: Deep work with Sonnet/Opus
claude --model=sonnet "Refactor the authentication system"
```

---

## Next Steps

- [Sonnet 5 Deep Dive](3-sonnet.md) - The all-around workhorse
- [Opus 5 Deep Dive](4-opus.md) - Maximum reasoning power
- [Model Selection Guide](5-selection-guide.md) - Decision frameworks

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
