# Cost Optimization Strategies

**Reading Time**: 25-35 minutes (varies by experience)
**Skill Level**: Intermediate to Advanced
**Prerequisites**: [Model Overview](../05-models/1-overview.md), [Agent Model Assignment](../02-agents/3-model-assignment.md)

---

## Achieve 70%+ Cost Savings! 💰

Master advanced strategies to dramatically reduce Claude Code costs while maintaining quality.

By the end of this guide, you'll know:
- The 10 cost optimization principles
- How to achieve 70%+ savings
- Real-world cost reduction case studies
- Monitoring and measurement strategies

---

## The Cost Optimization Formula

```
Total Savings = Model Selection + Context Optimization + Workflow Efficiency + Caching

Target: 70-80% cost reduction vs. baseline (all-Sonnet, no optimization)
```

---

## The 10 Principles of Cost Optimization

### 1. ✅ Use the Least Powerful Model That Works

**Baseline (No Optimization)**:
```bash
# Everything uses Sonnet
Daily operations: 50
Cost: 50 × $0.18 = $9.00/day
```

**Optimized**:
```bash
# Strategic model assignment
Searches (Haiku): 20 × $0.02 = $0.40
Coding (Sonnet): 25 × $0.18 = $4.50
Architecture (Opus): 5 × $0.70 = $3.50
Total: $8.40/day
```

**Savings**: 7% (modest, but adds up)

---

### 2. ✅ Optimize Context Size

**Baseline**:
```markdown
# Huge CLAUDE.md (2,000 lines)
- Every detail of every API
- Complete database schema
- All coding standards
- Full project history

Tokens per request: 15,000 (10K from context!)
Cost per request: $0.23
```

**Optimized**:
```markdown
# Concise CLAUDE.md (200 lines)
- Essential tech stack
- Key conventions
- Links to detailed docs

Tokens per request: 9,000 (3K from context)
Cost per request: $0.14
```

**Savings**: 39% per request

---

### 3. ✅ Batch Operations

**Baseline**:
```bash
# Individual requests
/format src/app.ts        # $0.08
/format src/index.ts      # $0.08
/format src/utils.ts      # $0.08
Total: $0.24
```

**Optimized**:
```bash
# Batch request
/format src/*.ts          # $0.10
```

**Savings**: 58%

---

### 4. ✅ Cache Expensive Operations

**Baseline**:
```bash
# Re-analyze every time
"Analyze the codebase architecture"  # 25K tokens, $0.38
"Analyze the codebase architecture"  # 25K tokens, $0.38
Total: $0.76
```

**Optimized**:
```bash
# Cache results
First: "Analyze architecture"        # 25K tokens, $0.38
Second: [Return cached result]       # 0 tokens, $0.00
Total: $0.38
```

**Savings**: 50%

---

### 5. ✅ Use Progressive Disclosure

**Baseline**:
```bash
# Always run deep review
/review --deep              # 25K tokens, $0.38
```

**Optimized**:
```bash
# Start with quick review
/review                     # 5K tokens, $0.08
# Only go deep if issues found
/review --deep              # (only when needed)
```

**Savings**: 79% (most reviews don't need deep analysis)

---

### 6. ✅ Avoid Redundant Tool Calls

**Baseline**:
```bash
# Agent reads same files multiple times
Read auth.ts               # 2K tokens
...operation...
Read auth.ts again         # 2K tokens
...operation...
Read auth.ts again         # 2K tokens
Total: 6K redundant tokens
```

**Optimized**:
```bash
# Agent caches file contents
Read auth.ts               # 2K tokens
...use cached version...
...use cached version...
Total: 2K tokens
```

**Savings**: 67%

---

### 7. ✅ Optimize Thinking Modes

**Baseline**:
```bash
# Always ultrathink
"Format code, ultrathink"   # 15K tokens, $0.23
```

**Optimized**:
```bash
# Normal mode for simple tasks
"Format code"               # 3K tokens, $0.05
```

**Savings**: 78%

---

### 8. ✅ Use Incremental Processing

**Baseline**:
```bash
# Re-process entire codebase
"Analyze all files"         # 100K tokens, $1.50
[Change one file]
"Analyze all files"         # 100K tokens, $1.50
Total: $3.00
```

**Optimized**:
```bash
# Process only changes
"Analyze all files"         # 100K tokens, $1.50
[Change one file]
"Analyze changed files"     # 5K tokens, $0.08
Total: $1.58
```

**Savings**: 47%

---

### 9. ✅ Smart Agent Selection

**Baseline**:
```bash
# General-Purpose for everything
Search code                 # General-Purpose + Sonnet
Cost: $0.18
```

**Optimized**:
```bash
# Explore Agent for searches
Search code                 # Explore + Haiku
Cost: $0.02
```

**Savings**: 89%

---

### 10. ✅ Measure and Monitor

**Principle**: You can't optimize what you don't measure

Enable cost tracking:
```json
{
  "costTracking": {
    "enabled": true,
    "logFile": ".claude/cost-log.json",
    "dailyBudget": 100000,
    "alerts": {
      "threshold": 0.8,
      "notify": "email"
    }
  }
}
```

---

## Complete Optimization Checklist

### Configuration Optimizations

- [ ] Explore Agent uses Haiku
- [ ] General-Purpose Agent uses Sonnet
- [ ] Skills use appropriate models
- [ ] CLAUDE.md < 500 lines
- [ ] Context includes only essentials
- [ ] Detailed docs in separate files

### Workflow Optimizations

- [ ] Batch similar operations
- [ ] Use progressive disclosure in skills
- [ ] Cache expensive analyses
- [ ] Incremental processing for large codebases
- [ ] Normal thinking mode for simple tasks

### Monitoring

- [ ] Cost tracking enabled
- [ ] Daily budget set
- [ ] Alerts configured
- [ ] Weekly cost review scheduled

---

## Real-World Case Studies

### Case Study 1: Startup Team (5 Developers)

**Before Optimization:**
- All operations: Sonnet
- Large CLAUDE.md (1,500 lines)
- No caching
- Individual file operations
- Daily cost: $45/day × 5 = $225/day
- Monthly cost: $6,750

**After Optimization:**
- Strategic model assignment (Haiku for searches)
- Concise CLAUDE.md (250 lines)
- Caching enabled
- Batch operations
- Daily cost: $12/day × 5 = $60/day
- Monthly cost: $1,800

**Savings**: $4,950/month (73% reduction)

---

### Case Study 2: Solo Developer

**Before Optimization:**
- Opus for everything (quality obsession)
- Ultrathink on all requests
- No batching
- Daily cost: $35/day
- Monthly cost: $1,050

**After Optimization:**
- Haiku: Searches (40%)
- Sonnet: Coding (50%)
- Opus: Architecture (10%)
- Normal thinking mode default
- Batch operations
- Daily cost: $8/day
- Monthly cost: $240

**Savings**: $810/month (77% reduction)

---

### Case Study 3: Enterprise Team (50 Developers)

**Before Optimization:**
- Mixed models but inefficient
- Huge context files
- No coordination
- Daily cost: $75/developer = $3,750/day
- Monthly cost: $112,500

**After Optimization:**
- Company-wide optimization standards
- Shared, optimized CLAUDE.md templates
- Centralized caching
- Workflow automation
- Daily cost: $22/developer = $1,100/day
- Monthly cost: $33,000

**Savings**: $79,500/month (71% reduction)

---

## Optimization Strategy by Project Type

### Web Application (React + TypeScript)

**Optimal Configuration:**
```json
{
  "agents": {
    "Explore": { "model": "haiku" },
    "general-purpose": { "model": "sonnet" }
  },
  "skills": {
    "component-generator": { "model": "sonnet" },
    "code-formatter": { "model": "haiku" },
    "code-review": {
      "model": "haiku",
      "modelOverrides": { "deep": "sonnet" }
    }
  }
}
```

**Expected Savings**: 60-65%

---

### API Service (Node.js + Express)

**Optimal Configuration:**
```json
{
  "agents": {
    "Explore": { "model": "haiku" },
    "general-purpose": { "model": "sonnet" }
  },
  "skills": {
    "api-scaffold": { "model": "sonnet" },
    "test-generator": { "model": "sonnet" },
    "security-audit": { "model": "opus" }
  }
}
```

**Expected Savings**: 55-60%

---

### Data Science (Python + Jupyter)

**Optimal Configuration:**
```json
{
  "agents": {
    "Explore": { "model": "haiku" },
    "general-purpose": { "model": "sonnet" }
  },
  "skills": {
    "data-analysis": { "model": "opus" },
    "code-formatter": { "model": "haiku" },
    "notebook-cleaner": { "model": "haiku" }
  }
}
```

**Expected Savings**: 50-55% (Opus needed for complex analysis)

---

## Advanced Techniques

### Technique 1: Request Deduplication

Detect and prevent duplicate requests:

```javascript
// .claude/plugins/deduplicate.js
const cache = new Map();

function deduplicate(request) {
  const key = hashRequest(request);

  if (cache.has(key)) {
    const cached = cache.get(key);
    if (Date.now() - cached.timestamp < 300000) { // 5 min
      return cached.result;
    }
  }

  const result = executeRequest(request);
  cache.set(key, { result, timestamp: Date.now() });
  return result;
}
```

**Savings**: 10-20% (catches accidental duplicates)

---

### Technique 2: Smart Context Pruning

Automatically remove stale context:

```markdown
## Auto-Prune Context

Remove from context if:
- Not referenced in last 10 requests
- File not modified in 7 days
- Feature marked as deprecated

Prune schedule: Daily at 2am
```

**Savings**: 15-25% (keeps context fresh and small)

---

### Technique 3: Parallel Agent Execution

Run independent operations in parallel:

```bash
# Sequential (slow, same cost)
/format src/
/lint src/
/test
Total time: 60s, Cost: $0.30

# Parallel (fast, same cost)
/format src/ & /lint src/ & /test &
Total time: 20s, Cost: $0.30
```

**Savings**: 0% cost, but 67% time savings

---

## Monitoring Dashboard

### Key Metrics to Track

**Daily Metrics:**
- Total requests
- Tokens used
- Cost (actual)
- Cost (budget)
- Model breakdown

**Weekly Metrics:**
- Cost trend
- Most expensive operations
- Optimization opportunities
- Budget vs. actual

**Monthly Metrics:**
- Total cost
- Savings vs. baseline
- Cost per developer
- ROI of optimizations

---

## Cost Optimization Roadmap

### Week 1: Baseline
- [ ] Enable cost tracking
- [ ] Measure current costs
- [ ] Identify top 10 expensive operations

### Week 2: Quick Wins
- [ ] Optimize model assignments
- [ ] Reduce CLAUDE.md size
- [ ] Enable caching

### Week 3: Workflow Optimization
- [ ] Batch operations
- [ ] Progressive disclosure in skills
- [ ] Smart agent selection

### Week 4: Advanced Techniques
- [ ] Request deduplication
- [ ] Context pruning
- [ ] Incremental processing

### Ongoing
- [ ] Weekly cost review
- [ ] Continuous optimization
- [ ] Share learnings with team

---

## Quick Reference

### Cost Optimization Tiers

**Tier 1: Essential (Target: 40-50% savings)**
- Model assignment (Haiku for searches)
- Concise CLAUDE.md
- Batch operations

**Tier 2: Advanced (Target: 60-70% savings)**
- Caching
- Progressive disclosure
- Smart agent selection
- Thinking mode optimization

**Tier 3: Expert (Target: 70-80% savings)**
- Request deduplication
- Context pruning
- Incremental processing
- Custom optimizations

---

## Next Steps

**Continue Phase 3:**
- [Advanced Optimization Techniques](2-advanced-techniques.md) - Expert-level strategies
- [Monitoring and Budgeting](3-monitoring-budgeting.md) - Track and control costs

---

## References

### Official Resources
- [Claude Pricing](https://www.anthropic.com/pricing)
- [Cost Optimization Guide](https://code.claude.com/docs/optimization)

### Tools
- [Claude Cost Calculator](https://claude-calculator.anthropic.com)
- [Token Counter](https://platform.openai.com/tokenizer)

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
