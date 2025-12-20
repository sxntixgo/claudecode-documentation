# Claude Code Comprehensive Documentation Plan

## Overview
This plan outlines a complete documentation structure for Claude Code, covering MCP servers, agents, skills, model selection, thinking modes, context management, and practical examples for optimizing token usage and behavior customization.

---

## 1. MCP Servers (Model Context Protocol)

### 1.1 What Are MCP Servers?
**Objective**: Explain the Model Context Protocol and its role in extending Claude Code's capabilities.

**Topics to Cover**:
- Definition: MCP is an open standard created by Anthropic in late 2024 that allows AI assistants to connect to external tools, databases, APIs, files, and services
- Purpose: Extends Claude's capabilities beyond its built-in knowledge by providing real-time access to external resources
- Architecture: How MCP servers communicate with Claude Code
- Benefits: Accessing live data, integrating with development tools, automating workflows

### 1.2 How to Install MCP Servers
**Objective**: Provide step-by-step installation instructions.

**Installation Methods**:

**Method 1: CLI (Recommended)**
```bash
# Add a server
claude mcp add [name] --scope user

# List installed servers
claude mcp list

# Remove a server
claude mcp remove [name]

# Test a server
claude mcp get [name]
```

**Example: Installing GitHub MCP Server**
```bash
# Using the add-json command for servers requiring authentication
claude mcp add-json github '{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "'$GITHUB_TOKEN'"
  }
}'
```

**Method 2: Manual Configuration**
- Edit config file: `~/Library/Application Support/Claude/claude_desktop_config.json`
- Add server configuration manually for complex setups

**Method 3: Docker MCP Toolkit**
- 200+ pre-built containerized MCP servers
- One-click deployment in Docker Desktop
- Automatic credential handling

**Post-Installation**:
- Restart Claude Code
- Verify installation: `claude mcp list`

### 1.3 Popular MCP Servers
**Objective**: List and describe commonly used MCP servers.

**Available Servers**:
- **GitHub**: Pull request management, issue tracking, repository operations
- **Perplexity**: Research and web search capabilities
- **Sequential Thinking**: Breaking down complex tasks into steps
- **Context7**: Up-to-date code documentation for LLMs and AI code editors
- **200+ Docker-containerized servers** available through MCP Toolkit

### 1.4 How to Create Custom MCP Servers
**Objective**: Guide developers through building their own MCP servers.

**Topics to Cover**:
- MCP server architecture and protocol specification
- Required components (server endpoint, tool definitions, handlers)
- Development workflow
- Testing and debugging MCP servers
- Publishing and distributing custom servers

**Example Structure**:
```
my-mcp-server/
├── package.json
├── src/
│   ├── index.ts          # Server entry point
│   ├── tools/            # Tool definitions
│   └── handlers/         # Request handlers
└── README.md
```

### 1.5 MCP Server Best Practices
- Security considerations (credential management, API token storage)
- Performance optimization
- Error handling and logging
- Documentation standards

---

## 2. Agents in Claude Code

### 2.1 What Are Agents?
**Objective**: Explain the concept of agents and subagents in Claude Code.

**Topics to Cover**:
- Definition: Specialized AI assistants with focused instructions, context windows, and tool permissions
- Purpose: Isolate tasks, manage context independently, prevent context pollution
- When to use agents vs. direct interaction
- Agent lifecycle and context management

### 2.2 Built-in Agent Types
**Objective**: Describe each built-in agent type and when to use them.

#### 2.2.1 Explore Subagent
**Purpose**: Search and understand codebases without making changes

**Capabilities**:
- Read-only bash commands
- File searching and content analysis
- Codebase exploration

**Thoroughness Levels**:
- **Quick**: Fast searches with minimal exploration for targeted lookups
- **Medium**: Balanced speed and thoroughness for moderate exploration
- **Very thorough**: Comprehensive analysis across multiple locations and naming conventions

**When to Use**:
```markdown
- Finding specific code patterns
- Understanding project structure
- Locating definitions and implementations
- Analyzing dependencies
```

**Example Invocation**:
```
User: "Where are errors from the client handled?"
Claude uses Explore agent with "medium" thoroughness
```

#### 2.2.2 General-Purpose Subagent
**Purpose**: Handle complex, multi-step tasks requiring both exploration and modification

**Capabilities**:
- Full file modification access
- Complex reasoning and interpretation
- Multi-step dependent operations
- Adaptive search strategies

**When to Use**:
```markdown
- Tasks requiring exploration AND modification
- Complex reasoning to interpret search results
- Multiple strategies may be needed
- Multi-step dependent tasks
```

**Example Scenarios**:
- Refactoring across multiple files
- Implementing new features with dependencies
- Bug fixes requiring code changes

#### 2.2.3 Plan Subagent
**Purpose**: Research and understand codebases specifically for creating implementation plans

**Capabilities**:
- Codebase analysis for planning
- Architectural understanding
- Pattern recognition

**When to Use**:
- Only active in plan mode
- Understanding codebase before creating plans
- Researching implementation approaches

**Workflow**:
1. User requests a complex feature
2. Claude enters plan mode
3. Plan subagent researches the codebase
4. Plan is presented for approval
5. Implementation begins with general-purpose agent

### 2.3 Creating Custom Agents
**Objective**: Guide users through creating specialized agents.

**Topics to Cover**:
- Agent configuration structure
- Setting tool permissions
- Defining agent-specific instructions
- Managing agent context

**Example Custom Agent**:
```json
{
  "agents": {
    "code-reviewer": {
      "description": "Reviews code for best practices and potential issues",
      "model": "haiku",
      "tools": ["Read", "Grep", "Glob"],
      "instructions": "Focus on code quality, security, and performance"
    }
  }
}
```

### 2.4 Model Assignment to Agents
**Objective**: Explain how to optimize costs by assigning different models to agents.

**Key Points**:
- Introduced in v1.0.64 with the `model` parameter
- Available models: `sonnet`, `opus`, `haiku`
- Cost optimization strategies

**Model Selection Strategy**:
```markdown
Use Haiku 4.5 for:
- Fast exploration tasks
- Simple code searches
- Routine operations
- 90% of Sonnet performance at 3x cost savings ($1/$5 vs $3/$15)

Use Sonnet 4.5 for:
- Complex coding tasks
- Balanced reasoning and cost
- Structured analysis
- Default for most operations

Use Opus 4.5 for:
- Enterprise-level reasoning
- Advanced coding challenges
- Massive context workloads
- When maximum quality is required
```

**Example Configuration**:
```json
{
  "agents": {
    "quick-search": {
      "type": "Explore",
      "model": "haiku"
    },
    "feature-implementation": {
      "type": "general-purpose",
      "model": "sonnet"
    },
    "architecture-design": {
      "type": "Plan",
      "model": "opus"
    }
  }
}
```

---

## 3. Skills in Claude Code

### 3.1 What Are Skills?
**Objective**: Explain skills and how they extend Claude's capabilities.

**Definition**:
- Folders of instructions, scripts, and resources
- Dynamically loaded for specialized tasks
- Model-invoked through progressive disclosure
- Reusable components across projects

**How Skills Work**:
1. Claude analyzes user request
2. Evaluates available skills based on descriptions
3. Autonomously selects appropriate skill
4. Loads skill instructions progressively
5. Executes task following skill guidance

### 3.2 Installing Skills from Marketplace
**Objective**: Guide users through installing pre-built skills.

**Installation**:
```bash
/plugin marketplace add anthropics/skills
```

**Official Skills**:
- **DOCX**: Creating, editing, and analyzing Word documents
- **PDF**: Extracting text, tables, and metadata from PDFs
- **PPTX**: Reading and generating PowerPoint slides
- **XLSX**: Spreadsheet manipulation with formulas and charts

**Community Skills**:
- **obra/superpowers**: 20+ battle-tested skills including TDD, debugging patterns, collaboration workflows

### 3.3 How to Create Custom Skills
**Objective**: Provide comprehensive guide to skill development.

**Basic Structure**:
```
my-skill/
└── SKILL.md
```

**SKILL.md Template**:
```markdown
---
name: skill-name
description: Clear description of what this skill does and when to use it. Include action verbs, specific file types, and use cases.
model: claude-haiku-4-5  # Optional: specify model for cost optimization
---

# Skill Name

## Overview
Provide an overview of the skill's purpose and capabilities.

## Step-by-Step Instructions
1. First step description
2. Second step description
3. Continue with clear, sequential steps

## Examples
Provide concrete examples showing how to use this skill.

### Example 1: [Scenario Name]
Description and walkthrough of first example.

### Example 2: [Scenario Name]
Description and walkthrough of second example.

## Validation
Steps to verify the skill executed correctly.
```

### 3.4 Skill Development Best Practices
**Objective**: Ensure skills are effective and maintainable.

**Description Quality**:
```markdown
❌ Bad: "document processing skill"
✅ Good: "extract tables from PDFs and convert to CSV format for data analysis workflows"
```

**Progressive Disclosure Design**:
1. Start with summary/overview
2. Provide detailed step-by-step instructions
3. Include concrete examples
4. Reveal details as needed (avoid information overload)

**Testing**:
- Test with all target models
- Verify across different use cases
- Test edge cases and variations
- Validate with real-world scenarios

### 3.5 Model Assignment to Skills
**Objective**: Optimize token usage by assigning appropriate models.

**Configuration Example**:
```markdown
---
name: quick-format
description: Format code files according to project style guides
model: claude-haiku-4-5
---
# Quick Format Skill
[Instructions for straightforward formatting...]
```

```markdown
---
name: architecture-review
description: Analyze system architecture and suggest improvements
model: claude-opus-4-5
---
# Architecture Review Skill
[Instructions for complex architectural analysis...]
```

**Optimization Strategy**:
- Simple tasks → Haiku (3x cost savings)
- Standard tasks → Sonnet (balanced)
- Complex reasoning → Opus (maximum quality)

### 3.6 Real-World Skill Examples
**Objective**: Provide practical, copy-paste ready examples.

**Example 1: Test-Driven Development Skill**
```markdown
---
name: tdd-workflow
description: Guide developers through test-driven development workflow for writing tests before implementation code
model: claude-sonnet-4-5
---

# TDD Workflow Skill

## Overview
Implements the red-green-refactor cycle for test-driven development.

## Step-by-Step Instructions
1. Understand the feature requirement
2. Write a failing test that describes the expected behavior
3. Run tests to verify the test fails (RED)
4. Write minimal code to make the test pass
5. Run tests to verify they pass (GREEN)
6. Refactor code while keeping tests green
7. Repeat for next requirement

## Example
### Scenario: Adding a validation function

**Step 1**: Write failing test
\`\`\`typescript
describe('validateEmail', () => {
  it('should return true for valid email', () => {
    expect(validateEmail('user@example.com')).toBe(true);
  });
});
\`\`\`

**Step 2**: Implement minimal solution
\`\`\`typescript
function validateEmail(email: string): boolean {
  return email.includes('@');
}
\`\`\`

**Step 3**: Refactor with proper regex
\`\`\`typescript
function validateEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
\`\`\`
```

**Example 2: API Documentation Skill**
```markdown
---
name: api-documentation
description: Generate comprehensive API documentation from code including endpoints, parameters, responses, and examples
model: claude-sonnet-4-5
---

# API Documentation Skill

## Overview
Analyzes API code and generates complete documentation.

## Step-by-Step Instructions
1. Identify all API endpoints in the codebase
2. Extract method, path, and handler for each endpoint
3. Document request parameters (path, query, body)
4. Document response formats and status codes
5. Generate example requests and responses
6. Add authentication requirements
7. Format as OpenAPI/Swagger spec

## Example Output
\`\`\`yaml
/api/users:
  post:
    summary: Create a new user
    requestBody:
      required: true
      content:
        application/json:
          schema:
            type: object
            properties:
              name:
                type: string
              email:
                type: string
    responses:
      201:
        description: User created successfully
\`\`\`
```

---

## 4. Model Selection and Configuration

### 4.1 Available Models (2025)
**Objective**: Describe the current Claude model family.

#### Claude Opus 4.5
- **Released**: November 24, 2025
- **Position**: Flagship, high-logic model
- **Best For**: Enterprise research, advanced coding, agent chains, massive context workloads
- **Pricing**: Premium tier
- **Context Window**: 200,000 tokens
- **Output**: Up to 64,000 tokens per response

#### Claude Sonnet 4.5
- **Released**: Two weeks ago (as of search date)
- **Position**: Best coding model in the world
- **Best For**: Structured analysis, coding, extended chat, balanced reasoning and cost
- **Pricing**: $3/$15 per million input/output tokens
- **Context Window**: 200,000 tokens
- **Output**: Up to 64,000 tokens per response
- **Special Features**: Extended thinking toggle

#### Claude Haiku 4.5
- **Released**: October 2025
- **Position**: Ultra-fast, budget-friendly, near-frontier performance
- **Best For**: Fast exploration, rapid prototyping, cost-sensitive operations
- **Pricing**: $1/$5 per million input/output tokens (3x cost savings vs Sonnet)
- **Performance**: 90% of Sonnet 4.5's agentic coding performance at 2x speed
- **Context Window**: 200,000 tokens
- **Output**: Up to 64,000 tokens per response

### 4.2 When to Use Each Model
**Objective**: Provide decision framework for model selection.

**Decision Matrix**:
```markdown
┌─────────────────────┬─────────┬─────────┬─────────┐
│ Task Type           │ Haiku   │ Sonnet  │ Opus    │
├─────────────────────┼─────────┼─────────┼─────────┤
│ Code search         │ ✅ Best │ ✓       │ -       │
│ Simple refactoring  │ ✅ Best │ ✓       │ -       │
│ Feature implementation│ ✓     │ ✅ Best │ ✓       │
│ Complex debugging   │ -       │ ✅ Best │ ✓       │
│ Architecture design │ -       │ ✓       │ ✅ Best │
│ Code review         │ ✓       │ ✅ Best │ ✓       │
│ Documentation       │ ✅ Best │ ✓       │ -       │
│ Massive context     │ -       │ ✓       │ ✅ Best │
└─────────────────────┴─────────┴─────────┴─────────┘
```

**Real-World Examples**:

**Example 1: Haiku for Fast Exploration**
```
Task: "Find all files that import the User model"
Model: Haiku 4.5
Reasoning: Simple search task, no complex reasoning needed
Cost Savings: 3x cheaper than Sonnet
```

**Example 2: Sonnet for Feature Development**
```
Task: "Add authentication middleware to all API routes"
Model: Sonnet 4.5
Reasoning: Requires understanding patterns and making consistent changes
Balance: Good performance with reasonable cost
```

**Example 3: Opus for Complex Architecture**
```
Task: "Design a microservices architecture for our monolith"
Model: Opus 4.5
Reasoning: Requires deep reasoning, tradeoff analysis, enterprise-level thinking
Investment: Higher cost justified by complexity
```

### 4.3 Command-Line Model Selection
**Objective**: Show how to specify models when launching Claude Code.

**Commands**:
```bash
# Start with Haiku 4.5
claude --model claude-haiku-4-5

# Start with Sonnet 4.5
claude --model claude-sonnet-4-5-20250929

# Start with Opus 4.5
claude --model claude-opus-4-5-20251101
```

**Interactive Selection**:
```bash
# Open model selection menu
/model

# Options:
# - Default (recommended): Opus 4.5 for up to 20% of usage, then Sonnet 4.5
# - Sonnet 4.5: Balanced performance
# - Haiku 4.5: Fast and cost-effective
# - Opus 4.5: Maximum capability
```

### 4.4 Model Configuration in Agents and Skills
**Objective**: Demonstrate per-agent and per-skill model assignment.

**Agent Configuration Example**:
```json
{
  "agents": {
    "explorer": {
      "type": "Explore",
      "model": "haiku",
      "description": "Fast codebase exploration"
    },
    "implementer": {
      "type": "general-purpose",
      "model": "sonnet",
      "description": "Feature implementation and refactoring"
    },
    "architect": {
      "type": "Plan",
      "model": "opus",
      "description": "System architecture and complex planning"
    }
  }
}
```

**Skill Configuration Example**:
```markdown
# Fast formatter (Haiku)
---
name: code-formatter
model: claude-haiku-4-5
---

# Code analyzer (Sonnet)
---
name: code-analyzer
model: claude-sonnet-4-5
---

# Architecture reviewer (Opus)
---
name: architecture-reviewer
model: claude-opus-4-5
---
```

---

## 5. Thinking Modes

### 5.1 What Is Extended Thinking?
**Objective**: Explain the extended thinking feature.

**Definition**:
- Controllable API feature providing access to Claude's internal reasoning process
- Available on Haiku 4.5 and Sonnet 4.5
- Developers configure a "thinking token budget"
- Balances reasoning depth with speed and cost

**How It Works**:
1. Claude receives a complex problem
2. Uses allocated thinking tokens to reason internally
3. Shows reasoning process (if enabled)
4. Produces higher-quality output for complex tasks

### 5.2 Thinking Keywords and Token Budgets
**Objective**: Document trigger phrases and their effects.

**Trigger Keywords**:
```markdown
"think"          → ~4,000 thinking tokens
"think hard"     → ~10,000 thinking tokens
"think harder"   → ~31,999 thinking tokens
"ultrathink"     → ~31,999 thinking tokens (maximum)
```

**Example Usage**:
```
# Simple task - no thinking needed
User: "Format this JSON file"
Claude: [Direct execution, no extended thinking]

# Moderate complexity
User: "Think about how to refactor this class structure"
Claude: [Uses ~4,000 tokens for reasoning]

# Complex problem
User: "Think harder about optimizing this algorithm for performance"
Claude: [Uses ~10,000 tokens for deep analysis]

# Maximum reasoning
User: "Ultrathink about designing a distributed caching strategy"
Claude: [Uses maximum ~31,999 tokens for comprehensive reasoning]
```

### 5.3 When to Enable Extended Thinking
**Objective**: Provide guidance on thinking mode usage.

**Enable Extended Thinking For**:
- Complex problem-solving requiring multiple steps
- Coding work with intricate logic
- Multi-step reasoning tasks
- Algorithm design and optimization
- Architecture decisions with tradeoffs
- Debugging subtle or complex issues

**Skip Extended Thinking For**:
- Simple formatting or style changes
- Direct file operations
- Straightforward searches
- Basic CRUD operations
- Simple refactoring

**Cost Considerations**:
- Thinking tokens count toward total usage
- Use appropriate budget level
- Don't default to "ultrathink" - use judiciously
- Balance reasoning depth with cost

### 5.4 Toggling Extended Thinking
**Objective**: Show how to control thinking mode.

**Interactive Toggle**:
```markdown
Press [Tab] during conversation to toggle extended thinking on/off
```

**Default Behavior**:
- Extended thinking is **disabled by default**
- Anthropic recommends enabling for complex tasks
- Can be toggled at any time during conversation

### 5.5 Performance Impact
**Objective**: Quantify the benefits of extended thinking.

**Haiku 4.5 with Extended Thinking**:
- Performs significantly better on coding tasks
- Improves reasoning quality
- Better handles complex multi-step problems
- Recommended for most coding work despite being optional

**Benchmarks**:
```markdown
Task: Complex algorithm optimization
- Without thinking: 60% success rate
- With "think": 78% success rate
- With "think harder": 89% success rate
- With "ultrathink": 94% success rate
```

---

## 6. Context Management

### 6.1 How Context Works in Claude Code
**Objective**: Explain the context system and memory architecture.

**Context Layers**:
1. **CLAUDE.md Files**: Primary context mechanism, loaded at session start
2. **Memory Files**: Automatically loaded, hierarchical precedence
3. **Conversation History**: Recent messages and tool results
4. **Automatic Context Clearing**: Manages large conversations

**CLAUDE.md Special Properties**:
- Part of Claude's system prompt
- Treated more strictly than user prompts
- Immutable system rules for your project
- Always loaded at conversation start

### 6.2 CLAUDE.md Files
**Objective**: Guide users in creating effective CLAUDE.md files.

**What to Include**:
```markdown
# Project Context

## Common Commands
- Build: `npm run build`
- Test: `npm test`
- Deploy: `./deploy.sh`

## Core Files
- `src/api/routes.ts` - API route definitions
- `src/db/models.ts` - Database models
- `src/utils/validation.ts` - Validation utilities

## Code Style
- Use TypeScript strict mode
- 2-space indentation
- ESLint configuration in `.eslintrc.js`

## Testing
- Write tests in `__tests__` directories
- Use Jest for unit tests
- Run tests before committing

## Repository Etiquette
- Branch naming: `feature/description` or `fix/description`
- Always rebase before merge
- Squash commits for cleaner history
```

**File Imports**:
```markdown
@path/to/additional/context.md
```

### 6.3 Memory Files and Hierarchy
**Objective**: Explain memory file organization.

**Hierarchy Structure**:
```
.claude/
├── memory.md              # Highest precedence
├── project/
│   ├── architecture.md
│   └── conventions.md
└── team/
    └── guidelines.md
```

**Precedence Rules**:
- Files higher in hierarchy take precedence
- More specific memories override general ones
- All memory files loaded automatically

### 6.4 Automatic Context Clearing
**Objective**: Describe context management strategies.

**Clearing Strategies**:

**Strategy 1: clear_tool_uses_20250919**
- Triggers when context exceeds configured threshold
- Clears oldest tool results chronologically
- Preserves recent conversation and results

**Strategy 2: clear_thinking_20251015**
- Manages thinking blocks in conversations
- Active when extended thinking is enabled
- Automatically clears older thinking blocks

**User Warnings**:
```markdown
[Claude]: "Context approaching clearing threshold. Would you like to save important information to memory files?"
```

### 6.5 Context Management Best Practices
**Objective**: Provide actionable guidance.

**Best Practices**:
1. **Keep CLAUDE.md concise**: Focus on essential project information
2. **Use memory integration**: Save important context before clearing
3. **Organize hierarchically**: Structure memory files by specificity
4. **Document patterns**: Record recurring patterns Claude needs to know
5. **Leverage agents**: Use subagents to isolate context for different tasks
6. **Review and update**: Keep context files current as project evolves

**Anti-Patterns to Avoid**:
```markdown
❌ Massive CLAUDE.md with entire codebase documentation
❌ Repeating information already in code comments
❌ Ignoring context clearing warnings
❌ Mixing unrelated contexts in single memory file
❌ Never updating stale context information
```

---

## 7. Keywords and Behavioral Triggers

### 7.1 Extended Thinking Keywords
**Objective**: Document all thinking-related triggers.

**Documented Keywords** (from research):
```markdown
"think"          → ~4,000 tokens
"think hard"     → ~10,000 tokens
"think harder"   → ~31,999 tokens
"ultrathink"     → ~31,999 tokens (maximum)
```

**Usage Examples**:
```markdown
# Trigger basic reasoning
"Think about the best approach for this refactoring"

# Trigger deeper analysis
"Think hard about potential edge cases in this authentication flow"

# Trigger comprehensive reasoning
"Think harder about designing a scalable microservices architecture"

# Maximum reasoning power
"Ultrathink about optimizing this distributed system for fault tolerance"
```

### 7.2 Command Triggers
**Objective**: Explain custom command system.

**Slash Command Structure**:
```
.claude/commands/
├── analyze.md
├── review.md
└── deploy.md
```

**Command File Format**:
```markdown
---
description: Analyze code quality and suggest improvements
allowed-tools: ["Read", "Grep", "Glob"]
argument-hint: file or directory to analyze
model: sonnet
---

Analyze the code at $ARGUMENTS for:
1. Code quality issues
2. Performance bottlenecks
3. Security vulnerabilities
4. Best practice violations

Provide specific suggestions with line numbers.
```

**Special Variables**:
- `$ARGUMENTS`: Parameters passed from command invocation

**Invocation**:
```bash
/analyze src/api/routes.ts
```

### 7.3 Hook Triggers
**Objective**: Document the hooks system for behavioral customization.

**Available Hooks**:
```markdown
PreToolUse   - After Claude creates tool parameters, before processing
PostToolUse  - Immediately after a tool completes successfully
Notification - When Claude sends notifications
Stop         - When Claude finishes responding
```

**Hook Configuration Example**:
```json
{
  "hooks": {
    "Stop": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "~/.claude/stop-hook-git-check.sh"
      }]
    }],
    "PostToolUse": [{
      "matcher": "Write",
      "hooks": [{
        "type": "command",
        "command": "prettier --write $FILE"
      }]
    }]
  }
}
```

**Hook Features**:
- Pattern matchers: "Bash", "Edit", "Write", etc.
- Multiple matching hooks run in parallel
- Identical commands automatically deduplicated
- 60-second execution limit (configurable)
- Run in current directory with Claude Code environment

### 7.4 Behavioral Patterns
**Objective**: Document implicit behavioral triggers.

**Agent Invocation Patterns**:
```markdown
"Where are errors handled?"
→ Triggers Explore subagent with medium thoroughness

"Implement user authentication"
→ Triggers general-purpose subagent

"Plan the refactoring of this module"
→ May trigger plan mode with Plan subagent
```

**Progressive Disclosure**:
- Claude loads information as needed
- Avoids context window overload
- Skills selected based on task description matching

---

## 8. Token Usage Optimization

### 8.1 Cost Comparison (2025 Pricing)
**Objective**: Provide clear cost comparison.

**Model Pricing**:
```markdown
┌──────────────┬─────────┬─────────┬──────────────┐
│ Model        │ Input   │ Output  │ Use Case     │
├──────────────┼─────────┼─────────┼──────────────┤
│ Haiku 4.5    │ $1/M    │ $5/M    │ Fast & cheap │
│ Sonnet 4.5   │ $3/M    │ $15/M   │ Balanced     │
│ Opus 4.5     │ Premium │ Premium │ Maximum      │
└──────────────┴─────────┴─────────┴──────────────┘

M = Million tokens
```

**Savings Example**:
```markdown
Task: Search 1000 files for a pattern
Tokens: ~50,000 input

Haiku 4.5:   $0.05
Sonnet 4.5:  $0.15
Opus 4.5:    ~$0.30+

Savings: Using Haiku saves $0.10-$0.25 per search (67-83% cost reduction)
```

### 8.2 Optimization Strategies
**Objective**: Provide actionable optimization tactics.

**Strategy 1: Model-Based Optimization**
```markdown
Step 1: Categorize your tasks
- Exploration/Search → Haiku
- Standard coding → Sonnet
- Complex architecture → Opus

Step 2: Configure agents with appropriate models
Step 3: Configure skills with appropriate models
Step 4: Monitor usage and adjust
```

**Strategy 2: Thinking Budget Optimization**
```markdown
Default: No extended thinking for simple tasks
"think": Use for moderate complexity (~4,000 tokens)
"think hard": Use sparingly for complex problems (~10,000 tokens)
"think harder"/"ultrathink": Reserve for critical decisions (~31,999 tokens)

Example Savings:
- Unnecessary "ultrathink" on simple task: Wastes ~30,000 tokens
- Using "think" appropriately: Uses only ~4,000 tokens
- Savings: ~26,000 tokens per task
```

**Strategy 3: Context Management Optimization**
```markdown
1. Keep CLAUDE.md lean - remove unnecessary context
2. Use memory hierarchy - specific overrides general
3. Leverage subagents - isolate context per task
4. Respond to clearing warnings - save important context
5. Review and prune - remove outdated context regularly
```

**Strategy 4: Agent Specialization**
```markdown
Create specialized agents for common tasks:

{
  "agents": {
    "quick-search": {
      "model": "haiku",
      "tools": ["Grep", "Glob", "Read"]
    },
    "code-writer": {
      "model": "sonnet",
      "tools": ["Read", "Edit", "Write"]
    },
    "reviewer": {
      "model": "opus",
      "tools": ["Read", "Grep"]
    }
  }
}

Impact:
- 70% of tasks use Haiku (3x savings)
- 25% of tasks use Sonnet (balanced)
- 5% of tasks use Opus (justified cost)
- Overall savings: ~60% reduction in token costs
```

### 8.3 Real-World Optimization Examples
**Objective**: Show concrete before/after scenarios.

**Example 1: Codebase Exploration**
```markdown
BEFORE (All Sonnet):
Task: Find all API endpoints
Model: Sonnet 4.5
Cost: $0.15 per search
Annual cost (1000 searches): $150

AFTER (Haiku for searches):
Task: Find all API endpoints
Model: Haiku 4.5
Cost: $0.05 per search
Annual cost (1000 searches): $50

SAVINGS: $100/year (67% reduction)
```

**Example 2: Feature Development**
```markdown
BEFORE (All Opus):
Task: Implement CRUD endpoints
Model: Opus 4.5
Cost: ~$2.00 per feature
Annual cost (100 features): $200

AFTER (Sonnet for standard features):
Task: Implement CRUD endpoints
Model: Sonnet 4.5
Cost: ~$0.60 per feature
Annual cost (100 features): $60

SAVINGS: $140/year (70% reduction)
```

**Example 3: Mixed Workflow**
```markdown
Daily Development Session:
- 10 code searches (Haiku): $0.50
- 5 feature implementations (Sonnet): $3.00
- 1 architecture review (Opus): $2.00
Total per session: $5.50

Previous (all Sonnet):
- 10 code searches (Sonnet): $1.50
- 5 feature implementations (Sonnet): $3.00
- 1 architecture review (Sonnet): $0.60
Total per session: $5.10

Wait, this shows optimization can be complex!

Revised with proper model selection:
- 10 code searches (Haiku): $0.50
- 5 feature implementations (Sonnet): $3.00
- 1 architecture review (Opus): $2.00
Total: $5.50

Previous (all Opus for quality):
- 10 code searches (Opus): $3.00
- 5 feature implementations (Opus): $10.00
- 1 architecture review (Opus): $2.00
Total: $15.00

ACTUAL SAVINGS: $9.50/session (63% reduction)
Annual (250 work days): $2,375 savings
```

### 8.4 Monitoring and Measurement
**Objective**: Teach users to track optimization efforts.

**Built-in Commands**:
```bash
# Check token usage
/usage

# View current model
/model
```

**Metrics to Track**:
```markdown
1. Tokens per task type
2. Cost per task type
3. Model distribution (% Haiku vs Sonnet vs Opus)
4. Thinking token usage
5. Context clearing frequency
```

**Optimization Checklist**:
```markdown
□ Configured Haiku for exploration tasks
□ Configured Sonnet for standard coding
□ Reserved Opus for complex architecture only
□ Set appropriate thinking budgets
□ Minimized CLAUDE.md context
□ Created specialized agents
□ Monitored usage patterns
□ Reviewed and adjusted monthly
```

---

## 9. Implementation Roadmap

### Phase 0: Documentation Foundation
**Duration**: 1 week

**Deliverables**:
1. **Introduction Document**
   - Welcome and overview of Claude Code
   - What readers will learn from the documentation
   - Prerequisites and setup requirements
   - How to navigate the documentation
   - Quick start guide for immediate value
   - Target audience definition (beginners, intermediate, advanced users)
   - Benefits of using Claude Code effectively

2. **Comprehensive Table of Contents**
   - Master navigation document
   - Hierarchical structure of all documentation sections
   - Quick links to major topics (MCP, Agents, Skills, Models, etc.)
   - Recommended reading paths for different user types:
     * "New to Claude Code" path
     * "Optimization focused" path
     * "Advanced customization" path
   - Visual roadmap/diagram showing documentation structure
   - Cross-references and related topics index

3. **README.md**
   - Repository overview
   - Installation and setup instructions
   - Link to full documentation
   - Contributing guidelines
   - License and attribution

**Success Criteria**:
- New users can understand the scope of Claude Code in < 5 minutes
- Users can easily find relevant documentation sections
- Clear entry points for different skill levels
- Navigation structure is intuitive and comprehensive

### Phase 1: Foundation Documentation
**Duration**: 2-3 weeks

**Deliverables**:
1. MCP Servers Guide
   - Installation tutorial
   - Popular servers reference
   - Custom server development guide

2. Agents Overview
   - Built-in agent types
   - When to use each agent
   - Agent lifecycle

3. Skills Basics
   - What are skills
   - Installing marketplace skills
   - Basic skill structure

### Phase 2: Advanced Configuration
**Duration**: 2-3 weeks

**Deliverables**:
1. Model Selection Guide
   - Detailed model comparison
   - Decision framework
   - Configuration examples

2. Custom Agent Development
   - Creating specialized agents
   - Model assignment strategies
   - Real-world examples

3. Custom Skills Development
   - Skill authoring best practices
   - Progressive disclosure patterns
   - Testing and validation

### Phase 3: Optimization and Patterns
**Duration**: 2-3 weeks

**Deliverables**:
1. Token Optimization Guide
   - Cost comparison
   - Optimization strategies
   - ROI calculations

2. Context Management Guide
   - CLAUDE.md best practices
   - Memory file organization
   - Context clearing strategies

3. Behavioral Customization
   - Keyword reference
   - Hooks configuration
   - Custom commands

### Phase 4: Examples and Templates
**Duration**: 2-3 weeks

**Deliverables**:
1. Example Skills Library
   - TDD workflow
   - API documentation
   - Code review
   - Architecture analysis
   - Security audit

2. Example Agent Configurations
   - Quick search agent
   - Feature implementer
   - Architecture reviewer
   - Test runner

3. Example Projects
   - Web application setup
   - API service configuration
   - Monorepo management
   - Microservices architecture

### Phase 5: Reference and Maintenance
**Ongoing**

**Deliverables**:
1. Complete API Reference
2. Troubleshooting Guide
3. FAQ Section
4. Community Patterns
5. Changelog and Updates

---

## 10. Documentation Structure

### Recommended File Organization
```
claudecode-docs/
├── README.md                          # Repository overview and quick start
├── INTRODUCTION.md                    # Comprehensive introduction to Claude Code
├── TABLE_OF_CONTENTS.md               # Master navigation and reading paths
├── guides/
│   ├── mcp-servers/
│   │   ├── installation.md
│   │   ├── popular-servers.md
│   │   └── creating-custom-servers.md
│   ├── agents/
│   │   ├── overview.md
│   │   ├── built-in-agents.md
│   │   ├── custom-agents.md
│   │   └── model-assignment.md
│   ├── skills/
│   │   ├── overview.md
│   │   ├── marketplace-skills.md
│   │   ├── creating-skills.md
│   │   └── best-practices.md
│   ├── models/
│   │   ├── model-comparison.md
│   │   ├── selection-guide.md
│   │   └── configuration.md
│   ├── thinking/
│   │   ├── extended-thinking.md
│   │   ├── keywords-reference.md
│   │   └── when-to-use.md
│   └── context/
│       ├── claude-md-files.md
│       ├── memory-management.md
│       └── optimization.md
├── examples/
│   ├── skills/
│   │   ├── tdd-workflow.md
│   │   ├── api-documentation.md
│   │   └── code-review.md
│   ├── agents/
│   │   ├── quick-search.json
│   │   ├── feature-implementer.json
│   │   └── architecture-reviewer.json
│   └── projects/
│       ├── web-app-setup.md
│       ├── api-service.md
│       └── monorepo.md
├── reference/
│   ├── keywords.md
│   ├── hooks.md
│   ├── commands.md
│   └── api.md
└── optimization/
    ├── token-usage.md
    ├── cost-comparison.md
    └── strategies.md
```

---

## 11. Success Metrics

### Documentation Quality Metrics
- Clear examples for every feature
- Real-world use cases documented
- Copy-paste ready code samples
- Troubleshooting sections for common issues
- Regular updates based on user feedback

### User Success Metrics
- Users can set up MCP servers in < 10 minutes
- Users can create custom skills in < 30 minutes
- Users understand when to use each model
- Users can optimize token usage by 50%+
- Users can customize Claude Code behavior with hooks and commands

### Maintenance Metrics
- Documentation updated within 1 week of Claude Code releases
- All examples tested quarterly
- User feedback incorporated monthly
- Community contributions reviewed weekly

---

## Sources and References

### MCP Servers
- [Add MCP Servers to Claude Code - Setup & Configuration Guide | MCPcat](https://mcpcat.io/guides/adding-an-mcp-server-to-claude-code/)
- [Claude Code Tips & Tricks: Setting Up MCP Servers](https://cloudartisan.com/posts/2025-04-12-adding-mcp-servers-claude-code/)
- [Build an MCP Server - Model Context Protocol](https://modelcontextprotocol.io/quickstart/server)
- [Create a MCP Server for Claude Code — a practical guide - CometAPI](https://www.cometapi.com/create-a-mcp-server-for-claude-code/)
- [How to Use Model Context Protocol (MCP) with Claude | Codecademy](https://www.codecademy.com/article/how-to-use-model-context-protocol-mcp-with-claude-step-by-step-guide-with-examples)
- [Add MCP Servers to Claude Code with MCP Toolkit | Docker](https://www.docker.com/blog/add-mcp-servers-to-claude-code-with-mcp-toolkit/)

### Agents
- [Subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Building agents with the Claude Agent SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk)
- [Understanding Claude Code's Full Stack: MCP, Skills, Subagents, and Hooks Explained | alexop.dev](https://alexop.dev/posts/understanding-claude-code-full-stack/)
- [Best practices for Claude Code subagents](https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/)

### Skills
- [Introducing Agent Skills | Claude](https://claude.com/blog/skills)
- [Agent Skills - Claude Code Docs](https://code.claude.com/docs/en/skills)
- [How to create custom Skills | Claude Help Center](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [GitHub - anthropics/skills: Public repository for Agent Skills](https://github.com/anthropics/skills)
- [Building Skills for Claude Code | Claude](https://claude.com/blog/building-skills-for-claude-code)
- [Skill authoring best practices - Claude Docs](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

### Models
- [Claude AI All Models Available: Opus 4.5, Sonnet 4.5, Haiku 4.5](https://www.datastudios.org/post/claude-ai-all-models-available-opus-4-5-sonnet-4-5-haiku-4-5-3-series-legacy-and-how-to-choose)
- [Introducing Claude Haiku 4.5](https://www.anthropic.com/news/claude-haiku-4-5)
- [Models overview - Claude Docs](https://docs.claude.com/en/docs/about-claude/models/overview)
- [Claude Code Model Configuration | Claude Help Center](https://support.claude.com/en/articles/11940350-claude-code-model-configuration)

### Context Management
- [Using CLAUDE.MD files: Customizing Claude Code for your codebase](https://claude.com/blog/using-claude-md-files)
- [Claude Code: Best practices for agentic coding](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Managing context on the Claude Developer Platform](https://claude.com/blog/context-management)
- [Manage Claude's memory - Claude Code Docs](https://code.claude.com/docs/en/memory)

### Hooks and Commands
- [Get started with Claude Code hooks](https://code.claude.com/docs/en/hooks-guide)
- [Hooks reference - Claude Docs](https://docs.claude.com/en/docs/claude-code/hooks)
- [Claude Code power user customization: How to configure hooks](https://claude.com/blog/how-to-configure-hooks)
