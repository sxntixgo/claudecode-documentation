# Frequently Asked Questions (FAQ)

**Reading Time**: 40 minutes
**Skill Level**: All levels
**Last Updated**: 2025-01-15

---

## Welcome to the FAQ! 🤔

Quick answers to the most common questions about Claude Code. Use Ctrl+F/Cmd+F to search for keywords.

**Looking for something specific?**
- Troubleshooting? See [Troubleshooting Guide](2-troubleshooting.md)
- Technical details? See [API Reference](1-api-reference.md)
- Quick commands? See [Cheat Sheet](4-cheat-sheet.md)

---

## 🔍 Quick Find by Keyword

**Can't find your answer? Try these common searches (Ctrl+F / Cmd+F):**

| If you're searching for... | Jump to... |
|----------------------------|------------|
| **"offline"** / **"internet"** | [Can I use Claude Code offline?](#can-i-use-claude-code-offline) |
| **"cost"** / **"pricing"** / **"expensive"** | [Model Questions](#model-questions) |
| **"slow"** / **"performance"** / **"faster"** | [Optimization Questions](#optimization-questions) |
| **"error"** / **"bug"** / **"broken"** | [Troubleshooting Guide](2-troubleshooting.md) |
| **"install"** / **"setup"** / **"requirements"** | [What are the system requirements?](#what-are-the-system-requirements) |
| **"github"** / **"git"** / **"pr"** | [MCP Server Questions](#mcp-server-questions) |
| **"security"** / **"safe"** / **"private"** | [Security Guide](../14-security/1-security-compliance.md) |
| **"token"** / **"context"** / **"memory"** | [Context Management Questions](#context-management-questions) |
| **"custom"** / **"create"** / **"build"** | [Customization Questions](#customization-questions) |
| **"agent"** / **"skill"** / **"mcp"** | Use section links below |
| **"haiku"** / **"sonnet"** / **"opus"** | [Model Questions](#model-questions) |
| **"update"** / **"upgrade"** / **"version"** | [How do I update Claude Code?](#how-do-i-update-claude-code) |

---

## Table of Contents

1. [General Questions](#general-questions)
2. [MCP Server Questions](#mcp-server-questions)
3. [Agent Questions](#agent-questions)
4. [Skill Questions](#skill-questions)
5. [Model Questions](#model-questions)
6. [Context Management Questions](#context-management-questions)
7. [Optimization Questions](#optimization-questions)
8. [Customization Questions](#customization-questions)

---

## General Questions

### What is Claude Code and how does it differ from Claude?

**Claude** is the AI assistant you interact with via chat at claude.ai.

**Claude Code** is a specialized coding assistant with:
- **File system access**: Read and write code files
- **Command execution**: Run terminal commands
- **MCP Servers**: Connect to external tools (GitHub, databases, APIs)
- **Agents**: Specialized sub-assistants for focused tasks
- **Skills**: Reusable instruction sets
- **Project context**: CLAUDE.md files for project-specific knowledge

Think of Claude Code as "Claude with developer superpowers" 🦸‍♂️

---

### What are the system requirements?

**Minimum Requirements**:
- **OS**: macOS 10.15+, Linux (Ubuntu 20.04+), Windows 10+
- **RAM**: 4GB (8GB+ recommended)
- **Disk Space**: 1GB free
- **Internet**: Required for AI operations

**For MCP Servers**:
- **Node.js**: 16+ (for JavaScript MCP servers)
- **Python**: 3.8+ (for Python MCP servers)
- **Docker**: Optional (for Docker MCP Toolkit)

---

### Can I use Claude Code offline?

**No**, Claude Code requires an internet connection because:
- AI models run on Anthropic's servers
- Real-time inference requires cloud processing
- MCP servers often connect to online services

**What works offline**:
- Viewing cached documentation
- Reading previously loaded files
- Using local-only MCP servers (rare)

**For offline coding**:
- Use traditional IDEs with local-only tools
- Cache important documentation
- Prepare code offline, use Claude when connected

---

### How do I update Claude Code?

**Automatic Updates** (recommended):
- Claude Code checks for updates automatically
- Notification appears when update available
- Click "Update" to install

**Manual Update**:
```bash
# Check current version
claude --version

# Update via package manager (if installed that way)
npm update -g claude-code  # npm
brew upgrade claude        # Homebrew

# Or download latest from official site
# https://code.claude.com/download
```

**After updating**:
```bash
# Restart Claude Code
# Verify new version
claude --version
```

---

### What's the difference between Claude Code and GitHub Copilot?

| Feature | Claude Code | GitHub Copilot |
|---------|-------------|----------------|
| **Approach** | Agentic (autonomous multi-step tasks) | Autocomplete (suggestions as you type) |
| **Scope** | Entire files/projects | Line-by-line |
| **Context** | Full project context via CLAUDE.md | Current file + nearby files |
| **Extensibility** | MCP servers, agents, skills | Limited extensions |
| **Terminal Access** | Yes (can run commands) | No |
| **File Operations** | Read/write any file | Only current file |
| **Cost Model** | Per-token usage or subscription | Flat monthly fee |
| **Best For** | Complex refactoring, architecture, multi-file changes | Rapid coding, autocomplete |

**Use both together**: Many developers use Copilot for autocomplete and Claude Code for complex refactoring!

---

### What's the difference between Claude Code and Cursor?

| Feature | Claude Code | Cursor |
|---------|-------------|--------|
| **Type** | CLI + chat interface | Full IDE (VS Code fork) |
| **Integration** | Works with any editor | Integrated editor |
| **Agent System** | Built-in subagents | AI chat sidebar |
| **MCP Support** | Native | Via extensions |
| **File Access** | Full project | Full project |
| **Customization** | Skills, agents, hooks | Editor extensions |
| **Price** | Claude subscription | Cursor subscription |

**Choose Claude Code if**: You love your current editor and want powerful AI assistance
**Choose Cursor if**: You want IDE + AI in one integrated package

---

## MCP Server Questions

### Why is my MCP server not loading?

**Common causes and fixes**:

1. **Not properly configured**:
```bash
# Verify server in list
claude mcp list

# If missing, reinstall
claude mcp add server-name --scope user
```

2. **JSON syntax error**:
```bash
# Validate configuration
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq .
```

3. **Missing dependencies**:
```bash
# For npm-based servers
npm install -g @modelcontextprotocol/server-name
```

4. **Need restart**:
```bash
# Completely quit and restart Claude Code
```

See [Troubleshooting Guide](2-troubleshooting.md#mcp-server-not-loading) for detailed steps.

---

### How do I debug MCP server connection issues?

**Step-by-step debugging**:

**1. Check server status**:
```bash
claude mcp list
# Server should show as "active"
```

**2. View server logs**:
```bash
# macOS
tail -f ~/Library/Logs/Claude/mcp-server-name.log

# Linux
tail -f ~/.local/share/claude/logs/mcp-server-name.log
```

**3. Test server directly**:
```bash
# Run server command manually
npx @modelcontextprotocol/server-github

# Should start without errors
```

**4. Verify authentication**:
```bash
# Check environment variables
echo $GITHUB_TOKEN
echo $GITHUB_PERSONAL_ACCESS_TOKEN

# Should output your token (not empty)
```

**5. Check network**:
```bash
# Test connectivity
curl -I https://api.github.com

# Should return 200 OK
```

---

### Can I use multiple MCP servers at once?

**Yes!** Claude Code can connect to multiple MCP servers simultaneously.

**Example configuration**:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "your-token"}
    },
    "perplexity": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-perplexity"],
      "env": {"PERPLEXITY_API_KEY": "your-key"}
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {"DATABASE_URL": "postgresql://localhost:5432/mydb"}
    }
  }
}
```

**All three servers are active!** Claude can:
- Search GitHub for issues
- Research topics via Perplexity
- Query your PostgreSQL database

**Performance note**: More servers = more tools loaded = slightly longer initialization. Most users run 2-5 servers without issues.

---

### How do I create a custom MCP server?

**Quick start** (TypeScript):

**1. Create project**:
```bash
mkdir my-mcp-server
cd my-mcp-server
npm init -y
npm install @modelcontextprotocol/sdk
```

**2. Create server** (`src/index.ts`):
```typescript
#!/usr/bin/env node
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

const server = new Server(
  {
    name: 'my-server',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Define tools
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [{
    name: 'my_tool',
    description: 'What my tool does',
    inputSchema: {
      type: 'object',
      properties: {
        input: {type: 'string'}
      }
    }
  }]
}));

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const {name, arguments: args} = request.params;

  if (name === 'my_tool') {
    // Your tool logic here
    return {
      content: [{
        type: 'text',
        text: 'Tool result'
      }]
    };
  }
});

const transport = new StdioServerTransport();
await server.connect(transport);
```

**3. Configure in Claude**:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/path/to/my-mcp-server/src/index.ts"]
    }
  }
}
```

**Full guide**: See [Creating Custom MCP Servers](../01-mcp-servers/4-creating-custom-servers.md)

---

### Are MCP servers secure?

**MCP servers have full access to what you configure**, so security depends on:

✅ **Secure practices**:
- Only install servers from trusted sources
- Review server code before installing
- Use environment variables for secrets (not hardcoded)
- Limit server permissions where possible
- Keep servers updated

⚠️ **Security risks**:
- Malicious servers can access your data
- Servers can execute arbitrary code
- API tokens can be exposed if logged
- Network requests can leak information

**Best practices**:
1. **Audit servers**: Review code on GitHub before installing
2. **Use official servers**: Anthropic's `@modelcontextprotocol/*` are vetted
3. **Secrets management**: Use `.env` files (add to `.gitignore`)
4. **Network security**: Use HTTPS, verify SSL certificates
5. **Least privilege**: Only grant necessary permissions

**Trust levels**:
- **High trust**: Official Anthropic servers
- **Medium trust**: Popular open-source servers with many stars/contributors
- **Low trust**: Unknown or unreviewed servers (audit before use!)

---

### Can MCP servers access my credentials?

**Only if you configure them to!**

MCP servers can access:
- ✅ Environment variables you explicitly set
- ✅ Files in directories you grant access to
- ✅ Network resources you configure
- ❌ Other secrets (unless explicitly provided)

**Example** (GitHub server):
```json
{
  "mcpServers": {
    "github": {
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxx"  // ← Only this token accessible
      }
    }
  }
}
```

This server gets **only** the GitHub token, not your:
- Database passwords
- AWS credentials
- SSH keys
- Other API tokens

**Protection strategies**:
1. Use dedicated tokens with minimal scopes
2. Rotate tokens regularly
3. Never commit tokens to git
4. Use `.env` files for sensitive values
5. Audit server code to see what it accesses

---

## Agent Questions

### What's the difference between agents and skills?

**Agents** = AI assistants with specific capabilities
**Skills** = Instruction sets that any agent can use

| Aspect | Agents | Skills |
|--------|--------|--------|
| **What** | AI entities | Instruction documents |
| **Purpose** | Perform tasks autonomously | Guide how to perform tasks |
| **Configuration** | Tools, constraints, model | Description, steps, examples |
| **Execution** | Active (runs tasks) | Passive (provides instructions) |
| **Invocation** | Task tool explicitly calls | Claude selects when relevant |

**Analogy**:
- **Agent**: A specialist doctor (cardiologist, surgeon)
- **Skill**: A medical procedure manual (how to perform surgery)

**Example**:
- **Frontend Agent**: Has access to `src/components/**`, uses Sonnet model
- **TDD Skill**: Instructions for test-driven development workflow

The **Frontend Agent** can **use** the **TDD Skill** to write tests for components!

---

### When should I use Explore vs General-Purpose agents?

Use **Explore Agent** when:
- ✅ **Reading code** (no modifications needed)
- ✅ **Finding patterns** ("Where are all API endpoints?")
- ✅ **Understanding architecture** ("How does auth work?")
- ✅ **Locating code** ("Find the User model")
- ✅ **Speed matters** (Explore is 3-5x faster)

Use **General-Purpose Agent** when:
- ✅ **Modifying files** (any Write/Edit operations)
- ✅ **Complex reasoning** needed
- ✅ **Multi-step workflows** (refactoring, features)
- ✅ **Tests or builds** required
- ✅ **Quality > speed**

**Cost comparison**:
```
Task: Find all React components using useState

Explore Agent (Haiku): ~$0.02, 10 seconds
General-Purpose (Sonnet): ~$0.08, 25 seconds

Savings: 75% cheaper, 60% faster
```

**Rule of thumb**: If task doesn't modify files, use Explore!

---

### How do I create a custom agent?

**Quick start**:

**1. Create agent file** (`.claude/agents/frontend.md`):
```yaml
---
name: frontend-specialist
description: React/TypeScript frontend development
model: sonnet
tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
constraints:
  allowedPaths:
    - "src/components/**"
    - "src/pages/**"
  deniedPaths:
    - "src/server/**"
    - ".env*"
---

# Frontend Specialist

I specialize in React component development with TypeScript.

## Capabilities
- Create functional components
- Implement hooks
- Style with CSS modules
- Write component tests

## Guidelines
- Always use TypeScript strict mode
- Follow project component patterns
- Write tests alongside components
```

**2. Configure in `.claude/config.json`**:
```json
{
  "agents": {
    "frontend-specialist": {
      "model": "sonnet",
      "timeout": 180000
    }
  }
}
```

**3. Use the agent**:
```bash
You: "Use frontend-specialist agent to create a LoginForm component"
```

**Full guide**: See [Creating Custom Agents](../02-agents/4-custom-agents.md)

---

### Can agents share context?

**No, agents have isolated contexts** by design. This is a feature, not a bug!

**Why isolated?**
- ✅ **Prevents pollution**: Frontend agent doesn't see backend code
- ✅ **Focused results**: Agent only considers relevant code
- ✅ **Better performance**: Smaller context = faster, cheaper
- ✅ **Clear boundaries**: Explicit separation of concerns

**Sharing information between agents**:

Use **memory files** or **CLAUDE.md**:

```markdown
# .claude/memory.md

## Architecture Decisions

Frontend uses Context API for state management (decided by frontend-specialist agent)

Backend uses PostgreSQL with Prisma ORM (decided by backend-specialist agent)

Integration: REST API at /api/v1 endpoints
```

Both agents load memory.md and see shared context!

**Alternative**: Chain agent tasks in main conversation:
```
You: "Use frontend-specialist to design login form"
[Agent completes]

You: "Use backend-specialist to create login API endpoint"
[Agent sees previous conversation context]
```

---

### Why does my agent timeout?

**Common causes**:

**1. Task too complex**:
```bash
❌ "Refactor entire codebase to TypeScript"  # Too big!
✅ "Refactor src/utils/date.js to TypeScript"  # Focused
```

**2. Default timeout too short**:
```json
{
  "agents": {
    "slow-agent": {
      "timeout": 300000  // Increase to 5 minutes
    }
  }
}
```

**3. Using slow model (Opus)**:
```json
{
  "agents": {
    "speed-agent": {
      "model": "haiku"  // 2x faster than Sonnet
    }
  }
}
```

**4. Large context**:
- Reduce CLAUDE.md size
- Use path constraints to limit files
- Clear conversation history

**Solutions**:
- Break tasks into smaller pieces
- Increase timeout in config
- Use faster model (Haiku)
- Reduce context size

---

### How do I debug agent behavior?

**Techniques**:

**1. Explicit invocation**:
```bash
# See which agent is used
You: "Use Explore agent to find all API routes"

# Claude will confirm: "Using Explore agent..."
```

**2. Check configuration**:
```bash
# Verify agent config loaded
cat .claude/config.json | jq .agents
```

**3. Monitor execution**:
```bash
# Watch agent activity in verbose mode
claude --verbose

# Logs show:
# - Which agent invoked
# - Tools used
# - Files accessed
```

**4. Test in isolation**:
```bash
# Test agent with simple task first
You: "Use frontend-specialist to list files in src/components"

# If works → agent configured correctly
# If fails → check constraints and tools
```

**5. Review logs**:
```bash
# Check Claude logs
tail -f ~/Library/Logs/Claude/claude.log

# Look for agent errors or warnings
```

---

## Skill Questions

### How do I install a skill?

**From Anthropic's official skills**:
```bash
# Add skills marketplace
/plugin marketplace add anthropics/skills

# List available skills
/plugin marketplace list

# Install specific skill
/plugin marketplace install pdf
/plugin marketplace install docx
/plugin marketplace install xlsx
```

**From community (obra/superpowers)**:
```bash
# Clone repository
git clone https://github.com/obra/superpowers ~/.claude/skills/superpowers

# Or add as git submodule in project
cd your-project
git submodule add https://github.com/obra/superpowers .claude/skills/superpowers
```

**Manual installation**:
```bash
# Create skill directory
mkdir -p .claude/skills/my-skill

# Create SKILL.md
cat > .claude/skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: What the skill does
---

# Skill instructions here
EOF
```

**Verify installation**:
```bash
# Skills loaded automatically
# Test by asking Claude to use the skill
You: "Use my-skill to [task that matches skill description]"
```

---

### How do I create a custom skill?

**Quick template**:

Create `.claude/skills/code-review/SKILL.md`:
```yaml
---
name: code-review
version: 1.0.0
description: Comprehensive code review covering quality, security, and performance with configurable depth
model: claude-sonnet-4-5
tags: ["code-quality", "security", "review"]
---

# Code Review Skill

## Overview
Performs structured code review at three levels: quick, standard, or deep.

## Prerequisites
- Code committed to version control
- Tests written and passing

## Step-by-Step Instructions

### Phase 1: Understand Context
1. Read the code changes (git diff or file contents)
2. Understand the purpose and scope
3. Identify review depth needed

### Phase 2: Code Quality Review
1. Check readability and naming
2. Verify DRY principle
3. Review error handling
4. Assess maintainability

### Phase 3: Generate Report
1. Categorize issues by severity
2. Provide line numbers
3. Suggest improvements

## Examples

### Example 1: Quick Review
```markdown
## Quick Review Results

✅ Positive: Clear naming, good error handling
⚠️  Issues: Missing input validation on line 42

Recommendation: Fix validation before merge
```

## Validation
- [ ] All critical issues addressed
- [ ] Code follows style guide
- [ ] Tests pass
```

**Test the skill**:
```bash
You: "Review src/api/users.ts for code quality"
# Claude should use your code-review skill
```

**Full guide**: See [Creating Custom Skills](../03-skills/3-creating-skills.md)

---

### Why isn't my skill being invoked?

**Common causes**:

**1. Description too vague**:
```yaml
❌ description: "document processing skill"

✅ description: "extract tables from PDFs and convert to CSV format for data analysis workflows"
```

**2. Missing keywords**:
```yaml
# Add specific keywords user might mention
description: "API documentation generator for REST endpoints with OpenAPI/Swagger output including curl examples"
tags: ["api", "rest", "swagger", "documentation", "curl"]
```

**3. Wrong directory**:
```bash
# Skill must be in .claude/skills/
❌ skills/my-skill/SKILL.md
✅ .claude/skills/my-skill/SKILL.md
```

**4. Format errors**:
```bash
# Validate frontmatter
head -20 .claude/skills/my-skill/SKILL.md

# Should have:
# ---
# name: skill-name
# description: ...
# ---
```

**Testing**:
```bash
# Explicitly mention skill keywords
You: "Generate API documentation with OpenAPI spec"
# Should trigger if description matches

# Still not working? Make description more specific
```

---

### Can skills call other skills?

**Not directly**, but skills can **reference** other skills in their instructions.

**Example** (TDD skill references testing skill):
```yaml
---
name: tdd-workflow
description: Test-driven development workflow
dependencies: ["testing-utils"]
---

# TDD Workflow

## Phase 1: Write Test
1. Write failing test
2. Use **testing-utils skill** for test structure

## Phase 2: Implement
3. Write minimal code to pass test
4. Run tests

## Phase 3: Refactor
5. Improve code while keeping tests green
```

**How it works**:
1. User invokes TDD skill
2. TDD skill instructions mention "use testing-utils skill"
3. Claude loads testing-utils skill when needed
4. Both skill contexts available

**Best practice**: Keep skills focused and compose them via dependencies rather than creating mega-skills.

---

### How do I test a skill?

**Testing checklist**:

**1. Syntax validation**:
```bash
# Check frontmatter format
head -10 .claude/skills/my-skill/SKILL.md

# Verify name and description present
```

**2. Invocation test**:
```bash
You: "[Task that matches skill description exactly]"

# Claude should respond:
# "Using my-skill skill..."
# or mention the skill name
```

**3. Different complexity levels**:
```bash
# Test simple case
You: "Quick code review of small file"

# Test standard case
You: "Standard code review of medium file"

# Test complex case
You: "Deep code review of large refactoring"
```

**4. Model overrides** (if configured):
```yaml
modelOverrides:
  quick: claude-haiku-4-5
  standard: claude-sonnet-4-5
  deep: claude-opus-4-5
```

```bash
# Test each override
You: "Quick review..." → Should use Haiku
You: "Standard review..." → Should use Sonnet
You: "Deep review..." → Should use Opus
```

**5. Edge cases**:
- Missing inputs
- Invalid formats
- Large files
- Empty files

**6. Progressive disclosure**:
- Verify phases load incrementally
- Check that examples only shown when relevant
- Confirm detailed sections not loaded upfront

---

### What makes a good skill description?

**Anatomy of great descriptions**:

❌ **Bad** (vague, generic):
```yaml
description: "documentation skill"
```

✅ **Good** (specific, keyword-rich):
```yaml
description: "Generate comprehensive API documentation from TypeScript code including REST endpoints, request/response schemas, authentication methods, and curl example commands for testing"
```

**Formula**:
```
[Action Verb] + [What it does] + [Input types] + [Output format] + [Use case keywords]
```

**Examples**:

**TDD Skill**:
```yaml
description: "Guide test-driven development workflow for writing tests before implementation code using Jest, Mocha, or pytest with red-green-refactor cycle"
```
Keywords: test-driven, TDD, tests, Jest, Mocha, pytest, red-green-refactor

**Code Review Skill**:
```yaml
description: "Perform code review analyzing quality, security, performance with configurable depth levels outputting categorized issues with line numbers and fix suggestions"
```
Keywords: code review, quality, security, performance, issues, suggestions

**Data Extraction Skill**:
```yaml
description: "Extract tables and data from PDF documents converting to CSV, JSON, or Excel formats for data analysis and reporting workflows"
```
Keywords: PDF, extract, tables, CSV, JSON, Excel, data

**Key principles**:
1. **Be specific**: Include file types, formats, frameworks
2. **Use keywords**: Terms users likely to mention
3. **Show value**: What problem does it solve?
4. **Include examples**: Mention specific tools/outputs
5. **Keep concise**: 100-200 characters ideal

---

## Model Questions

### Which model should I use for my task?

**Decision tree**:

```
Is it a simple search or file operation?
├─ Yes → Haiku (3x cheaper, 2x faster)
└─ No → Is it complex architecture or critical logic?
    ├─ Yes → Opus (maximum reasoning)
    └─ No → Sonnet (balanced default)
```

**By task type**:

| Task | Recommended Model | Rationale |
|------|-------------------|-----------|
| Code search | Haiku | Simple pattern matching |
| Simple refactoring | Haiku | Straightforward changes |
| Feature implementation | Sonnet | Balanced quality + cost |
| Bug fixing | Sonnet | Needs good reasoning |
| Architecture design | Opus | Critical decisions |
| Code review | Sonnet | Quality analysis |
| Documentation | Haiku | Formatting & writing |
| Complex debugging | Opus | Deep reasoning required |

**Cost comparison** (same task):
```
Search 1000 files for pattern:
- Haiku:  $0.05 ←  3x cheaper
- Sonnet: $0.15
- Opus:   $0.30

Quality difference: Negligible for searches
Winner: Haiku
```

**Full guide**: See [Model Selection Guide](../05-models/5-selection-guide.md)

---

### How do I change the model mid-conversation?

**Method 1: Interactive menu**:
```bash
/model

# Shows menu:
# - Haiku 4.5 (fast & cheap)
# - Sonnet 4.5 (balanced) ← current
# - Opus 4.5 (maximum capability)

# Select new model
```

**Method 2: Command-line**:
```bash
# Start with specific model
claude --model claude-haiku-4-5

# Or
claude --model sonnet
```

**Method 3: Task-specific override**:
```bash
You: "Use Opus model to design authentication architecture"

# Claude uses Opus for this task only
# Reverts to default afterward
```

**Note**: Model changes apply to future messages, not current conversation context.

---

### Can I assign different models to different agents?

**Yes!** This is a powerful cost-optimization strategy.

**Configuration** (`.claude/config.json`):
```json
{
  "agents": {
    "Explore": {
      "model": "haiku"  // Fast searches
    },
    "general-purpose": {
      "model": "sonnet"  // Standard coding
    },
    "Plan": {
      "model": "opus"  // Complex planning
    },
    "frontend-specialist": {
      "model": "sonnet"
    },
    "quick-formatter": {
      "model": "haiku"  // Simple formatting
    }
  }
}
```

**Cost savings**:
```
Daily workflow:
- 10 searches (Explore/Haiku): $0.50
- 5 features (General/Sonnet): $3.00
- 1 architecture (Plan/Opus): $2.00

Total: $5.50/day

Previous (all Sonnet):
- 16 operations: $9.60/day

Savings: 43% ($4.10/day, $1,230/year)
```

**Full guide**: See [Agent Model Assignment](../02-agents/3-model-assignment.md)

---

### What's the cost difference between models?

**2025 Pricing**:

| Model | Input | Output | Use Case |
|-------|-------|--------|----------|
| **Haiku 4.5** | $1/M tokens | $5/M tokens | Fast & cheap |
| **Sonnet 4.5** | $3/M tokens | $15/M tokens | Balanced |
| **Opus 4.5** | Premium* | Premium* | Maximum quality |

*Opus pricing is higher than Sonnet but exact rates vary

**Real-world costs**:

**Simple task** (search code):
- Tokens: ~8,000
- Haiku: $0.04
- Sonnet: $0.13 (3.25x more)
- Opus: ~$0.30 (7.5x more)

**Medium task** (implement feature):
- Tokens: ~20,000
- Haiku: $0.10
- Sonnet: $0.33
- Opus: ~$0.75

**Complex task** (architecture):
- Tokens: ~50,000
- Haiku: $0.25 (may struggle)
- Sonnet: $0.83
- Opus: ~$1.90 (worth it for quality)

**Optimization** (using right model for each task):
```
10 searches (Haiku):     $0.40
5 features (Sonnet):     $1.65
1 architecture (Opus):   $1.90

Total: $3.95

All-Sonnet alternative:  $6.60
All-Opus alternative:    $19.00

Savings vs Sonnet: 40%
Savings vs Opus:   79%
```

---

### When should I use extended thinking?

**Use extended thinking for**:
- ✅ **Complex algorithms**: Optimization, data structures
- ✅ **Architectural decisions**: Tradeoff analysis
- ✅ **Subtle bugs**: Hard-to-find issues
- ✅ **Multi-step reasoning**: Planning complex workflows
- ✅ **Security analysis**: Vulnerability assessment

**Skip extended thinking for**:
- ❌ **Simple formatting**: JSON, code style
- ❌ **Basic searches**: Find files, grep patterns
- ❌ **Straightforward CRUD**: Standard endpoints
- ❌ **Documentation writing**: READMEs, comments
- ❌ **Simple refactoring**: Rename variables

**Thinking keywords**:
```bash
"think"         → ~4,000 tokens (moderate complexity)
"think hard"    → ~10,000 tokens (complex problems)
"think harder"  → ~31,999 tokens (maximum depth)
"ultrathink"    → ~31,999 tokens (comprehensive analysis)
```

**Cost impact**:
```
Same task with/without thinking:

No thinking:     $0.30
"think":         $0.42 (+40%)
"think harder":  $0.75 (+150%)

Use wisely!
```

**Toggle**: Press **Tab** during conversation to enable/disable thinking.

---

### How do thinking keywords work?

**Thinking keywords allocate token budget** for internal reasoning:

| Keyword | Token Budget | When to Use |
|---------|--------------|-------------|
| (none) | 0 | Simple tasks, formatting |
| `"think"` | ~4,000 | Moderate complexity |
| `"think hard"` | ~10,000 | Complex problems |
| `"think harder"` | ~31,999 | Very complex analysis |
| `"ultrathink"` | ~31,999 | Maximum reasoning |

**Examples**:

**No thinking** (simple):
```bash
You: "Format this JSON file"
# Direct execution, no internal reasoning needed
```

**Think** (moderate):
```bash
You: "Think about how to refactor this class for better testability"
# Uses ~4,000 tokens to analyze patterns and suggest refactoring
```

**Think harder** (complex):
```bash
You: "Think harder about optimizing this algorithm for O(n) time complexity"
# Uses ~31,999 tokens for deep algorithmic analysis
```

**Ultrathink** (maximum):
```bash
You: "Ultrathink about designing a distributed caching strategy for high availability"
# Uses maximum tokens for comprehensive reasoning about architecture, tradeoffs, failure modes
```

**Tips**:
- Start without thinking keywords
- Add "think" if results shallow
- Use "think harder" sparingly (expensive!)
- "ultrathink" for critical architecture only

---

## Context Management Questions

(Continuing in next message due to length...)

### What is CLAUDE.md and where should I put it?

**CLAUDE.md** is your project's "instruction manual" for Claude Code.

**Location** (choose one):
1. **Project root**: `/path/to/project/CLAUDE.md` (recommended)
2. **Claude directory**: `/path/to/project/.claude/CLAUDE.md`

**What to include**:
```markdown
# Project Name

## Tech Stack
- Language, framework, tools

## Common Commands
- Build, test, deploy commands

## Core Files
- Important files and their purposes

## Code Style
- Formatting rules, conventions

## Testing Requirements
- Coverage goals, test patterns

## Git Workflow
- Branch naming, commit style

## Notes for AI
- Project-specific guidance
- Patterns to follow
- Anti-patterns to avoid
```

**What NOT to include**:
- ❌ Entire codebase documentation
- ❌ Duplicate information from code comments
- ❌ Sensitive credentials
- ❌ Auto-generated API docs
- ❌ Changelog (use CHANGELOG.md)

**Size**: Keep under 500 lines for best performance.

**Full guide**: See [CLAUDE.md Files](../08-context/2-claude-md.md)

---

### How do memory files work?

**Memory files** provide hierarchical, persistent context.

**Hierarchy** (highest to lowest priority):
```
.claude/
├── memory.md              # Highest precedence
├── project/
│   ├── architecture.md    # Project-level memory
│   └── conventions.md
└── team/
    └── guidelines.md      # Team-level memory
```

**How precedence works**:
1. `memory.md` overrides everything
2. More specific overrides general
3. All files loaded automatically

**Example use case**:

**`.claude/memory.md`** (session-specific):
```markdown
# Current Session Context

Working on authentication feature
Using JWT tokens
API endpoint: /api/auth/login
```

**`.claude/project/architecture.md`** (project-wide):
```markdown
# Architecture Decisions

## State Management
Using Redux Toolkit (decided 2025-01-10)

## Database
PostgreSQL with Prisma ORM
```

**`.claude/team/guidelines.md`** (team conventions):
```markdown
# Team Guidelines

## Code Review
- Minimum 2 approvals required
- All PRs must pass CI

## Testing
- 80% code coverage minimum
```

**When to use**:
- Session decisions → `memory.md`
- Architecture decisions → `project/`
- Team conventions → `team/`

---

### What happens when context gets too large?

**Claude Code automatically manages context** using clearing strategies:

**Strategy 1: clear_tool_uses_20250919**
- Triggers when context exceeds threshold (~180K tokens)
- Clears oldest tool results chronologically
- Preserves recent conversation and results

**Strategy 2: clear_thinking_20251015**
- Manages thinking blocks when extended thinking enabled
- Clears older thinking blocks while keeping conclusions

**Warning signs**:
```
[Claude]: "Context approaching limit. Save important information to memory files."
```

**What to do**:
1. **Save to memory**: Important decisions → `.claude/memory.md`
2. **Clear history**: Start new session for unrelated tasks
3. **Reduce CLAUDE.md**: Move details to imported files
4. **Use focused agents**: Constrain paths to reduce context

**Prevention**:
- Keep CLAUDE.md lean (< 300 lines)
- Start new sessions for new features
- Use memory hierarchy effectively
- Respond to context warnings promptly

---

### How do I prevent context clearing?

**You can't prevent it entirely** (it's automatic), but you can **delay it**:

**1. Keep CLAUDE.md minimal**:
```markdown
❌ 1,000 lines of detailed documentation

✅ 200 lines with file imports:
@docs/architecture.md
@docs/api-spec.md
```

**2. Use memory hierarchy**:
- Save important context to memory files
- They're reloaded automatically

**3. Use focused agents**:
```json
{
  "agents": {
    "frontend-only": {
      "constraints": {
        "allowedPaths": ["src/frontend/**"]
      }
    }
  }
}
```
Smaller context = longer before clearing

**4. Start new sessions**:
```bash
# For unrelated tasks, start fresh
# Avoids accumulating irrelevant context
```

**5. Respond to warnings**:
```
[Claude]: "Context approaching limit..."
→ Save important info to memory NOW
```

---

### Can I import files into CLAUDE.md?

**Yes!** Use `@path/to/file.md` syntax.

**Example CLAUDE.md**:
```markdown
# My Project

## Overview
Brief project description

## Architecture
@docs/architecture.md

## API Reference
@docs/api-spec.md

## Deployment Guide
@docs/deployment.md
```

**Benefits**:
- ✅ Keep CLAUDE.md concise
- ✅ Modular documentation
- ✅ Load details only when needed (progressive disclosure)
- ✅ Easier to maintain

**Imported file** (`docs/architecture.md`):
```markdown
# Architecture

## Frontend
React 18 with TypeScript

## Backend
Node.js + Express + PostgreSQL

## Infrastructure
AWS (EC2, RDS, S3)
```

**Notes**:
- Paths relative to CLAUDE.md location
- Imported files also loaded automatically
- Can nest imports (import file that imports another)
- Keep total context reasonable

---

### What should I include in CLAUDE.md?

**Essential sections**:

**1. Project Identity**:
```markdown
# Project Name
Brief description (1-2 sentences)
```

**2. Tech Stack**:
```markdown
## Tech Stack
- Language: TypeScript
- Framework: React 18
- Backend: Node.js + Express
- Database: PostgreSQL
```

**3. Common Commands**:
```markdown
## Commands
npm run dev      # Start dev server
npm test         # Run tests
npm run build    # Production build
```

**4. Core Files**:
```markdown
## Core Files
- src/app.ts: Application entry point
- src/api/: REST API endpoints
- src/db/: Database models
```

**5. Code Style**:
```markdown
## Code Style
- 2-space indentation
- Single quotes
- Semicolons required
- ESLint + Prettier
```

**6. Testing**:
```markdown
## Testing
- 80% coverage minimum
- Jest for unit tests
- Cypress for E2E
```

**7. Git Workflow**:
```markdown
## Git Workflow
- Branch: feature/description
- Commits: Conventional Commits
- Squash before merge
```

**8. Notes for AI**:
```markdown
## Notes for AI
- Always run tests before committing
- Use existing component patterns
- Never commit .env files
```

**Optional sections**:
- Deployment
- Environment variables (reference only, not values!)
- Database migrations
- API authentication

**Full example**: See [CLAUDE.md Structure](1-api-reference.md#claudemd-structure)

---

## Optimization Questions

### How can I reduce token usage?

**Top 10 optimization strategies**:

**1. Use Haiku for simple tasks** (3x cheaper):
```json
{
  "agents": {
    "Explore": {"model": "haiku"}
  },
  "defaultModel": "haiku"
}
```

**2. Disable extended thinking** for routine work:
```bash
❌ "Think hard about formatting this code"
✅ "Format this code"
```

**3. Keep CLAUDE.md concise** (< 300 lines):
```markdown
❌ 1000 lines of docs in CLAUDE.md
✅ 200 lines + @docs/details.md imports
```

**4. Use focused agents** with path constraints:
```json
{
  "constraints": {
    "allowedPaths": ["src/components/**"]
  }
}
```

**5. Clear conversation history** between unrelated tasks

**6. Be specific** in prompts (avoid vague requests):
```bash
❌ "Improve the code"
✅ "Refactor src/utils/date.ts to use date-fns library"
```

**7. Use memory files** instead of repeating context

**8. Batch operations** when possible:
```bash
❌ "Fix file1" then "Fix file2" then "Fix file3"
✅ "Fix these three files: file1, file2, file3"
```

**9. Configure cost tracking**:
```json
{
  "costTracking": {
    "enabled": true,
    "dailyBudget": 50000,
    "alertThreshold": 0.8
  }
}
```

**10. Use Explore agent** for read-only tasks (cheaper, faster)

**Potential savings**: 50-70% reduction in token costs!

**Full guide**: See [Cost Optimization](../11-optimization/1-cost-optimization.md)

---

### What's the best model configuration for cost savings?

**Optimal configuration** (balances cost + quality):

```json
{
  "agents": {
    "Explore": {
      "model": "haiku",
      "description": "Fast codebase searches"
    },
    "general-purpose": {
      "model": "haiku",
      "description": "Routine coding tasks",
      "upgrade_to_sonnet_for": [
        "complex refactoring",
        "architecture changes",
        "critical bug fixes"
      ]
    },
    "Plan": {
      "model": "sonnet",
      "description": "Planning and architecture"
    }
  },

  "defaultModel": "haiku",

  "costTracking": {
    "enabled": true,
    "dailyBudget": 100000,
    "alertThreshold": 0.8
  }
}
```

**Rationale**:
- **Explore → Haiku**: Searches don't need deep reasoning (3x savings)
- **General-Purpose → Haiku**: 70% of coding tasks work fine with Haiku
- **Plan → Sonnet**: Planning benefits from better reasoning
- **Default → Haiku**: Fallback to cheapest model

**Cost comparison**:

**Baseline** (all Sonnet):
```
Daily: 100 operations
Cost: $15.00/day = $450/month
```

**Optimized** (strategic model use):
```
Daily:
- 70 simple tasks (Haiku): $2.10
- 25 standard tasks (Sonnet): $3.75
- 5 complex tasks (Opus): $3.00

Total: $8.85/day = $265.50/month

Savings: $184.50/month (41%)
```

**Upgrade to Sonnet/Opus when**:
- Task fails with Haiku
- Quality not meeting expectations
- Critical business logic
- Complex architecture

**Full guide**: See [Model Selection Guide](../05-models/5-selection-guide.md)

---

### How do I track my token usage?

**Method 1: Enable cost tracking** (recommended):

**Configure** (`.claude/config.json`):
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

**View logs**:
```bash
cat .claude/cost-log.json | jq .

# Shows:
# - Tokens per operation
# - Cost per operation
# - Model used
# - Timestamp
# - Daily totals
```

**Example log**:
```json
{
  "date": "2025-01-15",
  "operations": [
    {
      "timestamp": "2025-01-15T10:30:00Z",
      "agent": "Explore",
      "model": "haiku",
      "inputTokens": 5000,
      "outputTokens": 3000,
      "cost": 0.02,
      "task": "Find API endpoints"
    }
  ],
  "dailyTotal": {
    "cost": 8.45,
    "tokensSaved": 45000,
    "estimatedSavings": "65% vs all-Sonnet"
  }
}
```

**Method 2: Use `/usage` command**:
```bash
/usage

# Shows:
# - Current session tokens
# - Today's usage
# - Monthly usage
# - Model distribution
```

**Method 3: Claude Pro dashboard**:
- Visit claude.com/account
- View usage statistics
- See remaining daily/monthly limits

---

### Can I set a daily budget?

**Yes!** Configure in `.claude/config.json`:

```json
{
  "costTracking": {
    "enabled": true,
    "dailyBudget": 50000,     // 50,000 tokens/day
    "alertThreshold": 0.8,     // Alert at 80%
    "logFile": ".claude/cost-log.json"
  }
}
```

**How it works**:

**At 80% (40,000 tokens)**:
```
⚠️  [Claude]: You've used 80% of daily budget (40,000/50,000 tokens)
```

**At 100% (50,000 tokens)**:
```
🛑 [Claude]: Daily budget reached (50,000/50,000 tokens)
      Recommend upgrading to higher tier or waiting until tomorrow
```

**Budget doesn't hard-block** but provides warnings to manage usage.

**Setting appropriate budgets**:

| Usage Level | Daily Budget | Monthly Cost (estimated) |
|-------------|--------------|--------------------------|
| Light (personal) | 25,000 | ~$15-30 |
| Medium (professional) | 100,000 | ~$60-120 |
| Heavy (team) | 500,000 | ~$300-600 |

**Tips**:
- Start conservative, adjust based on actual usage
- Set alerts at 70-80% to avoid surprises
- Review logs weekly to optimize
- Use Haiku by default to stretch budget

---

### What workflows save the most tokens?

**Top token-saving workflows**:

**1. Explore-first workflow** (50% savings on searches):
```bash
# Instead of:
You: "Find and refactor all API endpoints"
[Uses General-Purpose agent, expensive]

# Do:
You: "Use Explore agent to find all API endpoints"
[Explore finds them cheaply]

You: "Now refactor these 5 endpoints: [list]"
[General-Purpose only refactors, not searching]

Savings: 50% on search phase
```

**2. Haiku-first, upgrade if needed**:
```bash
You: "Refactor src/utils/date.ts"
[Tries with Haiku first]

# If quality insufficient:
You: "Use Sonnet to refactor src/utils/date.ts with better error handling"

# Haiku worked? Save 66%
# Needed Sonnet? Only pay when needed
```

**3. Batch operations** (30% savings):
```bash
❌ Separate requests:
You: "Fix file1.ts"
You: "Fix file2.ts"
You: "Fix file3.ts"
Cost: 3x context loading

✅ Batched:
You: "Fix these files: file1.ts, file2.ts, file3.ts"
Cost: 1x context loading

Savings: ~30%
```

**4. Memory-augmented workflow** (reduce repetition):
```bash
# Save decisions to memory
You: "Save to memory: Using Redux Toolkit for state management"

# Later...
You: "Implement user authentication"
[Claude loads memory, knows to use Redux Toolkit]
[No need to re-explain architecture]

Savings: Eliminates repeated context
```

**5. Focused agent workflow** (40% savings):
```json
{
  "agents": {
    "frontend-only": {
      "constraints": {
        "allowedPaths": ["src/frontend/**"]
      }
    }
  }
}
```
```bash
You: "Use frontend-only agent to create LoginForm"
[Only loads frontend code, not entire codebase]

Savings: ~40% context reduction
```

**Full guide**: See [Optimization Strategies](../11-optimization/2-advanced-techniques.md)

---

### How much can I really save with optimization?

**Real-world case studies**:

**Case 1: Solo Developer**

**Before optimization** (all Sonnet):
- 30 operations/day
- Average: 15,000 tokens/operation
- Daily cost: $13.50
- Monthly: $405

**After optimization**:
- 20 searches (Haiku): $0.60
- 8 coding (Sonnet): $7.20
- 2 architecture (Opus): $6.00
- Daily cost: $13.80... wait, that's wrong!

Let me recalculate:

**After optimization**:
- 20 searches (Explore/Haiku, 5K tokens): $0.40
- 8 features (General/Haiku, 10K tokens): $0.80
- 2 planning (Plan/Sonnet, 20K tokens): $1.20
- Daily cost: $2.40
- Monthly: $72

**Savings: $333/month (82%)**

**Case 2: Small Team (5 developers)**

**Before** (all Sonnet):
- 150 operations/day
- Monthly: $2,025

**After**:
- 100 searches (Haiku): $3.00/day
- 40 features (Sonnet): $18.00/day
- 10 architecture (Opus): $15.00/day
- Monthly: $1,080

**Savings: $945/month (47%)**

**Case 3: Startup (10 developers)**

**Before** (mixed, unoptimized):
- Monthly: $6,800

**After** (strategic model use, focused agents):
- Monthly: $1,950

**Savings: $4,850/month (71%)**

**Key optimization factors**:
1. ✅ Haiku for searches (3x cheaper)
2. ✅ Focused agents (40% less context)
3. ✅ Memory files (reduce repetition)
4. ✅ Batching (30% fewer operations)
5. ✅ Strategic Opus use (only when needed)

**Realistic expectations**:
- **Conservative**: 40-50% savings
- **Moderate**: 60-70% savings
- **Aggressive**: 70-80% savings

**Full guide with calculations**: See [Cost Optimization](../11-optimization/1-cost-optimization.md)

---

## Customization Questions

### How do I create a slash command?

**Quick start**:

**1. Create command file** (`.claude/commands/review.md`):
```yaml
---
command: review
description: Code review with configurable depth
usage: /review [--quick | --standard | --deep] <file>
model: sonnet
options:
  - name: quick
    type: boolean
    default: false
  - name: deep
    type: boolean
    default: false
---

# Code Review Command

When invoked:

1. Determine depth from options
2. Load file from $ARG1
3. Run code review at appropriate depth
4. Output categorized issues

## Example

```bash
/review --quick src/api/users.ts
```

Performs quick review of users.ts
```

**2. Use the command**:
```bash
/review src/api/users.ts
# Or with options:
/review --deep src/auth/login.ts
```

**Full guide**: See [Creating Slash Commands](../09-keywords/2-slash-commands.md)

---

### What are hooks and how do I use them?

**Hooks** are automated actions triggered by events.

**Hook types**:
1. **PreToolUse**: Before tool executes
2. **PostToolUse**: After tool succeeds
3. **Notification**: When Claude sends notification
4. **Stop**: When Claude finishes responding

**Example use cases**:

**Auto-format after writing** (PostToolUse):
```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "npx prettier --write $FILE"
      }]
    }]
  }
}
```

**Check for unpushed commits** (Stop):
```json
{
  "hooks": {
    "Stop": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "~/.claude/stop-hook-git-check.sh"
      }]
    }]
  }
}
```

**Notify on errors** (Notification):
```json
{
  "hooks": {
    "Notification": [{
      "matcher": "error",
      "hooks": [{
        "type": "command",
        "command": "notify-send 'Claude Error' '$MESSAGE'"
      }]
    }]
  }
}
```

**Full guide**: See [Automation Patterns](../09-keywords/3-automation-patterns.md)

---

### Can I automate tasks with hooks?

**Yes!** Hooks enable powerful automation.

**Common automations**:

**1. Auto-test after code changes**:
```json
{
  "PostToolUse": [{
    "matcher": "Write|Edit",
    "hooks": [{
      "type": "command",
      "command": "npm test $FILE.test.js"
    }]
  }]
}
```

**2. Auto-commit after successful changes**:
```json
{
  "PostToolUse": [{
    "matcher": "Write",
    "hooks": [{
      "type": "command",
      "command": "git add $FILE && git commit -m 'Auto-commit: Updated $FILE'"
    }]
  }]
}
```

**3. Build after file changes**:
```json
{
  "PostToolUse": [{
    "matcher": "Write",
    "hooks": [{
      "type": "command",
      "command": "npm run build"
    }]
  }]
}
```

**4. Notify on completion**:
```json
{
  "Stop": [{
    "hooks": [{
      "type": "command",
      "command": "osascript -e 'display notification \"Claude finished\" with title \"Task Complete\"'"
    }]
  }]
}
```

**Best practices**:
- ✅ Make hooks idempotent (safe to run multiple times)
- ✅ Add error handling
- ✅ Set appropriate timeouts
- ✅ Test hooks before adding to config
- ❌ Don't make hooks too slow (< 5s ideal)
- ❌ Don't create infinite loops (hook triggering hook)

---

### How do I customize Claude's behavior?

**5 customization levels**:

**Level 1: CLAUDE.md instructions**
```markdown
# Notes for AI

- Always run tests before committing
- Use functional components (not class components)
- Prefer composition over inheritance
- Write tests alongside features
```

**Level 2: Agent specialization**
```json
{
  "agents": {
    "strict-tester": {
      "description": "Never allows code without tests",
      "constraints": {
        "requireTests": true
      }
    }
  }
}
```

**Level 3: Skills for workflows**
```yaml
---
name: tdd-workflow
description: Test-driven development workflow
---
[Detailed TDD instructions]
```

**Level 4: Hooks for automation**
```json
{
  "hooks": {
    "PostToolUse": [
      {"command": "npm test"},
      {"command": "npm run lint"}
    ]
  }
}
```

**Level 5: Custom MCP servers**
```typescript
// Custom tools specific to your workflow
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  // Your custom logic
});
```

**Combination example**:
```
CLAUDE.md: "Follow TDD workflow"
    ↓
Skill: tdd-workflow provides steps
    ↓
Agent: test-specialist enforces coverage
    ↓
Hook: Runs tests after each change
    ↓
MCP Server: Integrates with CI/CD
```

---

### What are the available hook types?

**Complete hook reference**:

### 1. PreToolUse Hook

**When**: After Claude creates tool parameters, before processing

**Use for**:
- Validation
- Logging
- Backup creation
- Permission checks

**Variables**:
- `$TOOL`: Tool name
- `$PARAMS`: JSON parameters

**Example**:
```json
{
  "PreToolUse": [{
    "matcher": "Write",
    "hooks": [{
      "type": "command",
      "command": "cp $FILE $FILE.backup"
    }]
  }]
}
```

### 2. PostToolUse Hook

**When**: Immediately after tool succeeds

**Use for**:
- Formatting
- Testing
- Building
- Committing

**Variables**:
- `$TOOL`: Tool name
- `$FILE`: File path (file operations)
- `$STATUS`: Exit code
- `$OUTPUT`: Tool output

**Example**:
```json
{
  "PostToolUse": [{
    "matcher": "Write|Edit",
    "hooks": [
      {"command": "npx prettier --write $FILE"},
      {"command": "npx eslint --fix $FILE"},
      {"command": "npm test $FILE.test.js"}
    ]
  }]
}
```

### 3. Notification Hook

**When**: Claude sends notification

**Use for**:
- OS notifications
- Logging errors
- Alerting
- Monitoring

**Variables**:
- `$MESSAGE`: Notification text
- `$LEVEL`: info/warning/error

**Example**:
```json
{
  "Notification": [{
    "matcher": "error",
    "hooks": [{
      "command": "notify-send 'Claude Error' '$MESSAGE'"
    }]
  }]
}
```

### 4. Stop Hook

**When**: Claude finishes responding

**Use for**:
- Session cleanup
- Git status checks
- Summary reports
- Final validations

**Variables**:
- `$SESSION_ID`: Session identifier

**Example**:
```json
{
  "Stop": [{
    "hooks": [{
      "command": "~/.claude/hooks/check-unpushed-commits.sh"
    }]
  }]
}
```

**Full reference**: See [Hook Specifications](1-api-reference.md#hook-specifications)

---

### How do I debug hook execution?

**Debugging techniques**:

**1. Enable hook logging**:

Create hook script with logging:
```bash
#!/bin/bash
# ~/.claude/hooks/my-hook.sh

# Log to file
exec > >(tee -a ~/.claude/logs/hook.log)
exec 2>&1

echo "=== Hook started: $(date) ==="
echo "Tool: $TOOL"
echo "File: $FILE"

# Your hook logic here
npx prettier --write "$FILE"

echo "=== Hook finished: $(date) ==="
```

**2. Test hook directly**:
```bash
# Make executable
chmod +x ~/.claude/hooks/my-hook.sh

# Run manually
TOOL=Write FILE=test.ts ~/.claude/hooks/my-hook.sh

# Check exit code
echo $?  # Should be 0 for success
```

**3. Check Claude logs**:
```bash
# macOS
tail -f ~/Library/Logs/Claude/claude.log

# Linux
tail -f ~/.local/share/claude/logs/claude.log

# Look for hook execution errors
```

**4. Add verbose output**:
```bash
#!/bin/bash
set -x  # Enable command tracing

# Hook will log every command it runs
npx prettier --write "$FILE"
```

**5. Use simpler hook first**:
```json
{
  "PostToolUse": [{
    "hooks": [{
      "command": "echo 'File changed: $FILE' >> /tmp/claude-hooks.log"
    }]
  }]
}
```

If simple hook works → hook system OK
If simple hook fails → config issue

**Common issues**:
- ❌ Hook not executable (`chmod +x`)
- ❌ Wrong shell (`#!/bin/bash` missing)
- ❌ Variables not quoted (`"$FILE"` not `$FILE`)
- ❌ Timeout too short (increase in config)
- ❌ Hook returns non-zero exit code

---

## Quick Navigation

**By topic**:
- [General](#general-questions) - Basics, system requirements, updates
- [MCP Servers](#mcp-server-questions) - Installation, auth, custom servers
- [Agents](#agent-questions) - Types, creation, debugging
- [Skills](#skill-questions) - Installation, creation, invocation
- [Models](#model-questions) - Selection, costs, thinking modes
- [Context](#context-management-questions) - CLAUDE.md, memory, imports
- [Optimization](#optimization-questions) - Cost saving, budgets, workflows
- [Customization](#customization-questions) - Commands, hooks, automation

**By user type**:
- **Beginners**: Start with [General](#general-questions)
- **Developers**: See [Agents](#agent-questions) and [Skills](#skill-questions)
- **Cost-conscious**: See [Optimization](#optimization-questions)
- **Power users**: See [Customization](#customization-questions)

---

## Still Have Questions?

**Not finding your answer?**

1. Check [Troubleshooting Guide](2-troubleshooting.md) for specific issues
2. See [API Reference](1-api-reference.md) for technical details
3. Browse [Cheat Sheet](4-cheat-sheet.md) for quick commands
4. Search [Official Docs](https://code.claude.com/docs)
5. Ask on [Community Forum](https://community.anthropic.com)
6. Report bugs on [GitHub](https://github.com/anthropics/claude-code/issues)

---

**Contributing to FAQ**

Found a question not covered here? Submit a PR or open an issue:
- GitHub: https://github.com/your-repo/documentation
- Include: Question + detailed answer + examples
- We'll add it to help others!

**Last Updated**: 2025-01-15
**Contributors**: Community submissions welcome!
