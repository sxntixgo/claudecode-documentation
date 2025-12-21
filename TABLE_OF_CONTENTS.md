# Table of Contents

> Your guide to navigating the Claude Code documentation

## 📍 You Are Here

This documentation follows a **pedagogical progression** from fundamental to advanced concepts. Each topic builds on the previous ones, creating a natural learning path from setup to optimization.

```
Foundation → Building Blocks → Advanced → Mastery
   MCP     →    Agents/Skills  → Context → Optimization
```

## 🗺️ Documentation Map

### Core Learning Path (Sequential)

```mermaid
graph TD
    A[1. MCP Servers] --> B[2. Agents]
    B --> C[3. Skills]
    C --> D[4. Models]
    D --> E[5. Thinking Modes]
    E --> F[6. Context Management]
    F --> G[7. Keywords & Triggers]
    G --> H[8. Token Optimization]

    style A fill:#87CEEB
    style B fill:#87CEEB
    style C fill:#87CEEB
    style D fill:#90EE90
    style E fill:#90EE90
    style F fill:#FFD700
    style G fill:#FFD700
    style H fill:#FF6347

    classDef beginner fill:#87CEEB
    classDef intermediate fill:#90EE90
    classDef advanced fill:#FFD700
    classDef mastery fill:#FF6347
```

🟦 **Beginner** → 🟢 **Intermediate** → 🟡 **Advanced** → 🔴 **Mastery**

---

## 📚 Complete Documentation Structure

### 🏁 Getting Started

| Document | Level | Time | What You'll Learn |
|----------|-------|------|-------------------|
| [README.md](README.md) | All | 5 min | Repository overview and quick start |
| [INTRODUCTION.md](INTRODUCTION.md) | All | 15 min | Welcome, learning path, prerequisites |
| **→ You Are Here** | All | 5 min | Navigation and reading paths |

---

### 1️⃣ MCP Servers (Foundation)

**Level**: 🟦 Beginner
**Prerequisites**: None - start here!
**What You'll Master**: Extending Claude Code with external tools and services

| Guide | Time | Topics |
|-------|------|--------|
| [What Are MCP Servers?](guides/1-mcp-servers/1-overview.md) | 15 min | Protocol overview, benefits, architecture |
| [Installation Guide](guides/1-mcp-servers/2-installation.md) | 30 min | CLI, manual, Docker installation methods |
| [Popular MCP Servers](guides/1-mcp-servers/3-popular-servers.md) | 25 min | GitHub, Perplexity, Context7, and more |
| **[Creating Custom MCP Servers](guides/1-mcp-servers/4-creating-custom-servers.md)** | **60 min** | **Build your own MCP server from scratch** |
| [Best Practices](guides/1-mcp-servers/5-best-practices.md) | 20 min | Security, performance, error handling |

**Total Time**: ~2.5 hours
**Dependencies**: None
**Next**: Agents (use MCP tools effectively)

**🔨 Creation Guide Included**: Learn to build custom MCP servers for your specific needs

---

### 2️⃣ Agents (Building on MCP)

**Level**: 🟦 Beginner → 🟢 Intermediate
**Prerequisites**: Understanding of MCP Servers
**What You'll Master**: Specialized AI assistants with focused capabilities

| Guide | Time | Topics |
|-------|------|--------|
| [What Are Agents?](guides/2-agents/1-overview.md) | 20 min | Concept, purpose, when to use |
| [Built-in Agent Types](guides/2-agents/2-built-in-agents.md) | 30 min | Explore, General-Purpose, Plan agents |
| [Model Assignment](guides/2-agents/3-model-assignment.md) | 25 min | Per-agent model selection for cost optimization |
| **[Creating Custom Agents](guides/2-agents/4-custom-agents.md)** | **50 min** | **Build specialized agents for your workflows** |

**Total Time**: ~2 hours
**Dependencies**: MCP Servers (Agents use MCP tools)
**Next**: Skills (leverage agents with reusable instructions)

**🔨 Creation Guide Included**: Learn to build custom agents with specialized capabilities

---

### 3️⃣ Skills (Leveraging Agents)

**Level**: 🟢 Intermediate
**Prerequisites**: MCP Servers, Agents basics
**What You'll Master**: Reusable instruction sets for complex tasks

| Guide | Time | Topics |
|-------|------|--------|
| [What Are Skills?](guides/3-skills/1-overview.md) | 20 min | Progressive disclosure, model invocation |
| [Marketplace Skills](guides/3-skills/2-marketplace-skills.md) | 20 min | Installing official and community skills |
| **[Creating Custom Skills](guides/3-skills/3-creating-skills.md)** | **70 min** | **SKILL.md structure, frontmatter, best practices** |
| [Model Assignment](guides/3-skills/4-model-assignment.md) | 20 min | Per-skill model selection |
| [Advanced Patterns](guides/3-skills/5-advanced-patterns.md) | 30 min | Progressive disclosure, testing, optimization |

**Total Time**: ~2.5 hours
**Dependencies**: Agents (Skills leverage agent capabilities)
**Next**: Models (choose the right engine for each task)

**🔨 Creation Guide Included**: Learn to build custom skills with progressive disclosure patterns

---

### 4️⃣ Model Selection (Understanding the Engine)

**Level**: 🟢 Intermediate
**Prerequisites**: Basic understanding of Agents and Skills
**What You'll Master**: Choosing Haiku, Sonnet, or Opus strategically

| Guide | Time | Topics |
|-------|------|--------|
| [Model Comparison](guides/models/model-comparison.md) | 20 min | Haiku 4.5, Sonnet 4.5, Opus 4.5 capabilities |
| [Selection Guide](guides/models/selection-guide.md) | 30 min | Decision matrix, when to use each model |
| [Configuration](guides/models/configuration.md) | 25 min | CLI flags, agent config, skill frontmatter |

**Total Time**: ~1.5 hours
**Dependencies**: Agents and Skills (model assignment context)
**Next**: Thinking Modes (control reasoning depth)

---

### 5️⃣ Thinking Modes (Optimizing Reasoning)

**Level**: 🟢 Intermediate → 🟡 Advanced
**Prerequisites**: Model Selection
**What You'll Master**: Extended thinking and reasoning depth control

| Guide | Time | Topics |
|-------|------|--------|
| [Extended Thinking Overview](guides/thinking/extended-thinking.md) | 15 min | What it is, how it works |
| [Keywords Reference](guides/thinking/keywords-reference.md) | 10 min | "think", "think hard", "ultrathink" budgets |
| [When to Use](guides/thinking/when-to-use.md) | 20 min | Use cases, cost considerations |

**Total Time**: ~45 minutes
**Dependencies**: Models (thinking affects token usage)
**Next**: Context Management (advanced control)

---

### 6️⃣ Context Management (Advanced Control)

**Level**: 🟡 Advanced
**Prerequisites**: All previous topics
**What You'll Master**: Memory, CLAUDE.md files, context optimization

| Guide | Time | Topics |
|-------|------|--------|
| [CLAUDE.md Files](guides/context/claude-md-files.md) | 30 min | System-level context, best practices |
| [Memory Management](guides/context/memory-management.md) | 25 min | Hierarchy, precedence, organization |
| [Optimization](guides/context/optimization.md) | 35 min | Context clearing, strategies, anti-patterns |

**Total Time**: ~1.5 hours
**Dependencies**: Understanding of entire system
**Next**: Keywords & Triggers (customize behavior)

---

### 7️⃣ Keywords & Triggers (Power User Features)

**Level**: 🟡 Advanced
**Prerequisites**: Context Management
**What You'll Master**: Hooks, commands, behavioral customization

| Reference | Time | Topics |
|-----------|------|--------|
| [Keywords Reference](reference/keywords.md) | 15 min | All thinking keywords, effects |
| [Hooks Reference](reference/hooks.md) | 30 min | PreToolUse, PostToolUse, Notification, Stop |
| [Commands Reference](reference/commands.md) | 20 min | Slash commands, $ARGUMENTS, frontmatter |

**Total Time**: ~1 hour
**Dependencies**: Context Management
**Next**: Token Optimization (put it all together)

---

### 8️⃣ Token Optimization (Synthesis)

**Level**: 🔴 Mastery
**Prerequisites**: All previous topics
**What You'll Master**: Cost-efficient Claude Code usage

| Guide | Time | Topics |
|-------|------|--------|
| [Token Usage Guide](optimization/token-usage.md) | 30 min | Tracking, estimation, monitoring |
| [Cost Comparison](optimization/cost-comparison.md) | 20 min | Haiku vs. Sonnet vs. Opus economics |
| [Optimization Strategies](optimization/strategies.md) | 45 min | 4 strategies, 60%+ savings potential |

**Total Time**: ~1.5 hours
**Dependencies**: All topics (applies everything learned)
**Outcome**: Save 50-60%+ on token costs

---

### 9️⃣ Examples & Templates (Practical Application)

**Level**: 🟢 Intermediate
**Prerequisites**: Basic understanding of Claude Code
**What You'll Master**: Real-world project configurations and workflows

| Guide | Time | Topics |
|-------|------|--------|
| [Examples Overview](guides/9-examples/1-overview.md) | 10 min | How to use templates and examples |
| **Projects** |||
| [React + TypeScript Project](guides/9-examples/projects/1-react-typescript.md) | 45 min | Complete frontend project setup |
| [Node.js API Service](guides/9-examples/projects/2-nodejs-api.md) | 40 min | Backend API configuration |
| **[Python/Django Project](guides/9-examples/projects/python/1-django.md)** | **45 min** | **Django with custom skills and workflows** |
| **[Python/FastAPI Project](guides/9-examples/projects/python/2-fastapi.md)** | **40 min** | **Modern async Python API** |
| **[Python/Flask Project](guides/9-examples/projects/python/3-flask.md)** | **30 min** | **Lightweight Flask web framework** |
| **Workflows** |||
| [Feature Development Workflow](guides/9-examples/workflows/1-feature-development.md) | 30 min | 6-phase development process |
| **[Bug Fixing Workflow](guides/9-examples/workflows/2-bug-fixing.md)** | **30 min** | **Systematic debugging with TDD approach** |
| **[Code Review Workflow](guides/9-examples/workflows/3-code-review.md)** | **25 min** | **AI-assisted PR reviews with security checks** |
| **[Refactoring Workflow](guides/9-examples/workflows/4-refactoring.md)** | **35 min** | **Safe refactoring with Plan agent and tests** |
| **Teams** |||
| [Solo Developer Setup](guides/9-examples/teams/1-solo-developer.md) | 25 min | Optimized individual configuration |

**Total Time**: ~6 hours
**Dependencies**: Understanding of core concepts
**Outcome**: Production-ready project configurations

---

### 🔟 Reference Documentation (Quick Lookup)

**Level**: All levels
**Prerequisites**: None for quick reference, intermediate for deep understanding
**What You'll Master**: Technical specifications and troubleshooting

| Guide | Time | Topics |
|-------|------|--------|
| **[Complete API Reference](guides/10-reference/1-api-reference.md)** | **45 min** | **AGENT.md, SKILL.md, config.json schemas** |
| **[Troubleshooting Guide](guides/10-reference/2-troubleshooting.md)** | **35 min** | **Common issues and solutions** |
| **[FAQ](guides/10-reference/3-faq.md)** | **40 min** | **50+ frequently asked questions** |
| **[Quick Reference Cheat Sheet](guides/10-reference/4-cheat-sheet.md)** | **10 min** | **One-page printable reference** |

**Total Time**: ~2 hours (reference as needed)
**Dependencies**: None
**Use For**: Quick lookups, troubleshooting, technical specifications

---

### 🔒 Security & Compliance (Production Readiness)

**Level**: 🔴 Advanced
**Prerequisites**: Understanding of core concepts, project experience
**What You'll Master**: Production deployment, security, testing, and performance

| Guide | Time | Topics |
|-------|------|--------|
| **[Security & Compliance](guides/11-security/1-security-compliance.md)** | **45 min** | **Secrets management, OWASP Top 10, GDPR/SOC 2/HIPAA, AI safety** |
| **[Testing & Quality](guides/11-security/2-testing-quality.md)** | **50 min** | **MCP/skill/agent testing, TDD/BDD, quality gates, CI/CD** |
| **[Performance & Monitoring](guides/11-security/3-performance-monitoring.md)** | **40 min** | **Benchmarks, token tracking, cost monitoring, optimization** |

**Total Time**: ~2 hours
**Dependencies**: Core concepts, project experience
**Outcome**: Production-ready, secure, and optimized deployments

---

### ⚡ Quick Reference (Power User Tools)

**Level**: All levels
**Prerequisites**: None
**What You'll Master**: Decision trees, checklists, and lookup tables

| Guide | Time | Topics |
|-------|------|--------|
| **[Model Selection Decision Tree](guides/12-quick-reference/1-model-selection-tree.md)** | **15 min** | **Haiku/Sonnet/Opus decision flowchart, cost calculator** |
| **[Optimization Checklist](guides/12-quick-reference/2-optimization-checklist.md)** | **20 min** | **Pre-implementation, configuration, runtime, monitoring** |
| **[Glossary](guides/12-quick-reference/3-glossary.md)** | **25 min** | **Complete terminology reference (80+ terms)** |
| **[Community Resources](guides/12-quick-reference/4-community-resources.md)** | **20 min** | **Official docs, community channels, learning materials** |

**Total Time**: ~1.5 hours (use as needed)
**Dependencies**: None
**Use For**: Quick decisions, daily optimization, learning resources

---

### 📄 Project Documentation

| Document | Purpose |
|----------|---------|
| [CHANGELOG.md](CHANGELOG.md) | Version history and updates |
| [CONTRIBUTING.md](CONTRIBUTING.md) | How to contribute to this documentation |
| [DOCUMENTATION_PLAN.md](DOCUMENTATION_PLAN.md) | Complete documentation roadmap and plan |

---

## 🎯 Reading Paths for Different Users

### Path 1: "New to Claude Code" (Complete Learning)

**Recommended for**: First-time users, those wanting comprehensive understanding
**Time investment**: ~15-20 hours total
**Approach**: Follow sequential order from MCP Servers → Token Optimization

```
Start → MCP Servers → Agents → Skills → Models →
Thinking → Context → Keywords → Optimization → Master
```

**Benefits**:
- Solid foundation in fundamentals
- Understand why things work, not just how
- Build knowledge progressively
- Ready for advanced customization

---

### Path 2: "Optimization Focused" (Quick to Power User)

**Recommended for**: Experienced developers, cost-conscious users
**Time investment**: ~6-8 hours core + as-needed reference
**Approach**: Cover fundamentals quickly, deep dive into optimization

```
MCP Servers (quick) → Agents (quick) → Models (deep) →
Thinking (deep) → Optimization (deep) → Context (reference)
```

**Focus Areas**:
1. Model Selection (30 min deep dive)
2. Thinking Modes (25 min deep dive)
3. Token Optimization (1 hour deep dive)
4. Reference other topics as needed

**Benefits**:
- Fast path to cost savings
- Practical optimization strategies
- Can return for advanced topics later

---

### Path 3: "Advanced Customization" (Power User)

**Recommended for**: Experienced Claude Code users seeking customization
**Time investment**: ~4-6 hours (assumes foundation knowledge)
**Approach**: Skip basics, focus on advanced features

```
Skills (deep) → Context Management (deep) →
Keywords & Triggers (deep) → Custom Agents → Custom Skills
```

**Focus Areas**:
1. Creating Custom Skills (1 hour)
2. CLAUDE.md Best Practices (30 min)
3. Hooks and Commands (45 min)
4. Advanced Context Patterns (35 min)

**Benefits**:
- Customize Claude Code to your workflow
- Create reusable skills for your team
- Master advanced patterns

---

### Path 4: "Quick Reference" (Lookup as Needed)

**Recommended for**: Active users needing quick answers
**Time investment**: 5-15 min per lookup
**Approach**: Use reference sections and examples

**Key Resources**:
- [Keywords Reference](reference/keywords.md) - All keywords and effects
- [Hooks Reference](reference/hooks.md) - Hook configuration
- [Commands Reference](reference/commands.md) - Slash command syntax
- [Examples](examples/) - Copy-paste ready templates

---

## 🔗 Dependency Diagram

Understanding how topics build on each other:

```mermaid
graph TB
    MCP[MCP Servers<br/>Foundation]
    Agents[Agents<br/>Use MCP tools]
    Skills[Skills<br/>Leverage agents]
    Models[Model Selection<br/>Choose engine]
    Thinking[Thinking Modes<br/>Control depth]
    Context[Context Management<br/>Memory & workflow]
    Keywords[Keywords & Triggers<br/>Customization]
    Optimization[Token Optimization<br/>Cost efficiency]

    MCP --> Agents
    Agents --> Skills
    MCP --> Skills

    Agents --> Models
    Skills --> Models

    Models --> Thinking

    Agents --> Context
    Skills --> Context
    Thinking --> Context

    Context --> Keywords

    MCP --> Optimization
    Agents --> Optimization
    Skills --> Optimization
    Models --> Optimization
    Thinking --> Optimization
    Context --> Optimization
    Keywords --> Optimization

    style MCP fill:#87CEEB
    style Agents fill:#87CEEB
    style Skills fill:#90EE90
    style Models fill:#90EE90
    style Thinking fill:#90EE90
    style Context fill:#FFD700
    style Keywords fill:#FFD700
    style Optimization fill:#FF6347
```

**Key Insights**:
- **MCP Servers** are the foundation - everything builds from here
- **Skills** require both MCP and Agents knowledge
- **Token Optimization** synthesizes ALL topics
- **Context Management** touches most advanced features

---

## 📦 Examples & Templates

Practical, copy-paste ready examples:

### Skills Examples
- [Documentation Professor](examples/skills/documentation-professor/) - Pedagogical documentation writer
- [TDD Workflow](examples/skills/tdd-workflow/) - Test-driven development
- [API Documentation](examples/skills/api-documentation/) - Generate API docs from code
- [Code Review](examples/skills/code-review/) - Automated code reviews

### Agent Configurations
- [Quick Search Agent](examples/agents/quick-search.json) - Fast codebase exploration (Haiku)
- [Feature Implementer](examples/agents/feature-implementer.json) - Standard development (Sonnet)
- [Architecture Reviewer](examples/agents/architecture-reviewer.json) - Deep analysis (Opus)

### CLAUDE.md Templates
- [Web Application](examples/claude-md-templates/web-application-CLAUDE.md) - React/Vue/Angular
- [API Service](examples/claude-md-templates/api-service-CLAUDE.md) - Backend services
- [Library/Package](examples/claude-md-templates/library-package-CLAUDE.md) - Open source
- [Monorepo](examples/claude-md-templates/monorepo-CLAUDE.md) - Multi-package projects
- [Documentation](examples/claude-md-templates/documentation-project-CLAUDE.md) - Doc sites
- [Machine Learning](examples/claude-md-templates/machine-learning-CLAUDE.md) - ML projects

### Complete Projects
- [Web App Setup](examples/projects/web-app-setup.md) - Full web application configuration
- [API Service](examples/projects/api-service.md) - Backend service with database
- [Monorepo](examples/projects/monorepo.md) - Multi-package repository

---

## ❓ Why This Order?

### Pedagogical Rationale

**1. MCP Servers First**
You can't use Claude Code's full power without understanding how to extend it. MCP is the foundation for everything else.

**2. Agents Build on MCP**
Agents use MCP tools to accomplish tasks. Understanding MCP first makes agents make sense.

**3. Skills Leverage Agents**
Skills are instruction sets that agents follow. You need to understand agents before creating effective skills.

**4. Models Power Everything**
Knowing when to use Haiku, Sonnet, or Opus is crucial for cost-effective usage. This comes after understanding what tasks you're running (via agents/skills).

**5. Thinking Optimizes Reasoning**
Once you know which model to use, thinking modes let you control the depth of reasoning and balance quality vs. cost.

**6. Context Manages Flow**
Advanced usage requires understanding how Claude manages information across conversations. This builds on all previous knowledge.

**7. Keywords Customize Behavior**
Power user features like hooks and custom commands require understanding the entire system first.

**8. Optimization Synthesizes All**
Token optimization applies everything you've learned - model selection, thinking budgets, context management, and strategic agent/skill usage.

---

## 🎓 Learning Checkpoints

After completing each section, you should be able to:

✅ **After MCP Servers**:
- Install and configure MCP servers
- Understand the Model Context Protocol
- Add popular servers (GitHub, Perplexity)
- Know when to create custom servers

✅ **After Agents**:
- Explain the difference between Explore, General-Purpose, and Plan agents
- Choose the right agent type for tasks
- Configure agents with specific models
- Understand agent lifecycle

✅ **After Skills**:
- Create custom skills with SKILL.md
- Install marketplace skills
- Assign models to skills for optimization
- Write effective skill descriptions

✅ **After Models**:
- Choose between Haiku, Sonnet, and Opus strategically
- Configure models via CLI, agents, or skills
- Understand cost implications of each model
- Use decision matrix for model selection

✅ **After Thinking Modes**:
- Use thinking keywords appropriately
- Understand thinking token budgets
- Toggle extended thinking when needed
- Balance reasoning depth with cost

✅ **After Context Management**:
- Write effective CLAUDE.md files
- Organize memory hierarchies
- Handle context clearing gracefully
- Apply context best practices

✅ **After Keywords & Triggers**:
- Configure hooks for automation
- Create custom slash commands
- Use keywords to modify behavior
- Customize Claude Code workflows

✅ **After Token Optimization**:
- Implement all 4 optimization strategies
- Save 50-60%+ on token costs
- Monitor and measure usage effectively
- Make data-driven model choices

---

## 📖 Additional Resources

### Quick References
- [Keywords Cheat Sheet](reference/keywords.md#cheat-sheet) - All keywords at a glance
- [Model Comparison Table](guides/models/model-comparison.md#comparison-table) - Quick model selection
- [Common Commands](reference/commands.md#common-commands) - Frequently used commands

### External Links
- [Official Claude Code Docs](https://code.claude.com/docs)
- [Claude API Documentation](https://docs.claude.com)
- [Model Context Protocol](https://modelcontextprotocol.io)
- [Anthropic Engineering Blog](https://www.anthropic.com/engineering)
- [Community Skills](https://github.com/obra/superpowers)

### Getting Help
- [Troubleshooting Guide](reference/troubleshooting.md) - Common issues and solutions
- [FAQ](reference/faq.md) - Frequently asked questions
- [GitHub Issues](https://github.com/anthropics/claude-code/issues) - Report bugs

---

## 🚀 Ready to Start?

Choose your path:

**→ [New to Claude Code? Start with INTRODUCTION.md](INTRODUCTION.md)**
**→ [Want quick optimization? Jump to Token Optimization](optimization/strategies.md)**
**→ [Need a specific answer? Use the search or references](reference/)**
**→ [Want to see examples? Browse templates](examples/)**

---

**Last Updated**: Phase 0 - Documentation Foundation
**Next Phase**: Phase 1 - Foundation Documentation (MCP, Agents, Skills)
