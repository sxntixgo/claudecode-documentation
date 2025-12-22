# Context Memory Hierarchy

**Reading Time**: 15 minutes
**Prerequisites**: [CLAUDE.md Structure](2-claude-md.md)

---

## Multi-Level Context Strategy 🧠

Optimize context usage with a strategic hierarchy.

---

## The Three-Tier System

### Tier 1: Essential (Always Loaded)
**What**: Core project information
**Where**: `.claude/CLAUDE.md` - First 100 lines
**Token Cost**: ~500-1,000 tokens

**Include**:
- Tech stack
- Project structure
- Coding standards
- Common patterns

---

### Tier 2: Reference (Load as Needed)
**What**: Detailed documentation
**Where**: `.claude/docs/` folder
**Token Cost**: 0 (only loaded when referenced)

**Include**:
- API specifications
- Database schema
- Architecture diagrams
- Detailed guides

**Usage**:
```bash
"Read .claude/docs/api-spec.md and implement the endpoint"
```

---

### Tier 3: Examples (Explicit Reference)
**What**: Code examples and templates
**Where**: `.claude/examples/` folder
**Token Cost**: 0 (only loaded when referenced)

**Include**:
- Component templates
- API endpoint examples
- Test templates

**Usage**:
```bash
"Follow the pattern in .claude/examples/api-endpoint.ts"
```

---

## Optimization Strategies

### Strategy 1: Progressive Disclosure

**Bad** - Everything in CLAUDE.md:
```markdown
[2,000 lines of specs, examples, edge cases...]
```
**Cost**: 10,000+ tokens per request!

**Good** - Split into tiers:
```markdown
# CLAUDE.md (100 lines - essentials only)
→ References: See .claude/docs/ for details
```
**Cost**: 500 tokens per request
**Load docs only when needed**

---

### Strategy 2: Context Switching

**Different contexts for different tasks**:

`.claude/contexts/frontend.md`:
```markdown
# Frontend Development Context

## Focus
- React components
- Styling
- State management

## Ignore
- Backend implementation
- Database schema
```

`.claude/contexts/backend.md`:
```markdown
# Backend Development Context

## Focus
- API endpoints
- Database queries
- Business logic

## Ignore
- Frontend styling
- Component structure
```

**Usage**:
```bash
# Load specific context
"Load context from .claude/contexts/frontend.md"
```

---

## Token Budget Management

**Daily Development** (50 requests):

| Approach | Tokens/Request | Daily Total | Monthly Cost |
|----------|---------------|-------------|--------------|
| **No CLAUDE.md** | 8,000 | 400,000 | $6.00 |
| **Huge CLAUDE.md** | 15,000 | 750,000 | $11.25 |
| **Optimized Tiers** | 8,500 | 425,000 | $6.38 |

**Savings**: $5/month with optimization!

---

## Next Steps

**Phase 2 Complete!** 🎉

**Continue to**:
- [Keywords & Triggers](../07-keywords/) - Power user features
- [Token Optimization](../09-optimization/) - Advanced savings

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
