# Monitoring and Budgeting

**Reading Time**: 15 minutes
**Skill Level**: Intermediate
**Prerequisites**: [Cost Optimization](1-cost-optimization.md)

---

## Track Your Savings 📊

Monitor costs and enforce budgets to stay within limits.

---

## Cost Tracking Setup

### Enable Tracking

`.claude/config.json`:
```json
{
  "costTracking": {
    "enabled": true,
    "logFile": ".claude/cost-log.json",
    "realTime": true,
    "aggregations": ["hourly", "daily", "weekly", "monthly"]
  }
}
```

---

## Reading Cost Logs

`.claude/cost-log.json`:
```json
{
  "date": "2025-12-20",
  "summary": {
    "requests": 150,
    "totalTokens": 1250000,
    "totalCost": 18.75,
    "byModel": {
      "haiku": { "requests": 60, "cost": 1.80 },
      "sonnet": { "requests": 80, "cost": 14.40 },
      "opus": { "requests": 10, "cost": 2.55 }
    }
  },
  "breakdown": {
    "agents": {
      "Explore": { "requests": 60, "cost": 1.80 },
      "general-purpose": { "requests": 90, "cost": 16.95 }
    },
    "skills": {
      "code-review": { "invocations": 20, "cost": 3.60 },
      "test-generator": { "invocations": 15, "cost": 2.70 }
    }
  }
}
```

---

## Daily Budget Enforcement

```json
{
  "budgets": {
    "daily": 100000,      // 100K tokens
    "weekly": 600000,     // 600K tokens
    "monthly": 2400000,   // 2.4M tokens
    "alerts": {
      "75%": "warning",
      "90%": "critical",
      "100%": "block"
    }
  }
}
```

---

## Cost Dashboard

### Key Metrics

**Dashboard View**:
```
Claude Code Cost Dashboard
==========================

Today (Dec 20, 2025)
--------------------
Requests: 150
Tokens: 1.25M
Cost: $18.75
Budget: $30.00 (37% remaining)

This Week
---------
Total Cost: $105.50
Weekly Budget: $150.00 (30% remaining)
Avg/Day: $21.10
Trend: ↓ Down 15% vs last week

Top Expenses
------------
1. Code Reviews: $25.20 (24%)
2. Feature Dev: $30.50 (29%)
3. Testing: $18.80 (18%)

Optimization Opportunities
--------------------------
⚠️  15 code reviews used Sonnet (could use Haiku)
    Potential savings: $2.70/day

✅ Good: 80% of searches use Haiku
✅ Good: Batch operations up 40%
```

---

## Alerts and Notifications

**Slack Integration**:
```javascript
if (dailyCost > budget * 0.75) {
  slack.send({
    channel: '#dev-team',
    message: '⚠️ Claude Code: 75% of daily budget used'
  });
}

if (dailyCost > budget * 0.90) {
  slack.send({
    channel: '#dev-team',
    message: '🚨 Claude Code: 90% of daily budget used!',
    priority: 'high'
  });
}
```

---

## Optimization Recommendations

Auto-generate suggestions:

```
Weekly Optimization Report
==========================

Potential Savings: $15/week

Recommendations:
1. Switch code reviews from Sonnet to Haiku (quick mode)
   Savings: $8/week

2. Batch formatting operations
   Current: 50 individual calls
   Optimized: 5 batch calls
   Savings: $4/week

3. Reduce CLAUDE.md context size
   Current: 10K tokens/request
   Target: 5K tokens/request
   Savings: $3/week
```

---

## Team Budgets

**Per-Developer Budgets**:
```json
{
  "teamBudgets": {
    "developer": {
      "daily": 50000,    // 50K tokens
      "monthly": 1200000 // 1.2M tokens
    },
    "lead": {
      "daily": 100000,   // 100K tokens (more Opus usage)
      "monthly": 2400000
    }
  }
}
```

---

## ROI Tracking

**Measure Value**:
```
Time Saved vs. Cost
===================

Code Reviews:
- Manual time: 30 min/review
- Claude time: 2 min/review
- Reviews/week: 20
- Time saved: 560 min/week = 9.3 hours
- Cost: $25/week
- Hourly rate: $100
- Value: 9.3 × $100 = $930
- ROI: ($930 - $25) / $25 = 3,620%

Test Generation:
- Manual time: 45 min
- Claude time: 3 min
- Tests/week: 15
- Time saved: 630 min/week = 10.5 hours
- Cost: $18/week
- Value: 10.5 × $100 = $1,050
- ROI: ($1,050 - $18) / $18 = 5,733%
```

---

## Next Steps

**Phase 3 Complete! 🎉**

**Continue to Phase 4:**
- Examples and Templates
- Real-world configurations
- Team collaboration patterns

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
