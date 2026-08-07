# Cost Optimization Strategies

**Reading Time**: 25-35 minutes (varies by experience)
**Skill Level**: Intermediate to Advanced
**Prerequisites**: [Model Overview](../06-models/1-overview.md), [Agent Model Assignment](../03-agents/3-model-assignment.md)

---

## Achieve 70%+ Cost Savings! 💰

Master advanced strategies to dramatically reduce Claude Code costs while maintaining quality.

By the end of this guide, you'll know:
- The 10 cost optimization principles
- How to achieve 70%+ savings
- Real-world cost reduction case studies
- Monitoring and measurement strategies

---

## Understanding Claude API Pricing Tiers

Before optimizing costs, understand your pricing options.

### Free Trial & Evaluation

**Anthropic API Free Trial** (as of January 2025):
- **$5 credit** for new accounts
- Valid for **1 month** from account creation
- Full API access to all models (Haiku, Sonnet, Opus)
- No credit card required to start
- Perfect for evaluation and small projects

> 💡 **Check current offer**: [anthropic.com/pricing](https://www.anthropic.com/pricing)

**What you can do with $5**:
```
Haiku (cheapest):
  $5 ÷ $0.001/1K = ~5,000,000 tokens
  ≈ 500-1,000 typical coding requests

Sonnet (balanced):
  $5 ÷ $0.003/1K = ~1,666,666 tokens
  ≈ 150-300 typical coding requests

Opus (premium):
  $5 ÷ $0.015/1K = ~333,333 tokens
  ≈ 30-60 complex requests
```

### Pay-As-You-Go Pricing

**Standard pricing structure**:

| Model | Input | Output | Use Case |
|-------|--------|--------|----------|
| **Haiku 4.5** | $1/M tokens | $5/M tokens | Searches, formatting, simple tasks |
| **Sonnet 5** | $3/M tokens | $15/M tokens | Coding, reviews, general development |
| **Opus 5** | Premium* | Premium* | Architecture, complex analysis |

> ⚠️ **Pricing subject to change**. Verify at [anthropic.com/pricing](https://www.anthropic.com/pricing)

### When to Upgrade from Free Trial

**Upgrade when**:
- ✅ Free trial credit exhausted
- ✅ Need more than 1 month evaluation
- ✅ Production deployment planned
- ✅ Team collaboration required

**Stay on free trial when**:
- ⏸️ Still evaluating Claude Code
- ⏸️ Small personal projects
- ⏸️ Learning and experimentation

### Billing and Budget Management

**Set up billing alerts**:
```json
{
  "billing": {
    "monthlyBudget": 100,  // $100/month
    "alerts": {
      "threshold50": "email@example.com",
      "threshold80": "email@example.com",
      "threshold100": "email@example.com"
    }
  }
}
```

**Track spending**:
```bash
# Check current month usage
claude billing status

# Expected output:
# Current month: $23.45 / $100.00 (23%)
# Days remaining: 18
# Projected: $41.20
```

### Free Tier Optimization Strategy

**Maximize free trial value**:

1. **Start with Haiku** for everything to extend credit
2. **Batch learning** - group similar requests
3. **Use documentation** before asking Claude
4. **Test configurations** on small files first
5. **Enable cost tracking** from day 1

**Example - Maximizing $5 credit:**
```
Week 1: Learning (Haiku only)
- Read docs, small experiments
- Cost: $0.50

Week 2-3: Building (Haiku + occasional Sonnet)
- Active development with strategic model use
- Cost: $3.00

Week 4: Polish (All models strategically)
- Final optimizations, Opus for architecture review
- Cost: $1.50

Total: $5.00 → Got full evaluation experience!
```

### Enterprise & Team Pricing

For teams and enterprises, contact Anthropic for:
- **Volume discounts** (> $1,000/month)
- **Custom rate limits**
- **Dedicated support**
- **SLA guarantees**
- **Private deployment options**

**Contact**: sales@anthropic.com

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

There is nothing to enable — measurement is built in:

| Tool | What it tells you |
|------|-------------------|
| `/usage` | Token counts and locally computed cost for the session. On Pro, Max, Team, and Enterprise plans it also attributes recent usage to individual skills, subagents, plugins, and MCP servers as a percentage of total, and flags anything at 10% or more. Press `d` for 24 hours, `w` for 7 days. |
| `/context` | What is occupying the context window right now — the fastest way to find the file or MCP server that is inflating every request. |
| [Console usage page](https://platform.claude.com/usage) | Authoritative billing. `/usage` computes its dollar figure locally at list rates, so it can differ from the invoice. |
| OpenTelemetry export | Per-user token and cost metrics streamed into your own observability stack. Works on every setup, and is how you get team-wide trends. |

Session totals reset when `/clear` starts a new session, so check `/usage` before clearing if
you want the number for a task.

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

- [ ] `/usage` checked after expensive sessions
- [ ] `/context` used to find context bloat
- [ ] Spend limits set at the org level (Team/Enterprise admin settings, or Console workspace limits)
- [ ] OpenTelemetry export configured for team-wide metrics
- [ ] Weekly cost review scheduled against the Console usage page

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
      "effort": "low"
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
- **Pricing Calculator**: Use [Anthropic Pricing Page](https://www.anthropic.com/pricing) for current rates
- **Token Estimation**: Count ~4 characters = 1 token (rough estimate)
- **Alternative Tokenizer** (Note: Uses GPT tokenization, Claude may differ): [OpenAI Tokenizer](https://platform.openai.com/tokenizer)
- **Cost Tracking**: Run `/usage` in-session; use the [Console usage page](https://platform.claude.com/usage) for authoritative billing

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
