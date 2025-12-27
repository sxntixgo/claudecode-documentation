# Opus 4.5 Deep Dive

**Reading Time**: 15 minutes
**Skill Level**: Advanced
**Prerequisites**: [Model Overview](1-overview.md)

---

## Harness Maximum Reasoning Power 🧠

Opus 4.5 is Claude's most capable model - use it strategically for complex, critical tasks.

---

## When Opus Excels

### ✅ Perfect Use Cases

**1. System Architecture**
```bash
claude --model=opus "Design microservices architecture for e-commerce platform"
# Comprehensive design with:
# - Service boundaries
# - Communication patterns
# - Data consistency strategies
# - Failure handling
# - Scalability considerations
```

**2. Security Audits**
```bash
claude --model=opus "Deep security audit - check OWASP Top 10 + logic flaws"
# Finds:
# - Subtle injection vulnerabilities
# - Authentication bypasses
# - Race conditions
# - Business logic flaws
```

**3. Performance Optimization**
```bash
claude --model=opus "Optimize database queries and fix N+1 problems"
# Analyzes:
# - Query patterns
# - Index strategies
# - Caching opportunities
# - Connection pooling
```

**4. Complex Refactoring**
```bash
claude --model=opus "Refactor monolith to hexagonal architecture"
# Maintains:
# - Functionality
# - Test coverage
# - Domain logic
# - Clean abstractions
```

---

## When Opus is Overkill

### ❌ Don't Use Opus For

**Simple Tasks**
```bash
# Waste of money
claude --model=opus "Format code with Prettier"
# Cost: $0.20 vs Haiku $0.02

# Unnecessary
claude --model=opus "Find files importing React"
# Cost: $0.15 vs Haiku $0.01
```

**Standard CRUD Operations**
```bash
# Sonnet is fine
claude --model=sonnet "Add CRUD endpoints for Product"
# Cost: $0.25, Quality: 92%

# Opus is overkill
claude --model=opus "Add CRUD endpoints for Product"  
# Cost: $0.90, Quality: 95% (marginal improvement)
```

---

## Strategic Opus Usage

**Rule of Thumb**: Use Opus when the cost of getting it wrong > cost of Opus

**Examples**:
- ✅ Payment processing security: Wrong = data breach ($$$)
- ✅ Scalability architecture: Wrong = rewrite in 6 months ($$$)
- ✅ Algorithm optimization: Wrong = slow app, lost users ($$$)
- ❌ README formatting: Wrong = minor inconvenience ($)

---

## Configuration

**Reserve for Critical Tasks**
```json
{
  "skills": {
    "system-design": { "model": "opus" },
    "security-audit": {
      "model": "sonnet",
      "modelOverrides": {
        "deep": "opus"  // Only deep mode uses Opus
      }
    },
    "code-review": {
      "model": "sonnet",  // Standard
      "modelOverrides": {
        "critical": "opus"  // Pre-production releases
      }
    }
  }
}
```

---

## Cost Management

**Daily Budget Example**

Target: $10/day development budget

| Activity | Model | Count | Cost |
|----------|-------|-------|------|
| Searches | Haiku | 20 | $0.40 |
| Formatting | Haiku | 10 | $0.20 |
| Bug fixes | Sonnet | 8 | $1.44 |
| Features | Sonnet | 5 | $1.25 |
| Code reviews | Sonnet | 3 | $0.54 |
| Architecture | Opus | 1 | $0.90 |
| Security audit | Opus | 1 | $1.20 |
| **Total** | | | **$5.93** |

Remaining $4.07 for unexpected Opus needs.

---

## Quality Benchmarks

**Deep Security Audit**
- Haiku: 60% of vulnerabilities found
- Sonnet: 85% of vulnerabilities found
- Opus: 97% of vulnerabilities found + architectural recommendations

**Worth Opus**: For production security audits, yes!

**Architecture Design**
- Haiku: Oversimplified, misses scalability
- Sonnet: Good but may miss edge cases
- Opus: Comprehensive, considers trade-offs, future-proof

**Worth Opus**: For critical system design, yes!

---

## Next Steps

- [Model Selection Guide](5-selection-guide.md) - Complete decision framework

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
