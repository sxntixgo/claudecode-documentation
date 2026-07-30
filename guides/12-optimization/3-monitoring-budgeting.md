# Monitoring and Budgeting

**Reading Time**: 15 minutes
**Skill Level**: Intermediate
**Prerequisites**: [Cost Optimization](1-cost-optimization.md)

---

## Track Your Savings 📊

Monitor costs and enforce budgets to stay within limits.

---

## Cost Tracking Setup

There is nothing to set up, and nothing to enable. Claude Code has no cost-tracking settings
key, no local log file, and no local budget enforcement. Tracking is done through commands and,
for teams, through your organization's console.

Be skeptical of any guide showing a `costTracking` block or a `.claude/cost-log.json` file —
neither exists.

---

## Reading Your Usage

### `/usage` — the primary view

```text
/usage
```

The Session block reports tokens and a locally computed cost, split by model:

```text
Total cost:            $0.55
Total duration (API):  6m 20s
Total code changes:    0 lines added, 0 lines removed
Usage by model:
   claude-sonnet-4-6:  1.2k input, 5.3k output, 940.0k cache read, 50.0k cache write ($0.55)
```

On a Pro, Max, Team, or Enterprise plan, `/usage` additionally:

- Attributes recent usage to **skills, subagents, plugins, and individual MCP servers**, each
  as a percentage of the total
- **Flags any behavior accounting for 10% or more** of recent usage, such as long context or
  cache misses, with a tip for reducing it
- Switches between the last 24 hours and last 7 days with `d` and `w`

That attribution is the part worth building a habit around. It answers "what is actually
costing me money" directly, and the answer regularly contradicts intuition.

Two caveats:

| Caveat | Consequence |
|--------|-------------|
| Cost is computed locally at standard list rates | Ignores promotional and contracted pricing; may differ from your bill |
| Built from local session history on one machine | Excludes usage from other devices and from claude.ai |

For authoritative billing, use the [Console usage page](https://platform.claude.com/usage).

Session totals reset when `/clear` starts a new session, which makes `/clear` a convenient
measurement boundary when comparing two approaches.

### `/context` — where the tokens went

`/usage` tells you how much you spent. `/context` tells you what you spent it on, by showing
what currently occupies the context window. When a session gets expensive, this is usually
where the answer is. See [Context Engineering](../09-context/4-context-engineering.md).

### Status line

You can display context usage continuously in your status line, which turns monitoring from
something you remember to do into something you notice.

---

## Budget Enforcement

**Budgets are an organization-level control, not a local one.** No setting on your machine will
stop a session from spending.

| Your setup | Where to cap spend |
|------------|-------------------|
| Teams or Enterprise plan | Seat allowance is the default ceiling. With usage credits enabled, set spend limits per organization, group, or member in admin settings. |
| Claude Console (API) | Workspace spend limits, per workspace |
| Bedrock, Google Cloud, Microsoft Foundry | Your cloud provider's budget controls |

For planning rather than enforcement: across enterprise deployments the average is roughly
**$13 per developer per active day**, or **$150–250 per developer per month**, with 90% of users
staying under $30 per active day. Pilot with a small group and measure before rolling out
widely — a coding seat costs more than a chat seat, because every turn carries file contents,
tool calls, and multi-step reasoning.

---

## Team Reporting

| Setup | See spend | Per-user reporting |
|-------|-----------|--------------------|
| Teams / Enterprise | Spend report in org analytics, CSV export, updated daily | Spend report CSV; Enterprise Analytics API on Enterprise |
| Console (API) | [Console usage page](https://platform.claude.com/usage) | Console dashboard and Claude Code Analytics API |
| Cloud providers | Your cloud billing console | OpenTelemetry export or an LLM gateway |

**OpenTelemetry export works on every setup** and is the only option that streams per-user
token and cost metrics into your own observability stack in near real time. If you need
per-developer attribution and you are not on Teams or Enterprise, this is the answer.

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

## Team Budget Planning

There is no `teamBudgets` key — see [Budget Enforcement](#budget-enforcement) above for where
caps actually live. What you can do locally is plan, using per-role expectations as a starting
point to validate against your own `/usage` data:

| Role | Expectation | Why |
|------|-------------|-----|
| Individual contributor | Around the $13/active-day average | Mostly Sonnet, scoped tasks |
| Tech lead / architect | Above average | More Opus for design work, longer sessions |
| Occasional user | Well below average | Short, infrequent sessions |

Set the actual limits where they are enforceable: seat allowances and member spend limits on
Teams and Enterprise, or workspace spend limits in the Console.

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
