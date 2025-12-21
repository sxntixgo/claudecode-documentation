# Troubleshooting Guide

**Reading Time**: 35 minutes
**Skill Level**: All levels
**Prerequisites**: Basic familiarity with Claude Code

---

## Welcome to Troubleshooting! 🔧

Encountering issues is a normal part of working with any tool. This guide provides step-by-step solutions to common Claude Code problems, organized by category for quick navigation.

**How to Use This Guide**:
1. Find your issue category below
2. Locate the specific problem
3. Follow the resolution steps
4. Check prevention strategies to avoid future occurrences

---

## Table of Contents

1. [MCP Server Issues](#mcp-server-issues)
2. [Agent and Subagent Issues](#agent-and-subagent-issues)
3. [Skill Loading Issues](#skill-loading-issues)
4. [Token and Cost Issues](#token-and-cost-issues)
5. [Configuration Issues](#configuration-issues)
6. [Git and Version Control Issues](#git-and-version-control-issues)
7. [Performance Issues](#performance-issues)
8. [Installation and Setup Issues](#installation-and-setup-issues)

---

## MCP Server Issues

### Issue: MCP Server Not Loading

**Symptoms**:
- Server doesn't appear in `claude mcp list`
- Tools from server not available
- No error message, server silently fails

**Common Causes**:
1. Server not properly configured
2. Installation incomplete
3. Dependencies missing
4. Configuration file syntax errors

**Resolution Steps**:

**Step 1: Verify Installation**
```bash
# Check if server is listed
claude mcp list

# Expected output should include your server
# If not listed, server not installed
```

**Step 2: Check Configuration**
```bash
# View configuration file (macOS)
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Linux
cat ~/.config/claude/claude_desktop_config.json
```

**Step 3: Validate JSON Syntax**
```bash
# Use jq to validate JSON
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq .

# If syntax error, jq will show the line number
```

**Step 4: Reinstall Server**
```bash
# Remove server
claude mcp remove server-name

# Re-add server
claude mcp add server-name --scope user
```

**Step 5: Restart Claude Code**
```bash
# Complete restart required for MCP servers
# Close all Claude windows and restart
```

**Prevention**:
- Always validate JSON after editing config files
- Use `claude mcp add` instead of manual editing when possible
- Keep server dependencies up-to-date

---

### Issue: MCP Server Authentication Failure

**Symptoms**:
- Error: "Authentication failed"
- Error: "Invalid credentials"
- Server loads but tools don't work

**Common Causes**:
- Missing or incorrect API tokens
- Environment variables not set
- Token expired or revoked
- Incorrect token format

**Resolution Steps**:

**Step 1: Check Environment Variables**
```bash
# Check if token is set
echo $GITHUB_TOKEN
echo $GITHUB_PERSONAL_ACCESS_TOKEN

# If empty, token not set
```

**Step 2: Set Token in Configuration**
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your-token-here"
      }
    }
  }
}
```

**Step 3: Verify Token Validity**
```bash
# Test GitHub token
curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/user

# Should return your user info, not 401 Unauthorized
```

**Step 4: Create New Token** (if expired)
1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Generate new token with required scopes
3. Update configuration with new token
4. Restart Claude Code

**Prevention**:
- Store tokens in environment variables, not hardcoded
- Set token expiration dates you can remember
- Document required token scopes in project README
- Use token management tools (e.g., `gh auth`)

---

### Issue: MCP Server Timeout

**Symptoms**:
- Error: "Server timeout after 30s"
- Long delays before operations
- Intermittent failures

**Common Causes**:
- Slow network connection
- Server overloaded
- Large data transfers
- Inefficient server implementation

**Resolution Steps**:

**Step 1: Increase Timeout**

Edit config to increase timeout:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["server.js"],
      "timeout": 60000  // Increase to 60 seconds
    }
  }
}
```

**Step 2: Check Network Connection**
```bash
# Test connectivity to external services
ping github.com
curl -I https://api.github.com

# If slow or failing, network issue
```

**Step 3: Optimize Server Calls**
- Reduce data payload size
- Use pagination for large datasets
- Implement caching where possible
- Batch requests when supported

**Prevention**:
- Set realistic timeouts based on server complexity
- Implement server-side caching
- Use CDN for static assets
- Monitor server performance

---

## Agent and Subagent Issues

### Issue: Agent Timeout Errors

**Symptoms**:
- Error: "Agent execution timed out"
- Agent stops mid-task
- Incomplete operations

**Common Causes**:
- Default timeout too short
- Complex task requires more time
- Infinite loops in agent logic
- Resource constraints

**Resolution Steps**:

**Step 1: Increase Agent Timeout**

In `.claude/config.json`:
```json
{
  "agents": {
    "general-purpose": {
      "timeout": 300000  // 5 minutes instead of default 2 minutes
    }
  }
}
```

**Step 2: Break Down Task**
Instead of one large task, split into smaller subtasks:
```
❌ Bad:  "Refactor entire codebase to TypeScript"
✅ Good: "Refactor src/utils to TypeScript"
         "Refactor src/components to TypeScript"
         "Refactor src/api to TypeScript"
```

**Step 3: Use Appropriate Agent**
- Explore agent: Read-only searches (faster)
- General-purpose: Complex multi-step tasks (allow more time)
- Plan agent: Planning and research (may need extended time)

**Prevention**:
- Configure timeouts based on typical task complexity
- Monitor agent execution times
- Optimize task scope to be specific and focused
- Use simpler agents (Haiku) for routine tasks

---

### Issue: Agent Not Using Correct Model

**Symptoms**:
- Haiku used when Opus expected
- Higher costs than anticipated
- Lower quality output than expected

**Common Causes**:
- Model not specified in agent config
- Task override not working
- Config file not loaded

**Resolution Steps**:

**Step 1: Verify Agent Configuration**

Check `.claude/config.json`:
```json
{
  "agents": {
    "Explore": {
      "model": "haiku"  // ✓ Correctly specified
    },
    "general-purpose": {
      // ❌ No model specified, uses default
    }
  }
}
```

**Step 2: Add Model Assignment**
```json
{
  "agents": {
    "Explore": {
      "model": "haiku"
    },
    "general-purpose": {
      "model": "sonnet"  // ✓ Now specified
    },
    "Plan": {
      "model": "opus"
    }
  }
}
```

**Step 3: Verify Config Loading**
```bash
# Check if config file exists
ls -la .claude/config.json

# Validate JSON syntax
cat .claude/config.json | jq .

# Restart Claude to load new config
```

**Step 4: Use Task-Specific Override**
```javascript
// Override model for specific task
Task({
  subagent_type: "general-purpose",
  model: "opus",  // Force Opus for this specific task
  prompt: "Design complex authentication system"
})
```

**Prevention**:
- Always specify `model` in agent configurations
- Set `defaultModel` in config as fallback
- Document model assignments in CLAUDE.md
- Monitor cost logs to verify model usage

---

## Skill Loading Issues

### Issue: Skill Not Being Invoked

**Symptoms**:
- Skill exists but Claude doesn't use it
- Manual invocation works, automatic doesn't
- Claude uses inline logic instead of skill

**Common Causes**:
- Skill description too vague
- Description doesn't match task keywords
- Skill not in correct directory
- SKILL.md format errors

**Resolution Steps**:

**Step 1: Check Skill Location**
```bash
# Skills must be in .claude/skills/
ls -la .claude/skills/

# Verify skill directory structure
tree .claude/skills/my-skill/
# Should show:
# .claude/skills/my-skill/
# └── SKILL.md
```

**Step 2: Improve Skill Description**

❌ **Bad Description** (too vague):
```yaml
---
name: document-skill
description: Helps with documents
---
```

✅ **Good Description** (specific, keyword-rich):
```yaml
---
name: api-documentation
description: Generate comprehensive API documentation from code including REST endpoints, request/response schemas, authentication methods, and example usage with curl commands
---
```

**Step 3: Add Keywords**
```yaml
---
name: api-documentation
description: Generate comprehensive API documentation from code including REST endpoints, request/response schemas, authentication methods, and example usage
tags: ["documentation", "api", "rest", "swagger", "openapi"]
---
```

**Step 4: Test Skill Invocation**
```bash
# Try task that should match skill
You: "Generate API documentation for src/api/routes.ts"

# Claude should mention using your skill
# If not, description needs improvement
```

**Prevention**:
- Use specific, keyword-rich descriptions
- Include file types and technologies in description
- Test skill invocation with realistic tasks
- Add tags for better discoverability

---

### Issue: Skill Progressive Disclosure Not Working

**Symptoms**:
- Entire skill loaded at once
- Context window fills quickly
- Skill instructions too verbose

**Common Causes**:
- Skill structure not optimized for progressive disclosure
- All details in one section
- No clear phase separation

**Resolution Steps**:

**Step 1: Restructure Skill with Phases**

❌ **Bad Structure** (everything at once):
```markdown
# My Skill

Do step 1, then step 2, then step 3, then step 4, then step 5...
[All 50 steps in one block]
```

✅ **Good Structure** (progressive):
```markdown
# My Skill

## Overview
Brief 1-2 sentence purpose

## Phase 1: Initial Setup
1-3 steps for initial phase

## Phase 2: Core Implementation
[Revealed only when Phase 1 complete]

## Phase 3: Validation
[Revealed only when Phase 2 complete]
```

**Step 2: Use Collapsible Sections**
```markdown
## Examples

<details>
<summary>Example 1: Basic Usage</summary>

[Detailed example shown only when needed]
</details>

<details>
<summary>Example 2: Advanced Usage</summary>

[Detailed advanced example]
</details>
```

**Step 3: External References**
```markdown
## Further Reading

For advanced patterns, see:
- [Link to external detailed guide]
- [Link to video tutorial]

These are loaded only if Claude needs deeper context.
```

**Prevention**:
- Structure skills in progressive phases
- Use summaries before detailed sections
- Link to external resources for deep dives
- Test skill with various complexity levels

---

## Token and Cost Issues

### Issue: Unexpected High Token Usage

**Symptoms**:
- Daily budget exceeded quickly
- Higher costs than expected
- Token usage doesn't match task complexity

**Common Causes**:
- Using Opus for simple tasks
- Extended thinking enabled unnecessarily
- Large context windows
- Repeated operations

**Resolution Steps**:

**Step 1: Check Model Usage**
```bash
# Review cost log if enabled
cat .claude/cost-log.json

# Look for:
# - Which models used most
# - Which tasks consumed most tokens
# - Patterns in high-cost operations
```

**Step 2: Optimize Model Assignment**
```json
{
  "agents": {
    "Explore": {
      "model": "haiku"  // Change from sonnet/opus
    },
    "general-purpose": {
      "model": "sonnet"  // Change from opus if possible
    }
  }
}
```

**Step 3: Disable Extended Thinking for Simple Tasks**
```bash
# Instead of:
You: "Think hard about formatting this JSON"

# Use:
You: "Format this JSON"  # No thinking keywords
```

**Step 4: Reduce Context Size**
- Keep CLAUDE.md concise (remove unnecessary sections)
- Use memory hierarchy to defer detailed context
- Clear conversation history periodically
- Use focused agents with path constraints

**Prevention**:
- Enable cost tracking in config.json
- Set daily budgets with alerts
- Review token usage weekly
- Use Haiku by default, upgrade only when needed

---

### Issue: Context Window Exceeded

**Symptoms**:
- Error: "Context window limit reached"
- Claude can't load all necessary files
- Truncated responses

**Common Causes**:
- CLAUDE.md too large
- Too many large files in context
- Conversation history too long
- Memory files accumulated

**Resolution Steps**:

**Step 1: Reduce CLAUDE.md Size**
```bash
# Check current size
wc -l .claude/CLAUDE.md

# If > 500 lines, too large
# Move details to separate files and import
```

**Before** (too large):
```markdown
# CLAUDE.md

## Entire Project Architecture
[5000 lines of detailed documentation]

## Every API Endpoint
[Detailed specs for 100 endpoints]

## Complete Database Schema
[All 50 tables documented]
```

**After** (optimized):
```markdown
# CLAUDE.md

## Project Overview
Brief description and key commands

## Architecture
See @docs/architecture.md for details

## API Reference
See @docs/api-spec.md for endpoints

## Database
See @docs/database-schema.md for schema
```

**Step 2: Use Focused Agents**
```json
{
  "agents": {
    "frontend-only": {
      "constraints": {
        "allowedPaths": ["src/frontend/**"],
        "deniedPaths": ["src/backend/**", "docs/**"]
      }
    }
  }
}
```

**Step 3: Clear Conversation History**
```bash
# Use /clear command or start new session
# Saves important context to memory first
```

**Prevention**:
- Keep CLAUDE.md under 300 lines
- Use file imports for detailed docs
- Implement memory hierarchy
- Start new sessions for unrelated tasks
- Use path-constrained agents

---

## Configuration Issues

### Issue: config.json Syntax Errors

**Symptoms**:
- Error: "Failed to parse config.json"
- Configuration not loading
- Changes not taking effect

**Common Causes**:
- Missing commas
- Trailing commas
- Unquoted keys
- Incorrect nesting

**Resolution Steps**:

**Step 1: Validate JSON**
```bash
# Use jq to find syntax errors
cat .claude/config.json | jq .

# Error will show line number and issue
# Example: "parse error: Expected separator between values at line 12"
```

**Step 2: Common Syntax Fixes**

❌ **Missing comma**:
```json
{
  "agents": {
    "Explore": {"model": "haiku"}  // ❌ Missing comma
    "general-purpose": {"model": "sonnet"}
  }
}
```

✅ **Fixed**:
```json
{
  "agents": {
    "Explore": {"model": "haiku"},  // ✓ Comma added
    "general-purpose": {"model": "sonnet"}
  }
}
```

❌ **Trailing comma**:
```json
{
  "agents": {
    "Explore": {"model": "haiku"},
  },  // ❌ Trailing comma
}
```

✅ **Fixed**:
```json
{
  "agents": {
    "Explore": {"model": "haiku"}
  }
}
```

**Step 3: Use JSON Linter**
```bash
# Install jsonlint
npm install -g jsonlint

# Validate config
jsonlint .claude/config.json
```

**Prevention**:
- Use JSON-aware editor (VS Code, vim with plugins)
- Validate after each edit
- Keep formatted with proper indentation
- Use version control to track changes

---

### Issue: CLAUDE.md Not Being Loaded

**Symptoms**:
- Instructions in CLAUDE.md ignored
- Claude doesn't follow project conventions
- Context not available

**Common Causes**:
- File in wrong location
- Filename incorrect (case-sensitive)
- File encoding issues
- Too large to load

**Resolution Steps**:

**Step 1: Verify File Location**
```bash
# CLAUDE.md must be in project root or .claude/
ls -la CLAUDE.md
ls -la .claude/CLAUDE.md

# File must be named exactly "CLAUDE.md" (all caps)
```

**Step 2: Check File Encoding**
```bash
# Must be UTF-8 encoded
file CLAUDE.md

# Should show: "UTF-8 Unicode text"
# If not, convert:
iconv -f ISO-8859-1 -t UTF-8 CLAUDE.md > CLAUDE_utf8.md
mv CLAUDE_utf8.md CLAUDE.md
```

**Step 3: Verify File Size**
```bash
# Check size
wc -l CLAUDE.md

# If > 1000 lines, may be too large
# Consider splitting into imported files
```

**Step 4: Test Loading**
```bash
# Start new Claude session and ask
You: "What are the common commands for this project?"

# Claude should reference CLAUDE.md content
# If not, file not loaded
```

**Prevention**:
- Use exact filename: CLAUDE.md (not claude.md or Claude.md)
- Place in project root or .claude/ directory
- Keep file size reasonable (< 500 lines)
- Use UTF-8 encoding

---

## Git and Version Control Issues

### Issue: Hooks Blocking Git Operations

**Symptoms**:
- Git commit fails with hook error
- Git push rejected
- Hook timeout errors

**Common Causes**:
- Hook script errors
- Insufficient permissions
- Hook timeout too short
- Missing dependencies

**Resolution Steps**:

**Step 1: Identify Failing Hook**
```bash
# Check hook configuration
cat .claude/config.json | jq .hooks

# Run git operation with verbose output
GIT_TRACE=1 git commit -m "test"
```

**Step 2: Test Hook Directly**
```bash
# Make hook script executable
chmod +x ~/.claude/stop-hook-git-check.sh

# Run hook manually
~/.claude/stop-hook-git-check.sh

# Check exit code
echo $?
# Should be 0 for success, non-zero indicates error
```

**Step 3: Debug Hook Script**

Add debugging to hook:
```bash
#!/bin/bash
set -x  # Enable debugging

# Your hook logic here
echo "Running git check hook..."

# ...rest of script
```

**Step 4: Increase Timeout**
```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "command",
        "command": "~/.claude/stop-hook-git-check.sh",
        "timeout": 120000  // Increase to 2 minutes
      }]
    }]
  }
}
```

**Step 5: Temporarily Disable Hook**
```json
{
  "hooks": {
    // Comment out or remove problematic hook
    // "Stop": [...]
  }
}
```

**Prevention**:
- Test hooks before adding to config
- Set appropriate timeouts
- Add error handling to hook scripts
- Log hook execution for debugging
- Document hook dependencies

---

### Issue: Branch Naming Conflicts

**Symptoms**:
- Error: "Branch name does not match required pattern"
- Git push fails with 403 error
- Cannot push to remote

**Common Causes**:
- Branch doesn't follow naming convention
- Session ID mismatch
- Protected branch restrictions

**Resolution Steps**:

**Step 1: Check Branch Naming Requirements**
```bash
# Some repositories require specific patterns
# Example: branch must start with 'claude/' and end with session ID

# Check current branch
git branch --show-current

# Example required format: claude/feature-name-{session-id}
```

**Step 2: Rename Branch**
```bash
# If branch name incorrect, rename
git branch -m old-branch-name claude/feature-name-abc123

# Push to new branch name
git push -u origin claude/feature-name-abc123
```

**Step 3: Check Protected Branches**
```bash
# Cannot push directly to main/master in many repos
# Create feature branch instead

# Check current branch
git branch --show-current

# If on main/master, create feature branch
git checkout -b claude/my-feature-abc123
```

**Prevention**:
- Follow repository branch naming conventions
- Create feature branches, don't push to main
- Document branch naming in CLAUDE.md
- Use git aliases for standard branch creation

---

## Performance Issues

### Issue: Slow Response Times

**Symptoms**:
- Long delays before responses
- Operations take minutes instead of seconds
- Frequent timeouts

**Common Causes**:
- Using Opus for simple tasks
- Large context windows
- Network latency
- Complex operations

**Resolution Steps**:

**Step 1: Use Faster Model**
```json
{
  "agents": {
    "Explore": {
      "model": "haiku"  // 2x faster than Sonnet
    }
  },
  "defaultModel": "haiku"
}
```

**Step 2: Reduce Context**
- Clear conversation history
- Reduce CLAUDE.md size
- Use focused agents
- Remove unnecessary memory files

**Step 3: Optimize Tasks**
```bash
# Instead of:
You: "Think harder about searching all files for patterns"

# Use:
You: "Search src/**/*.ts for 'async function'"  # Specific, no extended thinking
```

**Step 4: Use Parallel Operations**
```bash
# When possible, batch independent operations
# Claude can execute multiple tool calls in parallel
```

**Prevention**:
- Default to Haiku, upgrade only when needed
- Keep context minimal
- Use specific, focused prompts
- Avoid extended thinking for simple tasks
- Monitor response time patterns

---

### Issue: High Memory Usage

**Symptoms**:
- System slow when Claude running
- Out of memory errors
- Application crashes

**Common Causes**:
- Large conversation history
- Many concurrent agents
- Memory leaks in MCP servers
- Large file operations

**Resolution Steps**:

**Step 1: Clear Conversation History**
```bash
# Start fresh session
# Save important context to memory files first
```

**Step 2: Restart MCP Servers**
```bash
# Restart Claude Code completely
# Closes and reopens all MCP servers
```

**Step 3: Limit File Sizes**
```json
{
  "agents": {
    "safe-agent": {
      "constraints": {
        "maxFileSize": 1048576  // 1MB limit
      }
    }
  }
}
```

**Step 4: Monitor System Resources**
```bash
# macOS
top -o mem

# Linux
htop

# Look for Claude or MCP server processes using excessive memory
```

**Prevention**:
- Start new sessions periodically
- Use file size constraints
- Monitor system resources
- Report memory leaks to MCP server developers

---

## Installation and Setup Issues

### Issue: Claude Code Not Installing

**Symptoms**:
- Installation fails
- Command not found: claude
- Permission denied errors

**Resolution Steps**:

**Step 1: Check System Requirements**
- macOS 10.15+ / Linux / Windows 10+
- Node.js 16+ (for MCP servers)
- Sufficient disk space (> 1GB free)

**Step 2: Verify Installation Method**
```bash
# Check if Claude installed
which claude

# If not found, reinstall following official guide
# Visit: https://code.claude.com/install
```

**Step 3: Fix Permissions**
```bash
# macOS/Linux: Fix permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

# Retry installation
```

**Prevention**:
- Follow official installation guide
- Keep Node.js updated
- Maintain adequate disk space
- Use supported operating system versions

---

## Getting More Help

### When to Report a Bug

Report issues when:
- Problem persists after following troubleshooting steps
- Error messages are unclear or misleading
- Issue affects multiple users
- Security vulnerability discovered

### How to Report Effectively

Include in bug report:
1. **Clear description** of the issue
2. **Steps to reproduce** the problem
3. **Expected behavior** vs actual behavior
4. **Environment details** (OS, Claude version, Node version)
5. **Error messages** (full text, stack traces)
6. **Configuration files** (redact secrets!)
7. **Workarounds** you've tried

### Where to Get Help

- **Official Docs**: https://code.claude.com/docs
- **GitHub Issues**: https://github.com/anthropics/claude-code/issues
- **Community Forum**: https://community.anthropic.com
- **Discord**: Check Anthropic's official channels

---

## Cross-References

### Related Guides

- [FAQ](3-faq.md) - Quick answers to common questions
- [API Reference](1-api-reference.md) - Complete schema documentation
- [Configuration Guide](../6-context/2-claude-md.md) - CLAUDE.md best practices
- [Agent Configuration](../2-agents/4-custom-agents.md) - Custom agent setup
- [Skill Development](../3-skills/3-creating-skills.md) - Skill creation guide

### Quick References

- [Cheat Sheet](4-cheat-sheet.md) - Quick command reference
- [Glossary](7-glossary.md) - Term definitions

---

**Still Stuck?**

If this guide didn't solve your problem:
1. Check the [FAQ](3-faq.md) for quick answers
2. Search [GitHub Issues](https://github.com/anthropics/claude-code/issues)
3. Ask on the [Community Forum](https://community.anthropic.com)
4. Report a new bug with detailed reproduction steps

**Remember**: Most issues have simple solutions. Start with the basics (restart, check config, validate syntax) before diving into complex debugging!
