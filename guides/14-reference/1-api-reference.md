# Complete API Reference

**Reading Time**: 45 minutes
**Skill Level**: Intermediate to Advanced
**Prerequisites**: Understanding of agents, skills, and configuration basics

---

## Welcome to the Technical Reference! 📚

This is your complete technical reference for all Claude Code configuration schemas, file formats, and specifications. Use this as your go-to resource when creating custom agents, skills, commands, and configurations.

---

## Table of Contents

1. [AGENT.md Schema](#agentmd-schema)
2. [SKILL.md Schema](#skillmd-schema)
3. [config.json Schema](#configjson-schema)
4. [Hook Specifications](#hook-specifications)
5. [Slash Command Schema](#slash-command-schema)
6. [CLAUDE.md Structure](#claudemd-structure)
7. [Environment Variables](#environment-variables)
8. [File Locations](#file-locations)

---

## AGENT.md Schema

### Overview

Custom agents are defined using `AGENT.md` files with YAML frontmatter. Agents are specialized AI assistants with specific capabilities, constraints, and behaviors.

### Complete Schema

```yaml
---
name: string (required)
  # Unique identifier for the agent
  # Example: "frontend-specialist", "security-auditor"

description: string (required)
  # Clear description of agent's purpose and capabilities
  # Should be 1-2 sentences, action-oriented
  # Example: "Specialized agent for React/TypeScript frontend development with focus on component architecture"

model: "haiku" | "sonnet" | "opus" (optional)
  # Model to use for this agent
  # Default: inherits from parent or "sonnet"
  # Choices:
  #   - "haiku": Fast, cost-effective (recommended for searches, simple tasks)
  #   - "sonnet": Balanced (recommended for standard coding)
  #   - "opus": Maximum reasoning (recommended for complex architecture)

tools: string[] (optional)
  # Array of tool names this agent can access
  # Available tools: "Read", "Write", "Edit", "Bash", "Grep", "Glob", "Task", etc.
  # Default: all tools available
  # Example: ["Read", "Grep", "Glob"] for read-only agents

constraints: object (optional)
  allowedPaths: string[] (optional)
    # Glob patterns for paths this agent can access
    # Example: ["src/components/**", "src/pages/**"]

  deniedPaths: string[] (optional)
    # Glob patterns for paths this agent cannot access
    # Takes precedence over allowedPaths
    # Example: ["src/server/**", ".env*", "**/*.private.*"]

  maxFileSize: number (optional)
    # Maximum file size in bytes agent can read/write
    # Default: unlimited
    # Example: 1048576 (1MB)

  readOnly: boolean (optional)
    # If true, agent cannot modify files
    # Default: false
    # Use for security-sensitive agents

autoActions: object (optional)
  beforeRead: Command[] (optional)
    # Commands to run before reading files
    # Example: [{"command": "git pull"}]

  afterWrite: Command[] (optional)
    # Commands to run after writing files
    # Example: [{"command": "npx prettier --write {file}"}]

  onError: Command[] (optional)
    # Commands to run when agent encounters errors
    # Example: [{"command": "notify-send 'Agent Error' '{error}'"}]

timeout: number (optional)
  # Maximum execution time in milliseconds
  # Default: 120000 (2 minutes)
  # Maximum: 600000 (10 minutes)

contextWindow: number (optional)
  # Maximum context window for this agent
  # Default: inherits from model defaults
  # Use to limit context for focused agents
---

# Agent Instructions

[Detailed instructions for how the agent should behave, written in markdown]

## Capabilities

- List specific capabilities
- What this agent excels at
- When to use this agent

## Limitations

- What this agent should NOT do
- Tasks to delegate to other agents
- Known constraints

## Examples

Provide concrete examples of tasks this agent handles well.
```

### Example: Frontend Specialist Agent

```yaml
---
name: frontend-specialist
description: React/TypeScript frontend development agent specializing in component architecture, hooks, and state management
model: sonnet
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
constraints:
  allowedPaths:
    - "src/components/**"
    - "src/pages/**"
    - "src/hooks/**"
    - "src/contexts/**"
    - "src/styles/**"
  deniedPaths:
    - "src/server/**"
    - "src/api/**"
    - ".env*"
  readOnly: false
autoActions:
  afterWrite:
    - command: "npx prettier --write {file}"
    - command: "npx eslint --fix {file}"
timeout: 180000
---

# Frontend Specialist Agent

## Capabilities

I specialize in:
- **React Components**: Creating functional components with TypeScript
- **Hooks**: useState, useEffect, useContext, custom hooks
- **State Management**: Context API, reducers, local state patterns
- **Component Architecture**: Composition, props drilling solutions
- **Styling**: CSS Modules, styled-components, Tailwind CSS
- **Testing**: React Testing Library, component testing

## Approach

1. **Type Safety First**: Always use TypeScript strict mode
2. **Component Composition**: Prefer composition over inheritance
3. **Performance**: Use memo, useCallback, useMemo when appropriate
4. **Accessibility**: Follow WCAG 2.1 AA standards
5. **Testing**: Write tests alongside components

## Limitations

I do NOT handle:
- Backend API development (use backend-specialist agent)
- Database queries (use data-specialist agent)
- DevOps configuration (use devops-specialist agent)
- Server-side rendering logic (use ssr-specialist agent)

## Examples

### Creating a Form Component

```typescript
interface LoginFormProps {
  onSubmit: (credentials: {email: string; password: string}) => Promise<void>;
  isLoading?: boolean;
}

export const LoginForm: React.FC<LoginFormProps> = ({onSubmit, isLoading}) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await onSubmit({email, password});
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        required
        aria-label="Email address"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        required
        aria-label="Password"
      />
      <button type="submit" disabled={isLoading}>
        {isLoading ? 'Logging in...' : 'Log In'}
      </button>
    </form>
  );
};
```
```

---

## SKILL.md Schema

### Overview

Skills are reusable instruction sets defined in `SKILL.md` files with YAML frontmatter. Skills use progressive disclosure to provide context as needed.

### Complete Schema

```yaml
---
name: string (required)
  # Unique identifier for the skill
  # Use kebab-case: "api-documentation", "tdd-workflow"

version: string (optional, semver format)
  # Semantic version number
  # Example: "1.0.0", "2.1.3"
  # Default: "1.0.0"

description: string (required, 100-200 characters recommended)
  # Clear, specific description of what this skill does
  # Include: action verbs, file types, specific use cases
  # Bad: "document processing skill"
  # Good: "extract tables from PDFs and convert to CSV format for data analysis workflows"

model: string (optional)
  # Default model for this skill
  # Options: "claude-haiku-4-5", "claude-sonnet-4-5", "claude-opus-4-5"
  # Example: "claude-haiku-4-5" for simple formatting tasks
  #          "claude-opus-4-5" for complex architecture analysis

modelOverrides: object (optional)
  # Named model configurations for different use cases
  # Allows users to invoke skill with different models
  # Example:
  #   quick: "claude-haiku-4-5"
  #   standard: "claude-sonnet-4-5"
  #   deep: "claude-opus-4-5"

dependencies: string[] (optional)
  # List of other skills this skill depends on
  # Example: ["tdd-workflow", "code-formatter"]

tags: string[] (optional)
  # Categories/tags for skill discovery
  # Example: ["testing", "python", "api"]

author: string (optional)
  # Skill author name or organization
  # Example: "Anthropic", "Your Name"

license: string (optional)
  # License for the skill
  # Example: "MIT", "Apache-2.0"
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
name: code-review
version: 2.1.0
description: Comprehensive code review covering quality, security, performance, and best practices with configurable depth levels
model: claude-sonnet-4-5
modelOverrides:
  quick: claude-haiku-4-5
  standard: claude-sonnet-4-5
  deep: claude-opus-4-5
tags: ["code-quality", "security", "best-practices", "review"]
author: "Anthropic"
license: "MIT"
---

# Code Review Skill

## Overview

This skill provides structured code review at three levels:
- **Quick**: Fast surface-level review for syntax, obvious issues (~5 min, Haiku)
- **Standard**: Balanced review covering quality, security, performance (~15 min, Sonnet)
- **Deep**: Comprehensive architectural review with security audit (~45 min, Opus)

Use this skill for pull request reviews, pre-merge checks, or periodic code audits.

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

## config.json Schema

### Overview

The `.claude/config.json` file configures Claude Code behavior at the project level, including agent settings, model defaults, hooks, and cost tracking.

### Complete Schema

```json
{
  "agents": {
    "agent-name": {
      "model": "haiku" | "sonnet" | "opus",
      "description": "string",
      "timeout": number,
      "tools": string[],
      "constraints": {
        "allowedPaths": string[],
        "deniedPaths": string[]
      }
    }
  },

  "defaultModel": "haiku" | "sonnet" | "opus",

  "costTracking": {
    "enabled": boolean,
    "dailyBudget": number,
    "alertThreshold": number (0.0-1.0),
    "logFile": "string (path)"
  },

  "hooks": {
    "PreToolUse": HookConfig[],
    "PostToolUse": HookConfig[],
    "Notification": HookConfig[],
    "Stop": HookConfig[]
  },

  "projectContext": {
    "name": "string",
    "description": "string",
    "techStack": string[],
    "conventions": object
  },

  "experimentalFeatures": {
    "featureName": boolean
  }
}
```

### Example Configuration

```json
{
  "agents": {
    "Explore": {
      "model": "haiku",
      "description": "Fast codebase exploration",
      "timeout": 120000
    },
    "general-purpose": {
      "model": "sonnet",
      "description": "Balanced coding tasks"
    },
    "Plan": {
      "model": "sonnet",
      "description": "Architecture planning"
    },
    "frontend-specialist": {
      "model": "sonnet",
      "tools": ["Read", "Write", "Edit", "Grep", "Glob"],
      "constraints": {
        "allowedPaths": ["src/components/**", "src/pages/**"],
        "deniedPaths": ["src/server/**", ".env*"]
      },
      "timeout": 180000
    }
  },

  "defaultModel": "sonnet",

  "costTracking": {
    "enabled": true,
    "dailyBudget": 100000,
    "alertThreshold": 0.8,
    "logFile": ".claude/cost-log.json"
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

  "projectContext": {
    "name": "My Web App",
    "description": "React TypeScript web application",
    "techStack": ["React", "TypeScript", "Node.js", "PostgreSQL"],
    "conventions": {
      "indentation": "2 spaces",
      "quotes": "single",
      "semicolons": true
    }
  },

  "experimentalFeatures": {
    "enhancedContextManagement": true
  }
}
```

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

options: array (optional)
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

```yaml
---
command: review
description: Comprehensive code review with configurable depth
usage: /review [--quick | --standard | --deep] <file-or-directory>
skill: code-review
model: sonnet
options:
  - name: quick
    type: boolean
    default: false
    description: Fast surface-level review
  - name: standard
    type: boolean
    default: true
    description: Balanced review (default)
  - name: deep
    type: boolean
    default: false
    description: Comprehensive architectural review
  - name: security-focus
    type: boolean
    default: false
    description: Focus primarily on security issues
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
```

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

**Last Updated**: 2025-01-15
**Maintained By**: Development Team
**Questions?**: Open an issue or contact the team
```

---

## Environment Variables

### System Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `CLAUDE_DEFAULT_MODEL` | Default model for all operations | `sonnet`, `haiku`, `opus` |
| `CLAUDE_CONFIG_PATH` | Custom path to config.json | `~/.config/claude/config.json` |
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
| `~/.config/claude/` | Global configuration | Linux/macOS |
| `~/Library/Application Support/Claude/` | Global configuration | macOS |
| `%APPDATA%\Claude\` | Global configuration | Windows |
| `.claude/` | Project-specific configuration | All |
| `.claude/config.json` | Project configuration | All |
| `.claude/memory.md` | Project memory | All |
| `.claude/skills/` | Custom skills | All |
| `.claude/commands/` | Slash commands | All |

### Project-Level Files

```
.claude/
├── config.json                    # Main configuration
├── CLAUDE.md                      # Project context
├── memory.md                      # Session memory
├── cost-log.json                  # Cost tracking (if enabled)
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

- [Creating Custom Agents](../03-agents/4-custom-agents.md) - Using AGENT.md schema
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
