# Thinking Modes Overview

**Reading Time**: 15 minutes
**Skill Level**: Intermediate
**Prerequisites**: [Model Overview](../04-models/1-overview.md)

---

## Control Claude's Reasoning Depth 🧠

Thinking modes let you control how deeply Claude reasons about your requests using special keywords.

---

## What Are Thinking Modes?

**Normal Mode** (default):
- Fast, direct answers
- Minimal internal reasoning
- Lower token usage

**Thinking Mode** (activated by keywords):
- Extended reasoning process
- Shows thought process
- Higher quality for complex tasks
- More tokens used

---

## Quick Comparison

| Mode | Keywords | Speed | Tokens | Best For |
|------|----------|-------|--------|----------|
| **Normal** | (none) | Fast | Low | Simple tasks |
| **Think** | "think", "reason" | Medium | Medium | Standard complexity |
| **Think Hard** | "think hard", "carefully" | Slow | High | Complex analysis |
| **Ultra Think** | "ultrathink", "deeply analyze" | Slowest | Highest | Critical decisions |

---

## When to Use Each Mode

### Normal Mode (Default)
```bash
# Simple, straightforward tasks
"Format this code with Prettier"
"Find all React components"
"Fix the typo in line 42"
```

### Think Mode
```bash
# Moderate complexity
"Think about the best way to refactor this"
"Reason through this bug and suggest fixes"
"Consider edge cases for this feature"
```

### Think Hard Mode
```bash
# Complex problems
"Think hard about the security implications"
"Carefully design the database schema"
"Analyze the performance bottlenecks"
```

### Ultra Think Mode
```bash
# Critical decisions
"Ultrathink: Design the system architecture"
"Deeply analyze: Security audit for production"
"Thoroughly reason: Migration strategy"
```

---

## Cost Impact

**Example Task**: "Refactor this authentication system"

| Mode | Tokens | Cost | Quality |
|------|--------|------|---------|
| Normal | 12,000 | $0.18 | 80% |
| Think | 18,000 | $0.27 | 90% |
| Think Hard | 25,000 | $0.38 | 95% |
| Ultra Think | 35,000 | $0.53 | 97% |

---

## Next Steps

- [Thinking Keywords Reference](2-keywords.md) - Complete keyword guide
- [Output Modes](3-output-modes.md) - Understanding thinking output

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
