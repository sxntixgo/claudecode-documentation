# Claude Code Documentation Project

## Project Status: ✅ Production Ready

Documentation is complete and follows a pedagogical progression from fundamentals to advanced topics.

## Documentation Structure

```
guides/
├── 00-plugins-overview/   # Advance organizer - all 4 plugin types
├── 01-mcp-servers/        # Plugin Type 1: External tools
├── 02-agents/             # Specialized AI assistants
├── 03-skills/             # Plugin Type 2: Custom instructions
├── 04-models/             # Model selection (Haiku/Sonnet/Opus)
├── 05-thinking/           # Thinking modes & reasoning
├── 06-context/            # Context management
├── 07-keywords/           # Plugin Type 3: Slash commands
├── 08-hooks/              # Plugin Type 4: Automation triggers
├── 09-optimization/       # Token & cost optimization
├── 10-examples/           # Real-world projects & workflows
├── 11-reference/          # API reference, cheat sheets
├── 12-security/           # Security & compliance
└── 13-community/          # Community resources
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
