# Thinking Keywords Reference

**Reading Time**: 15 minutes
**Prerequisites**: [Thinking Overview](1-overview.md)

---

## Complete Keyword Guide 📝

Master the keywords that control Claude's reasoning depth.

---

## Keyword Categories

### Basic Thinking
- `"think"`
- `"reason"`
- `"consider"`
- `"analyze"`

**Effect**: Moderate reasoning, ~1.5x tokens

**Examples**:
```bash
"Think about the best approach to cache this data"
"Reason through why this test is failing"
"Consider the trade-offs of using Redux vs Context"
```

---

### Deep Thinking
- `"think hard"`
- `"carefully"`
- `"thoroughly"`
- `"deeply"`

**Effect**: Extended reasoning, ~2x tokens

**Examples**:
```bash
"Think hard about the security implications of this API"
"Carefully design the database migration strategy"
"Thoroughly review the performance optimization options"
```

---

### Maximum Thinking
- `"ultrathink"`
- `"deeply analyze"`
- `"comprehensively evaluate"`
- `"exhaustively consider"`

**Effect**: Maximum reasoning, ~2.5-3x tokens

**Examples**:
```bash
"Ultrathink: Design a scalable microservices architecture"
"Deeply analyze: Find all security vulnerabilities"
"Comprehensively evaluate: Migration from monolith to microservices"
```

---

## Combining with Models

**Optimal Combinations**:

| Task Complexity | Model | Thinking Mode | Cost |
|----------------|-------|---------------|------|
| Simple | Haiku | Normal | $ |
| Standard | Sonnet | Think | $$ |
| Complex | Sonnet | Think Hard | $$$ |
| Critical | Opus | Ultra Think | $$$$ |

**Example**:
```bash
# Good: Sonnet + Think for complex refactoring
claude --model=sonnet "Think through how to refactor this to use dependency injection"

# Overkill: Opus + Ultra Think for simple task
claude --model=opus "Ultrathink: Format this code"

# Underpowered: Haiku + Normal for architecture
claude --model=haiku "Design microservices architecture"
```

---

## Real-World Usage

### Bug Investigation
```bash
# Start simple
"What's causing this error?"

# If unclear, add thinking
"Think about what could cause this race condition"

# If still stuck, go deeper
"Think hard: Analyze all possible causes of this intermittent bug"
```

### Code Review
```bash
# Quick check
"Review this PR"

# Standard review
"Think through any issues in this code"

# Pre-production
"Think hard: Deep security and performance review"
```

---

## Next Steps

- [Output Modes](3-output-modes.md) - Understanding the output format

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
