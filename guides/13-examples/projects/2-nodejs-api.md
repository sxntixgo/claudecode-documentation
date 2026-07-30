# Node.js API Service Template

**Reading Time**: 5 minutes
**Skill Level**: Intermediate
**Prerequisites**: Understanding of Claude Code basics

**Project Type**: Backend REST API
**Tech Stack**: Node.js, Express, TypeScript, PostgreSQL, Prisma
**Team Size**: 1-10 developers

---

## Complete .claude/ Structure

```
.claude/
├── CLAUDE.md
├── settings.json
├── agents/
│   └── explore.md
├── commands/
│   ├── endpoint.md
│   ├── migration.md
│   └── test.md
└── skills/
    ├── api-generator/
    │   └── SKILL.md
    └── security-audit/
        └── SKILL.md
```

---

## CLAUDE.md

`.claude/CLAUDE.md`:
```markdown
# API Service - Node.js + Express

RESTful API service with PostgreSQL database.

## Tech Stack

- Node.js 20+ with TypeScript
- Express 4.18
- Prisma ORM 5.7
- PostgreSQL 16
- Redis (caching)
- JWT authentication

## Project Structure

```
src/
├── routes/          # API routes
├── controllers/     # Request handlers
├── services/        # Business logic
├── repositories/    # Data access
├── middleware/      # Express middleware
├── models/          # Prisma models
├── types/           # TypeScript types
└── utils/           # Utilities
```

## API Conventions

### Request/Response Format
```json
// Success
{
  "success": true,
  "data": { ... }
}

// Error
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message"
  }
}
```

### Authentication
- JWT tokens in Authorization header
- Token expiry: 24 hours
- Refresh tokens: 30 days

## Common Tasks

### Add New Endpoint
1. Define route in `routes/`
2. Create controller in `controllers/`
3. Add service logic in `services/`
4. Add repository methods in `repositories/`
5. Write tests
6. Update API documentation

### Add Database Migration
1. Update Prisma schema
2. Run `npx prisma migrate dev`
3. Update repository methods
4. Update types
5. Test migration
```

---

## settings.json

`.claude/settings.json`:
```json
{
  "model": "sonnet"
}
```

Sonnet handles endpoint generation, migrations, and tests. Model choices for individual
agents and skills are not settings keys — they belong in the frontmatter of the agent or
skill file.

### Agent Frontmatter

`.claude/agents/explore.md`:
```markdown
---
name: explore
description: Fast file searches across routes, controllers, services, and repositories.
model: haiku
---

Locate the relevant files and report their paths with the matching snippets. Do not edit.
```

Agents that omit `model` inherit the session model, so a general development agent needs no
override here.

### Skill Frontmatter

`.claude/skills/api-generator/SKILL.md`:
```markdown
---
name: api-generator
description: Generate REST endpoints with controller, service, repository, and tests
model: sonnet
---
```

`.claude/skills/security-audit/SKILL.md`:
```markdown
---
name: security-audit
description: Audit endpoints for auth, input validation, and data exposure issues
model: opus
---
```

A skill's `model` applies for the rest of that turn only, then the session returns to
Sonnet. A test-generation skill that wants the session default can simply omit `model`.

### Tracking Cost

Claude Code has no budget setting and writes no spend file. Run `/usage` for this session's tokens and
locally computed cost (`d` and `w` switch to 24-hour and 7-day windows); on Pro, Max, Team,
and Enterprise plans it also attributes usage to individual skills, subagents, plugins, and
MCP servers and flags anything over 10% of the total. `/context` shows what is occupying
the context window, and the [Console usage page](https://platform.claude.com/usage) is the
authoritative source for billing. For a whole team, export per-user token and cost metrics
via OpenTelemetry into your own observability stack.

---

## /endpoint Command

`.claude/commands/endpoint.md`:
```markdown
---
command: endpoint
description: Generate REST API endpoint with tests
usage: /endpoint <Resource> <Method>
examples:
  - /endpoint User POST
  - /endpoint Product GET
skill: api-generator
model: sonnet
---

# Endpoint Generator

Generate complete REST endpoint:

1. Route definition
2. Controller with validation
3. Service layer
4. Repository methods
5. Integration tests
6. OpenAPI documentation

Example: `/endpoint User POST`

Generates:
- routes/user.ts
- controllers/userController.ts
- services/userService.ts
- repositories/userRepository.ts
- tests/user.test.ts
```

---

## Cost Estimate

**Daily (5 developers)**:
- API generation: $3.00
- Testing: $2.50
- Code reviews: $2.00
- Security audits: $1.50

**Total**: ~$9.00/day

---

**Next**: [Python Data Science](3-python-datascience.md)
