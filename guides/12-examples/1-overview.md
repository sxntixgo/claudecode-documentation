# Examples and Templates Overview

**Reading Time**: 10 minutes
**Skill Level**: All Levels

---

## Welcome to Real-World Examples! 📦

Copy-paste ready configurations for common project types, workflows, and team setups.

---

## What's Included

### 1. Project Configurations

Ready-to-use `.claude/` directories for:
- React + TypeScript Web App
- Node.js API Service
- Python Data Science Project
- Full-Stack Application
- Monorepo Setup

**Start here**: [Project Templates](projects/1-react-typescript.md)

---

### 2. Workflow Templates

Complete workflows for:
- Feature Development
- Bug Investigation and Fix
- Code Review Process
- Deployment Pipeline
- Testing Strategy

**Start here**: [Workflow Templates](workflows/1-feature-development.md)

---

### 3. Team Collaboration

Team setups for:
- Solo Developer
- Small Team (2-5 people)
- Medium Team (6-15 people)
- Enterprise Team (16+ people)

**Start here**: [Team Patterns](teams/1-solo-developer.md)

---

## Quick Start

### Option 1: Copy Entire Configuration

```bash
# Copy project template
cp -r guides/12-examples/projects/react-typescript/.claude/ .

# Customize for your project
vim .claude/CLAUDE.md
```

### Option 2: Pick and Choose

```bash
# Copy specific files
cp guides/12-examples/projects/react-typescript/.claude/config.json .claude/
cp guides/12-examples/workflows/feature-development.md .claude/workflows/
```

### Option 3: Mix and Match

Combine configurations from different examples to fit your needs.

---

## 📚 Complete Example Index

### Project Templates (5 examples)

**Web Development**:
1. [React + TypeScript Web App](projects/1-react-typescript.md) - Modern frontend with hooks, state management
2. [Node.js API Service](projects/2-nodejs-api.md) - RESTful API with Express, PostgreSQL

**Python Development**:
3. [Django Project](projects/python/1-django.md) - Full-stack web framework
4. [FastAPI Project](projects/python/2-fastapi.md) - High-performance async API
5. [Flask Project](projects/python/3-flask.md) - Lightweight microframework

---

### Workflow Templates (7 examples)

**Development Workflows**:
1. [Feature Development](workflows/1-feature-development.md) - End-to-end feature creation process
2. [Bug Fixing](workflows/2-bug-fixing.md) - Systematic debugging and resolution
3. [Code Review](workflows/3-code-review.md) - Comprehensive PR review process
4. [Refactoring](workflows/4-refactoring.md) - Safe code improvement strategies

**Documentation & Quality**:
5. [Documentation Writing](workflows/5-documentation-writing.md) - Creating clear, maintainable docs
6. [Performance Optimization](workflows/6-performance-optimization.md) - Speed and efficiency improvements
7. [Testing](workflows/7-testing.md) - Test-driven development and coverage

---

### Team Templates (1 example)

**Team Configurations**:
1. [Solo Developer](teams/1-solo-developer.md) - Optimized setup for individual developers

> 💡 **More team templates coming soon**: Small Team, Medium Team, Enterprise Team

---

## Examples by Need

**I want to...**

- **Start a new React project** → [React + TypeScript](projects/1-react-typescript.md)
- **Build a Python API** → [FastAPI](projects/python/2-fastapi.md) or [Flask](projects/python/3-flask.md)
- **Build a Node.js API** → [Node.js API](projects/2-nodejs-api.md)
- **Implement TDD workflow** → [Testing](workflows/7-testing.md)
- **Improve code quality** → [Code Review](workflows/3-code-review.md) + [Refactoring](workflows/4-refactoring.md)
- **Speed up my app** → [Performance Optimization](workflows/6-performance-optimization.md)
- **Set up cost optimization** → [Solo Developer](teams/1-solo-developer.md)
- **Write better docs** → [Documentation Writing](workflows/5-documentation-writing.md)
- **Debug systematically** → [Bug Fixing](workflows/2-bug-fixing.md)

---

## Next Steps

Browse the examples:
- [Project Templates](projects/1-react-typescript.md)
- [Workflow Templates](workflows/1-feature-development.md)
- [Team Patterns](teams/1-solo-developer.md)

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
