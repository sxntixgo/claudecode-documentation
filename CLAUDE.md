# Claude Code Documentation Project

## Project Status: ✅ Production Ready

Documentation is complete and follows a pedagogical progression from fundamentals to advanced topics.

## Documentation Structure

```
guides/
├── 01-mcp-servers/        # MCP servers - external tools
├── 03-agents/             # Specialized AI assistants
├── 04-skills/             # Custom workflow definitions
├── 05-commands/           # Slash commands (quick shortcuts)
├── 06-models/             # Model selection (Haiku/Sonnet/Opus)
├── 07-plugins/            # Plugin ecosystem overview
├── 08-thinking/           # Thinking modes & reasoning
├── 09-context/            # Context management
├── 10-keywords/           # Keywords & triggers
├── 11-hooks/              # Automation triggers
├── 12-optimization/       # Token & cost optimization
├── 13-examples/           # Real-world projects & workflows
├── 14-reference/          # API reference, cheat sheets
├── 15-security/           # Security & compliance
└── 16-community/          # Community resources
```

## Key Navigation Files

| File | Purpose |
|------|---------|
| `README.md` | Quick start and overview |
| `INTRODUCTION.md` | Learning paths by skill level |
| `TABLE_OF_CONTENTS.md` | Master navigation |

## Writing Guidelines

- **Mermaid diagrams only** (never ASCII art)
- **Real examples** with pytest tests
- **Progressive disclosure**: simple → complex
- **Cost transparency**: always include token implications
- **Cross-reference** related topics

## AI Assistant Instructions

### Core Workflow
1. Start tasks immediately when user selects
2. Brief completion summaries only
3. Show estimates only for future task choices

### Model Selection

| Model | Use For |
|-------|---------|
| **Haiku** | Simple tasks, searches (3x cheaper) |
| **Sonnet** | Documentation, coding (baseline) |
| **Opus** | Complex analysis (premium) |

### Context Tracking (Required)

**End every response with:**
```
---
📊 **Context**: ~XX% used | ~YYK tokens remaining
```

**When > 70%**: Add `⚠️ Context getting full` warning

## Official References

- [Claude Code Docs](https://code.claude.com/docs)
- [Model Context Protocol](https://modelcontextprotocol.io)
- [Community Skills](https://github.com/obra/superpowers)
