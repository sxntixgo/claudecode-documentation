# CLAUDE.md File Structure

**Reading Time**: 25 minutes
**Prerequisites**: [Context Overview](1-overview.md)

---

## Complete CLAUDE.md Guide 📋

Master the structure and best practices for CLAUDE.md files.

---

## Basic Template

`.claude/CLAUDE.md`:
```markdown
# Project Name

Brief one-line description.

## Tech Stack

- Language: TypeScript
- Framework: React 18
- Backend: Node.js + Express
- Database: PostgreSQL
- State: Redux Toolkit

## Project Structure

```
src/
├── client/     # React frontend
├── server/     # Express backend
├── shared/     # Shared types
└── database/   # Prisma schema
```

## Coding Standards

- TypeScript strict mode
- ESLint + Prettier
- Test coverage > 80%
- Functional components only

## Common Tasks

### Add API Endpoint
1. Define route in `src/server/routes/`
2. Create controller in `src/server/controllers/`
3. Add validation schema
4. Write integration tests

### Add React Component
1. Create in `src/client/components/`
2. Export from `index.ts`
3. Write Storybook story
4. Add unit tests

## Notes

- Use Prisma for database queries
- All APIs return { success, data?, error? }
- Components use CSS modules
```

---

## Advanced Sections

### API Conventions
```markdown
## API Conventions

### Request Format
```json
POST /api/v1/users
{
  "email": "user@example.com",
  "name": "John Doe"
}
```

### Response Format
```json
{
  "success": true,
  "data": { "id": 123, "email": "...", "name": "..." }
}
```

### Error Format
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required",
    "details": { "field": "email" }
  }
}
```
```

### Testing Patterns
```markdown
## Testing

### Unit Tests
- Location: `__tests__/` next to source
- Framework: Jest
- Coverage: 80% minimum

### Integration Tests
- Location: `tests/integration/`
- Use test database
- Clean up after each test

### E2E Tests
- Location: `tests/e2e/`
- Framework: Playwright
- Run before deployment
```

---

## Examples by Project Type

### Web Application
```markdown
# MyApp - React + TypeScript SPA

## Stack
- React 18, TypeScript, Vite
- TanStack Query, Zustand
- TailwindCSS, Radix UI

## Key Patterns
- Server state: TanStack Query
- Client state: Zustand
- Forms: React Hook Form + Zod
- Routing: React Router v6

## File Conventions
- `*.page.tsx` - Page components
- `*.component.tsx` - Reusable components
- `*.hook.ts` - Custom hooks
- `*.api.ts` - API client functions
```

### API Service
```markdown
# API - Node.js + Express

## Stack
- Node.js 20, TypeScript
- Express, Prisma
- PostgreSQL, Redis

## Architecture
- Layered: Routes → Controllers → Services → Repositories
- Dependency injection
- Repository pattern

## Key Patterns
- Validation: Zod schemas
- Auth: JWT tokens
- Errors: Custom error classes
- Logging: Winston
```

---

## Best Practices

### ✅ Do
- Keep it under 500 lines
- Use bullet points
- Include code examples
- Update when patterns change
- Document common gotchas

### ❌ Don't
- Copy-paste entire docs
- Include implementation details
- Write essays
- Let it get stale
- Document every edge case

---

## Next Steps

- [Memory Hierarchy](3-memory-hierarchy.md) - Multi-level context strategies

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
