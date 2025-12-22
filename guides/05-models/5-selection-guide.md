# Model Selection Guide

**Reading Time**: 20 minutes
**Skill Level**: All Levels
**Prerequisites**: [Model Overview](1-overview.md)

---

## The Complete Decision Framework 🎯

Master model selection with practical decision trees, real-world scenarios, and optimization strategies.

---

## The 3-Second Decision Rule

**Ask yourself**: "Does this task require understanding and reasoning?"

- **No** → Haiku (searches, formatting, simple operations)
- **Yes, but standard** → Sonnet (features, bugs, tests)
- **Yes, and complex/critical** → Opus (architecture, security, optimization)

---

## Decision Tree by Task Type

### Code Search and Navigation

```
Is it pattern matching or file operations?
└─ YES → Haiku
   Examples:
   - "Find all React components"
   - "List files in src/"
   - "Show me all TODO comments"
```

### Code Modification

```
Does it need code understanding?
├─ NO (rule-based) → Haiku
│  Examples:
│  - "Format with Prettier"
│  - "Sort imports"
│  - "Convert var to const"
│
└─ YES → Is it simple or complex?
   ├─ Simple/Standard → Sonnet
   │  Examples:
   │  - "Add error handling"
   │  - "Fix this bug"
   │  - "Add validation"
   │
   └─ Complex/Critical → Opus
      Examples:
      - "Refactor to microservices"
      - "Optimize algorithm complexity"
      - "Design scalable architecture"
```

### Code Review

```
What depth do you need?
├─ Quick sanity check → Haiku
│  - Syntax errors
│  - Obvious bugs
│
├─ Standard review → Sonnet
│  - Code quality
│  - Best practices
│  - Test coverage
│
└─ Deep/Critical review → Opus
   - Architecture
   - Security audit
   - Performance analysis
```

---

## Real-World Scenarios

### Scenario 1: New Feature Development

**Task**: Add user profile editing

**Breakdown**:
1. Explore existing code → **Haiku** ($0.02)
2. Design API endpoints → **Sonnet** ($0.15)
3. Implement backend → **Sonnet** ($0.25)
4. Write tests → **Sonnet** ($0.20)
5. Code review → **Sonnet** ($0.18)

**Total**: $0.80 with Sonnet mix
**If all Opus**: $3.50 (4.4x more expensive)
**If all Haiku**: $0.15 (poor quality on steps 2-5)

---

### Scenario 2: Bug Investigation

**Task**: Fix mysterious production bug

**Breakdown**:
1. Find relevant code → **Haiku** ($0.01)
2. Understand bug → **Sonnet** ($0.12)
3. Fix + edge cases → **Sonnet** ($0.18)
4. Add regression tests → **Sonnet** ($0.15)
5. Security review → **Opus** ($0.70) ← Critical!

**Total**: $1.16
**Rationale**: Security bugs need Opus to prevent recurrence

---

### Scenario 3: Performance Optimization

**Task**: App is slow, needs optimization

**Breakdown**:
1. Profile hotspots → **Haiku** ($0.02)
2. Analyze patterns → **Sonnet** ($0.15)
3. Design optimization → **Opus** ($0.80) ← Complex!
4. Implement changes → **Sonnet** ($0.30)
5. Verify improvements → **Haiku** ($0.02)

**Total**: $1.29
**Rationale**: Opus for design, Sonnet for execution

---

## Cost Optimization Strategies

### Strategy 1: Progressive Escalation

Start cheap, upgrade if needed:

```bash
# Step 1: Try Haiku first
claude --model=haiku "Refactor this function"

# If result is poor:
# Step 2: Upgrade to Sonnet
claude --model=sonnet "Refactor this function"

# If still not good enough:
# Step 3: Use Opus
claude --model=opus "Refactor this function"
```

**Savings**: Only pay for Opus when necessary

---

### Strategy 2: Hybrid Workflows

Use different models for different phases:

```bash
# Research phase: Haiku
claude --model=haiku "What files handle authentication?"

# Planning phase: Sonnet
claude --model=sonnet "Plan refactoring of auth system"

# Execution phase: Sonnet
claude --model=sonnet "Implement the refactoring"

# Validation phase: Opus (if critical)
claude --model=opus "Deep review of auth security"
```

---

### Strategy 3: Batch Operations

Group similar tasks:

```bash
# Good: Batch with Haiku
claude --model=haiku "Format all files and fix imports"
# Cost: $0.03

# Bad: Individual Sonnet calls
claude --model=sonnet "Format app.ts"
claude --model=sonnet "Format index.ts"
# Cost: $0.24 (8x more expensive)
```

---

## Common Mistakes

### Mistake 1: "Opus is always better"

**Wrong**: Using Opus for everything
```bash
claude --model=opus "Format code"  # $0.20
claude --model=opus "Find files"   # $0.15
claude --model=opus "Fix typo"     # $0.18
# Daily: $50+ (unsustainable)
```

**Right**: Strategic Opus usage
```bash
claude --model=haiku "Format code"    # $0.02
claude --model=haiku "Find files"     # $0.01
claude --model=sonnet "Fix typo"      # $0.10
claude --model=opus "Design system"   # $0.80
# Daily: $8 (sustainable)
```

---

### Mistake 2: "Haiku is good enough"

**Wrong**: Using Haiku for complex tasks
```bash
claude --model=haiku "Design microservices"
# Result: Oversimplified, missing critical considerations
# Cost to fix later: $$$
```

**Right**: Match complexity to model
```bash
claude --model=opus "Design microservices"
# Result: Comprehensive, scalable design
# Saves: Months of rework
```

---

## Quick Reference

### Task-to-Model Mapping

| Task | Haiku | Sonnet | Opus |
|------|-------|--------|------|
| File search | ✅ | - | - |
| Code formatting | ✅ | - | - |
| Import organization | ✅ | - | - |
| Spell checking | ✅ | - | - |
| Bug fixes | - | ✅ | - |
| Feature implementation | - | ✅ | - |
| Test writing | - | ✅ | - |
| Code review (standard) | - | ✅ | - |
| Documentation | - | ✅ | - |
| Architecture design | - | - | ✅ |
| Security audit (deep) | - | - | ✅ |
| Performance optimization | - | - | ✅ |
| Algorithm design | - | - | ✅ |
| System design | - | - | ✅ |

---

## Next Steps

**Phase 2 Continuation:**
- [Thinking Modes Overview](../07-thinking/1-overview.md) - Control reasoning depth
- [Context Management](../08-context/1-overview.md) - Advanced context control

**Optimization:**
- [Token Optimization](../11-optimization/1-cost-optimization.md) - 70%+ cost savings

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
