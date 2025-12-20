# Claude Code Documentation Project

## Project Overview
This repository contains comprehensive documentation for Claude Code, covering MCP servers, agents, skills, model selection, thinking modes, context management, and optimization strategies.

## Documentation Structure
The documentation follows a **pedagogical progression** from fundamental to advanced concepts:
1. MCP Servers (foundation)
2. Agents (building on MCP)
3. Skills (leveraging agents)
4. Models (understanding the engine)
5. Thinking Modes (optimizing reasoning)
6. Context Management (advanced control)
7. Keywords & Triggers (power user features)
8. Token Optimization (synthesis)

## Key Files
- `DOCUMENTATION_PLAN.md` - Master plan with all topics, examples, and implementation roadmap
- `README.md` - Repository overview and quick start
- `INTRODUCTION.md` - Comprehensive introduction (to be created in Phase 0)
- `TABLE_OF_CONTENTS.md` - Master navigation (to be created in Phase 0)

## Writing Guidelines

### Content Standards
- **Clear examples**: Every feature must have copy-paste ready code examples
- **Real-world scenarios**: Include practical use cases, not just theoretical explanations
- **Progressive disclosure**: Start simple, then add complexity
- **Cost transparency**: Always include token usage and cost implications
- **Multi-level**: Cater to beginners, intermediate, and advanced users

### Code Examples
- Use TypeScript/JavaScript for agent and skill configurations
- Use bash for command-line examples
- Include both simple and complex examples for each feature
- Show before/after comparisons for optimization strategies

### Documentation Format
- Use GitHub-flavored Markdown
- Include table of contents for long documents
- Use code fencing with language tags
- Add visual diagrams where helpful (especially for dependencies)
- Link to official sources and references

### Tone and Style
- Professional and technical, but approachable
- Direct and concise
- Focus on practical value
- Explain "why" not just "how"
- Use active voice

## Implementation Phases

### Phase 0: Documentation Foundation (1 week)
Create introduction, table of contents, and README with clear navigation and pedagogical rationale.

### Phase 1: Foundation Documentation (2-3 weeks)
MCP Servers, Agents overview, Skills basics - the fundamental building blocks.

### Phase 2: Advanced Configuration (2-3 weeks)
Model selection, custom agents, custom skills - leveraging the fundamentals.

### Phase 3: Optimization and Patterns (2-3 weeks)
Token optimization, context management, behavioral customization - mastery level.

### Phase 4: Examples and Templates (2-3 weeks)
Real-world examples, templates, and complete project configurations.

### Phase 5: Reference and Maintenance (ongoing)
API reference, troubleshooting, FAQ, and updates.

## Common Commands

### Testing Documentation
```bash
# Check all markdown links
markdown-link-check **/*.md

# Spell check
cspell "**/*.md"

# Validate code examples
# (extract and test code blocks from markdown)
```

### Building Documentation
```bash
# If using a static site generator
npm run build

# Preview locally
npm run dev
```

### Git Workflow
- Branch naming: `claude/plan-claude-code-docs-{session-id}`
- Commit messages: Clear, descriptive, explain the "why"
- Always push to the feature branch
- Create PR when ready for review

## Target Audience

### Beginners
- New to Claude Code
- Need step-by-step guidance
- Require foundational concepts first
- Should follow sequential reading path

### Intermediate Users
- Familiar with basics
- Want to optimize workflows
- Need real-world examples
- Can skip some fundamentals

### Advanced Users
- Power users and customizers
- Need reference documentation
- Looking for edge cases and optimization
- Can jump directly to specific topics

## Success Metrics
- Users can set up MCP servers in < 10 minutes
- Users can create custom skills in < 30 minutes
- Users understand when to use each model
- Users can optimize token usage by 50%+
- Documentation covers all major use cases

## Quality Checklist
For each documentation page:
- [ ] Clear objective stated at the beginning
- [ ] Real-world examples included
- [ ] Code examples are tested and working
- [ ] Cost/token implications explained
- [ ] Links to official sources provided
- [ ] Troubleshooting section for common issues
- [ ] Cross-references to related topics
- [ ] Appropriate for target skill level
- [ ] Follows logical progression from previous topics
- [ ] Builds foundation for subsequent topics

## Resources and References

### Official Documentation
- [Claude Code Docs](https://code.claude.com/docs)
- [Claude API Docs](https://docs.claude.com)
- [Anthropic Engineering Blog](https://www.anthropic.com/engineering)
- [Model Context Protocol](https://modelcontextprotocol.io)

### Community Resources
- [Claude Code GitHub Issues](https://github.com/anthropics/claude-code/issues)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)
- [Community Skills (obra/superpowers)](https://github.com/obra/superpowers)

## Task Planning and Tracking Requirements

### Claude Pro Subscription Context
The user has a **Claude Pro subscription** with the following limits:
- **Usage tracking**: Monitor token consumption as percentage of daily/monthly limits
- **Model costs**: Different models consume different amounts of usage quota
- **Smart allocation**: Choose models based on task complexity vs. usage efficiency

### Required Task Planning Format

**ONLY when asking the user to choose a task**, provide estimates with:

```markdown
## Task Plan: [Task Name]

⏱️ **Estimated Time**: [X minutes/hours for Claude to complete]
🤖 **Recommended Model**: [Haiku 4.5 / Sonnet 4.5 / Opus 4.5]
🎯 **Estimated Tokens**: ~[X,XXX] tokens (input + output)
📊 **Usage Impact**: ~[X]% of Claude Pro daily usage
💰 **Rationale**: [Why this model? Why these tokens?]

### Task Breakdown:
1. [Subtask 1] - [X min] - [Y tokens]
2. [Subtask 2] - [X min] - [Y tokens]
3. [Subtask 3] - [X min] - [Y tokens]
```

**Note**: Do NOT show estimates for tasks that are already completed. Estimates are only for helping the user choose future tasks.

### Model Selection Guidelines

| Model | When to Use | Token Efficiency | Speed | Cost Impact |
|-------|-------------|------------------|-------|-------------|
| **Haiku 4.5** | Simple tasks, searches, formatting | ⭐⭐⭐ Excellent | 🚀 Fastest | ✅ Lowest (3x cheaper) |
| **Sonnet 4.5** | Standard documentation, coding | ⭐⭐ Good | 🏃 Fast | ⚠️ Medium (baseline) |
| **Opus 4.5** | Complex architecture, deep analysis | ⭐ Higher usage | 🚶 Slower | ❌ Highest (premium) |

### Task Completion Format

**AFTER completing any task**, provide a brief completion summary:

```markdown
## Task Complete: [Task Name]

✅ **Status**: Complete
💾 **Files Changed**: [List of files]
🔗 **Commit**: [Commit hash and message]

---

## Next Available Tasks

Choose your next task based on priority and usage budget:

### High Priority Tasks

#### 1. [Task Name]
⏱️ **Time**: [X min]
🤖 **Model**: [Haiku/Sonnet/Opus]
🎯 **Tokens**: ~[X,XXX]
📊 **Usage**: ~[X]%
📝 **Description**: [What needs to be done]
🎯 **Value**: [Why this matters]

#### 2. [Task Name]
⏱️ **Time**: [X min]
🤖 **Model**: [Haiku/Sonnet/Opus]
🎯 **Tokens**: ~[X,XXX]
📊 **Usage**: ~[X]%
📝 **Description**: [What needs to be done]
🎯 **Value**: [Why this matters]

### Medium Priority Tasks

[Same format as above]

### Quick Wins (Low Usage)

[Tasks that use Haiku and minimal tokens]

---

## Usage Budget Summary

**Used So Far**: [X]% of daily Claude Pro usage
**Remaining**: [X]% available
**Recommendation**: [Choose Haiku/Sonnet/Opus tasks based on remaining budget]
```

**Important**:
- Completion summaries should be brief - just status, files, and commit
- Full estimates (time, model, tokens, usage %) are ONLY shown for next available tasks
- This helps the user choose future tasks without cluttering completed work reports

### Token Estimation Guidelines

**Documentation Writing Tasks:**
- Simple markdown page (500 words): ~2,000-3,000 tokens (Haiku)
- Complex guide with examples (1,500 words): ~6,000-10,000 tokens (Sonnet)
- Comprehensive reference (3,000+ words): ~15,000-25,000 tokens (Sonnet/Opus)

**Code Generation Tasks:**
- Simple skill/template: ~3,000-5,000 tokens (Haiku)
- Complex skill with tests: ~8,000-12,000 tokens (Sonnet)
- Advanced architecture design: ~15,000-30,000 tokens (Opus)

**Research Tasks:**
- Quick lookup: ~1,000-2,000 tokens (Haiku)
- Comprehensive research: ~5,000-10,000 tokens (Sonnet)
- Deep analysis with synthesis: ~15,000-25,000 tokens (Opus)

**Planning Tasks:**
- Simple task breakdown: ~2,000-4,000 tokens (Haiku)
- Detailed implementation plan: ~8,000-15,000 tokens (Sonnet)
- Complex architectural planning: ~20,000-40,000 tokens (Opus)

### Claude Pro Usage Estimation

**Approximate Daily Limits (subject to change):**
- Claude Pro provides usage-based limits rather than hard token counts
- Usage percentage is measured across conversation turns
- Different models impact usage differently

**Rule of Thumb for This Project:**
- Small tasks (<5,000 tokens): ~1-2% of daily usage
- Medium tasks (5,000-15,000 tokens): ~3-5% of daily usage
- Large tasks (15,000-30,000 tokens): ~6-10% of daily usage
- Very large tasks (30,000+ tokens): ~10-15% of daily usage

**Usage Optimization Strategies:**
1. **Batch similar tasks**: Complete multiple small tasks in one session
2. **Choose Haiku when possible**: 3x more efficient than Sonnet
3. **Avoid Opus for routine work**: Reserve for complex architecture/analysis
4. **Monitor usage after each task**: Track actual vs. estimated consumption
5. **Plan ahead**: Prioritize high-value tasks when usage budget is available

## Notes for AI Assistants

When working on this documentation:

### Core Principles
1. **Maintain pedagogical order**: Ensure new content fits the logical progression
2. **Include cost analysis**: Always show token usage and savings potential
3. **Real examples only**: No hypothetical or untested code
4. **Link to sources**: Every claim should reference official documentation
5. **Test examples**: Verify all code examples work before committing
6. **Update plan**: Keep DOCUMENTATION_PLAN.md in sync with actual content
7. **Cross-reference**: Link related topics together
8. **Multiple skill levels**: Provide basic and advanced examples for each topic

### Task Planning Workflow
**ALWAYS follow this workflow:**

1. **User Selects Task**: When user says "continue with task 1" or "continue with agents" or similar
2. **Start Immediately**: Begin working on the task right away WITHOUT asking for confirmation
3. **During Work**: Focus on completing the task efficiently
4. **After Completion**: Brief summary (status, files, commit) - NO estimates for completed work
5. **Next Steps**: List 3-5 next tasks with full planning details (time, model, tokens, usage %)
6. **Usage Check**: Show remaining usage budget and recommendations

**Key Principles**:
- Show estimates ONLY for future tasks the user is choosing between, NOT for completed work
- Once user selects a task, START IMMEDIATELY without asking "continue" or waiting for confirmation
- User should only need to say the task name/number ONCE to trigger execution

### Example Task Planning

**Good Example (when asking user to choose):**
```markdown
## Next Available Tasks

#### 1. Create INTRODUCTION.md
⏱️ **Time**: 45 minutes
🤖 **Model**: Sonnet 4.5
🎯 **Tokens**: ~12,000 tokens
📊 **Usage**: ~4% of Claude Pro daily usage
💰 **Rationale**: Sonnet balances quality and efficiency for this medium-complexity writing task
📝 **Description**: Write comprehensive introduction with welcome, learning path, and navigation
🎯 **Value**: Critical foundation - first thing users see

Which task would you like me to tackle?
```

**Good Example (after completing task):**
```markdown
## Task Complete: Create TABLE_OF_CONTENTS.md

✅ **Status**: Complete
💾 **Files Changed**: TABLE_OF_CONTENTS.md
🔗 **Commit**: 861b8de - Create comprehensive TABLE_OF_CONTENTS.md with navigation

[Then show next available tasks with estimates]
```

**Bad Example:**
```markdown
## Task Complete: Create TABLE_OF_CONTENTS.md

✅ Completed In: 35 minutes
🤖 Model Used: Sonnet 4.5
📈 Actual Tokens: ~8,500 tokens consumed
📊 Usage Consumed: ~3% of Claude Pro daily usage
```
❌ Don't show estimates/actuals for completed work - keep it brief!

### When User Requests Task Estimates

If user asks "What tasks are next?" or "What should we do?", ALWAYS respond with:
1. List of 5-10 available tasks
2. Each with: time, model, tokens, usage %, description, value
3. Grouped by priority (High/Medium/Quick Wins)
4. Usage budget summary
5. Recommendation based on remaining budget
