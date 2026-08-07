# Model Assignment for Skills

**Reading Time**: 20 minutes
**Skill Level**: Intermediate
**Prerequisites**: [What Are Skills?](1-overview.md), [Creating Custom Skills](3-creating-skills.md), [Model Assignment for Agents](../03-agents/3-model-assignment.md)

---

## Welcome to Skill Cost Optimization! 💰

You've learned how to create custom skills and optimize agent costs. Now let's apply the same cost-saving strategies to **skills** - achieving even greater savings through smart model selection.

By the end of this guide, you'll be able to:
- Assign different models (Haiku, Sonnet, Opus) to specific skills
- Reduce token costs by 50-70% through strategic model selection
- Configure skill-level model overrides in SKILL.md frontmatter
- Understand when to use each model for different skill types
- Measure and optimize skill execution costs

---

## Why Assign Different Models to Skills?

### The Problem: One-Size-Fits-All Is Expensive

By default, skills inherit the model from the agent executing them. But different skills have different complexity levels:

**Example: Documentation Generator Skill**

```markdown
Without Model Assignment (uses Sonnet for everything):
- Quick docs: 8,000 tokens × $3/$15 per M = $0.12
- Standard docs: 15,000 tokens × $3/$15 per M = $0.23
- Deep docs: 30,000 tokens × $3/$15 per M = $0.45

With Model Assignment (Haiku for quick/standard, Sonnet for deep):
- Quick docs: 8,000 tokens × $1/$5 per M = $0.04 (67% savings!)
- Standard docs: 15,000 tokens × $1/$5 per M = $0.08 (65% savings!)
- Deep docs: 30,000 tokens × $3/$15 per M = $0.45 (same, needs reasoning)

Total savings: 61% reduction in cost
```

### Real-World Impact

**Team using 20 skills daily:**

| Scenario | Daily Cost | Monthly Cost | Savings |
|----------|------------|--------------|---------|
| **All Sonnet** | $8.50 | $255 | - |
| **Smart Assignment** | $3.20 | $96 | **62% ($159/month)** |

---

## Understanding Model Selection for Skills

### Quick Comparison

| Model | Best For Skills That... | Example Skills |
|-------|-------------------------|----------------|
| **Haiku 4.5** | Format, validate, simple generation | code-formatter, spell-checker, linter |
| **Sonnet 5** | Analyze, review, standard generation | code-review, test-generator, api-scaffold |
| **Opus 5** | Complex reasoning, architecture | system-design, security-audit-deep, refactor-architect |

### Decision Tree

```mermaid
graph TD
    Skill["Skill Task"]

    Skill --> Q1{"Does it require<br/>deep reasoning?"}

    Q1 -->|No| Q2{"Does it need<br/>code understanding?"}
    Q1 -->|Yes| UseOpus["Use Opus 5<br/>Complex analysis needed"]

    Q2 -->|No| UseHaiku["Use Haiku 4.5<br/>Simple operations"]
    Q2 -->|Yes| Q3{"Simple or complex<br/>code analysis?"}

    Q3 -->|Simple| UseSonnet1["Use Sonnet 5<br/>Standard code work"]
    Q3 -->|Complex| UseOpus2["Use Opus 5<br/>Architecture/refactoring"]

    style UseHaiku fill:#d4f4dd
    style UseSonnet1 fill:#fff9e6
    style UseOpus fill:#f4d4ff
    style UseOpus2 fill:#f4d4ff
```

---

## Configuring Model Assignment

There is exactly one place to assign a model to a skill: the `model` field in the YAML
frontmatter of that skill's own `SKILL.md`. No settings file has a per-skill model key.

### The `model` Field

`.claude/skills/code-formatter/SKILL.md`:
```yaml
---
name: code-formatter
description: Format code with Prettier/Black
model: haiku  # ← Runs this skill on Haiku
---

# Code Formatter Skill

This skill runs formatters - no deep reasoning needed, so Haiku is perfect!
```

Accepted values are `haiku`, `sonnet`, `opus`, `fable`, or a full model ID.

> ⚠️ **The override is scoped to the turn, not to the skill.**
> Invoking a skill with `model: haiku` switches the model for the remainder of the current
> turn — including work Claude does after the skill finishes. It is **not** written to your
> settings, and your session model resumes on the next prompt. So this is not a permanent
> per-skill assignment; it is a per-invocation one that the frontmatter requests every time.

Two consequences worth internalizing:

- A cheap skill invoked in the middle of an expensive task downgrades the rest of that task.
  If the follow-up work needs Sonnet, invoke the Haiku skill in its own turn.
- Nothing drifts. You never have to clean up a model setting a skill left behind.

### Pairing `model` with `effort`

`SKILL.md` also accepts an `effort` field — `low`, `medium`, `high`, `xhigh`, or `max` — which
controls how much reasoning the model spends before answering. It is the finer-grained dial,
and reaching for it first often beats jumping a model tier:

```yaml
---
name: code-review
description: Review a diff for correctness, style, and obvious bugs
model: sonnet
effort: low     # Shallow pass; raise to high for architecture-level review
---
```

A Sonnet-at-`low` review and a Sonnet-at-`high` review are genuinely different tools. Try
moving `effort` before you move `model`.

### Different Depths Mean Different Skills

A single skill has one `model` value. There is no mechanism for a skill to select among
several models based on how the user invoked it. When you want a quick pass and a deep pass,
ship two skills:

```
.claude/skills/code-review/SKILL.md         # model: haiku,  effort: low
.claude/skills/code-review-deep/SKILL.md    # model: opus,   effort: high
```

Each one gets a `description` that says plainly when it applies, which is also what lets
Claude pick the right one on its own.

### Setting the Session Default

Everything a skill does not override comes from the session model, which you set in
`.claude/settings.json`:

```json
{
  "model": "sonnet",
  "fallbackModel": "haiku"
}
```

**Which model actually runs:**
1. A skill's frontmatter `model` — for the remainder of the turn that invoked it
2. Otherwise the session model, resolved by settings precedence (highest first):
   managed settings → command-line arguments → `.claude/settings.local.json` →
   `.claude/settings.json` → `~/.claude/settings.json`

---

## Skill Categories and Recommended Models

### 🎨 Formatting & Linting Skills → Haiku

**Why Haiku:** No reasoning needed, just rule application

**Examples** (each in its own `SKILL.md` frontmatter):
```yaml
# code-formatter/SKILL.md — typically 3-5K tokens
model: haiku

# spell-checker/SKILL.md — typically 2-4K tokens
model: haiku

# import-sorter/SKILL.md — typically 1-3K tokens
model: haiku
```

**Savings:** 66% compared to Sonnet

---

### 🧪 Testing Skills → Sonnet (with Haiku for simple cases)

**Why Sonnet:** Needs code understanding, but not architecture-level

**Examples:**
```yaml
# test-generator/SKILL.md
model: sonnet
effort: medium   # Drop to low for straightforward unit tests

# tdd-workflow/SKILL.md
model: sonnet    # Needs to understand behavior

# coverage-analyzer/SKILL.md
model: haiku     # Just parses coverage reports
```

**Savings:** 30-50%, mostly from pulling the mechanical skills down to Haiku

---

### 📚 Documentation Skills → Haiku to Sonnet

**Why Mixed:** Simple formatting (Haiku), complex explanations (Sonnet)

**Examples:**
```yaml
# readme-generator/SKILL.md
model: haiku     # Template-driven; ship a second skill for prose-heavy READMEs

# api-docs/SKILL.md
model: haiku     # Extracting JSDoc/TSDoc

# changelog-generator/SKILL.md
model: haiku     # Git log formatting
```

**Savings:** 50-60% compared to all-Sonnet

---

### 🔒 Security Skills → Sonnet to Opus

**Why Sonnet/Opus:** Security needs careful analysis

**Examples:**
```yaml
# secrets-scanner/SKILL.md
model: haiku     # Pattern matching only

# security-audit/SKILL.md
model: sonnet    # OWASP Top 10 pass
effort: high

# security-audit-threat-model/SKILL.md
model: opus      # Separate skill; threat modeling is a different job
effort: high

# vulnerability-scanner/SKILL.md
model: sonnet    # Dependency analysis
```

**Savings:** 20-40% (security is critical, use premium models)

---

### ⚙️ Code Generation Skills → Sonnet

**Why Sonnet:** Needs code understanding and generation

**Examples:**
```yaml
# component-generator
model: sonnet

# api-scaffold
model: sonnet

# migration-generator
model: opus  # Database migrations are critical!
```

**Savings:** 30-40% compared to Opus-everything

---

### 🏗️ Architecture & Refactoring → Opus

**Why Opus:** Complex reasoning, system-level understanding

**Examples:**
```yaml
# system-design
model: opus

# refactor-architect
model: opus

# performance-optimizer
model: opus  # Complex analysis needed
```

**Cost:** Higher, but necessary for quality

---

## Real-World Skill Configurations

### Example 1: Cost-Optimized Development Workflow

**Project**: Small startup, budget-conscious

Because each skill declares its own model, a "configuration" is really just the set of values
across your skill files. There is no central list, and no `defaultSkillModel` key — the
session model in `.claude/settings.json` is what skills fall back to.

Each row below is the `model` line in that skill's own `SKILL.md`:

| Skill | Model | Why |
|-------|-------|-----|
| `code-formatter` | `haiku` | Rule application |
| `spell-checker` | `haiku` | No reasoning |
| `code-review` | `haiku` + `effort: low` | Surface pass is enough day to day |
| `code-review-deep` | `sonnet` + `effort: high` | Separate skill for the thorough pass |
| `test-generator` | `sonnet` | Needs to understand behavior |
| `api-scaffold` | `sonnet` | Generation with judgment |

`.claude/settings.json`:
```json
{
  "model": "haiku",
  "fallbackModel": "sonnet"
}
```

A Haiku session default suits this posture: anything that genuinely needs more says so in its
own frontmatter, and everything else stays cheap by default.

---

### Example 2: Enterprise Quality-Focused

**Project**: Large enterprise, quality > cost

| Skill | Model | Why |
|-------|-------|-----|
| `code-formatter` | `haiku` | Still mechanical, still cheap |
| `code-review` | `opus` + `effort: high` | Review quality is the point |
| `security-audit` | `opus` | No compromises |
| `test-generator` | `sonnet` | Good balance |
| `api-scaffold` | `opus` | Public contract; mistakes are expensive |
| `refactor-architect` | `opus` | Design mistakes compound |

`.claude/settings.json`:
```json
{
  "model": "sonnet"
}
```

Note that formatting stays on Haiku even here. Quality-focused does not mean paying premium
rates for work with no judgment in it.

---

### Example 3: Balanced Approach

**Project**: Mid-size team, balance cost and quality

| Skill | Model | Why |
|-------|-------|-----|
| `code-formatter`, `spell-checker` | `haiku` | Mechanical |
| `code-review` | `sonnet` + `effort: low` | Lower effort before lower model |
| `test-generator`, `api-scaffold` | `sonnet` | Standard coding work |
| `security-audit`, `refactor-architect` | `opus` | Expensive to get wrong |

`.claude/settings.json`:
```json
{
  "model": "sonnet"
}
```

**Before adopting any of these**, measure. These are postures to test with your own eval set,
not settings to copy — see [Performance vs. Cost Trade-offs](#performance-vs-cost-trade-offs)
below.

---

## Measuring Skill Costs

### Attribute usage per skill with `/usage`

On a Pro, Max, Team, or Enterprise plan, `/usage` breaks down what counts against your plan limits and attributes recent usage to skills, subagents, plugins, and individual MCP servers, each as a percentage of the total. Press `d` or `w` to switch between the last 24 hours and the last 7 days.

This is the fastest way to find out which skill is actually costing you money, and the answer is often not the one you assumed.

The Session block at the top of `/usage` shows token counts and a locally computed dollar figure for the current session:

```text
Total cost:            $0.55
Total duration (API):  6m 20s
Usage by model:
   claude-sonnet-4-6:  1.2k input, 5.3k output, 940.0k cache read, 50.0k cache write ($0.55)
```

Two caveats worth knowing before you rely on these numbers:

- The dollar figure is computed locally from token counts at standard list rates. It does not reflect promotional pricing or contracted discounts, so it may differ from your bill. For authoritative billing, use the [Console usage page](https://platform.claude.com/usage).
- The breakdown is computed from local session history on one machine. Usage from other devices or from claude.ai is not included.

Session totals reset when `/clear` starts a new session.

### See what is consuming context right now

`/context` shows what is currently occupying the context window. Use it when a skill feels expensive but you are not sure whether the cost is the skill itself or everything it dragged in alongside it.

### Organization-wide reporting

Per-skill attribution is a local view. For spend across a team, the mechanism depends on how you authenticate:

| Setup | Where to look |
|-------|---------------|
| Teams or Enterprise plan | Spend report in org analytics, with CSV export |
| Claude Console (API) | [Console usage page](https://platform.claude.com/usage) and the Claude Code Analytics API |
| Bedrock, Google Cloud, or Microsoft Foundry | Your cloud billing console, or OpenTelemetry export |

OpenTelemetry export works on every setup and is the only option that streams per-user token and cost metrics into your own observability stack in near real time.

---

## Performance vs. Cost Trade-offs

Cost and latency scale predictably with model and mode: input and output pricing is published per model, and a deeper review reads more and writes more. Quality does not scale predictably, and it is the variable that decides whether a cheaper model is acceptable for a given skill.

That means quality is the one number you have to measure on your own skill and your own codebase. A published figure would not transfer — review quality depends on your language, your conventions, and what your skill instructs Claude to look for.

### Measure it with a benchmark

Run your eval set against each candidate model and compare pass rate alongside tokens and duration. The `skill-creator` plugin aggregates exactly these three into `benchmark.json`. See [Evaluating Your Skills](3-creating-skills.md#evaluating-your-skills) for the setup.

What you are looking for is the point where a cheaper model stops being acceptable:

| Signal | Reading |
|--------|---------|
| Pass rate holds within a point or two on the cheaper model | Use the cheaper model |
| Pass rate drops but only on your hardest cases | Cascade — cheap model first, escalate on those cases |
| Pass rate drops across the board | The skill needs more explicit instructions, or the task needs the stronger model |
| Pass rate is identical with and without the skill | The skill is not earning its tokens |

That last row is the one people skip. A skill can score well on every case and still be dead weight if Claude scored just as well without it.

### Starting points

Absent your own measurements, these are reasonable first guesses to test rather than conclusions to adopt:

- **Mechanical, rule-checkable work** (formatting, lint-style checks, renaming) — start with Haiku
- **Judgment over unfamiliar code** (review, refactoring proposals, test design) — start with Sonnet
- **Multi-file reasoning with expensive mistakes** (architecture, security analysis) — start with Sonnet, escalate to Opus if your evals show a gap

Test every skill against each model you intend to run it on. Instructions that are sufficient for Opus frequently underspecify for Haiku, which shows up as a pass-rate cliff rather than a gradual decline.

---

## Common Pitfalls

### ❌ Pitfall 1: Using Haiku for Complex Analysis

```yaml
# Bad: Using Haiku for architecture review
security-audit:
  model: haiku  # Will miss subtle vulnerabilities!
```

**Problem:** Haiku lacks deep reasoning for security/architecture

**Fix:**
```yaml
# security-audit/SKILL.md
model: sonnet    # Minimum for security
effort: high

# security-audit-threat-model/SKILL.md
model: opus      # Separate skill; threat modeling is a different job
```

---

### ❌ Pitfall 2: Using Opus for Simple Tasks

```yaml
# Bad: Using Opus for formatting
code-formatter:
  model: opus  # Massive waste of tokens!
```

**Problem:** 3-5x more expensive for same result

**Fix:**
```yaml
code-formatter:
  model: haiku  # Perfect for rule-based tasks
```

---

### ❌ Pitfall 3: Not Tracking Costs

**Problem:** You assign models by intuition, never check what they actually cost, and carry a wrong guess for months. You cannot optimize what you do not measure.

**Fix:** Run `/usage` after a representative working session and read the per-skill breakdown. It takes seconds and routinely contradicts expectations — the skill you invoke constantly on Haiku is often cheaper than the one you invoke twice a week on Opus.

Check it again after changing an assignment. A change you never verified is a guess with extra steps.

---

## Best Practices

### 1. ✅ Start Conservative, Optimize Down

```yaml
# Start with Sonnet, measure, then optimize
code-review:
  model: sonnet  # Default safe choice

# After measuring:
# code-review/SKILL.md
model: haiku     # Quick reviews work fine with Haiku
effort: low

# code-review-deep/SKILL.md
model: sonnet    # Separate skill for the thorough pass
effort: high
```

---

### 2. ✅ Use Progressive Disclosure with Model Assignment

```yaml
# Match complexity to model
# One skill, one model. Progressive disclosure applies to the skill's
# CONTENT (what files it loads), not to model selection.
model: haiku
effort: low
```

---

### 3. ✅ Document Model Choices

```yaml
---
description: Reviews a diff for correctness, style, and obvious bugs. Use before committing.
model: haiku     # Quick reviews don't need deep reasoning
effort: low
---
```

---

## Quick Reference

### Model Selection Cheat Sheet

| Skill Type | Recommended Model | Reasoning |
|------------|------------------|-----------|
| Formatting | Haiku | Rule-based, no reasoning |
| Linting | Haiku | Pattern matching |
| Simple docs | Haiku | Template-based |
| Code review (quick) | Haiku | Syntax + style only |
| Code review (standard) | Sonnet | Code understanding needed |
| Code review (deep) | Opus | Architecture analysis |
| Test generation | Sonnet | Code understanding |
| API scaffolding | Sonnet | Pattern + understanding |
| Security audit | Opus | Critical, needs best |
| System design | Opus | Complex reasoning |
| Refactoring | Opus | Architecture knowledge |

### Cost Optimization Checklist

- [ ] Enable per-skill cost tracking
- [ ] Review costs after 1 week
- [ ] Identify expensive skills
- [ ] Test Haiku for simple skills
- [ ] Use progressive model selection
- [ ] Document model choices
- [ ] Monitor quality impact
- [ ] Iterate and optimize

---

## Next Steps

Congratulations! You now know how to optimize skill costs through smart model assignment.

**Next Guide**: [Advanced Skill Patterns](5-advanced-patterns.md) (30 min)
Master progressive disclosure, testing, and skill composition patterns.

**Also Explore**:
- [Model Selection Deep Dive](../06-models/1-overview.md) - Complete guide to all models
- [Token Optimization](../12-optimization/1-cost-optimization.md) - Advanced cost-saving strategies
- [Context Management](../09-context/1-overview.md) - Control what skills see

---

## References and Further Reading

### Official Documentation
- [Model Pricing](https://code.claude.com/docs/models/pricing)
- [Skill Configuration](https://code.claude.com/docs/skills/configuration)
- [Cost Optimization Guide](https://code.claude.com/docs/optimization)

### Related Topics
- [Agent Model Assignment](../03-agents/3-model-assignment.md) - Similar strategies for agents
- [Creating Custom Skills](3-creating-skills.md) - Building skills from scratch

---

**Questions or Feedback?**
Found a mistake? Have a suggestion? [Open an issue](https://github.com/anthropics/claude-code/issues) or contribute to this documentation!
