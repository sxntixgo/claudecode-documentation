# Advanced Prompting Techniques

**Reading Time**: 45-50 minutes
**Skill Level**: Intermediate to Advanced
**Prerequisites**: [Advanced Prompting Overview](1-overview.md), [Prompt Basics](../02-prompt-basics/1-overview.md)

---

## The Four Core Techniques

This guide covers four powerful advanced prompting techniques that dramatically improve consistency, quality, and efficiency:

1. **Chain-of-Thought** (CoT) - Guide reasoning step-by-step
2. **Few-Shot Learning** - Teach through examples
3. **Constraint-Based Prompting** - Shape outputs precisely
4. **Meta-Prompting** - Prompts that improve prompts

---

## Technique 1: Chain-of-Thought Prompting

### What Is It?

Chain-of-Thought (CoT) prompting guides Claude through explicit reasoning steps rather than jumping to conclusions.

**Basic prompt** (no CoT):
```
"Find the security vulnerability in this code"
```

**Chain-of-Thought prompt**:
```
"Analyze this code for security vulnerabilities using these steps:
1. Identify all user inputs
2. Trace each input through the code
3. Check for validation at each step
4. List any missing validations
5. Assess severity of each vulnerability
6. Provide remediation for each issue"
```

### Why It Works

- **Reduces errors**: Explicit steps prevent Claude from skipping important checks
- **Improves consistency**: Same steps = same quality across tasks
- **Enables verification**: You can see the reasoning process
- **Catches edge cases**: Systematic approach finds what intuition misses

---

### Pattern: The Explicit Steps Template

```
Task: [What to do]

Follow these steps:
1. [First step - often "analyze" or "identify"]
2. [Second step - often "evaluate" or "check"]
3. [Third step - often "categorize" or "prioritize"]
4. [Final step - often "provide recommendations" or "summarize"]

For each step, show your work before moving to the next.
```

---

### Example 1: Code Review with CoT

**❌ Without CoT**:
```
"Review this authentication function for issues"
```

Result: Inconsistent depth, might miss subtle issues

**✅ With CoT**:
```
"Review this authentication function using this systematic approach:

Step 1: Input Validation
- List all inputs (username, password, tokens, etc.)
- Check validation for each
- Note any missing validation

Step 2: Authentication Logic
- Verify password hashing (should be bcrypt/argon2)
- Check for timing attacks
- Verify token generation is cryptographically secure

Step 3: Session Management
- Check session token storage (HttpOnly, Secure flags)
- Verify session expiration logic
- Check for session fixation vulnerabilities

Step 4: Error Handling
- Verify errors don't leak information
- Check for proper logging (no password logging)

Step 5: Summary
- List all issues found by severity (Critical, High, Medium, Low)
- Provide fix for each issue with code example

Show findings for each step before proceeding to the next."
```

Result: Comprehensive, consistent reviews

---

### Example 2: Bug Diagnosis with CoT

**✅ CoT Bug Diagnosis**:
```
"Diagnose why users can't log in. Use this systematic approach:

Step 1: Reproduce
- Describe exact steps to reproduce the issue
- Note any error messages or symptoms

Step 2: Isolate
- Check frontend (form submission, validation)
- Check network (API call, response)
- Check backend (authentication logic, database query)
- Identify which layer is failing

Step 3: Root Cause
- Examine code at the failing layer
- Check recent changes (git log)
- Identify the specific line/function causing failure

Step 4: Explain
- Why is this happening?
- What conditions trigger it?

Step 5: Fix
- Provide code fix
- Explain why the fix works
- Suggest how to prevent similar issues

Document findings at each step."
```

---

### When to Use CoT

| Use CoT When... | Skip CoT When... |
|----------------|------------------|
| Task requires systematic checking | Task is simple/straightforward |
| Consistency matters (reusable pattern) | One-off task with no reuse |
| Multiple steps needed | Single-step task |
| Quality > speed | Speed > thoroughness |
| Debugging complex issues | Simple obvious fixes |

---

### CoT for Skills

Chain-of-Thought is **perfect for skills** since you define the steps once and reuse them:

```markdown
# .claude/skills/systematic-refactor/SKILL.md
name: systematic-refactor
description: Refactor code systematically

## Progressive Disclosure

### Step 1: Analyze Current Code
Examine the code to refactor:
1. Identify code smells (duplication, long functions, deep nesting)
2. Note dependencies and side effects
3. List test coverage

### Step 2: Plan Refactoring
Based on analysis:
1. Define refactoring goals
2. Break into small, safe steps
3. Identify risks

### Step 3: Execute Refactoring
For each step:
1. Make the change
2. Run tests
3. Verify behavior unchanged

### Step 4: Verify
1. Run full test suite
2. Check for regressions
3. Verify performance unchanged
```

---

## Technique 2: Few-Shot Learning

### What Is It?

Few-shot learning teaches Claude through **examples** rather than instructions.

**Zero-shot** (no examples):
```
"Write a commit message for these changes"
```

**Few-shot** (with examples):
```
"Write a commit message following these examples:

Example 1:
Changes: Added user authentication
Message: "Add JWT authentication with refresh tokens

- Implement login endpoint with bcrypt password hashing
- Add refresh token rotation for security
- Include rate limiting on auth endpoints"

Example 2:
Changes: Fixed null pointer bug
Message: "Fix null pointer exception in user profile

- Add null check before accessing user.email
- Add defensive programming in profile renderer
- Prevent crash when user data is incomplete"

Example 3:
Changes: Refactored database queries
Message: "Optimize database queries for user dashboard

- Add index on user_id and created_at columns
- Replace N+1 query with single JOIN
- Reduce query time from 3s to 300ms"

Now write a commit message for these changes: [your changes]"
```

### Why It Works

- **Implicit patterns**: Claude learns format, tone, level of detail from examples
- **Consistency**: Examples establish a standard to match
- **Less ambiguity**: "Like this" > long explanations
- **Transfer learning**: Claude extracts patterns and applies them

---

### Pattern: The Few-Shot Template

```
Task: [What to do]

Examples of desired output:

Example 1:
Input: [Sample input]
Output: [Desired output]

Example 2:
Input: [Sample input]
Output: [Desired output]

Example 3:
Input: [Sample input]
Output: [Desired output]

Now apply this pattern to:
Input: [Your actual input]
```

---

### Example 1: API Documentation

**✅ Few-Shot API Docs**:
```
"Generate API documentation following these examples:

Example 1:
Endpoint: POST /api/users
Docs:
```
**POST /api/users**

Create a new user account.

**Request Body**:
\```json
{
  "email": "user@example.com",
  "password": "securePass123",
  "name": "John Doe"
}
\```

**Response** (201 Created):
\```json
{
  "id": "usr_123",
  "email": "user@example.com",
  "name": "John Doe",
  "createdAt": "2025-01-15T10:30:00Z"
}
\```

**Errors**:
- `400` - Invalid email format or weak password
- `409` - Email already exists
```

Example 2:
Endpoint: GET /api/users/:id
Docs:
```
**GET /api/users/:id**

Retrieve user details by ID.

**Path Parameters**:
- `id` (string, required) - User ID (format: usr_*)

**Response** (200 OK):
\```json
{
  "id": "usr_123",
  "email": "user@example.com",
  "name": "John Doe",
  "createdAt": "2025-01-15T10:30:00Z"
}
\```

**Errors**:
- `404` - User not found
- `401` - Unauthorized (no valid token)
```

Now generate documentation for: DELETE /api/users/:id"
```

---

### Example 2: Test Case Generation

**✅ Few-Shot Test Cases**:
```
"Generate test cases following these examples:

Example 1:
Function: validateEmail(email)
Test cases:
\```javascript
describe('validateEmail', () => {
  it('should accept valid email', () => {
    expect(validateEmail('user@example.com')).toBe(true);
  });

  it('should reject email without @', () => {
    expect(validateEmail('userexample.com')).toBe(false);
  });

  it('should reject email without domain', () => {
    expect(validateEmail('user@')).toBe(false);
  });

  it('should handle edge case: plus addressing', () => {
    expect(validateEmail('user+tag@example.com')).toBe(true);
  });
});
\```

Example 2:
Function: calculateDiscount(price, discountPercent)
Test cases:
\```javascript
describe('calculateDiscount', () => {
  it('should calculate 10% discount correctly', () => {
    expect(calculateDiscount(100, 10)).toBe(90);
  });

  it('should handle 0% discount', () => {
    expect(calculateDiscount(100, 0)).toBe(100);
  });

  it('should handle 100% discount', () => {
    expect(calculateDiscount(100, 100)).toBe(0);
  });

  it('should throw error for invalid percent', () => {
    expect(() => calculateDiscount(100, -10)).toThrow();
    expect(() => calculateDiscount(100, 150)).toThrow();
  });
});
\```

Now generate test cases for: formatCurrency(amount, currencyCode)"
```

---

### How Many Examples?

| Complexity | Examples Needed | Reasoning |
|------------|----------------|-----------|
| **Simple format** | 1-2 | Pattern is obvious |
| **Standard task** | 2-3 | Show variation and edge cases |
| **Complex pattern** | 3-5 | Show nuances and exceptions |
| **Highly specific** | 5+ | Establish clear boundaries |

**Rule of thumb**: 3 examples covers 90% of use cases

---

### Combining Few-Shot + CoT

**Powerful combo**: Use few-shot to show format, CoT to ensure thoroughness:

```
"Generate code review comments using this approach:

EXAMPLES (format):
[Show 2-3 example review comments]

PROCESS (systematic):
1. Review code structure
2. Check for security issues
3. Verify error handling
4. Assess performance
5. Provide recommendations

Use the format from examples, following the systematic process."
```

---

## Technique 3: Constraint-Based Prompting

### What Is It?

Constraint-based prompting uses **explicit boundaries** to shape output precisely.

**Without constraints**:
```
"Explain how authentication works"
```
Result: Might be too long, too technical, or miss key points

**With constraints**:
```
"Explain how JWT authentication works with these constraints:
- Audience: Junior developers (2 years experience)
- Length: Maximum 200 words
- Must include: Token structure, signing, verification
- Must avoid: Deep cryptography details
- Format: Bullet points
- Include: One code example (< 10 lines)"
```

### Why It Works

- **Precision**: Gets exactly what you need, not what's "typical"
- **Efficiency**: Avoid back-and-forth refinements
- **Consistency**: Same constraints = same output format
- **Control**: You define "good enough"

---

### Types of Constraints

#### 1. **Length Constraints**
```
- Maximum 200 words
- Exactly 3 bullet points
- One sentence per step
- Code example: < 15 lines
```

#### 2. **Content Constraints**
```
- Must include: [required elements]
- Must avoid: [forbidden elements]
- Focus on: [specific aspects]
- Exclude: [out-of-scope topics]
```

#### 3. **Format Constraints**
```
- Format: Bullet points / Numbered list / Prose
- Structure: Problem → Solution → Example
- Style: Formal / Casual / Technical
- Code: Language, framework, pattern
```

#### 4. **Audience Constraints**
```
- Audience: Beginners / Experts / Mixed
- Assume knowledge: [list prerequisites]
- Avoid jargon except: [acceptable terms]
```

#### 5. **Quality Constraints**
```
- Include: Code examples, error handling
- Verify: Syntax, edge cases, security
- Test: Must compile/run
```

---

### Example 1: Code Generation with Constraints

**✅ Constrained Code Generation**:
```
"Create a password validator function with these constraints:

Language: TypeScript
Style: Functional (no classes)
Requirements:
  - Minimum 8 characters
  - At least one uppercase, lowercase, number, symbol
  - No common passwords (check against list)

Constraints:
  - Function signature: validatePassword(password: string): { valid: boolean; errors: string[] }
  - Return structured error messages (not just true/false)
  - Include JSDoc comments
  - Maximum 30 lines of code
  - Include 5 test cases
  - No external dependencies

Output format:
1. Function implementation
2. Test cases
3. Usage example"
```

---

### Example 2: Documentation with Constraints

**✅ Constrained Documentation**:
```
"Document the user registration API endpoint with these constraints:

Content requirements:
  - Include: Method, URL, auth requirements, request body, response, errors
  - Exclude: Implementation details, database schema

Format:
  - Use markdown
  - JSON examples must be prettified
  - Error codes in table format

Quality:
  - All JSON must be valid (test it)
  - Include both success and error examples
  - Cover 3 most common error scenarios

Audience: Frontend developers (assume REST API knowledge)

Length: 150-250 words (excluding code examples)"
```

---

### Constraint Patterns

#### Pattern 1: The Quality Gate

```
"[Task description]

Quality constraints:
✅ Must pass: [non-negotiable requirements]
⚠️  Should include: [nice-to-haves]
❌ Must avoid: [dealbreakers]

Verify each constraint before submitting output."
```

#### Pattern 2: The Specification

```
"[Task description]

Specifications:
- Input format: [exact format]
- Output format: [exact format]
- Processing rules: [step-by-step]
- Edge cases: [list]
- Success criteria: [how to verify]"
```

---

## Technique 4: Meta-Prompting

### What Is It?

Meta-prompting is using Claude to **improve your prompts**.

**Direct approach** (no meta):
```
[Your prompt] → [Claude's response]
```

**Meta-prompting approach**:
```
"Improve this prompt: [your prompt]

Make it:
- More specific
- Include success criteria
- Add relevant constraints
- Optimize for cost (use Haiku if possible)"

→ [Claude provides improved prompt]
→ Use improved prompt for actual task
```

### Why It Works

- **Learn faster**: See what makes a good prompt
- **Continuous improvement**: Each refinement teaches you
- **Time saver**: Get to optimal prompt faster
- **Training tool**: Understand prompt engineering principles

---

### Pattern: Prompt Improvement Template

```
"Analyze and improve this prompt:

[Your current prompt]

Improvements needed:
1. Make intent clearer
2. Add missing context
3. Include constraints
4. Specify output format
5. Add success criteria

Provide:
- Analysis of current prompt (what's missing/unclear)
- Improved version
- Explanation of changes"
```

---

### Example 1: Improving a Vague Prompt

**Original prompt**:
```
"Make the code better"
```

**Meta-prompt**:
```
"Improve this prompt to be specific and actionable:

Current: 'Make the code better'

Context: The code is a React component with performance issues

Desired improvements:
- Specific about what 'better' means
- Include success criteria
- Specify constraints (don't break functionality)
- Measurable outcomes"
```

**Claude's improved prompt**:
```
"Optimize this React component for performance:

Current issues:
- Component re-renders on every parent update
- No memoization
- Inline function definitions

Goals:
- Reduce re-renders by 80%+
- Maintain current functionality
- Keep code readable

Constraints:
- Use React.memo, useMemo, useCallback
- Don't change component API
- Include before/after performance comparison

Success criteria:
- React DevTools Profiler shows < 2 renders per user action
- No regression in functionality tests"
```

---

### Example 2: Optimizing for Cost

**Meta-prompt for cost**:
```
"Optimize this prompt for cost while maintaining quality:

Current prompt: [your expensive prompt]

Goal: Achieve same results with Haiku instead of Sonnet

Strategies to try:
- Remove redundant context
- Make instructions more direct
- Remove unnecessary examples
- Simplify output format

Provide:
- Optimized version
- Estimated token savings
- Quality trade-offs (if any)"
```

---

## Combining Techniques: The Power of Integration

The real power comes from **combining** these techniques:

### Example: Production Code Review System

```markdown
# Combines ALL four techniques

"Review this code systematically for production readiness.

## CHAIN-OF-THOUGHT (systematic steps):
Step 1: Security Analysis
Step 2: Performance Check
Step 3: Error Handling
Step 4: Code Quality
Step 5: Recommendations

## FEW-SHOT (format examples):
[Include 2 example reviews showing desired format]

## CONSTRAINTS:
- Audience: Senior developers
- Format: Markdown checklist
- Length: Issues listed by severity
- Must include: Code snippets for fixes
- Severity levels: Critical, High, Medium, Low

## META (quality gate):
Before submitting, verify:
✅ All 5 steps completed
✅ Matches example format
✅ Each issue has code fix
✅ Severity accurately assessed

Process: Complete each CoT step, format like examples, verify constraints."
```

---

## Decision Matrix: Which Technique When?

| Situation | Best Technique | Why |
|-----------|---------------|------|
| Need consistent multi-step process | **Chain-of-Thought** | Ensures all steps followed |
| Want specific output format | **Few-Shot** | Examples > descriptions |
| Need precise, bounded output | **Constraints** | Explicit boundaries |
| Prompt not working well | **Meta-Prompting** | Let Claude help improve |
| Complex production workflow | **All combined** | Maximum control + quality |

---

## Common Mistakes

### ❌ Mistake 1: Too Many Constraints

**Bad**:
```
"Write a function with these 25 constraints..."
```

**Better**: Focus on 3-5 most important constraints. Over-constraining makes prompts brittle.

---

### ❌ Mistake 2: Examples That Don't Match Task

**Bad**: Showing 3 examples of API documentation, then asking for a UI component

**Better**: Examples must closely match the actual task

---

### ❌ Mistake 3: CoT Steps Too Granular

**Bad**:
```
"Step 1: Open the file
Step 2: Read line 1
Step 3: Read line 2..."
```

**Better**: Steps at right abstraction level (analyze → evaluate → recommend)

---

### ❌ Mistake 4: Meta-Prompting Every Time

**Bad**: Using meta-prompting for simple, well-understood tasks

**Better**: Meta-prompt when stuck or building new patterns

---

## Practice Exercises

### Exercise 1: Add CoT to This Prompt

Transform this basic prompt with chain-of-thought:

**Basic**: "Find performance issues in this code"

**Your CoT version**: _______

<details>
<summary>💡 Suggested Answer</summary>

```
"Find performance issues using this systematic approach:

Step 1: Identify Hotspots
- Profile the code (identify slow functions)
- Measure: Which functions take > 100ms?

Step 2: Analyze Each Hotspot
- Unnecessary computations?
- Inefficient algorithms?
- Missing caching?

Step 3: Quantify Impact
- Current time: [measurement]
- Expected after fix: [estimate]

Step 4: Recommend Fixes
- Specific code changes
- Expected performance improvement

Document findings at each step."
```

</details>

---

### Exercise 2: Create Few-Shot Examples

Create 2-3 few-shot examples for generating SQL queries from natural language.

**Task**: "Generate SQL query from: Show me all users who signed up last week"

**Your examples**: _______

<details>
<summary>💡 Suggested Answer</summary>

```
Example 1:
Input: "Show me all active users"
Output:
\```sql
SELECT * FROM users
WHERE status = 'active';
\```

Example 2:
Input: "Count users by country"
Output:
\```sql
SELECT country, COUNT(*) as user_count
FROM users
GROUP BY country
ORDER BY user_count DESC;
\```

Example 3:
Input: "Find users who haven't logged in for 30 days"
Output:
\```sql
SELECT id, email, last_login
FROM users
WHERE last_login < NOW() - INTERVAL '30 days'
ORDER BY last_login DESC;
\```
```

</details>

---

## Quick Reference

### CoT Checklist
- [ ] Break task into 3-5 clear steps
- [ ] Each step is measurable/verifiable
- [ ] Steps flow logically
- [ ] Request output after each step

### Few-Shot Checklist
- [ ] 2-3 examples (3 is optimal)
- [ ] Examples closely match target task
- [ ] Show variation and edge cases
- [ ] Consistent format across examples

### Constraints Checklist
- [ ] Define length limits
- [ ] Specify output format
- [ ] Set content boundaries
- [ ] Include quality gates
- [ ] Keep to 3-5 key constraints

### Meta-Prompting Checklist
- [ ] Provide current prompt
- [ ] Specify desired improvements
- [ ] Give context about task
- [ ] Request analysis + improved version

---

## Next Steps

You've learned the four core advanced techniques. Next, learn how to integrate them with Claude Code's context system:

**→ [Continue to Context Optimization](3-context-optimization.md)**

Learn how to use CLAUDE.md files, context layering, and memory management for maximum efficiency.

---

## Summary

**Four Advanced Techniques**:
1. ✅ **Chain-of-Thought**: Systematic step-by-step reasoning
2. ✅ **Few-Shot Learning**: Teaching through examples
3. ✅ **Constraint-Based**: Precise output control
4. ✅ **Meta-Prompting**: Prompts that improve prompts

**Key Takeaways**:
- Combine techniques for maximum power
- CoT for consistency, few-shot for format, constraints for precision
- Use meta-prompting to continuously improve
- 3 examples is the sweet spot for few-shot
- Keep constraints to 3-5 most important

**Time invested**: 45 minutes
**Skills gained**: Production-ready prompting techniques

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
