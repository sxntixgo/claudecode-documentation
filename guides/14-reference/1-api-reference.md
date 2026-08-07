# Complete API Reference

**Reading Time**: 45 minutes
**Skill Level**: Intermediate to Advanced
**Prerequisites**: Understanding of agents, skills, and configuration basics

---

## Welcome to the Technical Reference! 📚

This is your complete technical reference for all Claude Code configuration schemas, file formats, and specifications. Use this as your go-to resource when creating custom agents, skills, commands, and configurations.

---

## Table of Contents

1. [Subagent Schema](#subagent-schema)
2. [SKILL.md Schema](#skillmd-schema)
3. [settings.json Schema](#settingsjson-schema)
4. [Hook Specifications](#hook-specifications)
5. [Slash Command Schema](#slash-command-schema)
6. [CLAUDE.md Structure](#claudemd-structure)
7. [Environment Variables](#environment-variables)
8. [File Locations](#file-locations)

---

## Subagent Schema

### Overview

A custom subagent is a single Markdown file with YAML frontmatter. There is no `AGENT.md` and no registry — Claude Code discovers subagents by reading the directory, so the agent exists
the moment the file does.

| Scope | Path |
|-------|------|
| Project, shared via git | `.claude/agents/<name>.md` |
| Personal, all projects | `~/.claude/agents/<name>.md` |

### Complete Schema

```yaml
---
name: string (required)
  # Unique identifier, lowercase letters and hyphens. Cannot contain ":",
  # which is reserved for plugin-scoped names. Hooks receive this as agent_type.

description: string (required)
  # When Claude should delegate to this subagent. This IS the routing logic —
  # there is no rule table or pattern matcher, so be specific and action-oriented.

tools: string[] (optional)
  # Tools the subagent may use. Inherits every tool available to subagents if
  # omitted. If no entry resolves to a real tool, the subagent fails to launch.
  # To preload skills, use the skills field rather than listing Skill here.

model: string (optional)
  # sonnet | opus | haiku | fable | a full model ID | inherit
  # Defaults to inherit, meaning it runs on the main session's model.

permissionMode: string (optional)
  # default | acceptEdits | auto | dontAsk | bypassPermissions | plan
  # Ignored for plugin subagents.

skills: string[] (optional)
  # Skills to preload into the subagent's context at startup. The full skill
  # content is injected, not just the description. The subagent can still invoke
  # unlisted skills through the Skill tool.

hooks: object (optional)
  # Lifecycle hooks scoped to this subagent. Ignored for plugin subagents.

color: string (optional)
  # Display color in the task list and transcript: red, blue, green, yellow,
  # purple, orange, pink, or cyan.
---

# Agent Instructions

[Instructions for how the agent should behave, in markdown]
```

> ⚠️ **Fields that do not exist.** `constraints`, `allowedPaths`, `deniedPaths`, `maxFileSize`,
> `readOnly`, `autoActions`, `timeout`, and `contextWindow` are not read. To restrict what an
> agent can touch, limit `tools` in its frontmatter and set `permissions.deny` in
> `.claude/settings.json`. To run a command after every edit, use a `PostToolUse`
> [hook](../11-hooks/1-overview.md). There is no timeout field — narrow the task scope instead.

### Example: Frontend Specialist Agent

`.claude/agents/frontend-specialist.md`:

```markdown
---
name: frontend-specialist
description: Builds and modifies React components, hooks, and client-side state. Use for any work under src/components/ or src/pages/.
model: sonnet
tools: Read, Write, Edit, Bash, Grep, Glob
color: blue
---

# Frontend Specialist

## Scope

React components with TypeScript, hooks, Context-based state, CSS Modules and Tailwind,
and React Testing Library tests.

## Approach

1. TypeScript strict mode; no `any`
2. Composition over inheritance
3. Reach for `memo`, `useCallback`, and `useMemo` only with a measured reason
4. WCAG 2.1 AA for anything interactive
5. Write the test alongside the component

## Out of scope

Backend APIs, database queries, and deployment config. Say so and stop rather than
guessing at them.
```

To auto-format after every write, pair the agent with a hook in `.claude/settings.json`
rather than an `autoActions` block:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [{ "type": "command", "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write" }]
      }
    ]
  }
}
```

---

## SKILL.md Schema

### Overview

Skills are reusable instruction sets defined in `SKILL.md` files with YAML frontmatter. Skills use progressive disclosure to provide context as needed.

### Complete Schema

All frontmatter fields are optional. Only `description` is recommended, since that is what
Claude reads to decide whether the skill applies. A skill's command name comes from its
**directory name**, not from `name`.

```yaml
---
# Discovery — how Claude decides to use this skill
description: string (recommended)
  # What the skill does AND when to use it. Put the key use case first:
  # description + when_to_use are truncated at 1,536 characters in the listing.
  # Bad:  "document processing skill"
  # Good: "Extracts tables from PDFs and converts them to CSV. Use when
  #        working with PDF files or when the user mentions tables or extraction."

when_to_use: string (optional)
  # Extra trigger context — example requests or trigger phrases.
  # Appended to description; counts toward the same 1,536-character cap.

name: string (optional)
  # Display label in skill listings. Defaults to the directory name.
  # For personal and project skills this does NOT change the command name.
  # Max 64 chars, lowercase letters/numbers/hyphens, no "anthropic" or "claude".

paths: string[] | string (optional)
  # Glob patterns limiting when the skill auto-activates.
  # Example: ["**/*.test.ts", "**/migrations/*.sql"]

# Invocation control
disable-model-invocation: boolean (optional, default false)
  # true prevents Claude from auto-loading it; invoke manually with /name.

user-invocable: boolean (optional, default true)
  # false hides it from the / menu. For background knowledge, not commands.

argument-hint: string (optional)
  # Autocomplete hint. Example: "[issue-number]" or "[filename] [format]"

arguments: string[] | string (optional)
  # Named positional arguments for $name substitution in the body.

# Model and reasoning
model: string (optional)
  # sonnet | opus | haiku | fable | a full model ID | inherit
  # NOTE: applies for the REMAINDER OF THE CURRENT TURN only. It is not saved
  # to settings; the session model resumes on your next prompt.

effort: string (optional)
  # low | medium | high | xhigh | max. Available levels depend on the model.
  # Inherits the session effort level if omitted.

# Tool access
allowed-tools: string[] | string (optional)
  # Tools usable without a permission prompt during the invoking turn.
  # The grant clears on your next message.

disallowed-tools: string[] | string (optional)
  # Tools removed from the pool while this skill is active.

# Execution context
context: string (optional)
  # Set to "fork" to run in a forked subagent context, keeping the skill's
  # reads out of the main conversation's context window.

agent: string (optional)
  # Which subagent type to use. Only applies with context: fork.

background: boolean (optional, default true)
  # Only applies with context: fork. false waits for the result in the
  # invoking turn instead of running in the background.

hooks: object (optional)
  # Lifecycle hooks scoped to this skill.

shell: string (optional)
  # bash (default) or powershell, for inline shell commands in the body.
---

# Skill Name

## Overview
[1-2 paragraphs explaining what this skill does and when to use it]

## Prerequisites
- Required tools or dependencies
- Skills or knowledge needed
- Environment setup

## Step-by-Step Instructions

### Phase 1: [Phase Name]
1. First step with clear action
2. Second step with expected outcome
3. Continue with specific, actionable steps

### Phase 2: [Phase Name]
1. Next phase steps
2. Build on previous phase
3. Maintain clear progression

## Examples

### Example 1: [Scenario Name]
**Context**: Describe the starting situation
**Goal**: What we want to achieve

**Steps**:
1. Concrete step with code example
2. Next step showing progression
3. Final step with result

**Code**:
```language
// Actual working code example
```

**Validation**:
- How to verify it worked
- Expected output
- Common issues

### Example 2: [Different Scenario]
[Follow same structure]

## Validation

How to verify the skill executed correctly:
- Checklist of verification steps
- Tests to run
- Expected outcomes
- Common failure modes

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Common problem 1 | Why it happens | How to fix |
| Common problem 2 | Root cause | Resolution steps |

## Further Reading
- Link to related skills
- External documentation
- Best practices articles
```

### Example: Code Review Skill

```yaml
---
description: Reviews staged changes for correctness, security, and style issues. Use before committing or when the user asks for a code review.
model: sonnet
effort: medium
allowed-tools: Read Grep Bash(git diff *) Bash(git status *)
---

# Code Review Skill

## Overview

Reviews the staged diff for correctness, security, and style. Use for pull request reviews,
pre-merge checks, or periodic code audits.

## Prerequisites

- Code committed to version control
- Tests written and passing
- Linting/formatting already applied

## Step-by-Step Instructions

### Phase 1: Understand Context
1. Read the code changes (git diff or file contents)
2. Understand the purpose and scope
3. Identify the review depth needed (quick/standard/deep)

### Phase 2: Code Quality Review
1. **Readability**: Is code clear and self-documenting?
2. **Maintainability**: Can others easily modify this code?
3. **DRY Principle**: Are there unnecessary repetitions?
4. **Naming**: Are variables, functions, classes named clearly?
5. **Comments**: Are complex sections explained?

### Phase 3: Security Review (Standard/Deep only)
1. Input validation present?
2. SQL injection risks?
3. XSS vulnerabilities?
4. Authentication/authorization correct?
5. Secrets hardcoded?
6. Dependencies up-to-date and secure?

### Phase 4: Performance Review (Standard/Deep only)
1. Algorithmic complexity reasonable?
2. Database queries optimized?
3. Caching opportunities?
4. Memory leaks possible?
5. Unnecessary computations?

### Phase 5: Architecture Review (Deep only)
1. Design patterns appropriate?
2. Separation of concerns maintained?
3. SOLID principles followed?
4. Scalability considered?
5. Technical debt introduced?

### Phase 6: Generate Report
1. Categorize issues by severity (Critical/High/Medium/Low)
2. Provide specific line numbers
3. Suggest concrete improvements
4. Highlight what was done well

## Examples

### Example 1: Quick Review

**Context**: Small bug fix in login flow
**Model**: Haiku (quick mode)

**Review Output**:
```markdown
## Quick Code Review: Login Bug Fix

### ✅ Positive Findings
- Clear variable names
- Proper error handling added
- Tests updated

### ⚠️ Issues Found

**Medium Priority**:
- Line 42: Missing input validation for email format
  ```javascript
  // Current:
  const user = await findByEmail(email);

  // Suggested:
  if (!isValidEmail(email)) throw new Error('Invalid email format');
  const user = await findByEmail(email);
  ```

### Summary
1 medium issue, fix recommended before merge.
```

### Example 2: Standard Review

**Context**: New feature adding payment processing
**Model**: Sonnet (standard mode)

**Review Output**:
```markdown
## Standard Code Review: Payment Processing Feature

### ✅ Positive Findings
- Well-structured async/await usage
- Comprehensive error handling
- Good test coverage (85%)

### 🔴 Critical Issues

**Line 156: Sensitive data logged**
```javascript
// CRITICAL SECURITY ISSUE
console.log('Payment data:', paymentInfo); // Contains credit card numbers!

// Fix: Remove or redact sensitive data
console.log('Payment initiated for order:', orderId);
```

### ⚠️ High Priority Issues

**Line 203: SQL Injection vulnerability**
```javascript
// Vulnerable:
const query = `SELECT * FROM orders WHERE id = ${orderId}`;

// Fixed:
const query = 'SELECT * FROM orders WHERE id = ?';
db.execute(query, [orderId]);
```

### 📝 Medium Priority Issues

**Line 178: Missing input validation**
- Add schema validation for payment amount
- Verify currency code is valid
- Check amount is positive number

### Summary
1 critical, 2 high, 3 medium issues. Do NOT merge until critical/high are fixed.
```

## Validation

After code review:
- [ ] All critical issues addressed
- [ ] High-priority issues fixed or documented
- [ ] Security concerns resolved
- [ ] Performance bottlenecks identified
- [ ] Tests cover new functionality
- [ ] Documentation updated

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Review too superficial | Quick mode on complex code | Use standard or deep mode |
| False positives | Model hallucination | Verify each issue, use higher-tier model |
| Missing context | Insufficient code provided | Include related files, architecture docs |
| Too slow | Deep mode on large changeset | Split into smaller reviews or use standard mode |
```

---

## settings.json Schema

### Overview

`settings.json` is Claude Code's configuration file. It holds your model selection, permission rules, environment variables, and hooks. It is plain JSON, and it exists in four scopes that layer on top of one another.

There is no `config.json` — that filename has never been part of Claude Code.

**Scopes and precedence** (highest wins; a higher scope overrides the same key set lower down):

| Precedence | Location | What it is |
|------------|----------|------------|
| 1 (highest) | `managed-settings.json` in a system directory | Managed settings deployed by IT — cannot be overridden |
| 2 | Command line arguments | Applies to the current invocation only |
| 3 | `.claude/settings.local.json` | Project settings, personal to you, gitignored |
| 4 | `.claude/settings.json` | Project settings, committed to git and shared with the team |
| 5 (lowest) | `~/.claude/settings.json` | Your user settings, applied across all projects |

**Related files that are *not* settings**:

| File | Purpose |
|------|---------|
| `.mcp.json` | Project MCP server definitions |
| `~/.claude.json` | OAuth credentials and MCP state |
| `CLAUDE.md` | Project memory and conventions — instructions, not configuration |

### Available Keys

| Key | Purpose |
|-----|---------|
| `model` | Default model for the session (`haiku`, `sonnet`, `opus`, ...) |
| `availableModels` | Models offered in the model picker |
| `enforceAvailableModels` | Restrict selection to `availableModels` |
| `fallbackModel` | Model used when the primary is unavailable |
| `effortLevel` | Default reasoning effort |
| `alwaysThinkingEnabled` | Keep extended thinking on by default |
| `fastMode` | Optimize for speed |
| `permissions` | `allow` / `ask` / `deny` rule arrays |
| `env` | Environment variables exported into every session |
| `hooks` | Lifecycle hook definitions |
| `disableAllHooks` | Kill switch for all hooks |
| `autoCompactEnabled` | Automatic context compaction |
| `cleanupPeriodDays` | Retention window for local session data |
| `agent` | Run the main thread as this named subagent (a string, not a map) |
| `editorMode` | Editor keybinding mode |
| `attribution` | Commit and PR attribution behavior |
| `autoMemoryEnabled` | Automatic memory capture |
| `allowedMcpServers` / `deniedMcpServers` | MCP server allowlist / denylist |
| `enableAllProjectMcpServers` | Auto-approve MCP servers from `.mcp.json` |
| `outputStyle` | Response output style |

> ⚠️ Note the singular `agent` key. There is no `agents` object — per-subagent settings live in the subagent's own file, not here. See [subagent file Schema](#agentmd-schema).

### Example Configuration

`.claude/settings.json`:

```json
{
  "model": "sonnet",
  "fallbackModel": "haiku",

  "permissions": {
    "allow": ["Bash(npm run test:*)", "Read(./src/**)"],
    "ask": ["Bash(git push:*)"],
    "deny": ["Read(./.env)"]
  },

  "env": {
    "NODE_ENV": "development"
  },

  "hooks": {
    "Stop": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "~/.claude/stop-hook-git-check.sh"
      }]
    }],
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "npx prettier --write $FILE"
      }]
    }]
  },

  "autoCompactEnabled": true,
  "cleanupPeriodDays": 30
}
```

### Where Per-Agent and Per-Skill Models Live

Model choice for an individual subagent or skill is *not* a settings key. It goes in the YAML frontmatter of that component's own file.

```yaml
# .claude/agents/explore.md
---
name: explore
description: Fast codebase exploration
model: haiku
---
```

```yaml
# .claude/skills/my-skill/SKILL.md
---
name: my-skill
description: Deep architectural analysis
model: opus
---
```

A skill's `model` override applies for the rest of the current turn only. It is never written back to settings, and the session model resumes on your next prompt.

### Cost and Usage Tracking

There is no cost-tracking key and no cost log file. Usage is inspected through commands and the Console:

- `/usage` — token counts and locally computed cost for the session. On Pro, Max, Team, and Enterprise plans it also attributes recent usage to skills, subagents, plugins, and individual MCP servers as a percentage of total, and flags any behavior accounting for 10% or more. Press `d` for a 24-hour window or `w` for 7 days.
- `/context` — what is currently occupying the context window.
- [Console usage page](https://platform.claude.com/usage) — authoritative billing. The `/usage` dollar figure is computed locally at list rates and may differ from your bill.
- OpenTelemetry export — per-user token and cost metrics streamed into your own observability stack. Works on every setup.

Session totals reset when `/clear` starts a new session.

### Project Conventions Belong in CLAUDE.md

Project name, description, tech stack, and coding conventions are not settings keys. Put them in `CLAUDE.md`, which Claude reads as memory at the start of every session. See [CLAUDE.md Structure](#claudemd-structure).

---

## Hook Specifications

### Hook Types

Claude Code supports four hook types that trigger at different stages:

#### 1. PreToolUse

Executes after Claude creates tool parameters but before processing.

**Schema**:
```json
{
  "matcher": "string (tool name regex)",
  "hooks": [{
    "type": "command",
    "command": "string (shell command)",
    "timeout": number (milliseconds, default: 60000)
  }]
}
```

**Variables Available**:
- `$TOOL`: Tool name being used
- `$PARAMS`: JSON string of tool parameters

**Example**:
```json
{
  "PreToolUse": [{
    "matcher": "Write",
    "hooks": [{
      "type": "command",
      "command": "echo 'About to write file' >> /tmp/audit.log"
    }]
  }]
}
```

#### 2. PostToolUse

Executes immediately after a tool completes successfully.

**Variables Available**:
- `$TOOL`: Tool name that was used
- `$FILE`: File path (for file operations)
- `$STATUS`: Exit status code
- `$OUTPUT`: Tool output

**Example**: Auto-format files after writing
```json
{
  "PostToolUse": [{
    "matcher": "Write|Edit",
    "hooks": [{
      "type": "command",
      "command": "npx prettier --write $FILE"
    }, {
      "type": "command",
      "command": "npx eslint --fix $FILE"
    }]
  }]
}
```

#### 3. Notification

Executes when Claude sends notifications.

**Variables Available**:
- `$MESSAGE`: Notification message content
- `$LEVEL`: Notification level (info, warning, error)

**Example**:
```json
{
  "Notification": [{
    "matcher": "error",
    "hooks": [{
      "type": "command",
      "command": "notify-send 'Claude Error' '$MESSAGE'"
    }]
  }]
}
```

#### 4. Stop

Executes when Claude finishes responding.

**Variables Available**:
- `$SESSION_ID`: Current session identifier

**Example**: Check for unpushed commits
```json
{
  "Stop": [{
    "matcher": "",
    "hooks": [{
      "type": "command",
      "command": "~/.claude/stop-hook-git-check.sh"
    }]
  }]
}
```

### Hook Features

- **Pattern Matching**: Use regex in `matcher` field
- **Parallel Execution**: Multiple matching hooks run in parallel
- **Deduplication**: Identical commands automatically deduplicated
- **Timeout**: Default 60s, configurable up to 600s
- **Environment**: Runs in project directory with Claude environment

---

## Slash Command Schema

### Overview

Slash commands are custom shortcuts defined in `.claude/commands/*.md` files.

### Complete Schema

```yaml
---
command: string (required)
  # Command name (invoked as /command-name)
  # Use kebab-case, no spaces

description: string (required)
  # Brief description shown in command list
  # 1-2 sentences maximum

usage: string (optional)
  # Usage syntax with argument placeholders
  # Example: "/review [--quick | --standard | --deep] <file>"

skill: string (optional)
  # Name of skill to invoke
  # If specified, delegates to skill instead of inline instructions

model: "haiku" | "sonnet" | "opus" (optional)
  # Model to use for this command
  # Default: inherits from config

  # Command-line style options
  - name: "option-name"
    type: "boolean" | "string" | "number"
    default: any
    description: "string"
    required: boolean
---

# Command Instructions

[Markdown instructions for what Claude should do when command is invoked]

## Variables

Special variables available:
- `$ARGUMENTS`: All arguments passed to command
- `$ARG1`, `$ARG2`, etc.: Individual positional arguments
- `$OPTION_NAME`: Value of --option-name flag

## Examples

Show example usages to guide Claude's behavior.
```

### Example: Code Review Command

````
---
command: review
description: Comprehensive code review with configurable depth
usage: /review [--quick | --standard | --deep] <file-or-directory>
skill: code-review
model: sonnet
---

# Code Review Command

When this command is invoked:

1. **Determine Review Depth**:
   - If `--quick`: Use Haiku, quick review mode
   - If `--standard`: Use Sonnet, standard review
   - If `--deep`: Use Opus, comprehensive review

2. **Load Target**:
   - If `$ARG1` is a file: Review that file
   - If `$ARG1` is a directory: Review all files in directory
   - If no argument: Review changed files (git diff)

3. **Execute Review**:
   - Use code-review skill with appropriate model override
   - If `--security-focus`: Emphasize security issues in report

4. **Generate Report**:
   - Categorize issues by severity
   - Provide line numbers and code snippets
   - Suggest specific improvements

## Examples

```bash
# Quick review of single file
/review --quick src/components/LoginForm.tsx

# Standard review of directory
/review src/api/

# Deep security-focused review
/review --deep --security-focus src/auth/

# Review all changed files
/review
```
````

---

## CLAUDE.md Structure

### Overview

`CLAUDE.md` files provide project context and instructions. They're loaded at session start and treated as system-level instructions.

### Recommended Structure

```markdown
# Project Name

Brief project description (1-2 sentences)

## Tech Stack

- **Language**: TypeScript
- **Framework**: React 18
- **Backend**: Node.js + Express
- **Database**: PostgreSQL
- **Testing**: Jest + React Testing Library
- **Deployment**: Docker + AWS

## Project Structure

```
src/
├── client/          # React frontend
│   ├── components/  # Reusable components
│   ├── pages/       # Page components
│   └── hooks/       # Custom React hooks
├── server/          # Express backend
│   ├── api/         # API routes
│   ├── db/          # Database models
│   └── middleware/  # Express middleware
└── shared/          # Shared types and utilities
```

## Common Commands

### Development
```bash
npm run dev          # Start dev server (http://localhost:3000)
npm run dev:server   # Start backend only (http://localhost:3001)
npm run dev:client   # Start frontend only
```

### Testing
```bash
npm test             # Run all tests
npm run test:watch   # Run tests in watch mode
npm run test:coverage # Generate coverage report
```

### Building
```bash
npm run build        # Production build
npm run build:client # Build frontend only
npm run build:server # Build backend only
```

### Deployment
```bash
npm run deploy:staging  # Deploy to staging
npm run deploy:prod     # Deploy to production
```

## Core Files

| File/Directory | Purpose |
|----------------|---------|
| `src/client/App.tsx` | Main React application component |
| `src/server/index.ts` | Express server entry point |
| `src/shared/types.ts` | Shared TypeScript types |
| `src/client/components/` | Reusable UI components |
| `src/server/api/routes.ts` | API endpoint definitions |
| `src/server/db/models.ts` | Database models and schemas |

## Coding Standards

### TypeScript
- **Strict Mode**: Always enabled (`"strict": true`)
- **Types**: Explicit return types for functions
- **Interfaces**: Prefer interfaces over type aliases for objects
- **Naming**: PascalCase for types/interfaces, camelCase for variables

### React
- **Components**: Functional components with TypeScript
- **Hooks**: Use hooks for state and effects
- **Props**: Define explicit prop types
- **Testing**: Write tests for all components

### Code Style
- **Indentation**: 2 spaces
- **Quotes**: Single quotes for strings
- **Semicolons**: Required
- **Linter**: ESLint configuration in `.eslintrc.js`
- **Formatter**: Prettier configuration in `.prettierrc`

### File Naming
- **Components**: PascalCase (e.g., `LoginForm.tsx`)
- **Utilities**: camelCase (e.g., `formatDate.ts`)
- **Tests**: `*.test.ts` or `*.spec.ts`
- **Styles**: Component-scoped CSS modules (e.g., `LoginForm.module.css`)

## Testing Requirements

- **Coverage**: Minimum 80% code coverage
- **Components**: Test rendering, user interactions, edge cases
- **API**: Test all endpoints, error cases, validation
- **Integration**: Test critical user flows end-to-end

### Test Structure
```typescript
describe('Component/Function Name', () => {
  describe('Scenario', () => {
    it('should do expected behavior', () => {
      // Arrange
      // Act
      // Assert
    });
  });
});
```

## Git Workflow

### Branch Naming
- `feature/description` - New features
- `fix/description` - Bug fixes
- `refactor/description` - Code refactoring
- `docs/description` - Documentation updates

### Commit Messages
- Use conventional commits format
- Start with type: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`
- Be specific and descriptive

Examples:
- `feat: add user authentication with JWT`
- `fix: resolve memory leak in WebSocket connection`
- `docs: update API documentation for v2 endpoints`

### Pull Request Process
1. Create feature branch from `main`
2. Make changes and commit
3. Run tests: `npm test`
4. Run linter: `npm run lint`
5. Push and create PR
6. Request review from team
7. Address review feedback
8. Squash and merge after approval

## Environment Variables

```bash
# .env.example
NODE_ENV=development
PORT=3001
DATABASE_URL=postgresql://localhost:5432/myapp
JWT_SECRET=your-secret-key
API_KEY=your-api-key
```

⚠️ **Never commit** `.env` files with real credentials!

## Database Migrations

```bash
# Create new migration
npm run migrate:create -- --name=add-users-table

# Run migrations
npm run migrate:up

# Rollback last migration
npm run migrate:down
```

## Notes for AI Assistants

### When Writing Code
1. **Follow existing patterns** in the codebase
2. **Use TypeScript strict mode** - no `any` types
3. **Write tests** alongside new features
4. **Update documentation** when changing behavior
5. **Run linter** before committing

### When Refactoring
1. **Write tests first** to ensure behavior preservation
2. **Refactor incrementally** - small, focused changes
3. **Run full test suite** after each change
4. **Update related documentation**

### Security Reminders
- Never log sensitive data (passwords, tokens, PII)
- Validate all user inputs
- Use parameterized queries to prevent SQL injection
- Sanitize data before rendering to prevent XSS
- Keep dependencies updated

## File Imports

You can import additional context files:

```markdown
@docs/architecture.md
@docs/api-spec.md
@docs/deployment-guide.md
```

---

**Maintained By**: Development Team
**Questions?**: Open an issue or contact the team
```

---

## Environment Variables

### System Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `CLAUDE_DEFAULT_MODEL` | Default model for all operations | `sonnet`, `haiku`, `opus` |
| `CLAUDE_MEMORY_PATH` | Custom path to memory files | `~/.config/claude/memory/` |
| `CLAUDE_HOOKS_TIMEOUT` | Default hook timeout (ms) | `60000` |

### MCP Server Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `GITHUB_TOKEN` | GitHub personal access token | `ghp_xxxxxxxxxxxx` |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | Alternative name for GitHub token | `ghp_xxxxxxxxxxxx` |
| `PERPLEXITY_API_KEY` | Perplexity API key for search MCP | `pplx-xxxxxxxx` |
| `OPENAI_API_KEY` | OpenAI API key (for some MCP servers) | `sk-xxxxxxxx` |

### Custom Project Variables

Define in `.env` or `CLAUDE.md`:

```bash
# .env
PROJECT_NAME=my-web-app
DEFAULT_PORT=3000
DATABASE_URL=postgresql://localhost:5432/myapp
REDIS_URL=redis://localhost:6379
```

Reference in CLAUDE.md:
```markdown
## Environment Setup

Required environment variables:
- `DATABASE_URL`: PostgreSQL connection string
- `REDIS_URL`: Redis connection string
- `JWT_SECRET`: Secret key for JWT signing
```

---

## File Locations

### Claude Code Configuration

| File/Directory | Purpose | Platform |
|----------------|---------|----------|
| `~/.claude/` | User-level configuration | All |
| `~/.claude/settings.json` | User settings, all projects | All |
| `~/.claude.json` | OAuth credentials and MCP state | All |
| `.claude/` | Project-specific configuration | All |
| `.claude/settings.json` | Project settings, committed to git | All |
| `.claude/settings.local.json` | Project settings, personal and gitignored | All |
| `.claude/memory.md` | Project memory | All |
| `.claude/skills/` | Custom skills | All |
| `.claude/commands/` | Slash commands | All |
| `.mcp.json` | Project MCP servers | All |

Settings paths are fixed per scope. There is no environment variable or flag that redirects them elsewhere.

### Project-Level Files

```
.claude/
├── settings.json                  # Project settings (committed)
├── settings.local.json            # Personal overrides (gitignored)
├── CLAUDE.md                      # Project context
├── memory.md                      # Session memory
├── skills/                        # Custom skills
│   ├── my-skill/
│   │   └── SKILL.md
│   └── another-skill/
│       └── SKILL.md
├── commands/                      # Slash commands
│   ├── review.md
│   ├── test.md
│   └── deploy.md
└── agents/                        # Custom agents
    ├── frontend.md
    └── backend.md
```

---

## Cross-References

### Related Guides

- [Creating Custom Agents](../03-agents/4-custom-agents.md) - Using subagent file schema
- [Creating Custom Skills](../04-skills/3-creating-skills.md) - Using SKILL.md schema
- [Creating Slash Commands](../10-keywords/2-slash-commands.md) - Using command schema
- [CLAUDE.md Files](../09-context/2-claude-md.md) - Project context structure
- [Hooks Configuration](../10-keywords/3-automation-patterns.md) - Hook examples

### Quick References

- [Cheat Sheet](4-cheat-sheet.md) - One-page reference
- [Glossary](7-glossary.md) - Term definitions

---

## References

### Official Documentation
- [Claude Code Configuration Reference](https://code.claude.com/docs/configuration)
- [Agent API Reference](https://code.claude.com/docs/agents/api)
- [Skills API Reference](https://code.claude.com/docs/skills/api)
- [Hooks Reference](https://code.claude.com/docs/hooks)

---

**Need Help?**
- Stuck on a schema? See [Troubleshooting Guide](2-troubleshooting.md)
- Have questions? Check the [FAQ](3-faq.md)
- Want examples? Browse [Project Templates](../13-examples/projects/)
