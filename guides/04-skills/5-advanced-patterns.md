# Advanced Skill Patterns

**Reading Time**: 30 minutes
**Skill Level**: Advanced
**Prerequisites**: [What Are Skills?](1-overview.md), [Creating Custom Skills](3-creating-skills.md), [Model Assignment](4-model-assignment.md)

---

## Welcome to Skill Mastery! 🎓

You've learned how to create and optimize skills. Now let's explore **advanced patterns** that make your skills more powerful, maintainable, and user-friendly.

By the end of this guide, you'll master:
- Progressive disclosure patterns for optimal UX
- Skill composition and chaining
- Advanced testing strategies
- Dynamic skill behavior and context awareness
- Error handling and recovery patterns
- Skill versioning and migration strategies

---

## Progressive Disclosure Mastery

### Pattern 1: Three-Tier Complexity

**Goal**: Serve beginners, intermediates, and experts with one skill

`.claude/skills/code-review/SKILL.md`:
````markdown
---
name: code-review
modelOverrides:
  quick: haiku
  standard: sonnet
  expert: opus
---

# Code Review Skill

## 🟢 Quick Mode (Default - 2 min)

Basic checks for common issues:
- Syntax errors
- Style violations
- Obvious bugs

**Usage:** `/code-review`

---

<details>
<summary>🟡 Standard Mode (5 min)</summary>

## Standard Review

Comprehensive analysis including:
- All quick checks
- Test coverage
- Security basics (OWASP Top 10)
- Performance issues

**Usage:** `/code-review --standard`

</details>

---

<details>
<summary>🔴 Expert Mode (15 min)</summary>

## Expert Review

Deep architectural analysis:
- All standard checks
- Design patterns evaluation
- Scalability analysis
- Technical debt assessment
- Refactoring recommendations

**Usage:** `/code-review --expert`

</details>
````

**Benefits:**
- New users aren't overwhelmed
- Power users get full capabilities
- Clear visual hierarchy (🟢🟡🔴)
- Cost scales with complexity

---

### Pattern 2: Guided Workflow

**Goal**: Interactive step-by-step process

`.claude/skills/feature-development/SKILL.md`:
````markdown
# Feature Development Workflow

## Phase 1: Planning (Always visible)

I'll help you plan the feature:
1. What problem does it solve?
2. Who are the users?
3. What are the acceptance criteria?

<details>
<summary>Phase 2: Design (Click when ready)</summary>

Now let's design the solution:
1. API design
2. Data model
3. UI mockups
4. Architecture diagram

</details>

<details>
<summary>Phase 3: Implementation (Click when ready)</summary>

Time to build:
1. Write tests first (TDD)
2. Implement feature
3. Code review
4. Integration

</details>

<details>
<summary>Phase 4: Launch (Click when ready)</summary>

Final steps:
1. Documentation
2. Deployment plan
3. Monitoring setup
4. Rollback plan

</details>
````

**Usage:**
```
You: /feature "Add dark mode"

Claude: Let's plan the dark mode feature.

Phase 1: Planning
1. What problem does it solve?
   → Users want to reduce eye strain in low-light environments

2. Who are the users?
   → All users, especially those working at night

3. What are the acceptance criteria?
   → [ ] Toggle in settings
   → [ ] Persists across sessions
   → [ ] All components adapt to theme

Ready for Phase 2: Design? (yes/no)

You: yes

Claude: [Expands Phase 2 details...]
```

---

### Pattern 3: Conditional Depth

**Goal**: Automatically adjust depth based on findings

`.claude/skills/security-scan/SKILL.md`:
```markdown
## Instructions

1. Run quick security scan (all files)
2. If critical issues found:
   - Switch to Opus model
   - Perform deep analysis
   - Generate detailed remediation plan
3. If only warnings found:
   - Continue with Sonnet
   - Provide standard recommendations
4. If no issues found:
   - Report success
   - Suggest optional hardening
```

**Behavior:**
```
# Case 1: No issues found (Haiku, fast & cheap)
You: /security-scan
Claude: ✅ No security issues found (12 files scanned, 45 seconds)

# Case 2: Warnings found (auto-switches to Sonnet)
You: /security-scan
Claude: ⚠️ Found 3 warnings. Performing standard analysis...
        [Detailed Sonnet analysis...]

# Case 3: Critical issues (auto-switches to Opus)
You: /security-scan
Claude: 🚨 Critical: SQL injection found!
        Switching to deep analysis mode...
        [Comprehensive Opus analysis + remediation plan...]
```

---

## Skill Composition and Chaining

### Pattern 4: Skill Pipelines

**Goal**: Chain multiple skills together

`.claude/skills/full-review/SKILL.md`:
```markdown
# Full Review Pipeline

## Instructions

Execute skills in sequence:

1. **code-formatter** - Format code first
2. **spell-checker** - Fix typos in comments
3. **linter** - Check style violations
4. **code-review** - Comprehensive review
5. **security-scan** - Security check
6. **test-coverage** - Verify test coverage

Stop if any skill reports errors.
```

**Usage:**
```bash
/full-review

# Executes:
# [1/6] Running code-formatter... ✅
# [2/6] Running spell-checker... ✅
# [3/6] Running linter... ⚠️ 2 warnings
# [4/6] Running code-review... ✅
# [5/6] Running security-scan... ❌ Critical issue found!
# Pipeline stopped. Fix security issues before continuing.
```

---

### Pattern 5: Skill Dependencies

**Goal**: Automatically invoke prerequisite skills

`.claude/skills/deploy/SKILL.md`:
```yaml
---
name: deploy
dependencies:
  skills:
    - test-runner     # Must pass tests
    - security-scan   # Must pass security
    - build          # Must build successfully
  required: true      # Fail if dependencies fail
---

# Deploy Skill

## Pre-Deployment Checks

Before deploying, I'll automatically run:
1. Test suite (via test-runner skill)
2. Security scan (via security-scan skill)
3. Build process (via build skill)

If all pass, I'll proceed with deployment.
If any fail, deployment is blocked.
```

---

### Pattern 6: Skill Composition

**Goal**: Combine multiple skills into a meta-skill

`.claude/skills/pr-ready/SKILL.md`:
```markdown
# PR Ready Skill

This meta-skill ensures your code is ready for pull request.

## Checklist (Executes Sub-Skills)

- [ ] Code formatted (→ code-formatter skill)
- [ ] Linter passing (→ linter skill)
- [ ] Tests passing (→ test-runner skill)
- [ ] Coverage ≥ 80% (→ coverage-checker skill)
- [ ] No security issues (→ security-scan skill)
- [ ] Documentation updated (→ docs-checker skill)
- [ ] Commit message follows conventions (→ commit-lint skill)

## Usage

```bash
/pr-ready

# Output:
# PR Readiness Check
# ==================
# ✅ Code formatted
# ✅ Linter passing
# ✅ Tests passing (156/156)
# ✅ Coverage: 87%
# ❌ Security: 1 medium issue found
# ⚠️  Documentation: Missing JSDoc for 3 functions
# ✅ Commit messages valid
#
# Status: Not ready for PR
# Please fix security issue and documentation warnings.
```
```

---

## Advanced Testing Patterns

### Pattern 7: Fixture-Based Testing

**Structure:**
```
.claude/skills/your-skill/
├── SKILL.md
├── tests/
│   ├── fixtures/
│   │   ├── input/
│   │   │   ├── valid-code.ts
│   │   │   ├── invalid-code.ts
│   │   │   └── edge-case.ts
│   │   └── expected/
│   │       ├── valid-code.output.txt
│   │       ├── invalid-code.output.txt
│   │       └── edge-case.output.txt
│   └── run-tests.sh
```

**Test Script:**
```bash
#!/bin/bash

SKILL_DIR=".claude/skills/code-review"
FIXTURES="$SKILL_DIR/tests/fixtures"
PASSED=0
FAILED=0

for input in $FIXTURES/input/*.ts; do
  filename=$(basename "$input" .ts)
  expected="$FIXTURES/expected/${filename}.output.txt"

  echo "Testing: $filename"

  # Run skill
  actual=$(claude --skill=code-review "$input")

  # Compare output
  if diff -q <(echo "$actual") "$expected" > /dev/null; then
    echo "✅ PASS: $filename"
    ((PASSED++))
  else
    echo "❌ FAIL: $filename"
    echo "Expected:"
    cat "$expected"
    echo "Actual:"
    echo "$actual"
    ((FAILED++))
  fi
done

echo ""
echo "Results: $PASSED passed, $FAILED failed"
exit $FAILED
```

---

### Pattern 8: Snapshot Testing

**Goal**: Capture and compare skill outputs

`.claude/skills/your-skill/tests/snapshots.test.ts`:
```typescript
import { executeSkill } from '@claude/skill-testing';
import { describe, it, expect } from '@jest/globals';

describe('Code Review Skill Snapshots', () => {
  it('should match snapshot for valid code', async () => {
    const input = `
      export function add(a: number, b: number): number {
        return a + b;
      }
    `;

    const result = await executeSkill('code-review', { code: input });

    expect(result).toMatchSnapshot();
  });

  it('should match snapshot for code with issues', async () => {
    const input = `
      function bad() {
        var x = 1; // Using var instead of const
        // No return type annotation
      }
    `;

    const result = await executeSkill('code-review', { code: input });

    expect(result).toMatchSnapshot();
  });
});
```

**Update snapshots when intentionally changing behavior:**
```bash
npm test -- --updateSnapshot
```

---

### Pattern 9: Property-Based Testing

**Goal**: Test with generated inputs

```typescript
import { fc, test } from '@fast-check/jest';
import { executeSkill } from '@claude/skill-testing';

describe('Calculator Skill Property Tests', () => {
  test.prop([fc.integer(), fc.integer()])(
    'should add two integers correctly',
    async (a, b) => {
      const result = await executeSkill('calculator', {
        operation: 'add',
        a,
        b,
      });

      const expected = a + b;
      expect(result.value).toBe(expected);
    }
  );

  test.prop([fc.string(), fc.string()])(
    'should handle string inputs gracefully',
    async (a, b) => {
      const result = await executeSkill('calculator', {
        operation: 'add',
        a,
        b,
      });

      // Should return error, not crash
      expect(result.error).toBeDefined();
      expect(result.error).toContain('Invalid input type');
    }
  );
});
```

---

## Context-Aware Skills

### Pattern 10: Project Detection

**Goal**: Adapt behavior based on project type

`.claude/skills/test-generator/SKILL.md`:
```markdown
## Instructions

1. Detect project type:
   - Check for package.json → Node.js
   - Check for requirements.txt → Python
   - Check for Cargo.toml → Rust
   - Check for go.mod → Go

2. Detect test framework:
   - Node.js: Jest, Mocha, Vitest
   - Python: pytest, unittest
   - Rust: built-in `cargo test`
   - Go: built-in `go test`

3. Generate tests using detected framework:
   ```javascript
   // If Jest detected:
   describe('MyFunction', () => {
     it('should work', () => {
       expect(myFunction()).toBe(expected);
     });
   });

   // If Mocha detected:
   describe('MyFunction', function() {
     it('should work', function() {
       assert.equal(myFunction(), expected);
     });
   });
   ```
```

---

### Pattern 11: Workspace Awareness

**Goal**: Use workspace context for better results

`.claude/skills/import-fixer/SKILL.md`:
```markdown
## Instructions

1. Read `.claude/workspace.json` for project structure:
   ```json
   {
     "aliases": {
       "@components": "./src/components",
       "@utils": "./src/utils",
       "@types": "./src/types"
     },
     "importStyle": "named"
   }
   ```

2. When fixing imports, use workspace aliases:
   ```typescript
   // Bad (relative)
   import { Button } from '../../../components/Button';

   // Good (alias)
   import { Button } from '@components/Button';
   ```

3. Respect workspace import style:
   - `named`: Use named imports
   - `default`: Use default imports
   - `namespace`: Use namespace imports
```

---

## Error Handling Patterns

### Pattern 12: Graceful Degradation

**Goal**: Continue operation even if some checks fail

`.claude/skills/comprehensive-check/SKILL.md`:
```markdown
## Instructions

Run all checks, even if some fail:

```javascript
const results = {
  formatter: 'not_run',
  linter: 'not_run',
  tests: 'not_run',
  security: 'not_run'
};

try {
  results.formatter = await runFormatter();
} catch (error) {
  results.formatter = 'failed: ' + error.message;
}

try {
  results.linter = await runLinter();
} catch (error) {
  results.linter = 'failed: ' + error.message;
}

// Continue with remaining checks...

// Report all results
return {
  summary: `Completed 4 checks: ${successCount} passed, ${failCount} failed`,
  results
};
```

## Output Format

```
Comprehensive Check Results
===========================
✅ Formatter: All files formatted
❌ Linter: 3 errors found
✅ Tests: 156/156 passing
⚠️  Security: eslint-plugin-security not installed (skipped)

Summary: 2 passed, 1 failed, 1 skipped
```
```

---

### Pattern 13: Retry with Backoff

**Goal**: Retry failed operations with increasing delays

`.claude/skills/api-call/SKILL.md`:
```markdown
## Instructions

When calling external APIs, use exponential backoff:

```javascript
async function callWithRetry(fn, maxRetries = 3) {
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error) {
      if (attempt === maxRetries - 1) {
        throw error; // Final attempt failed
      }

      const delay = Math.pow(2, attempt) * 1000; // 1s, 2s, 4s
      console.log(`Attempt ${attempt + 1} failed. Retrying in ${delay}ms...`);
      await sleep(delay);
    }
  }
}

// Usage
const result = await callWithRetry(() => fetchGitHubIssues());
```
```

---

## Skill Versioning Patterns

### Pattern 14: Semantic Versioning

**Goal**: Manage breaking changes and upgrades

`.claude/skills/code-review/SKILL.md`:
```yaml
---
name: code-review
version: 2.0.0  # Major.Minor.Patch
deprecated: false
migrationGuide: MIGRATION.md
changelog: CHANGELOG.md
---
```

**CHANGELOG.md:**
```markdown
# Changelog

## v2.0.0 (2024-12-20) - BREAKING CHANGES

### Breaking Changes
- Removed `--quick` flag (use default mode instead)
- Changed output format from plain text to JSON

### Migration Guide
```bash
# Before (v1.x)
/code-review --quick

# After (v2.x)
/code-review  # Default mode is now fast
```

### Added
- Progressive disclosure pattern
- Opus model for deep review
- Cost tracking

### Fixed
- Security scan now checks OWASP Top 10

## v1.2.0 (2024-12-01)

### Added
- Security scan mode

### Fixed
- Test coverage calculation
```

---

### Pattern 15: Graceful Migration

**Goal**: Support both old and new versions during transition

`.claude/skills/code-review/SKILL.md`:
```markdown
## Instructions

Handle both v1 and v2 usage:

```javascript
// Detect version from invocation
if (args.includes('--quick')) {
  console.warn('Warning: --quick flag is deprecated. Use default mode instead.');
  console.warn('This flag will be removed in v3.0.0');
  // Continue with default mode
}

// Support old JSON output format for backward compatibility
if (config.outputFormat === 'v1') {
  console.warn('Warning: v1 output format is deprecated.');
  console.warn('Please migrate to v2 format. See MIGRATION.md');
  return formatV1Output(results);
}

// Use new format
return formatV2Output(results);
```
```

---

## Performance Optimization Patterns

### Pattern 16: Caching Results

**Goal**: Avoid redundant expensive operations

`.claude/skills/dependency-analyzer/SKILL.md`:
```markdown
## Instructions

Cache analysis results:

```javascript
const cacheKey = hashFile(filePath);
const cached = await getCache(cacheKey);

if (cached && cached.timestamp > fileModifiedTime) {
  return cached.result; // Use cached result
}

// Perform expensive analysis
const result = await analyzeDependencies(filePath);

// Cache for next time
await setCache(cacheKey, {
  result,
  timestamp: Date.now()
});

return result;
```

Cache location: `.claude/cache/skills/dependency-analyzer/`
```

---

### Pattern 17: Incremental Processing

**Goal**: Process only changed files

`.claude/skills/codebase-analyzer/SKILL.md`:
```markdown
## Instructions

Track processed files:

```javascript
// Load previous analysis
const lastRun = await loadAnalysis('.claude/cache/last-analysis.json');

// Get changed files since last run
const changedFiles = await getChangedFiles(lastRun.timestamp);

if (changedFiles.length === 0) {
  return lastRun.results; // No changes, return cached results
}

// Process only changed files
const updates = await analyzeFiles(changedFiles);

// Merge with previous results
const results = mergResults(lastRun.results, updates);

// Save for next run
await saveAnalysis('.claude/cache/last-analysis.json', {
  results,
  timestamp: Date.now()
});

return results;
```
```

---

## Quick Reference

### Progressive Disclosure Checklist

- [ ] Default mode is fast and simple
- [ ] Advanced options in `<details>` tags
- [ ] Clear visual hierarchy (emojis, headings)
- [ ] Model assignment matches complexity
- [ ] Each level adds value

### Testing Checklist

- [ ] Unit tests for core logic
- [ ] Integration tests with fixtures
- [ ] Snapshot tests for outputs
- [ ] Property-based tests for edge cases
- [ ] Automated test runner

### Error Handling Checklist

- [ ] Graceful degradation on failures
- [ ] Retry logic for transient errors
- [ ] Clear error messages
- [ ] Don't crash on invalid input
- [ ] Log errors for debugging

### Performance Checklist

- [ ] Cache expensive operations
- [ ] Process incrementally when possible
- [ ] Use appropriate model (don't overuse Opus)
- [ ] Measure and track performance
- [ ] Optimize hot paths

---

## Next Steps

Congratulations! You've mastered advanced skill patterns.

**Ready for Phase 2?** Explore:
- [Model Selection Deep Dive](../06-models/1-overview.md) - Understanding Haiku, Sonnet, and Opus
- [Thinking Modes](../08-thinking/1-overview.md) - Control reasoning depth
- [Context Management](../09-context/1-overview.md) - Advanced context control

**Want to Contribute?**
- [Share Your Skills](https://github.com/anthropics/skills) - Contribute to the marketplace
- [Skill Best Practices](https://code.claude.com/docs/skills/best-practices) - Official guidelines

---

## References and Further Reading

### Pattern Libraries
- [Progressive Disclosure (Nielsen Norman Group)](https://www.nngroup.com/articles/progressive-disclosure/)
- [Error Handling Patterns](https://martinfowler.com/articles/patterns-of-distributed-systems/)
- [Semantic Versioning](https://semver.org)

### Testing Resources
- [Jest Documentation](https://jestjs.io/docs/snapshot-testing)
- [Fast-Check (Property Testing)](https://github.com/dubzzz/fast-check)
- [Testing Best Practices](https://testingjavascript.com)

### Performance
- [Caching Strategies](https://aws.amazon.com/caching/)
- [Incremental Processing](https://martinfowler.com/articles/incremental-build.html)

---

**Questions or Feedback?**
Found a mistake? Have a suggestion? [Open an issue](https://github.com/anthropics/claude-code/issues) or contribute to this documentation!
