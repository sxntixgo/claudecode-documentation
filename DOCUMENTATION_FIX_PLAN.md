# Documentation Fix Plan

**Date**: December 21, 2025
**Based on**: DOCUMENTATION_REVIEW_PLAN.md
**Target**: Production-ready documentation (100% readiness)
**Estimated Total Time**: 4-6 hours

---

## Overview

This plan provides step-by-step instructions to fix all 47 issues identified in the documentation review. Following this plan will bring the documentation from 62% to 100% production ready.

**Execution Strategy**:
1. Fix critical issues first (blocks production)
2. Then important issues (quality improvements)
3. Finally minor issues (polish)
4. Validate after each phase
5. Re-run documentation-reviewer to verify

---

## Phase 1: Critical Fixes (Priority 1)

**Goal**: Fix blockers - broken links, TODOs, missing metadata
**Time**: 2-3 hours
**Impact**: 62% → 92% production ready

### Task 1.1: Fix TABLE_OF_CONTENTS.md Broken Links

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 45 minutes
**Lines to Update**: 132-592

#### Step 1: Update Model Section Links (Lines 132-136)

**Find and Replace**:
```markdown
OLD: guides/models/model-comparison.md
NEW: guides/4-models/1-overview.md

OLD: guides/models/selection-guide.md
NEW: guides/4-models/5-selection-guide.md

OLD: guides/models/configuration.md
ACTION: Remove reference (content integrated into other model guides)
```

**Specific Changes**:
```diff
Line 132:
- | [Model Comparison](guides/models/model-comparison.md) | 20 min | Haiku 4.5, Sonnet 4.5, Opus 4.5 capabilities |
+ | [Model Overview](guides/4-models/1-overview.md) | 20 min | Haiku 4.5, Sonnet 4.5, Opus 4.5 capabilities |

Line 134:
- | [Selection Guide](guides/models/selection-guide.md) | 30 min | Decision matrix, when to use each model |
+ | [Selection Guide](guides/4-models/5-selection-guide.md) | 30 min | Decision matrix, when to use each model |

Line 135:
- | [Configuration](guides/models/configuration.md) | 25 min | CLI flags, agent config, skill frontmatter |
+ (Remove this line - content is in other guides)
```

#### Step 2: Update Thinking Section Links (Lines 150-153)

**Find and Replace**:
```markdown
OLD: guides/thinking/extended-thinking.md
NEW: guides/5-thinking/1-overview.md

OLD: guides/thinking/keywords-reference.md
NEW: guides/5-thinking/2-keywords.md

OLD: guides/thinking/when-to-use.md
ACTION: Remove or change to guides/5-thinking/1-overview.md
```

**Specific Changes**:
```diff
Line 150:
- | [Extended Thinking Overview](guides/thinking/extended-thinking.md) | 15 min | What it is, how it works |
+ | [Extended Thinking Overview](guides/5-thinking/1-overview.md) | 15 min | What it is, how it works |

Line 151:
- | [Keywords Reference](guides/thinking/keywords-reference.md) | 10 min | "think", "think hard", "ultrathink" budgets |
+ | [Keywords Reference](guides/5-thinking/2-keywords.md) | 10 min | "think", "think hard", "ultrathink" budgets |

Line 152:
- | [When to Use](guides/thinking/when-to-use.md) | 20 min | Use cases, cost considerations |
+ (Remove this line - content integrated into overview)
```

#### Step 3: Update Context Section Links (Lines 168-171)

**Find and Replace**:
```markdown
OLD: guides/context/claude-md-files.md
NEW: guides/6-context/2-claude-md.md

OLD: guides/context/memory-management.md
NEW: guides/6-context/3-memory-hierarchy.md

OLD: guides/context/optimization.md
ACTION: Remove (content in other context guides)
```

**Specific Changes**:
```diff
Line 168:
- | [CLAUDE.md Files](guides/context/claude-md-files.md) | 30 min | System-level context, best practices |
+ | [CLAUDE.md Files](guides/6-context/2-claude-md.md) | 30 min | System-level context, best practices |

Line 169:
- | [Memory Management](guides/context/memory-management.md) | 25 min | Hierarchy, precedence, organization |
+ | [Memory Hierarchy](guides/6-context/3-memory-hierarchy.md) | 25 min | Hierarchy, precedence, organization |

Line 170:
- | [Optimization](guides/context/optimization.md) | 35 min | Context clearing, strategies, anti-patterns |
+ (Remove this line - content integrated into other guides)
```

#### Step 4: Update Skills Section Links (Line references throughout)

**Find and Replace**:
```markdown
OLD: guides/skills/overview.md
NEW: guides/3-skills/1-overview.md

OLD: guides/skills/creating-skills.md
NEW: guides/3-skills/3-creating-skills.md
```

#### Step 5: Update Reference Section Links (Lines 184-189, 385-388)

**Find and Replace**:
```markdown
OLD: reference/keywords.md
NEW: guides/7-keywords/1-overview.md

OLD: reference/hooks.md
NEW: guides/7-keywords/3-automation-patterns.md

OLD: reference/commands.md
NEW: guides/7-keywords/2-slash-commands.md
```

**Specific Changes**:
```diff
Line 186:
- | [Keywords Reference](reference/keywords.md) | 15 min | All thinking keywords, effects |
+ | [Keywords Overview](guides/7-keywords/1-overview.md) | 15 min | All thinking keywords, effects |

Line 187:
- | [Hooks Reference](reference/hooks.md) | 30 min | PreToolUse, PostToolUse, Notification, Stop |
+ | [Automation Patterns](guides/7-keywords/3-automation-patterns.md) | 30 min | PreToolUse, PostToolUse, Notification, Stop |

Line 188:
- | [Commands Reference](reference/commands.md) | 20 min | Slash commands, $ARGUMENTS, frontmatter |
+ | [Slash Commands](guides/7-keywords/2-slash-commands.md) | 20 min | Slash commands, $ARGUMENTS, frontmatter |
```

#### Step 6: Update Optimization Section Links (Lines 204-207)

**Find and Replace**:
```markdown
OLD: optimization/token-usage.md
NEW: guides/8-optimization/3-monitoring-budgeting.md

OLD: optimization/cost-comparison.md
NEW: guides/8-optimization/1-cost-optimization.md

OLD: optimization/strategies.md
NEW: guides/8-optimization/2-advanced-techniques.md
```

**Specific Changes**:
```diff
Line 204:
- | [Token Usage Guide](optimization/token-usage.md) | 30 min | Tracking, estimation, monitoring |
+ | [Monitoring & Budgeting](guides/8-optimization/3-monitoring-budgeting.md) | 30 min | Tracking, estimation, monitoring |

Line 205:
- | [Cost Comparison](optimization/cost-comparison.md) | 20 min | Haiku vs. Sonnet vs. Opus economics |
+ | [Cost Optimization](guides/8-optimization/1-cost-optimization.md) | 30 min | Haiku vs. Sonnet vs. Opus economics |

Line 206:
- | [Optimization Strategies](optimization/strategies.md) | 45 min | 4 strategies, 60%+ savings potential |
+ | [Advanced Techniques](guides/8-optimization/2-advanced-techniques.md) | 35 min | 4 strategies, 60%+ savings potential |
```

#### Step 7: Update Quick Reference Section (Lines 288-292)

**Find and Replace**:
```markdown
OLD: guides/12-quick-reference/1-model-selection-tree.md
NEW: guides/10-reference/5-model-selection-tree.md

OLD: guides/12-quick-reference/2-optimization-checklist.md
NEW: guides/10-reference/6-optimization-checklist.md

OLD: guides/12-quick-reference/3-glossary.md
NEW: guides/10-reference/7-glossary.md

OLD: guides/12-quick-reference/4-community-resources.md
NEW: guides/12-community/1-resources.md
```

**Specific Changes**:
```diff
Line 288:
- | **[Model Selection Decision Tree](guides/12-quick-reference/1-model-selection-tree.md)** | **15 min** | **Haiku/Sonnet/Opus decision flowchart, cost calculator** |
+ | **[Model Selection Decision Tree](guides/10-reference/5-model-selection-tree.md)** | **15 min** | **Haiku/Sonnet/Opus decision flowchart, cost calculator** |

Line 290:
- | **[Optimization Checklist](guides/12-quick-reference/2-optimization-checklist.md)** | **20 min** | **Pre-implementation, configuration, runtime, monitoring** |
+ | **[Optimization Checklist](guides/10-reference/6-optimization-checklist.md)** | **20 min** | **Pre-implementation, configuration, runtime, monitoring** |

Line 291:
- | **[Glossary](guides/12-quick-reference/3-glossary.md)** | **25 min** | **Complete terminology reference (80+ terms)** |
+ | **[Glossary](guides/10-reference/7-glossary.md)** | **25 min** | **Complete terminology reference (80+ terms)** |

Line 292:
- | **[Community Resources](guides/12-quick-reference/4-community-resources.md)** | **20 min** | **Official docs, community channels, learning materials** |
+ | **[Community Resources](guides/12-community/1-resources.md)** | **20 min** | **Official docs, community channels, learning materials** |
```

#### Step 8: Update Additional Reference Links (Lines 565-567, 385-388)

**Check all other occurrences** of these patterns and update similarly.

**Validation**:
```bash
# After making changes, verify no broken links remain
grep -o '\](guides/[^)]*\.md)' TABLE_OF_CONTENTS.md | sed 's/](//;s/)//' | while read link; do
    if [ ! -f "$link" ]; then
        echo "STILL BROKEN: $link"
    fi
done

# Should return no output if all fixed
```

---

### Task 1.2: Fix INTRODUCTION.md Broken Links

**File**: `INTRODUCTION.md`
**Time**: 30 minutes

#### Step 1: Fix All Model Links

**Find and Replace** (multiple occurrences):
```markdown
OLD: guides/models/model-comparison.md
NEW: guides/4-models/1-overview.md

OLD: guides/models/selection-guide.md
NEW: guides/4-models/5-selection-guide.md
```

#### Step 2: Fix All Skills Links

**Find and Replace**:
```markdown
OLD: guides/skills/overview.md
NEW: guides/3-skills/1-overview.md

OLD: guides/skills/creating-skills.md
NEW: guides/3-skills/3-creating-skills.md
```

#### Step 3: Fix All Thinking Links

**Find and Replace**:
```markdown
OLD: guides/thinking/extended-thinking.md
NEW: guides/5-thinking/1-overview.md

OLD: guides/thinking/when-to-use.md
ACTION: Change to guides/5-thinking/1-overview.md or remove
```

#### Step 4: Fix All Context Links

**Find and Replace**:
```markdown
OLD: guides/context/claude-md-files.md
NEW: guides/6-context/2-claude-md.md

OLD: guides/context/optimization.md
ACTION: Change to guides/6-context/1-overview.md or remove
```

**Validation**:
```bash
# Verify all links in INTRODUCTION.md
grep -o '\](guides/[^)]*\.md)' INTRODUCTION.md | sed 's/](//;s/)//' | while read link; do
    if [ ! -f "$link" ]; then
        echo "STILL BROKEN: $link"
    fi
done
```

---

### Task 1.3: Remove TODO/FIXME/TBD Markers

**Time**: 45 minutes

#### File 1: guides/2-agents/1-overview.md

**Action**: Read file, find TODOs, complete or remove them

```bash
# Find TODOs
grep -n "TODO\|FIXME\|TBD" guides/2-agents/1-overview.md

# For each TODO:
# 1. If content can be completed quickly: Complete it
# 2. If it's a placeholder for future work: Remove it
# 3. If it's important but time-consuming: Convert to GitHub issue and remove from doc
```

#### File 2: guides/2-agents/2-built-in-agents.md

Same process as above.

#### File 3: guides/4-models/5-selection-guide.md

Same process as above.

#### File 4: guides/4-models/2-haiku.md

Same process as above.

#### File 5: guides/1-mcp-servers/3-popular-servers.md

Same process as above.

**Validation**:
```bash
# Verify no TODOs remain in production docs
find guides -name "*.md" -exec grep -l "TODO\|FIXME\|TBD\|\[TBD\]" {} \;

# Should return no files
```

---

### Task 1.4: Add Missing Reading Time Estimates

**Time**: 30 minutes

#### Step 1: Identify Files Missing Reading Time

```bash
# Find files without reading time
find guides -name "*.md" -type f | while read file; do
    if ! grep -q "Reading Time\|reading time" "$file"; then
        wc -w "$file"
    fi
done | sort -n

# Estimate reading time: ~200 words per minute
```

#### Step 2: Add Reading Time to Each File

**Format**:
```markdown
# [Guide Title]

**Reading Time**: [X] minutes
**Skill Level**: [Beginner/Intermediate/Advanced]
**Prerequisites**: [List or "None"]
```

**Estimation Formula**:
- Count words in file
- Divide by 200 (average reading speed)
- Round to nearest 5 minutes
- Adjust for code complexity (+5-10 min if heavy code examples)

**Example**:
```markdown
File has 2,500 words
2,500 ÷ 200 = 12.5 minutes
Round to 15 minutes
Has many code examples: +5 minutes = 20 minutes
```

**Validation**:
```bash
# Verify all files have reading time
find guides -name "*.md" -exec grep -L "Reading Time\|reading time" {} \;

# Should return no files
```

---

### Task 1.5: Update Non-Existent Example References

**Time**: 30 minutes

**Action**: Remove or update references to examples that don't exist

#### Examples Directory Cleanup

**Update TABLE_OF_CONTENTS.md** (Lines 453-475):

```diff
### Skills Examples
- - [Documentation Professor](examples/skills/documentation-professor/) - Pedagogical documentation writer
- - [TDD Workflow](examples/skills/tdd-workflow/) - Test-driven development
- - [API Documentation](examples/skills/api-documentation/) - Generate API docs from code
- - [Code Review](examples/skills/code-review/) - Automated code reviews
+ - [Documentation Professor](examples/skills/documentation-professor/) - Pedagogical documentation writer
+ (Note: Additional skills examples available in guides/9-examples/workflows/)

### Agent Configurations
- - [Quick Search Agent](examples/agents/quick-search.json) - Fast codebase exploration (Haiku)
- - [Feature Implementer](examples/agents/feature-implementer.json) - Standard development (Sonnet)
- - [Architecture Reviewer](examples/agents/architecture-reviewer.json) - Deep analysis (Opus)
+ (Examples integrated into guides/2-agents/ documentation)

### CLAUDE.md Templates
- - [Web Application](examples/claude-md-templates/web-application-CLAUDE.md) - React/Vue/Angular
- - [API Service](examples/claude-md-templates/api-service-CLAUDE.md) - Backend services
- (etc...)
+ (See project templates in guides/9-examples/projects/ for complete examples)
```

**Validation**:
```bash
# Verify all referenced example files exist
grep -r "examples/" TABLE_OF_CONTENTS.md | grep -o 'examples/[^)]*' | while read path; do
    if [ ! -e "$path" ]; then
        echo "Missing: $path"
    fi
done
```

---

## Phase 2: Important Fixes (Priority 2)

**Goal**: Add missing content, improve navigation
**Time**: 1-2 hours
**Impact**: 92% → 98% production ready

### Task 2.1: Add Phase 5 Workflows to TABLE_OF_CONTENTS

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 15 minutes
**Location**: After line 236 (after workflow 4)

**Add These Lines**:
```markdown
| **[Documentation Writing Workflow](guides/9-examples/workflows/5-documentation-writing.md)** | **25 min** | **API docs, tutorials, testing examples, ROI analysis** |
| **[Performance Optimization Workflow](guides/9-examples/workflows/6-performance-optimization.md)** | **30 min** | **Profile, analyze, optimize, validate with real examples** |
| **[Testing Workflow](guides/9-examples/workflows/7-testing.md)** | **35 min** | **TDD, unit tests, integration, E2E with comprehensive examples** |
```

**Full Context** (lines 229-239):
```markdown
| **Workflows** |||
| [Feature Development Workflow](guides/9-examples/workflows/1-feature-development.md) | 30 min | 6-phase development process |
| **[Bug Fixing Workflow](guides/9-examples/workflows/2-bug-fixing.md)** | **30 min** | **Systematic debugging with TDD approach** |
| **[Code Review Workflow](guides/9-examples/workflows/3-code-review.md)** | **25 min** | **AI-assisted PR reviews with security checks** |
| **[Refactoring Workflow](guides/9-examples/workflows/4-refactoring.md)** | **35 min** | **Safe refactoring with Plan agent and tests** |
| **[Documentation Writing Workflow](guides/9-examples/workflows/5-documentation-writing.md)** | **25 min** | **API docs, tutorials, testing examples, ROI analysis** |
| **[Performance Optimization Workflow](guides/9-examples/workflows/6-performance-optimization.md)** | **30 min** | **Profile, analyze, optimize, validate with real examples** |
| **[Testing Workflow](guides/9-examples/workflows/7-testing.md)** | **35 min** | **TDD, unit tests, integration, E2E with comprehensive examples** |
| **Teams** |||
| [Solo Developer Setup](guides/9-examples/teams/1-solo-developer.md) | 25 min | Optimized individual configuration |
```

---

### Task 2.2: Restructure Quick Reference Section

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 15 minutes
**Location**: Lines 280-296

**Current Issue**: Section titled "⚡ Quick Reference (Power User Tools)" but references wrong directory

**Update**:
```diff
- ### ⚡ Quick Reference (Power User Tools)
+ ### 🔟 Quick Reference (Power User Tools)

**Level**: All levels
**Prerequisites**: None
**What You'll Master**: Decision trees, checklists, and lookup tables

| Guide | Time | Topics |
|-------|------|--------|
- | **[Model Selection Decision Tree](guides/12-quick-reference/1-model-selection-tree.md)** | **15 min** | **Haiku/Sonnet/Opus decision flowchart, cost calculator** |
+ | **[Model Selection Decision Tree](guides/10-reference/5-model-selection-tree.md)** | **15 min** | **Haiku/Sonnet/Opus decision flowchart, cost calculator** |
(etc. - already covered in Task 1.1)
```

---

### Task 2.3: Add Community Section to Navigation

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 20 minutes
**Location**: After Quick Reference section (new section)

**Add New Section**:
```markdown
---

### 📚 Community & Contribution

**Level**: All levels
**Prerequisites**: None
**What You'll Master**: Contributing to Claude Code ecosystem

| Guide | Time | Topics |
|-------|------|--------|
| **[Community Resources](guides/12-community/1-resources.md)** | **20 min** | **Official docs, forums, learning materials** |
| **[Contribution Guide](guides/12-community/2-contribution-guide.md)** | **25 min** | **How to contribute skills, MCP servers, documentation** |
| **[Best Practices Catalog](guides/12-community/3-best-practices-catalog.md)** | **30 min** | **Production patterns from real-world use** |

**Total Time**: ~1.5 hours
**Dependencies**: None
**Use For**: Contributing back, learning from community, sharing expertise
```

---

### Task 2.4: Update Section Numbering

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 10 minutes

**Update Section Headers**:
```diff
- ### 🔟 Reference Documentation (Quick Lookup)
+ ### 🔟 Reference Documentation

- ### 🔒 Security & Compliance (Production Readiness)
+ ### 1️⃣1️⃣ Security & Compliance

- ### ⚡ Quick Reference (Power User Tools)
+ ### 1️⃣2️⃣ Quick Reference

+ ### 1️⃣3️⃣ Community & Contribution
```

---

### Task 2.5: Update "Why This Order?" Section

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 20 minutes
**Location**: Lines 478-505

**Add Phase 5 Content**:
```markdown
**8. Optimization Synthesizes All**
Token optimization applies everything you've learned - model selection, thinking budgets, context management, and strategic agent/skill usage.

**9. Examples Provide Templates**
Real-world project configurations and workflows show how to apply all concepts in production environments.

**10. Reference Enables Quick Lookup**
API references, troubleshooting guides, and FAQs support ongoing development work.

**11. Security Ensures Production Quality**
Security, testing, and performance guides ensure deployments are production-ready and maintainable.

**12. Community Enables Contribution**
Contribution guides and best practices allow you to give back and learn from others' experiences.
```

---

### Task 2.6: Verify Cross-References in New Workflows

**Files**: Workflows 5-7
**Time**: 30 minutes

**For Each File**:
1. Open file
2. Find all markdown links `[text](path)`
3. Verify each path exists
4. Update if broken

```bash
# Automated check
for file in guides/9-examples/workflows/{5,6,7}-*.md; do
    echo "Checking $file"
    grep -o '\](guides/[^)]*\.md)' "$file" | sed 's/](//;s/)//' | while read link; do
        if [ ! -f "$link" ]; then
            echo "  BROKEN: $link"
        fi
    done
    grep -o ']\(\.\./\.\./[^)]*\.md)' "$file" | sed 's/](\.\.\//guides\//;s/)//' | while read link; do
        if [ ! -f "$link" ]; then
            echo "  BROKEN: $link"
        fi
    done
done
```

**Fix any broken links found**.

---

### Task 2.7: Update Learning Checkpoints

**File**: `TABLE_OF_CONTENTS.md`
**Time**: 15 minutes
**Location**: Lines 508-558

**Add New Checkpoints**:
```markdown
✅ **After Examples & Templates**:
- Apply project configurations to your codebase
- Use workflow guides for common development tasks
- Adapt templates to your specific needs
- Follow production-ready patterns

✅ **After Security & Compliance**:
- Implement security best practices in code
- Set up comprehensive testing pipelines
- Monitor performance and costs effectively
- Deploy confidently to production

✅ **After Community Engagement**:
- Contribute skills and MCP servers back
- Share best practices with community
- Learn from others' production experiences
- Help newcomers get started
```

---

## Phase 3: Minor Fixes (Priority 3)

**Goal**: Polish and cleanup
**Time**: 1 hour
**Impact**: 98% → 100% production ready

### Task 3.1: Repository Cleanup

**Time**: 15 minutes

#### Move PR Description

```bash
# Create .github directory if it doesn't exist
mkdir -p .github/pull_request_templates

# Move PR description
mv PR_PHASE5_COMPLETION.md .github/pull_request_templates/

# Or just delete if no longer needed
# rm PR_PHASE5_COMPLETION.md
```

#### Clarify COMPLETION_SUMMARY.md

**Option 1**: Add header explaining purpose
```markdown
# Documentation Completion Summary

**Purpose**: Internal tracking document for Phase 0-5 completion
**Audience**: Documentation maintainers
**Status**: Historical record - all phases complete

---

[Existing content...]
```

**Option 2**: Move to .github/ or docs/ subdirectory

---

### Task 3.2: Standardize Metadata

**Time**: 20 minutes

**Decision**: Add "Last Updated" to ALL guides or NONE

**Recommendation**: Add to all for maintainability

**Script to Add**:
```bash
# Add last updated to files missing it
find guides -name "*.md" | while read file; do
    if ! grep -q "Last Updated" "$file"; then
        # Add after Reading Time line
        sed -i '/Reading Time:/a **Last Updated**: December 21, 2025' "$file"
    fi
done
```

Or manually add to each file's header:
```markdown
**Reading Time**: X minutes
**Skill Level**: [Level]
**Last Updated**: December 21, 2025
**Prerequisites**: [List]
```

---

### Task 3.3: Add Version Information

**Time**: 10 minutes

#### Update README.md

Add version badge or section:
```markdown
# Claude Code Documentation

**Version**: 1.0.0
**Last Updated**: December 21, 2025
**Status**: Production Ready

[Rest of README...]
```

#### Update CHANGELOG.md

Add version entry:
```markdown
## [1.0.0] - 2025-12-21

### Milestone: Complete Documentation

**Summary**: All phases (0-5) complete. Production-ready comprehensive documentation.

### Added
- 50+ comprehensive guides covering all Claude Code features
- 200+ working code examples
- 7 complete workflow guides
- Python project templates (Django, FastAPI, Flask)
- Security, testing, and performance guides
- Community contribution resources
- Complete API reference and troubleshooting guides

### Documentation Statistics
- Total guides: 50+
- Total examples: 200+
- Total words: 100,000+
- Coverage: 100% of Claude Code features

---

[Previous changelog entries...]
```

---

### Task 3.4: Clarify Duplicate Skills

**Time**: 5 minutes

**Add README to examples/skills/**:

```bash
# Create explanation
cat > examples/skills/README.md << 'EOF'
# Example Skills

This directory contains **reference copies** of skills for documentation and learning purposes.

## Active vs. Reference Skills

- **Active skills**: Located in `.claude/skills/` - these are loaded by Claude Code
- **Reference skills**: Located in `examples/skills/` - these are for documentation only

## Current Skills

### documentation-professor
- **Active**: `.claude/skills/documentation-professor/SKILL.md`
- **Reference**: `examples/skills/documentation-professor/SKILL.md`
- **Purpose**: Pedagogical documentation writing with university professor approach

## Using These Examples

To use an example skill:
1. Copy from `examples/skills/[skill-name]/` to `.claude/skills/[skill-name]/`
2. Restart Claude Code to load the skill
3. Invoke with the skill name

## Contributing Skills

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for how to contribute your own skills.
EOF
```

---

### Task 3.5: Verify CONTRIBUTING.md Links

**Time**: 10 minutes

```bash
# Check all links in CONTRIBUTING.md
grep -o '\](guides/[^)]*\.md)' CONTRIBUTING.md | sed 's/](//;s/)//' | while read link; do
    if [ ! -f "$link" ]; then
        echo "BROKEN in CONTRIBUTING.md: $link"
    fi
done

# Fix any broken links found
```

**Known broken link**:
```diff
- - **Technical questions**: Check the [FAQ](guides/10-reference/3-faq.md)
+ - **Technical questions**: Check the [FAQ](guides/10-reference/3-faq.md)
(Already correct - verify it exists)
```

---

## Phase 4: Validation

**Goal**: Verify all fixes worked
**Time**: 30 minutes

### Task 4.1: Run Automated Link Check

```bash
#!/bin/bash
# check_all_links.sh

echo "Checking all markdown files for broken links..."

broken_count=0

# Check root files
for file in *.md; do
    grep -o '\](guides/[^)]*\.md)' "$file" 2>/dev/null | sed 's/](//;s/)//' | while read link; do
        if [ ! -f "$link" ]; then
            echo "BROKEN in $file: $link"
            ((broken_count++))
        fi
    done
done

# Check guides
find guides -name "*.md" -type f | while read file; do
    # Check absolute links
    grep -o '\](guides/[^)]*\.md)' "$file" 2>/dev/null | sed 's/](//;s/)//' | while read link; do
        if [ ! -f "$link" ]; then
            echo "BROKEN in $file: $link"
            ((broken_count++))
        fi
    done

    # Check relative links
    dir=$(dirname "$file")
    grep -o ']\(\.\./[^)]*\.md)' "$file" 2>/dev/null | sed 's/](//;s/)//' | while read link; do
        fullpath="$dir/$link"
        if [ ! -f "$fullpath" ]; then
            echo "BROKEN in $file: $link (resolves to $fullpath)"
            ((broken_count++))
        fi
    done
done

if [ $broken_count -eq 0 ]; then
    echo "✅ No broken links found!"
else
    echo "❌ Found $broken_count broken links"
    exit 1
fi
```

---

### Task 4.2: Verify TODO Removal

```bash
# Check for any remaining TODOs
echo "Checking for TODO markers..."

find guides -name "*.md" -exec grep -l "TODO\|FIXME\|TBD\|\[TBD\]" {} \;

# Should return empty
# If any files found, review and remove TODOs
```

---

### Task 4.3: Verify Reading Times

```bash
# Check all guides have reading time
echo "Checking for missing reading time estimates..."

find guides -name "*.md" -exec grep -L "Reading Time\|reading time" {} \;

# Should return empty
# If files found, add reading time to each
```

---

### Task 4.4: Verify Table of Contents Accuracy

```bash
# Extract all links from TOC
grep -o '\](guides/[^)]*\.md)' TABLE_OF_CONTENTS.md | sed 's/](//;s/)//' | sort -u > /tmp/toc_links.txt

# Check each one exists
cat /tmp/toc_links.txt | while read link; do
    if [ ! -f "$link" ]; then
        echo "TOC references non-existent file: $link"
    fi
done

# Should return empty
```

---

### Task 4.5: Run Documentation Reviewer Again

**Final validation**:

```bash
# Re-run the documentation-reviewer skill
# This will generate a new DOCUMENTATION_REVIEW_PLAN.md

# Expected results:
# - Overall Status: Ready for Production
# - Critical Issues: 0
# - Important Issues: 0-2 (minor refinements)
# - Minor Issues: 0-3 (polish)
# - Production Readiness: 100%
```

---

## Execution Checklist

Use this checklist to track progress:

### Phase 1: Critical Fixes (2-3 hours)
- [ ] Task 1.1: Fix TABLE_OF_CONTENTS.md broken links (45 min)
  - [ ] Update Model section links
  - [ ] Update Thinking section links
  - [ ] Update Context section links
  - [ ] Update Skills section links
  - [ ] Update Reference section links
  - [ ] Update Optimization section links
  - [ ] Update Quick Reference section
  - [ ] Validate all changes
- [ ] Task 1.2: Fix INTRODUCTION.md broken links (30 min)
  - [ ] Fix Model links
  - [ ] Fix Skills links
  - [ ] Fix Thinking links
  - [ ] Fix Context links
  - [ ] Validate all changes
- [ ] Task 1.3: Remove TODO markers (45 min)
  - [ ] guides/2-agents/1-overview.md
  - [ ] guides/2-agents/2-built-in-agents.md
  - [ ] guides/4-models/5-selection-guide.md
  - [ ] guides/4-models/2-haiku.md
  - [ ] guides/1-mcp-servers/3-popular-servers.md
  - [ ] Validate no TODOs remain
- [ ] Task 1.4: Add reading time estimates (30 min)
  - [ ] Identify 9 files missing estimates
  - [ ] Calculate appropriate times
  - [ ] Add to each file
  - [ ] Validate all files have estimates
- [ ] Task 1.5: Update example references (30 min)
  - [ ] Clean up examples section in TOC
  - [ ] Validate all example paths

### Phase 2: Important Fixes (1-2 hours)
- [ ] Task 2.1: Add Phase 5 workflows to TOC (15 min)
- [ ] Task 2.2: Restructure Quick Reference section (15 min)
- [ ] Task 2.3: Add Community section (20 min)
- [ ] Task 2.4: Update section numbering (10 min)
- [ ] Task 2.5: Update "Why This Order?" (20 min)
- [ ] Task 2.6: Verify workflow cross-references (30 min)
- [ ] Task 2.7: Update learning checkpoints (15 min)

### Phase 3: Minor Fixes (1 hour)
- [ ] Task 3.1: Repository cleanup (15 min)
  - [ ] Move/remove PR description
  - [ ] Clarify COMPLETION_SUMMARY.md
- [ ] Task 3.2: Standardize metadata (20 min)
  - [ ] Add "Last Updated" consistently
- [ ] Task 3.3: Add version information (10 min)
  - [ ] Update README.md
  - [ ] Update CHANGELOG.md
- [ ] Task 3.4: Clarify duplicate skills (5 min)
  - [ ] Add examples/skills/README.md
- [ ] Task 3.5: Verify CONTRIBUTING.md links (10 min)

### Phase 4: Validation (30 minutes)
- [ ] Task 4.1: Run automated link check
- [ ] Task 4.2: Verify TODO removal
- [ ] Task 4.3: Verify reading times
- [ ] Task 4.4: Verify TOC accuracy
- [ ] Task 4.5: Run documentation reviewer again

---

## Success Criteria

The documentation is production-ready when:

✅ **All automated checks pass**:
- [ ] Zero broken links
- [ ] Zero TODO markers
- [ ] All files have reading times
- [ ] All TOC references valid

✅ **Documentation reviewer reports**:
- [ ] Overall Status: "Ready for Production"
- [ ] Critical Issues: 0
- [ ] Production Readiness: 100% (13/13 criteria)

✅ **Manual verification**:
- [ ] Sample user can navigate documentation
- [ ] All learning paths work end-to-end
- [ ] Examples are accessible and useful
- [ ] Search/discovery works well

---

## Time Estimates Summary

| Phase | Tasks | Time | Cumulative |
|-------|-------|------|------------|
| Phase 1: Critical | 5 tasks | 2h 30m - 3h | 3h |
| Phase 2: Important | 7 tasks | 1h 30m - 2h | 5h |
| Phase 3: Minor | 5 tasks | 1h | 6h |
| Phase 4: Validation | 5 checks | 30m | 6h 30m |
| **Total** | **22 tasks** | **5h 30m - 6h 30m** | **6h 30m** |

**Realistic estimate**: 6 hours with breaks

---

## Git Workflow

**Recommended approach**: Create feature branch for fixes

```bash
# Create fix branch
git checkout -b claude/documentation-fixes-dKZpl

# Work through phases, committing after each major task
git add -A
git commit -m "Fix TABLE_OF_CONTENTS.md broken links (Task 1.1)"

git add -A
git commit -m "Fix INTRODUCTION.md broken links (Task 1.2)"

# Continue for each task...

# After Phase 1 complete
git push -u origin claude/documentation-fixes-dKZpl

# Create PR
# Title: "Fix critical documentation issues from review"
# Body: Reference DOCUMENTATION_REVIEW_PLAN.md

# After review and merge, delete branch
```

---

## Notes

**Tips for Efficiency**:
1. Use find/replace in your editor for bulk link updates
2. Create scripts for repetitive checks (link validation, TODO search)
3. Work in focused 45-minute blocks with breaks
4. Test as you go - don't wait until end to validate
5. Commit after each major task for easy rollback if needed

**Common Pitfalls**:
1. Missing relative path adjustments (../../ vs guides/)
2. Forgetting to update both occurrences of same link
3. Removing content that's referenced elsewhere
4. Adding reading times that don't match actual content length

**Quality Checks**:
- After each phase, run the validation scripts
- Spot-check a few files manually
- Have another person test navigation if possible
- Check on mobile/different screen sizes for TOC readability

---

**End of Fix Plan**

This plan provides everything needed to bring the documentation to 100% production readiness in approximately 6 hours of focused work. Follow the phases in order, validate after each phase, and you'll have publication-ready documentation.
