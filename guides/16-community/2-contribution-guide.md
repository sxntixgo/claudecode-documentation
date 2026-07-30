# Community Contribution Guide

**Reading Time**: 20 minutes
**Last Updated**: December 21, 2025

---

## Overview

Welcome to the Claude Code community! This guide explains how you can contribute to the Claude Code ecosystem by creating skills, building MCP servers, improving documentation, and sharing best practices.

**Ways to Contribute**:
- Create and share custom skills
- Build MCP servers for the community
- Contribute to documentation
- Share best practices and patterns
- Report bugs and suggest features
- Help other community members

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Contributing Skills](#contributing-skills)
3. [Contributing MCP Servers](#contributing-mcp-servers)
4. [Contributing to Documentation](#contributing-to-documentation)
5. [Reporting Bugs](#reporting-bugs)
6. [Suggesting Features](#suggesting-features)
7. [Community Support](#community-support)

---

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors, regardless of:
- Experience level (beginners welcome!)
- Background or identity
- Technical expertise
- Location or timezone

### Expected Behavior

✅ **Do**:
- Be respectful and professional
- Provide constructive feedback
- Help others learn and grow
- Give credit where credit is due
- Focus on what is best for the community

❌ **Don't**:
- Use hostile or offensive language
- Harass or discriminate against others
- Share others' private information
- Spam or self-promote excessively
- Dismiss others' contributions

### Reporting Issues

If you experience or witness unacceptable behavior, please report it to:
- Email: conduct@anthropic.com
- GitHub: Use the "Report" feature

All reports will be handled confidentially.

---

## Contributing Skills

### Why Contribute Skills?

- **Help the community**: Share your expertise
- **Get feedback**: Improve your skills through community review
- **Build reputation**: Establish yourself as a Claude Code expert
- **Learn**: See how others solve problems

### Skill Contribution Process

#### Step 1: Develop Your Skill

Create a high-quality skill following [best practices](../04-skills/4-model-assignment.md):

```markdown
---
name: your-skill-name
description: Clear, specific description of what the skill does. Include action verbs, file types, and use cases (100-200 chars).
version: 1.0.0
model: claude-haiku-4-5  # Choose appropriate model
author: Your Name
license: MIT
---

# Skill Name

## Overview
What does this skill do and why is it useful?

## Step-by-Step Instructions
1. First step with clear description
2. Second step with examples
3. Continue with sequential steps...

## Examples

### Example 1: Common Use Case
[Concrete example with expected output]

### Example 2: Edge Case
[Show how skill handles edge cases]

## Validation
How to verify the skill worked correctly.

## Troubleshooting
Common issues and solutions.
```

#### Step 2: Test Your Skill

**Thorough Testing**:
1. Test with all target models (Haiku, Sonnet, Opus)
2. Test multiple use cases
3. Test edge cases and error scenarios
4. Get feedback from beta testers
5. Iterate based on feedback

**Quality Checklist**:
- [ ] Clear, specific description (not vague)
- [ ] Works with intended model
- [ ] Step-by-step instructions are easy to follow
- [ ] Includes concrete examples
- [ ] Handles edge cases gracefully
- [ ] Includes validation steps
- [ ] Includes troubleshooting section
- [ ] No security vulnerabilities
- [ ] Respects user privacy

#### Step 3: Document Your Skill

Create comprehensive documentation:

**README.md**:
```markdown
# Skill Name

## Description
Brief description of what the skill does.

## Installation

\```bash
# If hosted on GitHub
git clone https://github.com/username/skill-name
cp -r skill-name ~/.claude/skills/
\```

## Usage

\```
You: "Description of how to invoke the skill"
\```

## Requirements
- Claude Code version: v1.0+
- Model: Haiku 4.5 or higher
- Dependencies: (if any)

## Examples

### Example 1
[Description and output]

### Example 2
[Description and output]

## Cost Estimate
- Tokens: ~X,XXX per invocation
- Cost: ~$X.XX (with recommended model)

## License
MIT License

## Author
Your Name (@github-username)

## Contributing
Contributions welcome! Please open an issue first to discuss changes.
```

#### Step 4: Share Your Skill

**Option 1: Submit to Official Repository**

1. Fork [anthropics/skills](https://github.com/anthropics/skills)
2. Add your skill to the repository
3. Create a pull request with:
   - Skill files (SKILL.md, README.md)
   - Examples
   - Tests (if applicable)
   - Documentation

**PR Template**:
```markdown
## Skill Submission: [Skill Name]

**Description**: Brief description of what the skill does

**Use Cases**:
- Use case 1
- Use case 2

**Testing**:
- [ ] Tested with Haiku 4.5
- [ ] Tested with Sonnet 4.5
- [ ] Tested with Opus 4.5
- [ ] Includes examples
- [ ] Includes documentation

**Checklist**:
- [ ] Follows skill best practices
- [ ] Includes comprehensive documentation
- [ ] No security vulnerabilities
- [ ] Respects user privacy
- [ ] MIT license (or compatible)
```

**Option 2: Publish Independently**

1. Create GitHub repository for your skill
2. Add detailed README.md
3. Include installation instructions
4. Add to [community skills list](./1-resources.md)
5. Share on social media with #ClaudeCode

**Option 3: Submit to obra/superpowers**

The [obra/superpowers](https://github.com/obra/superpowers) repository is a community-curated collection of battle-tested skills:

1. Fork the repository
2. Add your skill following their structure
3. Submit PR with skill and documentation

### Skill Licensing

**Recommended License**: MIT License (permissive, widely compatible)

**MIT License Template**:
```
MIT License

Copyright (c) 2025 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## Contributing MCP Servers

### Why Contribute MCP Servers?

- **Extend Claude Code**: Add new capabilities
- **Integrate tools**: Connect Claude to external services
- **Solve real problems**: Build what you need, share with others

### MCP Server Contribution Process

#### Step 1: Build Your Server

Follow the [Creating Custom MCP Servers](../01-mcp-servers/4-creating-custom-servers.md) guide.

**Key Requirements**:
- Follows MCP specification
- Handles errors gracefully
- Includes comprehensive logging
- Secure credential handling
- Well-documented API

#### Step 2: Test Your Server

**Testing Checklist**:
- [ ] Server starts successfully
- [ ] All tools work as expected
- [ ] Error handling works
- [ ] Authentication works (if applicable)
- [ ] Handles rate limiting (if applicable)
- [ ] Performance is acceptable
- [ ] Memory usage is reasonable
- [ ] Works with Claude Code

**Test with Claude Code**:
```bash
# Add your server
claude mcp add-json my-server '{
  "command": "node",
  "args": ["path/to/server.js"],
  "env": {}
}'

# Test
claude mcp list
claude mcp get my-server
```

#### Step 3: Document Your Server

**README.md Template**:
```markdown
# MCP Server Name

## Description
What does this server provide?

## Features
- Feature 1
- Feature 2
- Feature 3

## Installation

### Prerequisites
- Node.js 18+ (or other runtime)
- API key for [Service] (if required)

### Install via NPM
\```bash
npm install -g @username/mcp-server-name
\```

### Install from Source
\```bash
git clone https://github.com/username/mcp-server-name
cd mcp-server-name
npm install
npm run build
\```

## Configuration

### Add to Claude Code

\```bash
claude mcp add-json my-server '{
  "command": "npx",
  "args": ["-y", "@username/mcp-server-name"],
  "env": {
    "API_KEY": "your-api-key"
  }
}'
\```

### Environment Variables
- `API_KEY`: Your API key for [Service]
- `BASE_URL`: (Optional) Custom base URL

## Available Tools

### tool_name_1
**Description**: What does this tool do?

**Parameters**:
- `param1` (string, required): Description
- `param2` (number, optional): Description

**Example**:
\```
You: "Use my-server to fetch data about X"
\```

### tool_name_2
[Continue for all tools]

## Examples

### Example 1: Common Use Case
[Show complete example]

### Example 2: Advanced Usage
[Show advanced example]

## Security

### Credential Storage
This server requires an API key. Store it securely:
- Use environment variables
- Never commit to version control
- Rotate keys regularly

### Permissions
This server requires:
- Network access to [Service]
- No file system access
- No shell access

## Development

### Running Locally
\```bash
npm run dev
\```

### Running Tests
\```bash
npm test
\```

### Building
\```bash
npm run build
\```

## Troubleshooting

### Server won't start
[Common solution]

### Connection errors
[Common solution]

## License
MIT

## Contributing
Contributions welcome! Please see CONTRIBUTING.md

## Support
- GitHub Issues: https://github.com/username/mcp-server-name/issues
- Discord: [link]
```

#### Step 4: Publish Your Server

**Option 1: Publish to NPM**

```bash
# Update package.json
{
  "name": "@username/mcp-server-name",
  "version": "1.0.0",
  "description": "MCP server for...",
  "main": "dist/index.js",
  "bin": {
    "mcp-server-name": "./dist/index.js"
  },
  "keywords": ["mcp", "claude-code", "server"],
  "author": "Your Name",
  "license": "MIT"
}

# Publish
npm publish --access public
```

**Option 2: Submit to MCP Toolkit (Docker)**

If your server would benefit from containerization:

1. Create Dockerfile
2. Submit to [MCP Toolkit](https://github.com/docker/mcp-toolkit)
3. One-click deployment for users

**Option 3: Add to Model Context Protocol Registry**

Submit your server to the official [MCP Registry](https://modelcontextprotocol.io/servers):

1. Fork the registry repository
2. Add your server metadata
3. Submit PR

---

## Contributing to Documentation

### Types of Documentation Contributions

1. **Fix errors**: Typos, broken links, outdated info
2. **Improve clarity**: Make explanations easier to understand
3. **Add examples**: More real-world examples
4. **Fill gaps**: Document undocumented features
5. **Translate**: Translate docs to other languages (future)

### Documentation Contribution Process

#### Step 1: Find What to Improve

**Sources of Documentation Issues**:
- Your own experience (what was confusing?)
- [GitHub Issues](https://github.com/anthropics/claude-code/issues) with "documentation" label
- Community discussions
- User questions

#### Step 2: Make Your Changes

**For Small Changes** (typos, small fixes):

1. Edit directly on GitHub
2. Submit PR with description
3. No issue needed

**For Large Changes** (new sections, major rewrites):

1. Open GitHub issue first to discuss
2. Get feedback on approach
3. Make changes
4. Submit PR

**Documentation Style Guide**:
- Use active voice
- Be concise but complete
- Include code examples
- Use proper markdown formatting
- Add diagrams for complex topics (Mermaid, not ASCII)
- Cross-reference related topics

#### Step 3: Test Your Changes

**Before Submitting**:
- [ ] Spell check
- [ ] Test all code examples
- [ ] Verify all links work
- [ ] Check markdown rendering
- [ ] Review for clarity

**Tools**:
```bash
# Check links
npx markdown-link-check **/*.md

# Spell check
npx cspell "**/*.md"

# Lint markdown
npx markdownlint **/*.md
```

#### Step 4: Submit Pull Request

**PR Title**: `docs: [brief description]`

**PR Description Template**:
```markdown
## Description
What does this PR change in the documentation?

## Motivation
Why is this change needed?

## Changes
- Change 1
- Change 2

## Checklist
- [ ] Tested code examples
- [ ] Checked spelling
- [ ] Verified links
- [ ] Follows style guide
```

---

## Reporting Bugs

### Where to Report

- **Claude Code bugs**: [GitHub Issues](https://github.com/anthropics/claude-code/issues)
- **Documentation bugs**: [Documentation Repository Issues](https://github.com/user/claudecode-documentation/issues)
- **Security vulnerabilities**: security@anthropic.com (do NOT create public issue)

### Bug Report Template

```markdown
## Bug Description
Clear description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen?

## Actual Behavior
What actually happens?

## Environment
- Claude Code version: [run `claude --version`]
- OS: [macOS 14.2, Windows 11, Ubuntu 22.04]
- Node.js version: [if relevant]
- Model: [Haiku/Sonnet/Opus]

## Screenshots
[If applicable]

## Additional Context
Any other relevant information

## Workaround
If you found a temporary workaround, share it
```

### Security Vulnerabilities

**DO NOT** create public issues for security vulnerabilities.

**Instead**:
1. Email: security@anthropic.com
2. Include:
   - Description of vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if known)
3. Wait for response before public disclosure

---

## Suggesting Features

### Where to Suggest

- **Feature requests**: [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- **RFC (major features)**: [RFC Process](https://github.com/anthropics/rfcs)

### Feature Request Template

```markdown
## Feature Description
Clear description of the proposed feature

## Motivation
Why is this feature needed? What problem does it solve?

## Proposed Solution
How should this feature work?

## Alternatives Considered
What other approaches did you consider?

## Use Cases
Concrete examples of how this would be used:

### Use Case 1
[Description]

### Use Case 2
[Description]

## Impact
- Who would benefit from this?
- How often would it be used?
- Would it break existing functionality?

## Implementation Notes
Any thoughts on how to implement this?

## Willingness to Contribute
- [ ] I can help implement this
- [ ] I can help test this
- [ ] I can help document this
```

---

## Community Support

### Getting Help

**Official Channels**:
- [Claude Help Center](https://support.claude.com)
- [Community Forum](https://community.anthropic.com)
- [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)

**Community Channels**:
- Discord: [Anthropic Discord](https://discord.gg/anthropic)
- Reddit: r/ClaudeAI
- Twitter/X: #ClaudeCode hashtag

### Helping Others

**Be a Good Community Member**:

✅ **Do**:
- Answer questions when you can
- Share your solutions and learnings
- Point people to relevant documentation
- Be patient with beginners
- Celebrate others' successes

❌ **Don't**:
- Answer questions you're not sure about
- Be dismissive of "simple" questions
- Promote commercial products excessively
- Share bad security practices

**Earn Reputation**:
- Answer questions in GitHub Discussions
- Write blog posts about Claude Code
- Create video tutorials
- Share useful skills and patterns
- Contribute to documentation

---

## Recognition

### Contributors Hall of Fame

Top contributors will be recognized:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Featured in community spotlights
- Invited to beta programs

### Contribution Levels

**Bronze**: 1-5 contributions
**Silver**: 6-20 contributions
**Gold**: 21-50 contributions
**Platinum**: 50+ contributions

**Contributions Count**:
- Skills published
- MCP servers published
- Documentation PRs merged
- Bugs reported and fixed
- Community support provided

---

## Getting Started

Ready to contribute? Here's what to do:

1. **Join the community**:
   - Star the [Claude Code repo](https://github.com/anthropics/claude-code)
   - Join [Discord](https://discord.gg/anthropic)
   - Follow [@AnthropicAI](https://twitter.com/AnthropicAI)

2. **Find your first contribution**:
   - Look for "good first issue" labels
   - Fix documentation typos
   - Answer questions in discussions
   - Share a skill you created

3. **Get feedback**:
   - Ask in Discord before starting large work
   - Open draft PRs early for feedback
   - Iterate based on review comments

4. **Celebrate**:
   - Share your contribution on social media
   - Add to your portfolio
   - Help others do the same

---

## Questions?

- **General questions**: [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- **Contribution questions**: [Discord #contributors channel](https://discord.gg/anthropic)
- **Security issues**: security@anthropic.com

---

## Thank You!

Thank you for contributing to Claude Code! Your contributions help make AI more accessible and useful for everyone.

Every contribution matters, whether it's:
- A typo fix
- A new skill
- Answering someone's question
- Building an MCP server
- Improving documentation

**Together we're building the future of AI-assisted development.** 🚀
