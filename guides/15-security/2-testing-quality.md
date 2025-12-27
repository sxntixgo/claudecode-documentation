# Testing & Quality Guide

**Reading Time**: 40 minutes
**Skill Level**: Intermediate to Advanced
**Prerequisites**: [Understanding Agents](../03-agents/1-overview.md), [Skills Basics](../04-skills/1-overview.md)

---

## Welcome to Quality Assurance

You've written code with Claude's help. Now let's ensure it's thoroughly tested and maintains high quality standards.

By the end of this guide, you'll understand:
- Testing MCP servers (unit, integration, e2e)
- Testing custom skills (behavior validation)
- Testing agents (isolated testing)
- Quality gates and pre-commit hooks
- TDD/BDD patterns with Claude Code
- Test automation strategies

---

## Part 1: Testing MCP Servers

### Unit Testing MCP Tools

**src/tools/calculateSum.ts:**
```typescript
export async function calculateSum(numbers: number[]): Promise<number> {
  if (!Array.isArray(numbers)) {
    throw new Error('Input must be an array')
  }
  if (numbers.length === 0) {
    throw new Error('Array must not be empty')
  }
  return numbers.reduce((a, b) => a + b, 0)
}
```

**tests/tools/calculateSum.test.ts:**
```typescript
import { describe, it, expect } from 'vitest'
import { calculateSum } from '../../src/tools/calculateSum'

describe('calculateSum', () => {
  // Happy path
  it('should sum positive numbers', () => {
    expect(calculateSum([1, 2, 3])).toBe(6)
  })

  it('should handle negative numbers', () => {
    expect(calculateSum([-1, -2, -3])).toBe(-6)
  })

  // Edge cases
  it('should handle single number', () => {
    expect(calculateSum([5])).toBe(5)
  })

  it('should handle zeros', () => {
    expect(calculateSum([0, 0, 0])).toBe(0)
  })

  // Error cases
  it('should throw on empty array', () => {
    expect(() => calculateSum([])).toThrow('Array must not be empty')
  })

  it('should throw on non-array input', () => {
    expect(() => calculateSum('not an array' as any)).toThrow()
  })

  // Boundary conditions
  it('should handle large numbers', () => {
    expect(calculateSum([1e10, 2e10])).toBe(3e10)
  })
})
```

### Integration Testing MCP Server

**tests/mcp-server.integration.test.ts:**
```typescript
import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { startMCPServer } from '../src/server'

describe('MCP Server Integration', () => {
  let server: any

  beforeAll(async () => {
    server = await startMCPServer({ port: 3001 })
  })

  afterAll(async () => {
    await server.close()
  })

  it('should initialize tools correctly', async () => {
    const tools = server.getTools()
    expect(tools).toContainEqual(
      expect.objectContaining({ name: 'calculateSum' })
    )
  })

  it('should handle tool invocation', async () => {
    const result = await server.invokeTool('calculateSum', {
      numbers: [1, 2, 3]
    })
    expect(result).toEqual({ sum: 6 })
  })

  it('should handle invalid tool calls', async () => {
    const result = await server.invokeTool('unknownTool', {})
    expect(result.error).toBeDefined()
  })

  it('should isolate tool state', async () => {
    // Tool 1 execution
    const result1 = await server.invokeTool('calculateSum', {
      numbers: [1, 2]
    })

    // Tool 2 execution
    const result2 = await server.invokeTool('calculateSum', {
      numbers: [3, 4]
    })

    // Results should be independent
    expect(result1).not.toEqual(result2)
  })
})
```

### Performance Testing

**tests/mcp-server.performance.test.ts:**
```typescript
import { describe, it, expect } from 'vitest'
import { calculateSum } from '../src/tools/calculateSum'

describe('MCP Server Performance', () => {
  it('should handle large arrays efficiently', () => {
    const largeArray = Array.from({ length: 10000 }, (_, i) => i)
    const start = performance.now()

    calculateSum(largeArray)

    const end = performance.now()
    const duration = end - start

    // Should complete in < 100ms
    expect(duration).toBeLessThan(100)
  })

  it('should not have memory leaks', async () => {
    const initialMemory = process.memoryUsage().heapUsed
    const iterations = 1000

    for (let i = 0; i < iterations; i++) {
      await calculateSum([1, 2, 3, 4, 5])
    }

    const finalMemory = process.memoryUsage().heapUsed
    const memoryIncrease = finalMemory - initialMemory

    // Memory increase should be reasonable
    expect(memoryIncrease).toBeLessThan(10 * 1024 * 1024) // 10MB
  })
})
```

---

## Part 2: Testing Custom Skills

### Skill Behavior Testing

**skills/code-review-skill/SKILL.md:**
```markdown
---
name: code-review-skill
version: 1.0.0
---

# Code Review Skill

You help developers review code for quality and best practices.

When invoked:
1. Ask for file path or paste code
2. Perform quick review
3. Suggest improvements
```

**skills/code-review-skill/tests/behavior.test.ts:**
```typescript
import { describe, it, expect } from 'vitest'
import { invokeClaude } from '../../../src/claude-api'

describe('Code Review Skill Behavior', () => {
  it('should identify syntax errors', async () => {
    const code = `
      function broken() {
        const x = 5
        return x
      // Missing closing brace
    `

    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: code
    })

    expect(result).toContain('syntax')
    expect(result.toLowerCase()).toContain('error')
  })

  it('should suggest improvements', async () => {
    const code = `
      function add(a, b) {
        var sum = a + b
        return sum
      }
    `

    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: code
    })

    // Should suggest const over var
    expect(result.toLowerCase()).toContain('const')
  })

  it('should recognize security issues', async () => {
    const code = `
      const password = 'my-secret-password'
      db.connect(password)
    `

    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: code
    })

    expect(result.toLowerCase()).toContain('hardcod')
    expect(result.toLowerCase()).toContain('secret')
  })

  it('should work with different languages', async () => {
    const pythonCode = `
      def greet(name):
          print(f"Hello, {name}")
    `

    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: pythonCode
    })

    expect(result).toBeDefined()
    expect(result.length > 0).toBe(true)
  })
})
```

### Progressive Disclosure Testing

**skills/code-review-skill/tests/progressive-disclosure.test.ts:**
```typescript
import { describe, it, expect } from 'vitest'
import { invokeClaude } from '../../../src/claude-api'

describe('Code Review Skill - Progressive Disclosure', () => {
  const testCode = `
    function processUser(data) {
      var user = data
      return user
    }
  `

  it('should provide quick review with default', async () => {
    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: testCode
    })

    // Quick review should be concise
    const lines = result.split('\n').length
    expect(lines).toBeLessThan(20)
  })

  it('should provide deep review with --deep flag', async () => {
    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: testCode,
      options: { deep: true }
    })

    // Deep review should be more comprehensive
    const lines = result.split('\n').length
    expect(lines).toBeGreaterThan(20)
  })

  it('should provide security review with --security flag', async () => {
    const result = await invokeClaude({
      skill: 'code-review-skill',
      input: testCode,
      options: { security: true }
    })

    // Should mention security aspects
    expect(result.toLowerCase()).toContain('secret')
      .or.toContain('security')
  })
})
```

---

## Part 3: Testing Agents

### Agent Behavior Isolation

**tests/agents/frontend-agent.test.ts:**
```typescript
import { describe, it, expect } from 'vitest'
import { createAgent } from '../src/agents'

describe('Frontend Agent', () => {
  const agent = createAgent('frontend-agent')

  it('should have correct tool permissions', () => {
    const allowedTools = agent.getAllowedTools()
    expect(allowedTools).toContain('Read')
    expect(allowedTools).toContain('Write')
    expect(allowedTools).not.toContain('DatabaseQuery')
  })

  it('should restrict file paths', () => {
    const canAccess = agent.canAccessPath('src/components/Button.tsx')
    expect(canAccess).toBe(true)

    const cannotAccess = agent.canAccessPath('src/api/users.ts')
    expect(cannotAccess).toBe(false)

    const deniedPath = agent.canAccessPath('.env')
    expect(deniedPath).toBe(false)
  })

  it('should use correct model', () => {
    expect(agent.getModel()).toBe('haiku')
  })

  it('should enforce constraints on code generation', async () => {
    const result = await agent.run(
      'Create a new React component'
    )

    // Should only create files in allowed paths
    const createdFiles = result.filesModified
    for (const file of createdFiles) {
      expect(file.path).toMatch(/^src\/(components|pages)/)
    }
  })
})
```

### Agent Context Isolation

**tests/agents/context-isolation.test.ts:**
```typescript
import { describe, it, expect } from 'vitest'
import { createAgent } from '../src/agents'

describe('Agent Context Isolation', () => {
  it('should not share context between agent instances', async () => {
    const agent1 = createAgent('test-agent')
    const agent2 = createAgent('test-agent')

    // Agent 1 runs a task
    await agent1.run('Save important context: User prefers TypeScript')

    // Agent 2 should not see agent 1's context
    const agent2Memory = agent2.getMemory()
    expect(agent2Memory).not.toContain('TypeScript')
  })

  it('should clear context when requested', async () => {
    const agent = createAgent('test-agent')

    // Add context
    await agent.run('Remember: API base URL is https://api.example.com')

    // Clear context
    agent.clearContext()

    // Context should be gone
    expect(agent.getMemory()).toBe('')
  })

  it('should maintain context within same session', async () => {
    const agent = createAgent('test-agent')

    // Add context
    await agent.run('Remember: Using React 18')

    // Same agent should retain it
    const memory = agent.getMemory()
    expect(memory).toContain('React')
  })
})
```

---

## Part 4: Quality Gates & Pre-Commit Hooks

### Pre-Commit Hook Setup

**package.json:**
```json
{
  "scripts": {
    "test": "vitest",
    "test:coverage": "vitest --coverage",
    "lint": "eslint src tests",
    "format": "prettier --write src tests",
    "pre-commit": "npm run lint && npm run test && npm run test:coverage",
    "prepare": "husky install"
  },
  "devDependencies": {
    "husky": "^8.0.0",
    "lint-staged": "^14.0.0"
  }
}
```

**Setup husky:**
```bash
npx husky install
npx husky add .husky/pre-commit "npm run pre-commit"
```

**.husky/pre-commit:**
```bash
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

echo "Running pre-commit checks..."

# 1. Lint staged files
npx lint-staged

# 2. Run tests
npm run test -- --run

# 3. Check coverage
npm run test:coverage

# 4. Security audit
npm audit --audit-level=moderate || true

# 5. Type check
npx tsc --noEmit

echo "✅ All checks passed!"
```

**.lintstagedrc.json:**
```json
{
  "*.{ts,tsx,js,jsx}": [
    "eslint --fix",
    "prettier --write"
  ],
  "*.md": [
    "prettier --write"
  ]
}
```

### Coverage Requirements

**vitest.config.ts:**
```typescript
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      lines: 80,
      functions: 80,
      branches: 75,
      statements: 80,
      exclude: [
        'node_modules/',
        'tests/'
      ]
    }
  }
})
```

### Linting Configuration

**.eslintrc.json:**
```json
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "prettier"
  ],
  "rules": {
    "no-console": ["warn", { "allow": ["warn", "error"] }],
    "no-hardcoded-credentials": "error",
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-types": "warn"
  }
}
```

---

## Part 5: TDD/BDD with Claude Code

### Test-Driven Development Workflow

**Using Claude to drive TDD:**

```markdown
# TDD Workflow with Claude Code

## Step 1: Write the Test
You: "I need a function that validates email addresses.
     Write a failing test for validateEmail()"

Claude:
\`\`\`typescript
describe('validateEmail', () => {
  it('should accept valid emails', () => {
    expect(validateEmail('user@example.com')).toBe(true)
  })
})
\`\`\`

## Step 2: Verify Test Fails
You: npm test

Output: ❌ FAIL - validateEmail is not defined

## Step 3: Implement Minimum Code
You: "Now write the minimum code to pass this test"

Claude:
\`\`\`typescript
export function validateEmail(email: string): boolean {
  return email.includes('@')
}
\`\`\`

## Step 4: Verify Test Passes
You: npm test

Output: ✅ PASS

## Step 5: Add More Tests
You: "Add test for invalid emails"

Claude: [adds tests for invalid emails]

## Step 6: Refactor
You: "Refactor to use proper email regex"

[Improves implementation while keeping tests green]
```

### Behavior-Driven Development

**Using Gherkin syntax with Claude:**

**features/user-authentication.feature:**
```gherkin
Feature: User Authentication
  As a user
  I want to log in with email and password
  So that I can access my account

  Scenario: Login with valid credentials
    Given I am on the login page
    When I enter valid email and password
    Then I should be logged in
    And I should see the dashboard

  Scenario: Login with invalid password
    Given I am on the login page
    When I enter valid email but wrong password
    Then I should see an error message
    And I should remain logged out
```

**Let Claude implement:**
```
You: "Implement the authentication feature using these scenarios"

Claude generates:
- Step definitions (Gherkin → code)
- Test implementations
- Application code to make tests pass
```

---

## Part 6: Test Automation Strategies

### Continuous Integration Setup

**.github/workflows/test.yml:**
```yaml
name: Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

      - name: Run tests
        run: npm run test:coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/coverage-final.json

      - name: Security audit
        run: npm audit --audit-level=moderate
```

### Test Report Generation

**package.json:**
```json
{
  "scripts": {
    "test:report": "vitest --coverage --reporter=html --reporter=json"
  }
}
```

### Monitor Test Trends

```bash
# Track test results over time
npm run test:report && \
  cp coverage/test-results.json logs/test-results-$(date +%Y-%m-%d).json

# Analyze trends
node scripts/analyze-test-trends.js
```

---

## Quality Metrics Dashboard

### Key Metrics to Track

```markdown
## Quality Dashboard

- **Code Coverage**: 85%+ (target: 90%)
- **Test Pass Rate**: 100%
- **Average Test Duration**: <5 min
- **Critical Bugs Found**: 0 in production (last month)
- **Security Issues**: 0 critical vulnerabilities
- **Lint Violations**: 0 errors, <5 warnings
```

### Sample Metrics Script

**scripts/metrics.ts:**
```typescript
import fs from 'fs'

interface Metrics {
  coverage: number
  testPassRate: number
  testCount: number
  avgDuration: number
}

export async function collectMetrics(): Promise<Metrics> {
  const coverage = JSON.parse(
    fs.readFileSync('coverage/coverage-final.json', 'utf8')
  )

  const lines = Object.values(coverage)
    .map(file => (file as any).lines)
    .reduce((a: any, b: any) => ({ ...a, ...b }), {})

  const coveredLines = Object.values(lines).filter((l: any) => l > 0).length
  const totalLines = Object.keys(lines).length

  return {
    coverage: Math.round((coveredLines / totalLines) * 100),
    testPassRate: 100,
    testCount: 150,
    avgDuration: 4.2
  }
}
```

---

## Best Practices Summary

✅ **Unit Tests**: Test individual functions in isolation
✅ **Integration Tests**: Test MCP server with real tools
✅ **Performance Tests**: Verify acceptable speed and memory
✅ **Behavior Tests**: Validate skill behavior matches spec
✅ **Context Isolation**: Ensure agents don't share state
✅ **Pre-Commit Hooks**: Enforce quality before commits
✅ **Coverage Requirements**: Maintain 80%+ coverage
✅ **CI/CD Integration**: Automate testing on every push

---

## Next Steps

**Continue Learning**:
- [Security Checklist](1-security-compliance.md) - Security testing
- [Reference Guide](../14-reference/) - Testing patterns reference

**Action Items**:
1. Set up Husky pre-commit hooks
2. Configure coverage thresholds
3. Add CI/CD workflow
4. Write tests for existing code
5. Monitor test metrics weekly

---

## References

- [Vitest Documentation](https://vitest.dev/)
- [Testing Library](https://testing-library.com/)
- [Jest Matchers](https://jestjs.io/docs/expect)
- [Node.js Testing Guide](https://nodejs.org/en/docs/guides/testing/)
- [BDD with Cucumber](https://cucumber.io/)

---

**Quality is a Journey, Not a Destination**

Great testing practices improve code reliability, reduce bugs, and give you confidence in your application.
