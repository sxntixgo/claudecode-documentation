# Contributing to Claude Code Documentation

Thank you for your interest in improving the Claude Code documentation! This guide will help you contribute effectively.

---

## Table of Contents

1. [How to Contribute](#how-to-contribute)
2. [Documentation Standards](#documentation-standards)
3. [Code Examples](#code-examples)
4. [Submission Guidelines](#submission-guidelines)
5. [Review Process](#review-process)
6. [Community Guidelines](#community-guidelines)

---

## How to Contribute

### Ways to Help

**🐛 Report Issues**
- Found an error or typo
- Discovered outdated information
- Identified confusing sections
- Located broken links

**💡 Suggest Content**
- Missing documentation for a feature
- Need for additional examples
- Request for specific tutorials
- Ideas for new templates

**✍️ Submit Changes**
- Fix typos and grammar
- Improve code examples
- Add real-world use cases
- Create new project templates
- Write workflow guides
- Expand troubleshooting solutions
- Add FAQ answers

**⭐ Share Feedback**
- What's helpful
- What's confusing
- What's missing
- How to improve

---

## Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR-USERNAME/claudecode-documentation.git
cd claudecode-documentation
```

### 2. Create a Branch

```bash
# Create a feature branch
git checkout -b feature/improve-mcp-docs

# Or for fixes
git checkout -b fix/typo-in-agents-guide
```

### 3. Make Changes

Follow the [Documentation Standards](#documentation-standards) below.

### 4. Test Your Changes

```bash
# Check for broken links
markdown-link-check **/*.md

# Spell check (if you have cspell installed)
cspell "**/*.md"

# Validate code examples
# Extract and test code blocks from markdown
```

### 5. Submit Pull Request

```bash
# Commit your changes
git add .
git commit -m "Improve MCP server installation guide

- Add Docker installation method
- Include troubleshooting section
- Add example configurations"

# Push to your fork
git push origin feature/improve-mcp-docs

# Create pull request on GitHub
```

---

## Documentation Standards

### Content Principles

**1. Clarity Over Brevity**
- Explain concepts thoroughly
- Use simple language
- Define technical terms
- Provide context

**2. Show, Don't Just Tell**
- Include working code examples
- Provide real-world scenarios
- Show before/after comparisons
- Demonstrate outcomes

**3. Progressive Complexity**
- Start with basics
- Build to advanced topics
- Indicate skill level clearly
- Provide skip-ahead options for experts

**4. Maintain Consistency**
- Follow existing formatting
- Match writing style
- Use consistent terminology
- Follow file naming conventions

### File Structure

**Guide Template**:
```markdown
# Guide Title

**Reading Time**: X minutes
**Skill Level**: Beginner/Intermediate/Advanced
**Prerequisites**: Link to prerequisite guides

> **Note**: Do not add "Last Updated" or "Version" stamps to guides. Git commit
> history is the source of truth for when content changed. Hand-maintained
> stamps drift silently — every one in this repo was between seven months and
> a year and a half stale before they were removed.

---

## Welcome! [Engaging intro with emoji]

Brief overview of what this guide covers and why it matters.

---

## Table of Contents

1. [Section 1](#section-1)
2. [Section 2](#section-2)
3. [Section 3](#section-3)

---

## Section 1

### Subsection

Content with examples...

---

## Cross-References

### Related Guides
- [Related Guide 1](../path/to/guide.md)
- [Related Guide 2](../path/to/guide.md)

---

## References

### Official Documentation
- [Link 1](URL)
- [Link 2](URL)

### Community Resources
- [Link 3](URL)
```

### Formatting Guidelines

**Headers**:
```markdown
# Main Title (H1 - only once per file)

## Major Section (H2)

### Subsection (H3)

#### Sub-subsection (H4 - rarely needed)
```

**Code Blocks**:
````markdown
```language
// Code here
// Always specify language
```
````

**Diagrams**:
```markdown
**ALWAYS use Mermaid diagrams**, never ASCII art:

\```mermaid
graph TD
    A[Start] --> B[Process]
    B --> C[End]
\```
```

**Lists**:
```markdown
**Unordered**:
- Item 1
- Item 2
  - Nested item
- Item 3

**Ordered**:
1. First step
2. Second step
3. Third step
```

**Tables**:
```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
```

**Emphasis**:
```markdown
*Italic*
**Bold**
`Code inline`
```

**Links**:
```markdown
[Link Text](URL)
[Relative Link](../path/to/file.md)
[Section Link](#section-heading)
```

---

## Code Examples

### Quality Standards

**1. Working Code**
- Test all examples before submitting
- Ensure code runs without errors
- Use realistic variable names
- Include necessary imports

**2. Complete Examples**
- Don't show fragments without context
- Include setup if needed
- Show expected output
- Provide full file paths

**3. Best Practices**
- Follow language conventions
- Use modern syntax
- Include error handling
- Add helpful comments

### Example Template

````markdown
**Task**: Create a custom MCP server

**Complete Example**:

```typescript
#!/usr/bin/env node
// File: src/index.ts

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
        input: { type: 'string', description: 'Input parameter' }
      },
      required: ['input']
    }
  }]
}));

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  if (name === 'my_tool') {
    // Your tool logic
    const result = processInput(args.input);

    return {
      content: [{
        type: 'text',
        text: `Result: ${result}`
      }]
    };
  }

  throw new Error(`Unknown tool: ${name}`);
});

// Start server
const transport = new StdioServerTransport();
await server.connect(transport);

console.error('MCP Server running...');
```

**Installation**:
```bash
npm install @modelcontextprotocol/sdk
chmod +x src/index.ts
```

**Configuration** (`.claude/config.json`):
```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["./src/index.ts"]
    }
  }
}
```

**Expected Output**:
```
MCP Server running...
[Server processes Claude requests]
```

**Testing**:
```bash
# Test the server
node src/index.ts

# Should start without errors
# Press Ctrl+C to stop
```
````

---

## Submission Guidelines

### Pull Request Checklist

Before submitting, ensure:

- [ ] Code examples tested and working
- [ ] Links verified (no broken links)
- [ ] Spelling and grammar checked
- [ ] Formatting consistent with existing docs
- [ ] Mermaid diagrams used (not ASCII art)
- [ ] Cross-references added where relevant
- [ ] Screenshots/images optimized if included
- [ ] Commit message is descriptive

### Commit Message Format

Use **Conventional Commits** format:

```
<type>: <description>

[optional body]

[optional footer]
```

**Types**:
- `docs`: Documentation changes
- `fix`: Bug fixes in documentation
- `feat`: New documentation content
- `refactor`: Reorganization or restructuring
- `style`: Formatting, typos (no content changes)
- `test`: Adding or updating tests for code examples

**Examples**:

```
docs: add Docker installation guide for MCP servers

- Include Docker Compose example
- Add troubleshooting section for common Docker issues
- Link to official Docker documentation
```

```
fix: correct Haiku pricing in cost comparison table

Update pricing from $0.80/M to $1/M for input tokens
per 2025 pricing update
```

```
feat: add Python/Django project template

Complete template including:
- CLAUDE.md configuration
- Django-specific slash commands
- Model generator skill
- Testing workflow
```

### Pull Request Description

Provide a clear description:

```markdown
## Summary
Brief description of what this PR does.

## Changes
- Specific change 1
- Specific change 2
- Specific change 3

## Motivation
Why are these changes needed?

## Screenshots (if applicable)
[Include screenshots for visual changes]

## Checklist
- [x] Tested all code examples
- [x] Verified all links
- [x] Checked spelling
- [x] Followed style guide
```

---

## Review Process

### What to Expect

1. **Automated Checks**
   - Link validation
   - Spell check
   - Formatting validation
   - Example code extraction and testing (if applicable)

2. **Maintainer Review**
   - Content accuracy
   - Completeness
   - Clarity
   - Consistency with existing docs

3. **Feedback**
   - Suggestions for improvement
   - Requests for clarification
   - Additional examples needed

4. **Approval & Merge**
   - Once approved, maintainers will merge
   - Your contribution will be credited
   - Changes appear in next documentation release

### Response Time

- **Initial response**: Within 3-5 business days
- **Follow-up**: Within 2-3 business days
- **Merge time**: Varies based on PR complexity

### If Changes Requested

- Address feedback in new commits
- Don't force-push (preserves review history)
- Respond to comments when done
- Request re-review

---

## Community Guidelines

### Code of Conduct

**Be Respectful**
- Treat all contributors with respect
- Welcome newcomers
- Assume good intentions
- Provide constructive feedback

**Be Collaborative**
- Share knowledge freely
- Help others learn
- Credit others' work
- Work together to improve

**Be Professional**
- Keep discussions on-topic
- Avoid off-topic debates
- Focus on content quality
- Respect maintainer decisions

### Communication Channels

**GitHub Issues**
- Report bugs
- Request features
- Discuss improvements
- Track progress

**Pull Requests**
- Submit changes
- Review others' work
- Discuss implementation
- Collaborate on solutions

**Community Forum** (if available)
- General questions
- Share experiences
- Help other users
- Discuss best practices

---

## Recognition

### Contributors

All contributors are recognized in:
- `CHANGELOG.md` for significant contributions
- Git commit history (permanent record)
- Special thanks in major releases

### Types of Contributions

We value **all contributions**, including:
- 📝 Documentation improvements
- 🐛 Bug reports
- 💡 Feature suggestions
- ❓ Answering questions
- 📢 Spreading the word
- ⭐ Starring the repository
- 🔗 Sharing with others

---

## Getting Help

### Questions About Contributing?

- **Documentation questions**: Open a GitHub issue
- **Technical questions**: Check the [FAQ](guides/14-reference/3-faq.md)
- **Process questions**: Comment on existing PRs or issues
- **General help**: Reach out to maintainers

### Resources

- [Table of Contents](TABLE_OF_CONTENTS.md) - Overall structure and reading order
- [Table of Contents](TABLE_OF_CONTENTS.md) - Navigation guide
- [Changelog](CHANGELOG.md) - Recent changes
- [Style Guide](https://github.com/sxntixgo/claudecode-documentation/blob/main/CLAUDE.md) - Internal writing guidelines

---

## License

By contributing, you agree that your contributions will be licensed under the same license as this project (MIT License).

---

## Thank You! 🙏

Your contributions make this documentation better for everyone. Whether you're fixing a typo or writing a comprehensive guide, every contribution matters!

**Questions?** Don't hesitate to ask. We're here to help!

**Ready to contribute?** Pick an issue labeled `good-first-issue` or `help-wanted`!

---

**Maintained By**: Documentation Team
