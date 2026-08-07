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
| `.claude/settings.json` | Project settings — model, permissions, env, hooks (committed) |
| `.claude/settings.local.json` | Personal overrides (gitignored) |
| `~/.claude/settings.json` | User settings, all projects |
| `.claude/skills/<name>/SKILL.md` | Custom skills — each carries its own frontmatter |
| `.claude/agents/<name>.md` | Custom subagents — each carries its own frontmatter |
| `.claude/commands/` | Slash commands (merged into skills; still supported) |
| `.mcp.json` | Project MCP servers |

---

## Model Pricing

| Model | Input | Output | Use Case |
|-------|-------|--------|----------|
| **Haiku 4.5** | $1/M | $5/M | Fast & cheap (searches, simple tasks) |
| **Sonnet 5** | $3/M | $15/M | Balanced (standard coding) |
| **Opus 5** | $5/M | $25/M | Maximum reasoning (architecture) |
| **Fable 5** | $10/M | $50/M | Highest capability |

**M = Million tokens.** Sonnet 5 is $2/$10 introductory through 31 Aug 2026, then $3/$15.
Haiku 4.5 is still the current Haiku — there is no Haiku 5.
[Verify current rates](https://platform.claude.com/docs/en/about-claude/pricing).

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
`.claude/settings.json` sets the session default. There is no `agents` key — each subagent
carries its own `model` in its own file:

```json
{
  "model": "sonnet",
  "fallbackModel": "haiku"
}
```

### Cost Tracking

No settings key tracks or caps cost. Use the commands:

```text
/usage      # tokens + cost; per-skill/subagent/plugin attribution on paid plans
/context    # what is occupying the context window right now
```

Spend limits exist at the organization level (Teams/Enterprise admin settings, or Console
workspace limits), not in a local file.

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

`.claude/skills/<name>/SKILL.md` — all fields optional; the command name comes from the
directory, not from `name`:

```yaml
---
description: What it does AND when to use it. This is what triggers the skill.
when_to_use: Extra trigger phrases or example requests
model: sonnet            # turn-scoped override, not saved to settings
effort: medium           # low | medium | high | xhigh | max
allowed-tools: Read Grep Bash(git diff *)
disallowed-tools: AskUserQuestion
paths: ["**/*.test.ts"]  # only auto-activate for matching files
disable-model-invocation: true   # manual /name only
context: fork            # run in an isolated subagent context
---
```

---

## Agent Frontmatter

`.claude/agents/<name>.md` — `name` and `description` are required:

```yaml
---
name: agent-name
description: When Claude should delegate to this subagent
model: sonnet            # sonnet|opus|haiku|fable|full ID|inherit (default inherit)
tools: Read, Grep, Glob  # omit to inherit all subagent tools
permissionMode: default  # default|acceptEdits|auto|dontAsk|bypassPermissions|plan
skills: code-conventions # preload skill content at startup
color: blue
---
```

Restrict file access with `permissions` in settings.json rather than agent frontmatter —
there are no `allowedPaths`, `deniedPaths`, or `timeout` fields.

---

## Slash Command

`.claude/commands/review.md` — the command name comes from the filename:

```yaml
---
description: Reviews a diff for correctness and security. Use before committing.
argument-hint: "[file]"
arguments: [file]
model: sonnet
---

Review $file for correctness, security, and missing error handling.
```

---

## Hook Types

| Hook | Trigger | Use For |
|------|---------|---------|
| **PreToolUse** | Before tool runs | Validation, backup |
| **PostToolUse** | After tool succeeds | Format, test, build |
| **Notification** | Claude notifies | OS alerts, logging |
| **Stop** | Response complete | Git checks, cleanup |

### Hook Input

Hooks receive JSON on **stdin**, not shell variables. Parse it with `jq`:

```bash
f=$(jq -r '.tool_input.file_path')   # tool events
```

Common fields: `hook_event_name`, `tool_name`, `tool_input`, `cwd`, `session_id`.
Exit `0` for success, `2` to block (stderr becomes the reason).
Available in the environment: `$CLAUDE_PROJECT_DIR`, `$CLAUDE_EFFORT`.

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
- [ ] Know how to check `/usage` and `/context`

### Context
- [ ] CLAUDE.md < 200 lines
- [ ] Use file imports (@docs/...)
- [ ] Memory hierarchy configured
- [ ] Clear history between unrelated tasks

### Usage
- [ ] Use Explore for read-only
- [ ] Batch operations
- [ ] Specific prompts (not vague)
- [ ] Skip thinking keywords for simple tasks

### Monitoring
- [ ] Review `/usage` weekly (press `w` for 7 days)
- [ ] Check model distribution
- [ ] Adjust based on actual usage

**Target**: 50-70% cost reduction

---

## Troubleshooting Quick Fixes

### MCP Server Not Loading
```bash
claude mcp list          # Verify installation
cat .mcp.json | jq .     # Project servers (~/.claude.json for user scope)
claude mcp remove NAME && claude mcp add NAME
# Restart Claude
```

### Settings Not Applying
```bash
cat .claude/settings.json | jq .   # Validate JSON
```
Then check precedence — a higher-priority file may be overriding you. Highest first: managed
settings, command-line arguments, `.claude/settings.local.json`, `.claude/settings.json`,
`~/.claude/settings.json`. `model` and `outputStyle` are read once at startup, so restart the
session after changing them.

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

Set the default model with `"model"` in settings.json, not an environment variable. Settings
file locations are fixed per scope and cannot be redirected.

```bash
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
✅ < 200 lines + @imports

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

**Claude Code Version**: 1.0.x
**For**: Haiku 4.5, Sonnet 5, Opus 5

---

**Print This Page**: Bookmark for quick reference during development!

**More Details**: See full guides at [Table of Contents](../../TABLE_OF_CONTENTS.md)
