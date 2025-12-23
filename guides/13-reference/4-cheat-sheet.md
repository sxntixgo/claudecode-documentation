# Claude Code Quick Reference Cheat Sheet

**One-Page Reference | Print-Friendly | Bookmark This**

---

## Command Line

### Launch Claude
```bash
claude                          # Start default model
claude --model haiku            # Start with Haiku
claude --model sonnet           # Start with Sonnet
claude --model opus             # Start with Opus
claude --version                # Check version
```

### MCP Servers
```bash
claude mcp list                 # List installed servers
claude mcp add NAME             # Add server
claude mcp remove NAME          # Remove server
claude mcp get NAME             # Get server info
```

---

## Interactive Commands

### Model Selection
```bash
/model                          # Open model selection menu
/usage                          # View token usage
```

### Thinking Control
```
Press [Tab]                     # Toggle extended thinking on/off
```

---

## File Locations

| File/Directory | Purpose |
|----------------|---------|
| `CLAUDE.md` | Project context (root or .claude/) |
| `.claude/config.json` | Agent, model, hook configuration |
| `.claude/memory.md` | Session memory |
| `.claude/skills/` | Custom skills |
| `.claude/commands/` | Slash commands |
| `.claude/agents/` | Custom agents |

---

## Model Pricing (2025)

| Model | Input | Output | Use Case |
|-------|-------|--------|----------|
| **Haiku 4.5** | $1/M | $5/M | Fast & cheap (searches, simple tasks) |
| **Sonnet 4.5** | $3/M | $15/M | Balanced (standard coding) |
| **Opus 4.5** | Premium | Premium | Maximum reasoning (architecture) |

**M = Million tokens**

---

## Thinking Keywords

| Keyword | Token Budget | When to Use |
|---------|--------------|-------------|
| (none) | 0 | Simple tasks |
| `"think"` | ~4,000 | Moderate complexity |
| `"think hard"` | ~10,000 | Complex problems |
| `"think harder"` | ~31,999 | Very complex |
| `"ultrathink"` | ~31,999 | Maximum reasoning |

---

## Agent Types

| Agent | Purpose | Best For | Model |
|-------|---------|----------|-------|
| **Explore** | Read-only search | Finding code, understanding | Haiku |
| **General-Purpose** | Full read/write | Coding, refactoring | Sonnet |
| **Plan** | Planning mode | Architecture planning | Sonnet/Opus |

---

## Quick Config Examples

### Optimal Cost Configuration
```json
{
  "agents": {
    "Explore": {"model": "haiku"},
    "general-purpose": {"model": "sonnet"},
    "Plan": {"model": "sonnet"}
  },
  "defaultModel": "haiku"
}
```

### Cost Tracking
```json
{
  "costTracking": {
    "enabled": true,
    "dailyBudget": 100000,
    "alertThreshold": 0.8,
    "logFile": ".claude/cost-log.json"
  }
}
```

### Auto-Format Hook
```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{"command": "npx prettier --write $FILE"}]
    }]
  }
}
```

---

## CLAUDE.md Template

```markdown
# Project Name

## Tech Stack
- Language: TypeScript
- Framework: React 18
- Backend: Node.js + Express

## Commands
\`\`\`bash
npm run dev      # Dev server
npm test         # Run tests
npm run build    # Build
\`\`\`

## Core Files
- `src/app.ts`: Entry point
- `src/api/`: API routes

## Code Style
- 2 spaces, single quotes
- ESLint + Prettier

## Notes for AI
- Run tests before commit
- Follow existing patterns
```

---

## Skill Frontmatter

```yaml
---
name: skill-name
version: 1.0.0
description: Clear, specific description with keywords
model: claude-sonnet-4-5
modelOverrides:
  quick: claude-haiku-4-5
  deep: claude-opus-4-5
tags: ["testing", "api"]
---
```

---

## Agent Frontmatter

```yaml
---
name: agent-name
description: Agent purpose
model: sonnet
tools: ["Read", "Write", "Edit", "Grep"]
constraints:
  allowedPaths: ["src/components/**"]
  deniedPaths: [".env*", "**/*.private.*"]
timeout: 180000
---
```

---

## Slash Command

```yaml
---
command: review
description: Code review
usage: /review [options] <file>
model: sonnet
options:
  - name: quick
    type: boolean
    default: false
---

# Command instructions here
```

---

## Hook Types

| Hook | Trigger | Use For |
|------|---------|---------|
| **PreToolUse** | Before tool runs | Validation, backup |
| **PostToolUse** | After tool succeeds | Format, test, build |
| **Notification** | Claude notifies | OS alerts, logging |
| **Stop** | Response complete | Git checks, cleanup |

### Hook Variables
- `$TOOL`: Tool name
- `$FILE`: File path
- `$STATUS`: Exit code
- `$OUTPUT`: Tool output
- `$MESSAGE`: Notification message

---

## Common Patterns

### Explore-First Workflow
```bash
1. You: "Use Explore agent to find all API endpoints"
2. [Review results]
3. You: "Refactor these endpoints: [list]"
```
**Savings**: 50% on search phase

### Batching
```bash
❌ "Fix file1" then "Fix file2" then "Fix file3"
✅ "Fix files: file1, file2, file3"
```
**Savings**: ~30%

### Memory-Augmented
```bash
You: "Save to memory: Using Redux Toolkit for state"
[Later...]
You: "Implement authentication"
# Claude loads memory automatically
```

---

## Optimization Checklist

### Configuration
- [ ] Explore agent → Haiku
- [ ] General-Purpose → Haiku/Sonnet
- [ ] Plan agent → Sonnet
- [ ] Default model → Haiku
- [ ] Cost tracking enabled

### Context
- [ ] CLAUDE.md < 300 lines
- [ ] Use file imports (@docs/...)
- [ ] Memory hierarchy configured
- [ ] Clear history between unrelated tasks

### Usage
- [ ] Use Explore for read-only
- [ ] Batch operations
- [ ] Specific prompts (not vague)
- [ ] Skip thinking keywords for simple tasks

### Monitoring
- [ ] Review cost logs weekly
- [ ] Check model distribution
- [ ] Adjust based on actual usage

**Target**: 50-70% cost reduction

---

## Troubleshooting Quick Fixes

### MCP Server Not Loading
```bash
claude mcp list          # Verify installation
cat ~/.config/claude/claude_desktop_config.json | jq .
claude mcp remove NAME && claude mcp add NAME
# Restart Claude
```

### Config Not Loading
```bash
ls .claude/config.json   # Verify exists
cat .claude/config.json | jq .  # Validate JSON
# Restart session
```

### Skill Not Invoked
- Check: `.claude/skills/SKILL-NAME/SKILL.md` exists
- Improve description (add keywords)
- Test: Explicitly mention skill keywords

### Agent Timeout
- Increase timeout in config (default: 120000)
- Break task into smaller pieces
- Use faster model (Haiku)

---

## Environment Variables

```bash
# System
export CLAUDE_DEFAULT_MODEL=sonnet
export CLAUDE_CONFIG_PATH=~/.config/claude/config.json

# MCP Servers
export GITHUB_TOKEN=ghp_xxxxx
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxxxx
export PERPLEXITY_API_KEY=pplx-xxxxx
```

---

## Decision Trees

### Model Selection
```
Simple search/format? → Haiku
  ↓ No
Complex architecture? → Opus
  ↓ No
Standard coding → Sonnet
```

### Agent Selection
```
Read-only task? → Explore
  ↓ No
Multi-step coding? → General-Purpose
  ↓ No
Need planning? → Plan
```

---

## Cost Savings Calculator

### Example: Solo Developer

**Before** (all Sonnet):
- 30 ops/day × 15K tokens × $3/$15 per M
- = $13.50/day = $405/month

**After** (optimized):
- 20 searches (Haiku, 5K): $0.40/day
- 8 features (Sonnet, 10K): $2.40/day
- 2 planning (Sonnet, 20K): $1.20/day
- = $4.00/day = $120/month

**Savings**: $285/month (70%)

---

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| **Tab** | Toggle extended thinking |
| **Ctrl/Cmd + C** | Cancel operation |
| **Ctrl/Cmd + D** | Exit Claude |

---

## Essential Links

- **Official Docs**: https://code.claude.com/docs
- **GitHub**: https://github.com/anthropics/claude-code
- **Community**: https://community.anthropic.com
- **MCP Spec**: https://modelcontextprotocol.io
- **Skills Repo**: https://github.com/anthropics/skills

---

## Common Mistakes to Avoid

❌ Using Opus for searches
✅ Use Haiku (3x cheaper, same quality)

❌ Vague prompts ("improve this")
✅ Specific ("refactor src/utils/date.ts to use date-fns")

❌ "think harder" for simple tasks
✅ No thinking keywords for formatting/searches

❌ 1000-line CLAUDE.md
✅ < 300 lines + @imports

❌ All default settings
✅ Configure agents, enable cost tracking

❌ Ignoring context warnings
✅ Save to memory immediately

---

## Pro Tips

### Cost Optimization
1. Default to Haiku, upgrade when needed
2. Use Explore agent for searches (50% savings)
3. Batch operations (30% savings)
4. Keep CLAUDE.md lean
5. Monitor and adjust weekly

### Productivity
1. Create project-specific skills
2. Use slash commands for common tasks
3. Configure hooks for automation
4. Leverage memory for recurring context
5. Use focused agents for large codebases

### Quality
1. Reserve Opus for critical architecture
2. Use "think" for complex reasoning
3. Write clear, specific prompts
4. Review agent outputs
5. Test generated code

---

## Version Info

**Last Updated**: 2025-01-15
**Claude Code Version**: 1.0.x
**For**: Haiku 4.5, Sonnet 4.5, Opus 4.5

---

**Print This Page**: Bookmark for quick reference during development!

**More Details**: See full guides at [Table of Contents](../TABLE_OF_CONTENTS.md)
