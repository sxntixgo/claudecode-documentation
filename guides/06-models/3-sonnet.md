# Sonnet 4.5 Deep Dive

**Reading Time**: 15 minutes  
**Skill Level**: Intermediate
**Prerequisites**: [Model Overview](1-overview.md)

---

## The All-Around Workhorse ⚖️

Sonnet 4.5 is the sweet spot for most development tasks - balancing quality, speed, and cost.

---

## When Sonnet Excels

### ✅ Perfect Use Cases

**1. Feature Implementation**
```bash
claude --model=sonnet "Add JWT authentication to the API"
# Quality: Excellent (proper error handling, best practices)
# Speed: 15-20s
# Cost: $0.15-0.25
```

**2. Bug Fixing**
```bash
claude --model=sonnet "Fix the race condition in user login"
# Understands context, handles edge cases
# Speed: 10-15s
# Cost: $0.10-0.18
```

**3. Test Generation**
```bash
claude --model=sonnet "Write comprehensive tests for UserService"
# Generates unit tests, integration tests, edge cases
# Speed: 20-30s
# Cost: $0.20-0.35
```

**4. Code Reviews**
```bash
claude --model=sonnet "Review this PR for issues"
# Thorough analysis, practical suggestions
# Speed: 15-25s
# Cost: $0.15-0.30
```

---

## When to Upgrade to Opus

### ⚠️ Consider Opus For

**Complex Architecture**
```bash
# Sonnet: Good but may oversimplify
claude --model=sonnet "Design event-driven architecture"

# Opus: Comprehensive, considers all trade-offs  
claude --model=opus "Design event-driven architecture"
```

**Security-Critical Code**
```bash
# Sonnet: Catches most issues
claude --model=sonnet "Security audit this payment processor"

# Opus: Catches subtle vulnerabilities
claude --model=opus "Security audit this payment processor"
```

---

## When to Downgrade to Haiku

### ✅ Use Haiku Instead For

**Simple Operations**
```bash
# Overkill with Sonnet
claude --model=sonnet "Format code with Prettier"
# Cost: $0.12, Speed: 8s

# Perfect with Haiku
claude --model=haiku "Format code with Prettier"
# Cost: $0.02, Speed: 3s
# Quality: Identical!
```

---

## Configuration Best Practices

**Default for Most Operations**
```json
{
  "model": "sonnet",
  "agents": {
    "Explore": { "model": "haiku" },
    "general-purpose": { "model": "sonnet" }
  }
}
```

---

## Cost-Benefit Analysis

**Sonnet vs Haiku for Bug Fixes**
- Haiku: $0.03, 75% success rate → $0.04 per successful fix
- Sonnet: $0.18, 92% success rate → $0.20 per successful fix
- **Worth it**: 5x better quality for 5x cost

**Sonnet vs Opus for Feature Development**
- Sonnet: $0.25, 90% quality → Good enough for most features
- Opus: $0.80, 97% quality → Only for critical features
- **Sweet spot**: Sonnet for 90% of features

---

## Next Steps

- [Opus 4.5 Deep Dive](4-opus.md) - Maximum reasoning power
- [Model Selection Guide](5-selection-guide.md) - Decision frameworks

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
