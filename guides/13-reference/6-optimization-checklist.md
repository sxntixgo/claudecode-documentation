# Optimization Checklist

**Reading Time**: 20 minutes
**Skill Level**: Intermediate
**Prerequisites**: [Token Optimization Guide](../11-optimization/strategies.md)

---

## The Optimization Checklist

Use this checklist to ensure your Claude Code setup is optimized for cost and performance.

---

## Phase 1: Pre-Implementation Checklist

Complete this BEFORE starting a project or new feature.

### Planning

- [ ] **Define task clearly** - Vague requests cost 30% more tokens
  - ❌ "Improve the code"
  - ✅ "Refactor getUserData to use caching and reduce database queries by 50%"

- [ ] **Break into subtasks** - Smaller tasks are more efficient
  - ❌ "Build a complete user authentication system"
  - ✅ "1. Design schema, 2. Implement signup, 3. Implement login, 4. Add MFA"

- [ ] **Choose right model first** - Prevents mid-task upgrades
  - [ ] Is it a search? → Haiku
  - [ ] Is it architecture? → Opus
  - [ ] Standard coding? → Sonnet

- [ ] **Estimate token usage** - Plan budget before starting
  ```
  Simple task: ~5K tokens
  Standard task: ~15K tokens
  Complex task: ~30K tokens
  ```

- [ ] **Decide on thinking mode** - Add keywords only if needed
  - [ ] "think" for moderate complexity (~4K extra)
  - [ ] "think hard" for hard problems (~10K extra)
  - [ ] No thinking for simple tasks

### Documentation

- [ ] **Write CLAUDE.md** - Improves efficiency by 20-30%
  - [ ] Tech stack clearly listed
  - [ ] Key file locations documented
  - [ ] Build/test commands included
  - [ ] Project context and constraints

- [ ] **Update CLAUDE.md** - Keep it fresh as project evolves
  - [ ] Remove outdated information
  - [ ] Add recent learnings
  - [ ] Keep under 300 lines

---

## Phase 2: Configuration Checklist

Set up your `.claude/` directory correctly.

### Agent Configuration

- [ ] **Create `.claude/config.json`** with optimal models
  ```json
  {
    "agents": {
      "Explore": {"model": "haiku"},
      "general-purpose": {"model": "sonnet"},
      "Plan": {"model": "opus"}
    }
  }
  ```

- [ ] **Set default model** - Should be Haiku
  - [ ] `"defaultModel": "haiku"` in config

- [ ] **Configure agent permissions** - Restrict file access
  - [ ] Frontend agent: only `src/components/**`, `src/pages/**`
  - [ ] Backend agent: only `src/api/**`, `src/services/**`
  - [ ] All agents: deny `.env*`, `**/*.secret.*`

### Skill Configuration

- [ ] **Create project-specific skills**
  - [ ] Code review skill with quick/deep options
  - [ ] Testing skill (TDD workflow)
  - [ ] Documentation skill
  - [ ] Security audit skill

- [ ] **Set skill frontmatter correctly**
  ```yaml
  ---
  name: skill-name
  model: sonnet
  modelOverrides:
    quick: haiku
    deep: opus
  ---
  ```

### Hooks Configuration

- [ ] **Pre-commit hooks** - Auto-format and validate
  ```json
  {
    "hooks": {
      "PreToolUse": [{
        "matcher": "Write",
        "hooks": [{"command": "npx prettier --write $FILE"}]
      }]
    }
  }
  ```

- [ ] **Cost tracking** - Monitor usage
  ```json
  {
    "costTracking": {
      "enabled": true,
      "dailyBudget": 100000,
      "alertThreshold": 0.8
    }
  }
  ```

---

## Phase 3: Runtime Checklist

Use this while working with Claude Code.

### Task Execution

- [ ] **Use Explore agent for searches**
  - Saves 50% on read-only tasks
  - Use when: Looking for files, understanding code, searching patterns
  - Skip when: Need to modify files

- [ ] **Batch operations** - Combine similar tasks
  - ❌ "Add error handling to fileA, fileB, fileC" (3 calls)
  - ✅ "Add error handling to fileA, fileB, fileC" (1 call)
  - Saves: ~30% tokens

- [ ] **Use specific prompts** - Vague = expensive
  ```
  ❌ Vague: "Fix the API"
  ✅ Specific: "Add rate limiting (100 req/min) to POST /users endpoint"
  Difference: 20% cost savings
  ```

- [ ] **Save context to memory** - Reuse across sessions
  - [ ] Save key decisions
  - [ ] Document discovered patterns
  - [ ] Record architectural choices

- [ ] **Clear memory between unrelated tasks**
  - Prevents irrelevant context overhead
  - Improves response quality for new tasks

### Code Quality

- [ ] **Request tests with implementation**
  ```
  "Implement feature X and write tests"
  (vs. separate calls to implement then test)
  ```

- [ ] **Use TDD skills** - Reduces revisions
  - [ ] `/tdd "Feature name"` instead of manual back-and-forth

- [ ] **Ask for explanations once** - Reread if needed
  - ❌ Ask explanation 3 times (wasted tokens)
  - ✅ Ask once, save response, reread

### Model Selection During Work

- [ ] **Upgrade only when needed**
  - Try with Haiku first
  - If results inadequate → upgrade to Sonnet
  - If still inadequate → upgrade to Opus

- [ ] **Downgrade after complex phase**
  - Opus for architecture (20 min)
  - Sonnet for implementation (30 min)
  - Haiku for testing/refactoring (10 min)

---

## Phase 4: Monitoring Checklist

Track and optimize your actual usage.

### Weekly Monitoring

- [ ] **Review token usage**
  ```bash
  cat .claude/cost-log.json | jq '.weekly'
  ```

- [ ] **Check model distribution**
  - [ ] Haiku: Should be 40-50% of usage
  - [ ] Sonnet: Should be 40-50% of usage
  - [ ] Opus: Should be 5-10% of usage

- [ ] **Identify expensive tasks**
  - Which tasks used the most tokens?
  - Could they have used cheaper models?

- [ ] **Calculate actual costs**
  - Total tokens used
  - Cost per task
  - Cost per feature

### Monthly Optimization

- [ ] **Analyze patterns**
  - What types of tasks cost the most?
  - Where are the savings opportunities?
  - Are model assignments optimal?

- [ ] **Update configuration** based on insights
  - [ ] Adjust agent model assignments
  - [ ] Modify skill model overrides
  - [ ] Refine CLAUDE.md

- [ ] **Set new targets**
  - Reduction goal: 5-10% monthly improvement
  - Target: 50-70% savings vs. baseline

- [ ] **Team review** (if applicable)
  - Share findings with team
  - Discuss optimization strategies
  - Update project standards

### Cost Tracking Template

**Weekly Report:**
```markdown
## Week of [Date]

### Usage Summary
- Total tokens: 250,000
- Total cost: $7.50
- Model breakdown:
  - Haiku: 100K tokens (40%)
  - Sonnet: 140K tokens (56%)
  - Opus: 10K tokens (4%)

### Top 5 Expensive Tasks
1. Architecture design - 30K tokens
2. Feature implementation - 25K tokens
3. Bug fixing - 18K tokens
4. Code review - 15K tokens
5. Testing - 12K tokens

### Observations
- Haiku usage too low (should be 45%)
- Opus usage perfect (4%)
- Sonnet usage appropriate

### Next Week's Focus
- Use Haiku more for searches
- Batch code reviews
- Use TDD skill to reduce iterations
```

---

## Quick Optimization Wins

### Win #1: Use Explore Agent (Save 50%)

**Before:**
```
"Find all API endpoints" → General-Purpose → Sonnet
Cost: 0.15, Time: 5 min
```

**After:**
```
"Find all API endpoints" → Explore → Haiku
Cost: 0.02, Time: 2 min
Savings: 87%
```

### Win #2: Batch Operations (Save 30%)

**Before:**
```
Task 1: "Add validation to fileA"
Task 2: "Add validation to fileB"
Task 3: "Add validation to fileC"
Cost: 3 × $0.15 = $0.45
```

**After:**
```
Task: "Add validation to fileA, fileB, fileC"
Cost: $0.25
Savings: 44%
```

### Win #3: Specific Prompts (Save 20%)

**Before:**
```
"Improve performance"
Tokens: 15K (unclear what to optimize)
```

**After:**
```
"Optimize database queries in getUserProfile to load in <100ms"
Tokens: 12K (specific target)
Savings: 20%
```

### Win #4: Memory Reuse (Save 25%)

**Before:**
```
Conversation 1: Explain architecture (10K tokens)
Conversation 2: Implement feature, reexplain (12K tokens)
Total: 22K tokens
```

**After:**
```
Conversation 1: Explain architecture, save to memory (10K)
Conversation 2: Implement feature (8K)
Total: 18K tokens
Savings: 18%
```

---

## Monthly Optimization Routine

### Week 1: Review and Plan

```markdown
## Monday
- [ ] Review last month's costs
- [ ] Identify expensive tasks
- [ ] Plan optimization targets

## Wednesday
- [ ] Review progress
- [ ] Adjust strategies if needed

## Friday
- [ ] Update team on plans
```

### Week 2-3: Implement

```markdown
## Daily
- [ ] Apply model selection rules
- [ ] Use Explore agent for searches
- [ ] Batch similar tasks
- [ ] Save important context
```

### Week 4: Measure and Adjust

```markdown
## Analysis
- [ ] Calculate actual savings
- [ ] Compare vs. baseline
- [ ] Identify gaps

## Adjustment
- [ ] Refine agent configuration
- [ ] Update CLAUDE.md
- [ ] Plan next month's targets
```

---

## Target Metrics

### Baseline (Without Optimization)

- Average cost per task: $0.30
- Most tasks use Sonnet
- Token usage: 400K/month
- Cost: $12/month

### After Phase 1 (Planning)

- Tokens: -10% → 360K
- Cost: $10.80/month
- Improvement: 10%

### After Phase 2 (Configuration)

- Tokens: -20% → 320K
- Cost: $9.60/month
- Improvement: 20% cumulative

### After Phase 3 (Runtime Optimization)

- Tokens: -35% → 260K
- Cost: $7.80/month
- Improvement: 35% cumulative

### After Phase 4 (Monitoring & Refinement)

- Tokens: -50% → 200K
- Cost: $6.00/month
- Improvement: 50% cumulative

**Target Achievement**: 50-70% cost reduction possible!

---

## Troubleshooting

### Problem: Models Always Using Sonnet

**Checklist:**
- [ ] Is default model set to Haiku?
- [ ] Are agents configured with correct models?
- [ ] Check: `cat .claude/config.json | jq '.agents'`

**Fix:**
```json
{
  "defaultModel": "haiku",
  "agents": {
    "Explore": {"model": "haiku"}
  }
}
```

### Problem: Token Usage Not Decreasing

**Checklist:**
- [ ] Are you using Explore for searches?
- [ ] Are you batching operations?
- [ ] Are prompts specific enough?
- [ ] Check cost logs: `cat .claude/cost-log.json`

**Debug:**
```bash
# See per-task breakdown
npm run cost-report
```

### Problem: Haiku Producing Poor Results

**Checklist:**
- [ ] Is the task actually simple?
- [ ] Is prompt specific enough?
- [ ] Are you using thinking keywords?

**Solution:**
- Upgrade to Sonnet for this task
- Keep Haiku for simpler tasks
- Adjust your task breakdown

---

## Checklist for Different Roles

### Solo Developer

- [ ] Set default to Haiku
- [ ] Configure three agents (Explore/General/Plan)
- [ ] Enable cost tracking
- [ ] Weekly review of spend
- [ ] Target: 50% savings

### Team Lead

- [ ] Establish team standards in CLAUDE.md
- [ ] Configure shared agent permissions
- [ ] Create team-specific skills
- [ ] Monthly cost reports
- [ ] Target: 60% savings (better leverage)

### DevOps/Infrastructure

- [ ] Secure secret management (.env)
- [ ] Configure CI/CD hooks
- [ ] Add pre-commit security checks
- [ ] Monitor costs across projects
- [ ] Target: 70% savings (batch operations)

---

## Print-Friendly Checklists

### Daily Checklist (Paste on Monitor)

```
✓ Specific prompt? (not vague)
✓ Right model choice?
✓ Batch similar tasks?
✓ Save context to memory?
✓ Review token usage?
```

### Weekly Checklist (Every Monday)

```
✓ Review cost logs
✓ Check model distribution
✓ Identify expensive tasks
✓ Update CLAUDE.md
✓ Measure savings vs. baseline
```

### Monthly Checklist (First Friday)

```
✓ Calculate actual ROI
✓ Refine agent config
✓ Update project standards
✓ Report to team
✓ Plan next month
```

---

## Next Steps

- Review [Token Optimization Guide](../11-optimization/strategies.md) for strategies
- Set up [Model Selection Tree](1-model-selection-tree.md) bookmark
- Check [Glossary](3-glossary.md) for terms
- Create your project's checklist version

---

**Download these checklists** and customize for your projects!
