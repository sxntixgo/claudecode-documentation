# Claude Code Documentation

> Comprehensive documentation for mastering Claude Code - from fundamentals to advanced optimization

## 📚 What's This?

This repository contains complete documentation for [Claude Code](https://code.claude.com), covering everything from setting up MCP servers to optimizing token usage and creating custom skills. The documentation follows a pedagogical progression, building from fundamental concepts to advanced patterns.

## 🎯 Learning Path

The documentation is structured in a logical order - each topic builds on previous ones:

1. **MCP Servers** → Foundation for extending Claude's capabilities
2. **Agents** → Specialized AI assistants that use MCP tools
3. **Skills** → Reusable instruction sets leveraging agents
4. **Models** → Choosing the right model (Haiku/Sonnet/Opus)
5. **Thinking Modes** → Controlling reasoning depth
6. **Context Management** → Advanced memory and workflow control
7. **Keywords & Triggers** → Customizing Claude Code behavior
8. **Token Optimization** → Cost-efficient usage strategies

**New to Claude Code?** Follow the sequential path from MCP Servers → Token Optimization.

**Experienced user?** Jump directly to specific topics or optimization strategies.

## 🚀 Quick Start

### Prerequisites
- Claude Code installed ([installation guide](https://code.claude.com/docs/en/get-started))
- Basic understanding of command-line tools
- (Optional) Git repository for practicing with skills and agents

### Documentation Structure

```
claudecode-docs/
├── INTRODUCTION.md           # Start here!
├── TABLE_OF_CONTENTS.md      # Full navigation with reading paths
├── guides/                   # Topic-by-topic guides
│   ├── mcp-servers/
│   ├── agents/
│   ├── skills/
│   ├── models/
│   ├── thinking/
│   └── context/
├── examples/                 # Real-world examples
│   ├── skills/
│   ├── agents/
│   ├── claude-md-templates/
│   └── projects/
├── reference/                # Quick lookup
│   ├── keywords.md
│   ├── hooks.md
│   └── commands.md
└── optimization/             # Cost and performance
    ├── token-usage.md
    ├── cost-comparison.md
    └── strategies.md
```

## ✨ Key Features

### 📖 Comprehensive Coverage
- **MCP Servers**: Installation, popular servers, creating custom servers
- **Agents**: Explore, General-Purpose, and Plan agents with model assignment
- **Skills**: Creating custom skills with progressive disclosure patterns
- **Model Selection**: When to use Haiku (3x cheaper), Sonnet, or Opus
- **Thinking Modes**: Keywords, budgets, and performance impact
- **Context Management**: CLAUDE.md files, memory hierarchy, clearing strategies

### 💰 Cost Optimization
- Real-world token savings examples (60%+ reduction possible)
- Model assignment strategies per-agent and per-skill
- Claude Pro usage estimation and budgeting
- Before/after cost comparisons

### 🎓 Pedagogical Approach
- Concepts build logically from simple to complex
- Real-world examples, not toy scenarios
- Copy-paste ready code samples
- Visual diagrams and decision matrices
- Multiple skill levels (beginner/intermediate/advanced)

### 🛠️ Practical Templates
- 6 CLAUDE.md templates for different project types
- Example skills (TDD, API docs, code review)
- Agent configurations (search, implementation, architecture)
- Complete project setups

## 📋 Current Status

**Phase 0 Planning**: ✅ Complete
- [x] Comprehensive documentation plan created
- [x] Pedagogical approach defined
- [x] Task planning and tracking system established
- [x] Documentation Professor skill implemented

**Next Phase**: Phase 0 Implementation
- [ ] Create INTRODUCTION.md
- [ ] Create TABLE_OF_CONTENTS.md with dependency diagrams
- [ ] Write guides for each major topic
- [ ] Add example skills and templates

## 🎨 Documentation Professor Skill

This repository includes an active skill at `.claude/skills/documentation-professor/` that helps create:
- Conversational, pedagogical documentation
- Visual elements (diagrams, tables, flowcharts)
- Interactive exercises and comprehension checks
- Python code examples with comprehensive tests
- Separate deep-dive sections for advanced topics
- Time estimates and complexity ratings

## 🤝 Contributing

Contributions are welcome! This documentation aims to help developers master Claude Code through:
- Clear, tested examples
- Real-world use cases
- Cost-transparent guidance
- Multiple skill levels

See `DOCUMENTATION_PLAN.md` for the complete roadmap and contribution guidelines.

## 📊 Success Metrics

Our goals for this documentation:
- ✅ Users can set up MCP servers in < 10 minutes
- ✅ Users can create custom skills in < 30 minutes
- ✅ Users understand when to use each model
- ✅ Users can optimize token usage by 50%+
- ✅ Clear entry points for all skill levels

## 🔗 Official Resources

- [Claude Code Documentation](https://code.claude.com/docs)
- [Claude API Docs](https://docs.claude.com)
- [Anthropic Engineering Blog](https://www.anthropic.com/engineering)
- [Model Context Protocol](https://modelcontextprotocol.io)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)

## 📄 License

This documentation is provided to help developers learn and master Claude Code effectively.

---

**Ready to learn?** Start with [INTRODUCTION.md](INTRODUCTION.md) (coming soon) or explore [DOCUMENTATION_PLAN.md](DOCUMENTATION_PLAN.md) to see what's covered.

**Questions or feedback?** Open an issue or contribute to make this documentation better!
