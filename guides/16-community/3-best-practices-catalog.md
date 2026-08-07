# Community Best Practices Catalog

**Reading Time**: 25 minutes

---

## Overview

This catalog collects battle-tested patterns, configurations, and workflows from the Claude Code community. These practices have been proven to work in real-world production environments.

**What's Included**:
- Real-world configurations that work
- Lessons learned from production use
- Performance optimization discoveries
- Creative skill implementations
- Novel workflow patterns
- Industry-specific best practices

> **Contributing**: Have a best practice to share? Submit a PR to add your pattern to this catalog. See [Contribution Guide](./2-contribution-guide.md).

---

## Table of Contents

1. [Project Configurations](#project-configurations)
2. [Skills and Patterns](#skills-and-patterns)
3. [Optimization Techniques](#optimization-techniques)
4. [Team Workflows](#team-workflows)
5. [Production Deployments](#production-deployments)
6. [Troubleshooting Solutions](#troubleshooting-solutions)

---

## Project Configurations

### Pattern: Multi-Environment CLAUDE.md

**Contributed by**: Community
**Use Case**: Managing different configurations for dev/staging/prod

**Problem**: Single CLAUDE.md doesn't work for all environments

**Solution**: Use environment-specific imports

**Implementation**:

```markdown
# CLAUDE.md (base)

# Project Context

@.claude/environments/${ENVIRONMENT:-development}.md

## Common Commands
- Build: `npm run build`
- Test: `npm test`
```

**Environment Files**:

`.claude/environments/development.md`:
```markdown
# Development Environment

## Database
- Connection: localhost:5432
- Name: myapp_dev

## API Endpoints
- Base URL: http://localhost:3000
- Debug mode: enabled

## Special Notes for AI
- Use verbose logging
- Don't worry about performance
- Include debug comments
```

`.claude/environments/production.md`:
```markdown
# Production Environment

## Database
- Connection: Use DATABASE_URL env var
- Name: myapp_prod

## API Endpoints
- Base URL: https://api.myapp.com
- Debug mode: disabled

## Special Notes for AI
- Never log sensitive data
- Optimize for performance
- Security is critical
- Test changes in staging first
```

**Benefits**:
- Environment-specific guidance
- Single source of truth
- Easy to maintain
- Prevents production mistakes

---

### Pattern: Monorepo CLAUDE.md Hierarchy

**Contributed by**: Community
**Use Case**: Large monorepo with multiple packages

**Structure**:
```
monorepo/
├── CLAUDE.md                          # Root context
├── .claude/
│   └── shared/
│       ├── testing.md                 # Shared testing practices
│       ├── deployment.md              # Shared deployment
│       └── security.md                # Security guidelines
├── packages/
│   ├── api/
│   │   └── CLAUDE.md                  # API-specific context
│   ├── web/
│   │   └── CLAUDE.md                  # Web-specific context
│   └── mobile/
│       └── CLAUDE.md                  # Mobile-specific context
```

**Root CLAUDE.md**:
```markdown
# Monorepo Project

## Architecture
This is a monorepo containing:
- `packages/api`: Node.js API server
- `packages/web`: React web app
- `packages/mobile`: React Native mobile app

## Shared Guidelines
@.claude/shared/testing.md
@.claude/shared/deployment.md
@.claude/shared/security.md

## Workspace Commands
- Install all: `npm install`
- Build all: `npm run build`
- Test all: `npm test`
- Run workspace: `npm run dev -w packages/[name]`

## Important
When making changes, consider impact on all packages.
Check for shared dependencies before updating.
```

**Package-specific CLAUDE.md** (e.g., `packages/api/CLAUDE.md`):
```markdown
# API Package

@../../.claude/shared/testing.md

## Specific to This Package
- Framework: Express.js
- Database: PostgreSQL with Prisma
- Auth: JWT tokens

## Commands
- Dev: `npm run dev`
- Test: `npm test`
- Migrate: `npm run prisma:migrate`

## Key Files
- `src/routes/`: API route handlers
- `src/services/`: Business logic
- `prisma/schema.prisma`: Database schema
```

**Benefits**:
- Shared best practices
- Package-specific context
- Prevents cross-package mistakes
- Scalable structure

---

## Skills and Patterns

### Pattern: Auto-Documenting Code Changes

**Contributed by**: Community
**Use Case**: Automatically update documentation when code changes

**Skill**: `auto-document-changes`

```markdown
---
name: auto-document-changes
description: Automatically update documentation to match code changes after refactoring or new features
model: claude-sonnet-4-5
---

# Auto-Document Changes

After making code changes, update related documentation automatically.

## Process

1. **Identify Changed Files**
   - Use git diff to see what changed
   - Identify files that changed

2. **Find Related Documentation**
   - Search for docs that reference changed code
   - Check README, API docs, tutorials
   - Look for code examples in docs

3. **Update Documentation**
   - Update function signatures
   - Update code examples
   - Update screenshots (if UI changed)
   - Update version numbers

4. **Verify Examples**
   - Test all code examples
   - Ensure examples still work
   - Fix broken examples

5. **Update Changelog**
   - Add entry to CHANGELOG.md
   - Describe what changed
   - Note breaking changes
```

**Usage**:
```
You: "I just refactored the authentication module. Use auto-document-changes skill to update all related docs."
```

**Result**: All documentation automatically updated to match code changes.

---

### Pattern: Progressive Code Review

**Contributed by**: Community
**Use Case**: Thorough code review in stages

**Skill**: `progressive-review`

```markdown
---
name: progressive-review
description: Perform comprehensive code review in progressive stages from high-level to detailed
model: claude-sonnet-4-5
---

# Progressive Code Review

Review code in stages, from high-level architecture to detailed implementation.

## Stage 1: Architecture Review (5 min)
- Overall structure and organization
- Design patterns used
- Architectural decisions
- Separation of concerns

## Stage 2: Logic Review (10 min)
- Algorithm correctness
- Edge case handling
- Error handling
- Business logic accuracy

## Stage 3: Code Quality Review (10 min)
- Code readability
- Naming conventions
- Code duplication
- Function complexity

## Stage 4: Security Review (10 min)
- Input validation
- SQL injection prevention
- XSS prevention
- Authentication/authorization
- Sensitive data handling

## Stage 5: Performance Review (5 min)
- Database query efficiency
- Algorithmic complexity
- Memory usage
- Network requests

## Stage 6: Testing Review (5 min)
- Test coverage
- Test quality
- Edge cases covered
- Integration tests

## Output Format
For each stage, provide:
- ✅ What looks good
- ⚠️ What needs attention
- 🔴 Critical issues
- 💡 Suggestions for improvement
```

**Benefits**:
- Systematic review process
- Nothing gets missed
- Clear priorities
- Actionable feedback

---

### Pattern: Smart Error Investigation

**Contributed by**: Community
**Use Case**: Debugging production errors efficiently

**Workflow**:

1. **Collect Context** (Haiku, 2 min):
   ```
   You: "Find all places where ErrorCode 'USER_NOT_FOUND' is thrown"
   ```

2. **Analyze Error Pattern** (Sonnet with "think", 5 min):
   ```
   You: "Think about why we're seeing 'USER_NOT_FOUND' errors spike at 2pm daily. Analyze:
   - Cron jobs that run at 2pm
   - Scheduled tasks
   - Peak traffic times
   - Related errors around same time"
   ```

3. **Find Root Cause** (Sonnet, 10 min):
   ```
   You: "The spike correlates with the daily sync job. Analyze the sync job code and identify why it's looking up users that don't exist."
   ```

4. **Propose Fix** (Sonnet, 5 min):
   ```
   You: "Suggest fixes for the sync job to handle deleted users gracefully"
   ```

5. **Implement and Test** (15 min):
   - Implement fix
   - Add tests
   - Verify in staging

**Lesson Learned**: Always correlate errors with time patterns - often reveals scheduled jobs or traffic patterns causing issues.

---

## Optimization Techniques

### Technique: Hybrid Model Strategy

**Contributed by**: Community (Production team at TechCorp)
**Impact**: 73% cost reduction, same quality

**Strategy**: Use different models for different parts of complex tasks

**Example - Feature Implementation**:

```
1. Planning (Sonnet, 10 min, $0.18)
   "Create implementation plan for user notifications feature"

2. Exploration (Haiku, 5 min, $0.05)
   "Find all places where we currently send emails"

3. Code Generation (Sonnet, 20 min, $0.36)
   "Implement notification service following the plan"

4. Testing (Haiku, 10 min, $0.10)
   "Generate unit tests for notification service"

5. Documentation (Haiku, 5 min, $0.05)
   "Generate API documentation for notification endpoints"

Total: 50 min, $0.74

Previous (all Sonnet): 50 min, $1.40
Savings: 47%

Previous (all Opus): 50 min, $2.80
Savings: 73%
```

**Key Insight**: Haiku works great for mechanical tasks (testing, docs, searching). Use Sonnet for creative work (planning, implementation).

---

### Technique: Batch Similar Operations

**Contributed by**: Community
**Impact**: 40% token reduction

**Problem**: Processing items one at a time wastes tokens on repeated context

**Solution**: Batch similar operations

**Before**:
```
You: "Add error handling to the createUser function"
[Claude adds error handling]

You: "Add error handling to the updateUser function"
[Claude adds error handling]

You: "Add error handling to the deleteUser function"
[Claude adds error handling]

Total: 3 conversations, ~30,000 tokens
```

**After**:
```
You: "Add error handling to all CRUD functions in UserService:
- createUser
- updateUser
- deleteUser
- getUser

For each function:
1. Validate input
2. Try-catch database operations
3. Log errors
4. Return appropriate error responses"

Total: 1 conversation, ~18,000 tokens
Savings: 40%
```

**Key Insight**: Batching reduces repeated context and produces more consistent results.

---

### Technique: Incremental Context Building

**Contributed by**: Community
**Use Case**: Large refactoring with limited context window

**Pattern**: Build context incrementally instead of loading everything

**Example - Refactoring Authentication**:

```
Phase 1: Understand Current System (Explore agent, Haiku, 5 min)
"Analyze current authentication system structure and create summary"

Result: 2-page summary of current system
Tokens: ~5,000

Phase 2: Plan Refactoring (Sonnet with "think", summary as context, 15 min)
"Using this summary, plan refactoring to JWT-based auth"

Result: Detailed plan
Tokens: ~12,000

Phase 3: Implement Phase 1 (Sonnet, plan as context, 20 min)
"Implement phase 1 of the plan: JWT token generation"

Result: Code changes
Tokens: ~15,000

Phase 4: Implement Phase 2 (Sonnet, 20 min)
"Implement phase 2: Update middleware"

Result: Code changes
Tokens: ~15,000

Total: 80 min, ~47,000 tokens

Naive Approach (load all files): ~120,000 tokens
Savings: 61%
```

**Key Insight**: Summaries and plans are much smaller than full code, allowing more efficient context usage.

---

## Team Workflows

### Workflow: Distributed Team Code Reviews

**Contributed by**: Community (Remote team at StartupCo)
**Team Size**: 8 developers across 5 timezones

**Problem**: Async code reviews lack context, reviewers miss subtleties

**Solution**: AI-assisted review summaries

**Process**:

1. **Developer Creates PR** (includes):
   - Code changes
   - Manual description
   - Test results

2. **Claude Generates Review Brief** (Sonnet, 5 min):
   ```
   You: "Analyze this PR and create a review brief for human reviewers.

   Include:
   - Summary of changes (2-3 sentences)
   - Files changed and why
   - Potential concerns to check
   - Testing coverage
   - Breaking changes (if any)
   - Areas needing careful review"
   ```

3. **Human Reviews with Context**:
   - Read brief (2 min)
   - Review code with specific concerns in mind (10 min)
   - Add comments

4. **Result**:
   - Review time: 20 min → 12 min (40% faster)
   - Review quality: Improved (fewer missed issues)
   - Context: Better (everyone sees same analysis)

**Template** (added to PR description by automation):
```markdown
## AI Review Brief

**Summary**: [2-3 sentence summary]

**Key Changes**:
- File 1: [reason for changes]
- File 2: [reason for changes]

**Potential Concerns**:
- ⚠️ [Concern 1]
- ⚠️ [Concern 2]

**Testing**: [Coverage summary]

**Breaking Changes**: [Yes/No + details]

**Focus Areas**:
1. [Area needing careful review]
2. [Area needing careful review]
```

---

### Workflow: Onboarding New Developers

**Contributed by**: Community
**Team**: Engineering team at ScaleUp Inc

**Challenge**: New developers took 2-3 weeks to become productive

**Solution**: Interactive Claude-guided onboarding

**Week 1 - Codebase Familiarization**:

Day 1: Architecture Overview
```
You: "I'm a new developer. Give me a guided tour of the codebase architecture.

Start with:
1. High-level overview
2. Main components
3. Data flow
4. Key technologies

Then quiz me to ensure I understand."
```

Day 2-3: Feature Walkthrough
```
You: "Walk me through how the user authentication feature works end-to-end. Show me all the relevant files and explain how they connect."
```

Day 4-5: Hands-on Tasks
```
You: "Help me implement a small feature: Add 'last login' timestamp to user profile. Guide me through:
1. Database schema change
2. API endpoint
3. Frontend display
4. Tests"
```

**Week 2 - Independent Work with Support**:

```
You: "I need to add a password reset feature. Create a plan and guide me through implementation, but let me write the code myself."
```

**Results**:
- Time to first commit: 1 day (was 3 days)
- Time to first feature: 1 week (was 2 weeks)
- Time to full productivity: 10 days (was 15 days)
- Confidence level: Higher

---

## Production Deployments

### Pattern: Pre-Deployment Checklist Automation

**Contributed by**: Community (DevOps team at CloudScale)

**Challenge**: Deployments occasionally broke prod due to missed checks

**Solution**: Claude-powered pre-deployment verification

**Pre-Deployment Hook** (`.claude/hooks/pre-deploy.sh`):

```bash
#!/bin/bash

# Run comprehensive pre-deployment checks

echo "🚀 Pre-Deployment Verification"

# 1. Check for common issues
claude <<EOF
Analyze the changes in this PR and verify:

1. **Environment Variables**: Check if new env vars are needed
2. **Database Migrations**: Check if migrations are safe
3. **Breaking Changes**: Identify any breaking API changes
4. **Dependencies**: Check for new dependencies
5. **Security**: Check for hardcoded secrets or keys
6. **Performance**: Check for potential performance issues
7. **Rollback Plan**: Verify we can rollback if needed

For each item, respond with:
- ✅ OK
- ⚠️ WARNING: [details]
- ❌ BLOCKING: [details]

If any BLOCKING issues, fail the deployment.
EOF

# 2. Run tests
npm test || exit 1

# 3. Check build
npm run build || exit 1

# 4. Verify migrations
npm run migrate:dry-run || exit 1

echo "✅ All pre-deployment checks passed"
```

**Results**:
- Production incidents: 12/year → 2/year (83% reduction)
- Caught before deployment:
  - 8 migrations that would lock tables
  - 15 missing environment variables
  - 6 breaking API changes
  - 3 hardcoded API keys

---

### Pattern: Smart Rollback Decision

**Contributed by**: Community
**Use Case**: Deciding whether to rollback or fix forward

**Situation**: Deployment completed, but errors appearing

**Decision Framework**:

```
You: "We just deployed v2.3.0 and seeing these errors:

[Error logs]

Analyze:
1. Severity of errors (user impact)
2. Percentage of requests affected
3. Can we fix forward quickly? (< 30 min)
4. Is rollback safe? (check migration compatibility)
5. Business impact of downtime vs degraded service

Recommend: ROLLBACK or FIX_FORWARD with reasoning."
```

**Example Analysis**:
```markdown
## Deployment Error Analysis

**Severity**: Medium
- Error: "Unable to load user preferences"
- Impact: Preferences not loading, using defaults
- User can still use app

**Affected**: 15% of requests
- Only users with preferences set before v2.2.0
- New users unaffected

**Fix Forward**: Possible (20 minutes)
- Issue: Migration didn't update preference schema
- Fix: Run supplemental migration
- Risk: Low (data transformation only)

**Rollback Safety**: ⚠️ Complex
- v2.3.0 added new database columns
- Rollback requires down migration
- Risk: 10 min downtime for migration

**Recommendation**: FIX FORWARD

**Reasoning**:
1. Limited user impact (15%, degraded not broken)
2. Quick fix available (20 min)
3. Rollback is risky (requires migration)
4. Fix forward = 0 downtime vs rollback = 10 min downtime

**Action Plan**:
1. Deploy supplemental migration (5 min)
2. Verify fixed in staging (5 min)
3. Deploy to production (5 min)
4. Monitor for 10 min
5. If issues, then rollback
```

---

## Troubleshooting Solutions

### Solution: Debugging Intermittent Test Failures

**Contributed by**: Community
**Problem**: Tests pass locally, fail in CI randomly

**Investigation Process**:

```
You: "These tests fail intermittently in CI but pass locally:

[Test names and error logs]

Analyze potential causes:
1. Timing/race conditions
2. Environment differences
3. Shared state between tests
4. Resource constraints
5. External dependencies

For each test, identify most likely cause."
```

**Common Findings**:

1. **Race Conditions** (60% of cases):
   - Missing `await` statements
   - Not waiting for async operations
   - Testing async code synchronously

2. **Shared State** (25% of cases):
   - Global variables not reset
   - Database not cleared between tests
   - Cached data leaking

3. **Environment Differences** (10% of cases):
   - Different timezones
   - Different Node versions
   - Different dependency versions

4. **Resource Constraints** (5% of cases):
   - CI has less memory
   - CI has slower disk
   - Network latency differences

**Fix Pattern**:
```
You: "Fix this flaky test. The error is: [error]

Apply these principles:
1. Add explicit waits for async operations
2. Clear all state before each test
3. Mock external dependencies
4. Increase timeouts for CI environment
5. Add retry logic for network operations"
```

---

### Solution: Memory Leak Detection

**Contributed by**: Community
**Problem**: Application memory usage grows over time

**Investigation**:

```
You: "Think harder about potential memory leaks in this application.

Analyze:
1. Event listeners not being removed
2. Closures capturing unnecessary data
3. Caches growing unbounded
4. Circular references
5. Global variables accumulating

Check these files:
[List of files]

For each potential leak, explain:
- What's leaking
- Why it's leaking
- How to fix it
- How to prevent it"
```

**Common Patterns Found**:

1. **Event Listeners**:
   ```javascript
   // ❌ Leak: Listener never removed
   window.addEventListener('resize', handleResize);

   // ✅ Fixed: Remove listener
   useEffect(() => {
     window.addEventListener('resize', handleResize);
     return () => window.removeEventListener('resize', handleResize);
   }, []);
   ```

2. **Unbounded Caches**:
   ```javascript
   // ❌ Leak: Cache grows forever
   const cache = new Map();
   function getCached(key) {
     if (!cache.has(key)) {
       cache.set(key, expensiveOperation(key));
     }
     return cache.get(key);
   }

   // ✅ Fixed: LRU cache with size limit
   const cache = new LRUCache({ max: 100 });
   ```

3. **Closures**:
   ```javascript
   // ❌ Leak: Closure captures huge array
   function createHandler(largeArray) {
     return function handler(item) {
       // Uses largeArray, keeping it in memory
       return largeArray.includes(item);
     };
   }

   // ✅ Fixed: Extract only what's needed
   function createHandler(largeArray) {
     const set = new Set(largeArray); // Smaller, faster
     return function handler(item) {
       return set.has(item);
     };
   }
   ```

---

## Industry-Specific Best Practices

### E-Commerce: Inventory Management CLAUDE.md

**Contributed by**: E-commerce developer

```markdown
# E-Commerce Platform

## Critical Data: Inventory

**IMPORTANT**: Inventory operations require special handling

### Inventory Rules
1. **Never** decrement inventory without a transaction
2. **Always** use database transactions for orders
3. **Check** inventory before confirming order
4. **Reserve** inventory during checkout (expire after 10 min)
5. **Log** all inventory changes with reason

### Inventory Operations

#### Reserving Inventory
\`\`\`javascript
// Always use this pattern
async function reserveInventory(productId, quantity) {
  return await db.transaction(async (tx) => {
    const product = await tx.product.findUnique({
      where: { id: productId },
      select: { inventory: true }
    });

    if (product.inventory < quantity) {
      throw new InsufficientInventoryError();
    }

    await tx.product.update({
      where: { id: productId },
      data: { inventory: { decrement: quantity } }
    });

    await tx.inventoryLog.create({
      data: {
        productId,
        change: -quantity,
        reason: 'RESERVATION',
        expiresAt: new Date(Date.now() + 10 * 60 * 1000)
      }
    });
  });
}
\`\`\`

## Testing Inventory
- **Always** test concurrent reservations
- **Always** test reservation expiration
- **Always** test inventory rollback on order cancellation
```

**Result**: Zero oversell incidents since implementing

---

### Healthcare: HIPAA-Compliant Development

**Contributed by**: Healthcare developer

```markdown
# Healthcare Application - HIPAA Compliance Required

## ⚠️ CRITICAL: PHI (Protected Health Information) Handling

### Rules for AI Assistant
1. **NEVER** log PHI (names, SSN, medical records, etc.)
2. **ALWAYS** encrypt PHI at rest and in transit
3. **ALWAYS** use parameterized queries (prevent SQL injection)
4. **NEVER** include PHI in error messages
5. **ALWAYS** audit access to PHI

### PHI Identification
PHI includes:
- Names, addresses, dates (except year)
- Phone numbers, fax numbers, email addresses
- Social Security numbers
- Medical record numbers
- Health plan numbers
- Any other unique identifier

### Code Patterns

#### Logging (NEVER log PHI)
\`\`\`javascript
// ❌ BAD: Logs PHI
logger.info(\`User \${user.name} accessed record \${record.id}\`);

// ✅ GOOD: Logs IDs only
logger.info(\`User \${user.id} accessed record \${record.id}\`, {
  userId: user.id,
  recordId: record.id,
  action: 'READ'
});
\`\`\`

#### Error Messages
\`\`\`javascript
// ❌ BAD: Exposes PHI
throw new Error(\`Patient \${patient.name} not found\`);

// ✅ GOOD: Generic error
throw new Error('Patient not found', { patientId: patient.id });
\`\`\`

## Testing
- **NEVER** use real PHI in tests
- **ALWAYS** use synthetic data generators
- **ALWAYS** test encryption
- **ALWAYS** test audit logs
```

---

## Contributing Your Best Practice

Have a best practice to share? Here's how:

1. **Format**: Follow the pattern structure above
2. **Include**:
   - Clear problem statement
   - Your solution with code
   - Results/impact (metrics preferred)
   - Lessons learned
3. **Submit**: Create PR adding to this file
4. **Review**: Community will review and suggest improvements

**Template**:
```markdown
### Pattern: [Name]

**Contributed by**: [Your name or "Community"]
**Use Case**: [When to use this]

**Problem**: [What problem does this solve]

**Solution**: [Your solution]

**Implementation**:
[Code or detailed steps]

**Results**:
- [Metric 1]
- [Metric 2]

**Lessons Learned**: [Key insights]
```

---

## Stay Updated

This catalog is constantly evolving with community contributions.

- **Star this repo** to get notifications of new best practices
- **Subscribe** to the newsletter for monthly highlights
- **Join Discord** to discuss patterns with other users

---

## Thank You Contributors!

This catalog exists because of contributions from the Claude Code community. Thank you to everyone who has shared their knowledge!

**Top Contributors**:
- 🥇 Community members who shared their production experiences
- 🥈 Early adopters who discovered optimization techniques
- 🥉 Documentation contributors who refined and organized

*Your name here? Submit a best practice!*
