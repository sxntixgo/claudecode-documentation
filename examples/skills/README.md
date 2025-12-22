# Example Skills

This directory contains **reference copies** of skills for documentation and learning purposes.

## Active vs. Reference Skills

- **Active skills**: Located in `.claude/skills/` - these are loaded by Claude Code and actively used
- **Reference skills**: Located in `examples/skills/` - these are for documentation, examples, and learning only

## Purpose

The skills in this directory serve as:
- **Examples** for learning how to create custom skills
- **Templates** for starting your own skill development
- **Documentation** showing real-world skill structures
- **Reference** implementations demonstrating best practices

## Current Skills

### documentation-professor
- **Active**: `.claude/skills/documentation-professor/SKILL.md`
- **Reference**: `examples/skills/documentation-professor/SKILL.md`
- **Purpose**: Pedagogical documentation writing with university professor approach
- **Description**: Creates clear, pedagogical documentation for technical topics with conversational teaching style, visual elements, interactive exercises, and Python code examples with tests

## Using These Examples

To use an example skill in your own project:

1. **Copy the skill directory** from `examples/skills/[skill-name]/` to `.claude/skills/[skill-name]/`
2. **Restart Claude Code** to load the skill (or reload if already running)
3. **Invoke the skill** using its name in your prompts
4. **Customize** the SKILL.md file to fit your needs

## Creating Your Own Skills

See the complete guide: [Creating Custom Skills](../../guides/3-skills/3-creating-skills.md)

**Quick start**:
1. Create a new directory in `.claude/skills/your-skill-name/`
2. Create a `SKILL.md` file with YAML frontmatter
3. Write your skill instructions using progressive disclosure
4. Test and iterate

## Contributing Skills

Want to share your skills with the community?

See: [Contribution Guide](../../guides/12-community/2-contribution-guide.md)

**Options for sharing**:
- **Submit to official repo**: For widely useful, well-tested skills
- **Share independently**: Host on your own GitHub repository
- **Community collection**: Contribute to [obra/superpowers](https://github.com/obra/superpowers)

---

**Note**: Skills in this `examples/` directory are not automatically loaded by Claude Code. They must be copied to `.claude/skills/` to be used.
