# Claude Code Documentation Project

## Project Overview
This repository contains comprehensive documentation for Claude Code, covering MCP servers, agents, skills, model selection, thinking modes, context management, and optimization strategies.

## Documentation Structure
The documentation follows a **pedagogical progression** from fundamental to advanced concepts:
1. MCP Servers (foundation)
2. Agents (building on MCP)
3. Skills (leveraging agents)
4. Models (understanding the engine)
5. Thinking Modes (optimizing reasoning)
6. Context Management (advanced control)
7. Keywords & Triggers (power user features)
8. Token Optimization (synthesis)

## Key Files
- `DOCUMENTATION_PLAN.md` - Master plan with all topics, examples, and implementation roadmap
- `README.md` - Repository overview and quick start
- `INTRODUCTION.md` - Comprehensive introduction (to be created in Phase 0)
- `TABLE_OF_CONTENTS.md` - Master navigation (to be created in Phase 0)

## Writing Guidelines

### Content Standards
- **Clear examples**: Every feature must have copy-paste ready code examples
- **Real-world scenarios**: Include practical use cases, not just theoretical explanations
- **Progressive disclosure**: Start simple, then add complexity
- **Cost transparency**: Always include token usage and cost implications
- **Multi-level**: Cater to beginners, intermediate, and advanced users

### Code Examples
- Use TypeScript/JavaScript for agent and skill configurations
- Use bash for command-line examples
- Include both simple and complex examples for each feature
- Show before/after comparisons for optimization strategies

### Documentation Format
- Use GitHub-flavored Markdown
- Include table of contents for long documents
- Use code fencing with language tags
- Add visual diagrams where helpful (especially for dependencies)
- Link to official sources and references

### Tone and Style
- Professional and technical, but approachable
- Direct and concise
- Focus on practical value
- Explain "why" not just "how"
- Use active voice

## Implementation Phases

### Phase 0: Documentation Foundation (1 week)
Create introduction, table of contents, and README with clear navigation and pedagogical rationale.

### Phase 1: Foundation Documentation (2-3 weeks)
MCP Servers, Agents overview, Skills basics - the fundamental building blocks.

### Phase 2: Advanced Configuration (2-3 weeks)
Model selection, custom agents, custom skills - leveraging the fundamentals.

### Phase 3: Optimization and Patterns (2-3 weeks)
Token optimization, context management, behavioral customization - mastery level.

### Phase 4: Examples and Templates (2-3 weeks)
Real-world examples, templates, and complete project configurations.

### Phase 5: Reference and Maintenance (ongoing)
API reference, troubleshooting, FAQ, and updates.

## Common Commands

### Testing Documentation
```bash
# Check all markdown links
markdown-link-check **/*.md

# Spell check
cspell "**/*.md"

# Validate code examples
# (extract and test code blocks from markdown)
```

### Building Documentation
```bash
# If using a static site generator
npm run build

# Preview locally
npm run dev
```

### Git Workflow
- Branch naming: `claude/plan-claude-code-docs-{session-id}`
- Commit messages: Clear, descriptive, explain the "why"
- Always push to the feature branch
- Create PR when ready for review

## Target Audience

### Beginners
- New to Claude Code
- Need step-by-step guidance
- Require foundational concepts first
- Should follow sequential reading path

### Intermediate Users
- Familiar with basics
- Want to optimize workflows
- Need real-world examples
- Can skip some fundamentals

### Advanced Users
- Power users and customizers
- Need reference documentation
- Looking for edge cases and optimization
- Can jump directly to specific topics

## Success Metrics
- Users can set up MCP servers in < 10 minutes
- Users can create custom skills in < 30 minutes
- Users understand when to use each model
- Users can optimize token usage by 50%+
- Documentation covers all major use cases

## Quality Checklist
For each documentation page:
- [ ] Clear objective stated at the beginning
- [ ] Real-world examples included
- [ ] Code examples are tested and working
- [ ] Cost/token implications explained
- [ ] Links to official sources provided
- [ ] Troubleshooting section for common issues
- [ ] Cross-references to related topics
- [ ] Appropriate for target skill level
- [ ] Follows logical progression from previous topics
- [ ] Builds foundation for subsequent topics

## Resources and References

### Official Documentation
- [Claude Code Docs](https://code.claude.com/docs)
- [Claude API Docs](https://docs.claude.com)
- [Anthropic Engineering Blog](https://www.anthropic.com/engineering)
- [Model Context Protocol](https://modelcontextprotocol.io)

### Community Resources
- [Claude Code GitHub Issues](https://github.com/anthropics/claude-code/issues)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)
- [Community Skills (obra/superpowers)](https://github.com/obra/superpowers)

## Notes for AI Assistants
When working on this documentation:
1. **Maintain pedagogical order**: Ensure new content fits the logical progression
2. **Include cost analysis**: Always show token usage and savings potential
3. **Real examples only**: No hypothetical or untested code
4. **Link to sources**: Every claim should reference official documentation
5. **Test examples**: Verify all code examples work before committing
6. **Update plan**: Keep DOCUMENTATION_PLAN.md in sync with actual content
7. **Cross-reference**: Link related topics together
8. **Multiple skill levels**: Provide basic and advanced examples for each topic
