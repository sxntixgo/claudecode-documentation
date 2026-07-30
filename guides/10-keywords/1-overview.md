# Keywords & Triggers Overview

**Reading Time**: 15 minutes
**Skill Level**: Intermediate
**Prerequisites**: [Plugin Ecosystem Overview](../07-plugins/1-overview.md), Basic Claude Code usage

> **📌 Includes Plugin Types 3 & 4**: This section covers Slash Commands (Plugin Type 3) and references Hooks (Plugin Type 4). See [Plugin Ecosystem Overview](../07-plugins/1-overview.md) to understand how these fit with MCP Servers and Skills. For detailed hooks documentation, see [Hooks & Automation](../11-hooks/1-overview.md).

---

## Welcome to Power User Features! ⚡

Keywords and triggers let you automate workflows and customize Claude Code's behavior through simple text patterns.

---

## What Are Keywords and Triggers?

**Keywords**: Special words or phrases that activate specific behaviors
**Triggers**: What a skill advertises in its `description` (and optional `paths`) so Claude invokes it on its own

---

## Types of Keywords

### 1. Thinking Keywords
Control reasoning depth:
- `"think"` - Moderate reasoning
- `"think hard"` - Deep analysis
- `"ultrathink"` - Maximum reasoning

**More**: [Thinking Modes](../08-thinking/2-keywords.md)

---

### 2. Slash Commands
Quick shortcuts for common workflows:
- `/review` - Code review
- `/test` - Generate tests
- `/docs` - Generate documentation
- `/format` - Format code

**Create your own**: [Creating Slash Commands](2-slash-commands.md)

---

### 3. Auto-Invocation
Skills can load without you typing a command. Claude reads each skill's `description` (and
`when_to_use`, which is appended to it) and decides whether your request matches — no regex, no
confidence score:

```yaml
# In SKILL.md
description: Reviews staged changes for security, logic, and style issues before commit.
when_to_use: review my code, check this PR, look over my changes
```

**When you say**: "Review my code for issues"
**Claude automatically**: Uses code-review skill

Add `paths` if the skill should only wake up for certain files (see
[Custom Automation](3-automation-patterns.md)).

---

## Common Use Cases

### Development Workflow
```bash
/format              # Format current file
/test UserService    # Generate tests
/review --deep       # Deep code review
/docs api/users.ts   # Generate API docs
```

### Quick Actions
```bash
/build               # Run build
/deploy staging      # Deploy to staging
/lint --fix          # Run linter with fixes
```

### Team Collaboration
```bash
/pr-ready            # Check if code is PR-ready
/commit              # Generate commit message
/changelog           # Update changelog
```

---

## Benefits

**Speed**: One command instead of full sentences
**Consistency**: Same workflow every time
**Customization**: Create commands for your specific needs
**Team Alignment**: Share commands across team

---

## Next Steps

**Essential Reading**:
- [Creating Slash Commands](2-slash-commands.md) **(Creation Guide)** - Build your own commands
- [Custom Automation](3-automation-patterns.md) - Advanced trigger patterns

**Related**:
- [Custom Skills](../04-skills/3-creating-skills.md) - Skills work great with slash commands
- [Context Management](../09-context/1-overview.md) - Commands can reference context

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
