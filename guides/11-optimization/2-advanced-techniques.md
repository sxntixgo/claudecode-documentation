# Advanced Optimization Techniques

**Reading Time**: 20 minutes
**Skill Level**: Expert
**Prerequisites**: [Cost Optimization](1-cost-optimization.md)

---

## Expert-Level Optimization 🚀

Push beyond 70% savings with advanced techniques.

---

## Technique 1: Prompt Engineering for Efficiency

### Concise Prompts

**Inefficient**:
```
I would like you to please review my code and check for any potential issues
or bugs that might exist, and also please make sure to check the coding style
and conventions, and also security vulnerabilities, and performance issues...
```
Tokens: 150 (wasted)

**Efficient**:
```
Review code for: bugs, style, security, performance
```
Tokens: 15 (10x reduction)

---

## Technique 2: Response Format Control

**Inefficient**:
```
"Analyze this code and explain everything in detail with examples..."
```
Response: 5,000 tokens

**Efficient**:
```
"Analyze code. Return bullet points only, no explanations."
```
Response: 500 tokens (90% reduction)

---

## Technique 3: Incremental Context Loading

Load context progressively:

```markdown
## Tier 1: Always Load (Essential)
- Tech stack
- Project structure
- Key conventions

## Tier 2: Load on Demand (Detailed)
- API specifications
- Database schema
- Architecture docs

## Tier 3: Explicit Load (Reference)
- Code examples
- Templates
- Historical decisions
```

**Savings**: 60-70% context tokens

---

## Technique 4: Smart File Filtering

Only process relevant files:

``bash
# Bad: Process everything
"Review all files for security issues"
Processes: 1,000 files, 500K tokens

# Good: Filter first
"Find files with authentication logic, then review for security"
Processes: 15 files, 25K tokens
Savings: 95%
```

---

## Technique 5: Result Caching Strategy

**Simple Cache** (5 min TTL):
```javascript
cache.set(key, result, 300000); // 5 minutes
```

**Smart Cache** (Content-based TTL):
```javascript
if (result.isStatic) {
  cache.set(key, result, 86400000); // 24 hours
} else if (result.changesSlowly) {
  cache.set(key, result, 3600000);  // 1 hour
} else {
  cache.set(key, result, 300000);   // 5 minutes
}
```

**Savings**: 40-60%

---

## Technique 6: Parallel Processing with Deduplication

```javascript
// Detect duplicate requests in parallel batch
const requests = [
  "Format app.ts",
  "Format app.ts",  // Duplicate!
  "Format index.ts"
];

const unique = [...new Set(requests)];
const results = await Promise.all(
  unique.map(r => execute(r))
);

// Return results with duplicates
```

---

## Next Steps

- [Monitoring and Budgeting](3-monitoring-budgeting.md) - Track optimization impact

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
