# Prompt Engineering Basics

**Reading Time**: 15-20 minutes
**Skill Level**: Beginner
**Prerequisites**: None - Start here!

---

## Why Prompting Matters

The difference between a vague prompt and a good prompt can mean:

- **5 seconds vs 5 minutes** to get the right answer
- **$0.02 vs $0.20** in API costs
- **First try vs multiple iterations** to achieve your goal

**Example**:

❌ **Vague Prompt** (costs more, takes longer):
```
"Make the code better"
```
Claude response: "What aspect would you like me to improve? Performance, readability, error handling, testing...?"

✅ **Good Prompt** (gets it done):
```
"Refactor the authentication function in auth.ts to use async/await instead of promises,
and add error handling for network timeouts"
```
Claude response: *[Makes the exact changes requested]*

**Time saved**: 3-4 minutes
**Cost saved**: ~$0.10

---

## The Basic Formula

Every effective prompt has four components:

```
Clear Intent + Sufficient Context + Specific Constraints + Success Criteria
```

### 1. Clear Intent (What you want)

Be specific about the action:

| ❌ Vague | ✅ Clear |
|---------|---------|
| "Look at this code" | "Review this code for security vulnerabilities" |
| "Help with tests" | "Write unit tests for the login function" |
| "Fix the bug" | "Fix the null pointer exception on line 42" |

### 2. Sufficient Context (What Claude needs to know)

Provide relevant information:

```
# ❌ Missing context
"Add validation"

# ✅ With context
"Add email validation to the signup form in src/components/Signup.tsx
using the validator library we're already using"
```

### 3. Specific Constraints (Boundaries and requirements)

Define how it should be done:

```
# ❌ No constraints
"Add a database"

# ✅ With constraints
"Add PostgreSQL database connection using the 'pg' library,
store credentials in .env file, don't commit .env to git"
```

### 4. Success Criteria (How you'll know it's done)

State what "done" looks like:

```
# ❌ No success criteria
"Optimize the code"

# ✅ With success criteria
"Optimize the data processing function to handle 10,000 records
in under 2 seconds, verified by the benchmark test"
```

---

## Quick Wins: Before & After

### Win 1: Bug Fixes

**❌ Before (vague)**:
```
"There's a bug in the checkout"
```

**✅ After (specific)**:
```
"Fix the bug where clicking 'Checkout' twice creates duplicate orders.
The issue is in src/checkout.ts, likely missing a loading state check"
```

**Why better**: Claude knows exactly what to look for and where.

---

### Win 2: Code Creation

**❌ Before (vague)**:
```
"Create a user component"
```

**✅ After (specific)**:
```
"Create a React functional component called UserProfile that displays
user name, email, and avatar. Use TypeScript, follow our existing
component pattern in src/components/, and use Tailwind for styling"
```

**Why better**: Matches your project's tech stack and conventions.

---

### Win 3: Refactoring

**❌ Before (vague)**:
```
"Clean up the code"
```

**✅ After (specific)**:
```
"Refactor the data fetching logic in Dashboard.tsx:
- Extract API calls to a separate service file
- Add error handling with user-friendly messages
- Keep the existing functionality unchanged"
```

**Why better**: Clear scope and preserves existing behavior.

---

### Win 4: Code Review

**❌ Before (vague)**:
```
"Review my code"
```

**✅ After (specific)**:
```
"Review src/api/auth.ts for:
- Security vulnerabilities (SQL injection, XSS)
- Error handling completeness
- TypeScript type safety
Prioritize security issues"
```

**Why better**: Focused review on what matters most.

---

### Win 5: Explanations

**❌ Before (vague)**:
```
"Explain this code"
```

**✅ After (specific)**:
```
"Explain how the caching mechanism works in src/cache.ts,
specifically the TTL (time-to-live) logic and when cached data is invalidated"
```

**Why better**: Gets explanation of the specific part you're confused about.

---

## Complete Example: The Four-Part Formula

Let's build a complete prompt using all four components:

```
# Task: Add a feature to export data

❌ VAGUE PROMPT:
"Add export functionality"

✅ COMPLETE PROMPT:

"[INTENT] Add CSV export functionality to the user dashboard

[CONTEXT]
- File: src/components/UserDashboard.tsx
- We're using React + TypeScript
- Export button should appear next to the existing 'Filter' button

[CONSTRAINTS]
- Use the 'papaparse' library for CSV generation
- Include columns: name, email, signup_date, account_status
- Download should use browser's native download (no server upload)
- File name format: users_export_YYYY-MM-DD.csv

[SUCCESS CRITERIA]
- Clicking 'Export' downloads a CSV file immediately
- All active users appear in the export
- CSV opens correctly in Excel/Google Sheets"
```

**Result**: Claude knows exactly what to build, how to build it, and how to verify success.

---

## Top 5 Beginner Mistakes

### ❌ Mistake 1: Being Too Polite

**Bad**:
```
"Hi Claude! I hope you're having a great day! I was wondering if maybe
you could possibly help me with something if you have time? I have this
small issue with my code and I would really appreciate it if..."
```

**Good**:
```
"Fix the syntax error in app.ts line 23"
```

**Why**: Claude doesn't need pleasantries. Be direct and save tokens (cost).

---

### ❌ Mistake 2: Asking Before Acting

**Bad**:
```
User: "Can you help me add authentication?"
Claude: "Yes, I can help! What authentication method would you like?"
User: "JWT tokens"
Claude: "Where should I implement this?"
User: "In the backend"
...
[5 back-and-forth messages later, work finally begins]
```

**Good**:
```
"Add JWT authentication to the Express backend in src/auth/.
Use bcrypt for password hashing, store tokens in HTTP-only cookies,
implement login, logout, and refresh token endpoints"
```

**Why**: One clear prompt > five vague messages. Saves time and cost.

---

### ❌ Mistake 3: Omitting File Locations

**Bad**:
```
"Update the login function"
```

**Good**:
```
"Update the login function in src/auth/login.ts"
```

**Why**: Claude won't have to search or ask where the file is.

---

### ❌ Mistake 4: No Constraints = Surprise Results

**Bad**:
```
"Add a database to the project"
```

*Claude might add MongoDB when you use PostgreSQL everywhere else*

**Good**:
```
"Add PostgreSQL database connection using Prisma ORM (we already use it
for the user service). Connection string in .env, migration files in
prisma/migrations/"
```

**Why**: Constraints ensure consistency with your existing codebase.

---

### ❌ Mistake 5: Combining Unrelated Tasks

**Bad**:
```
"Fix the login bug and also add dark mode and refactor the navbar and
write tests for the checkout flow and update the README"
```

**Good** (separate prompts):
```
1. "Fix the login bug where users can't log in with email addresses
   containing '+' characters. Issue is in src/auth/validator.ts"

2. "Add dark mode toggle to the navbar using CSS variables. Follow the
   existing theme pattern in src/styles/theme.ts"

3. "Refactor the navbar component in src/components/Navbar.tsx to use
   composition pattern instead of conditional rendering"
```

**Why**: One task per prompt = clearer results, easier to verify, better debugging.

---

## Practice: Transform These Prompts

Try improving these vague prompts using the four-part formula:

### Exercise 1
❌ **Vague**: "The tests are failing"

✅ **Your answer**: (Try it yourself first!)

<details>
<summary>💡 Suggested Answer</summary>

```
"Fix the failing test 'should validate email format' in src/tests/auth.test.ts.
The test expects the validator to reject emails without @ symbol,
but it's currently passing invalid emails"
```

</details>

---

### Exercise 2
❌ **Vague**: "Make it faster"

✅ **Your answer**: (Try it yourself first!)

<details>
<summary>💡 Suggested Answer</summary>

```
"Optimize the user search function in src/api/search.ts.
Currently takes 3+ seconds for 10,000 users.
Target: < 500ms by adding database indexing on the email and name columns"
```

</details>

---

### Exercise 3
❌ **Vague**: "Add comments"

✅ **Your answer**: (Try it yourself first!)

<details>
<summary>💡 Suggested Answer</summary>

```
"Add JSDoc comments to the public API functions in src/api/users.ts.
Include parameter types, return types, and brief description of what each function does.
Focus on the exported functions only, not internal helpers"
```

</details>

---

## Quick Reference Card

Keep this handy while you work:

### The Prompt Formula

| Component | Description | Example |
|-----------|-------------|---------|
| **1. INTENT** | What action (fix, create, refactor) | "Fix the login timeout error" |
| **2. CONTEXT** | Where (file path, tech stack) | "in src/auth/login.ts" |
| **3. CONSTRAINTS** | How (requirements, don'ts) | "by increasing API timeout from 5s to 30s. Don't change retry logic" |
| **4. SUCCESS** | Done when (criteria, tests) | "Users can log in on slow connections" |

**Complete Example**:
> "Fix the login timeout error in src/auth/login.ts by increasing the API timeout from 5s to 30s. Don't change the retry logic. Success: Users can log in on slow connections."

---

## Common Patterns Cheat Sheet

| Task Type | Prompt Template |
|-----------|----------------|
| **Bug Fix** | "Fix [specific error] in [file]:[line]. Error occurs when [scenario]" |
| **New Feature** | "Add [feature] to [file/component] using [technology]. Requirements: [list]" |
| **Refactor** | "Refactor [file/function] to [improvement]. Keep [existing behavior] unchanged" |
| **Tests** | "Write [test type] tests for [function] in [file]. Cover: [scenarios]" |
| **Review** | "Review [file] for [specific issues]. Prioritize [what matters most]" |
| **Explain** | "Explain how [specific part] works in [file], specifically [aspect]" |

---

## What's Next?

Now that you understand the basics, learn the 7 essential prompt patterns:

**Continue to**: [Core Prompt Patterns](2-core-patterns.md)

In the next guide, you'll learn ready-to-use templates for:
- CREATE (building new features)
- FIX (debugging and repairs)
- REFACTOR (improving existing code)
- REVIEW (code review and analysis)
- EXPLAIN (understanding code)
- TEST (writing tests)
- OPTIMIZE (performance improvements)

---

## Key Takeaways

✅ **Use the four-part formula**: Intent + Context + Constraints + Success Criteria
✅ **Be specific**: "Fix X in Y" beats "something's broken"
✅ **One task per prompt**: Focus > multitasking
✅ **Skip the small talk**: Be direct, save tokens
✅ **Include file paths**: Help Claude find the right code

---

## References & Further Reading

### Official Documentation

**Anthropic Resources** (Most Current):
- [Anthropic Prompt Engineering Guide](https://docs.anthropic.com/claude/docs/prompt-engineering) - Official Claude prompting techniques and best practices
- [Anthropic Prompt Library](https://docs.anthropic.com/claude/page/prompts) - 50+ production-ready prompt examples
- [Claude API Documentation](https://docs.anthropic.com/claude/reference) - Technical reference for Claude integration

### Security

**Safe AI Usage**:
- [OWASP Top 10 for LLMs](https://owasp.org/www-project-top-10-for-large-language-model-applications/) (Updated 2024)
  - LLM01: Prompt Injection - Understanding and preventing malicious prompts
  - LLM02: Insecure Output Handling - Safe processing of AI responses

### Community Resources

- [Model Context Protocol](https://modelcontextprotocol.io) - Official MCP documentation for extending Claude Code
- [Claude Code GitHub Discussions](https://github.com/anthropics/claude-code/discussions) - Community patterns and solutions

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
