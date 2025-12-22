# Keywords & Triggers Overview

**Reading Time**: 15 minutes
**Skill Level**: Intermediate
**Prerequisites**: [Plugin Ecosystem Overview](../00-plugins-overview/1-overview.md), Basic Claude Code usage

> **📌 Includes Plugin Types 3 & 4**: This section covers Slash Commands (Plugin Type 3) and references Hooks (Plugin Type 4). See [Plugin Ecosystem Overview](../00-plugins-overview/1-overview.md) to understand how these fit with MCP Servers and Skills. For detailed hooks documentation, see [Hooks & Automation](../08-hooks/1-overview.md).

---

## Welcome to Power User Features! ⚡

Keywords and triggers let you automate workflows and customize Claude Code's behavior through simple text patterns.

---

## What Are Keywords and Triggers?

**Keywords**: Special words or phrases that activate specific behaviors
**Triggers**: Patterns that automatically invoke skills, agents, or commands

---

## Types of Keywords

### 1. Thinking Keywords
Control reasoning depth:
- `"think"` - Moderate reasoning
- `"think hard"` - Deep analysis
- `"ultrathink"` - Maximum reasoning

**More**: [Thinking Modes](../05-thinking/2-keywords.md)

---

### 2. Slash Commands
Quick shortcuts for common workflows:
- `/review` - Code review
- `/test` - Generate tests
- `/docs` - Generate documentation
- `/format` - Format code

**Create your own**: [Creating Slash Commands](2-slash-commands.md)

---

### 3. Auto-Triggers
Automatically invoke skills based on patterns:

```yaml
# In SKILL.md
autoTrigger:
  patterns:
    - "review.*code"
    - "check.*pr"
  confidence: 0.85
```

**When you say**: "Review my code for issues"
**Claude automatically**: Uses code-review skill

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
- [Custom Skills](../03-skills/3-creating-skills.md) - Skills work great with slash commands
- [Context Management](../06-context/1-overview.md) - Commands can reference context

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
