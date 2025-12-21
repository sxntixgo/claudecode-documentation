---
name: documentation-reviewer
description: Comprehensive documentation review for production readiness. Reviews entire documentation project for content quality, technical accuracy, formatting, structure, links, cross-references, accessibility, and security. Generates action plan for fixes needed before production release.
model: claude-opus-4-5
version: 1.0.0
author: Claude Code Documentation Project
---

# Documentation Reviewer Skill

Performs a comprehensive production readiness review of the entire documentation project and generates a structured action plan for any issues that need to be addressed.

## Overview

This skill conducts a thorough, systematic review of all documentation to ensure it meets production quality standards. It checks content quality, technical accuracy, formatting consistency, navigation structure, link validity, cross-references, accessibility, security, and style guide compliance.

**Output**: A detailed action plan in `DOCUMENTATION_REVIEW_PLAN.md` with prioritized action items.

## Review Scope

### 1. Content Quality Review
- **Clarity**: Check if explanations are clear and understandable
- **Completeness**: Verify all topics are thoroughly covered
- **Accuracy**: Validate technical information is correct
- **Relevance**: Ensure content is up-to-date and relevant
- **Consistency**: Check terminology is used consistently

### 2. Technical Accuracy Review
- **Commands**: Verify all CLI commands are correct
- **File paths**: Check all file paths exist and are accurate
- **Configuration**: Validate all config examples are correct
- **API references**: Ensure API documentation matches specifications
- **Code syntax**: Verify code examples have correct syntax (visual check only)

### 3. Formatting and Style Review
- **Markdown formatting**: Check proper markdown syntax throughout
- **Heading hierarchy**: Verify logical H1 → H2 → H3 structure
- **Code blocks**: Ensure proper language tags and formatting
- **Lists**: Check consistent list formatting (bullets, numbers)
- **Tables**: Verify table formatting is correct
- **Emphasis**: Check consistent use of bold, italic, code spans

### 4. Structure and Organization Review
- **Navigation**: Verify clear navigation structure
- **Table of Contents**: Check TOC is complete and accurate
- **Cross-references**: Validate all internal links point to existing content
- **Reading flow**: Ensure logical progression of topics
- **File organization**: Check files are in correct directories
- **Naming conventions**: Verify consistent file naming

### 5. Links and References Review
- **Internal links**: Check all markdown links to other docs
- **External links**: Verify external URLs (format check only)
- **File references**: Validate all `@import` or file references exist
- **Image links**: Check all image references (if applicable)
- **Anchor links**: Verify all `#anchor` links work

### 6. Production Readiness Criteria
- **No broken links**: All links must be valid
- **No TODOs**: No placeholder or TODO content
- **No placeholders**: All `[TBD]` or similar removed
- **Complete TOC**: Table of contents includes all pages
- **Valid cross-references**: All cross-refs point to existing content
- **No spelling errors**: Check for common spelling mistakes
- **No grammar errors**: Check for obvious grammar issues
- **Reading time estimates**: All pages have reading time
- **Clear navigation**: Users can easily find content
- **Beginner-friendly**: Content accessible to beginners

### 7. Special Focus Areas

#### Security Review
- Check code examples don't expose vulnerabilities
- Verify no hardcoded credentials or secrets
- Ensure security best practices are promoted
- Validate authentication examples are secure

#### Cost/Token Accuracy Review
- Verify all token estimates are reasonable
- Check cost calculations are accurate
- Ensure pricing information is current
- Validate ROI calculations make sense

#### Accessibility Review
- Check language is beginner-friendly
- Verify jargon is explained
- Ensure examples progress from simple to complex
- Validate prerequisites are clearly stated

#### Style Guide Consistency Review
- Check consistent terminology throughout
- Verify consistent formatting patterns
- Ensure consistent tone and voice
- Validate adherence to project style guide

## Step-by-Step Review Process

### Phase 1: Project Structure Analysis (5-10 min)

1. **Inventory all documentation files**
   - List all `.md` files in the project
   - Identify main sections and categories
   - Map the documentation hierarchy

2. **Verify directory structure**
   - Check files are in correct directories
   - Validate naming conventions
   - Ensure structure matches documentation plan

3. **Review TABLE_OF_CONTENTS.md**
   - Check all files are listed
   - Verify hierarchy is correct
   - Ensure descriptions are accurate

### Phase 2: Content Quality Review (10-15 min)

For each major section:

1. **Read and assess clarity**
   - Is the content clear and understandable?
   - Are explanations thorough enough?
   - Is technical jargon explained?

2. **Check completeness**
   - Are all promised topics covered?
   - Are there gaps in coverage?
   - Are examples sufficient?

3. **Verify consistency**
   - Is terminology used consistently?
   - Are concepts explained consistently?
   - Is the tone consistent?

4. **Assess beginner-friendliness**
   - Can beginners understand this?
   - Are prerequisites clearly stated?
   - Do examples progress logically?

### Phase 3: Technical Accuracy Review (10-15 min)

1. **Validate commands and syntax**
   - Check all CLI commands for accuracy
   - Verify code syntax (visual inspection)
   - Ensure proper language tags on code blocks

2. **Verify file paths and references**
   - Check all file paths are valid
   - Verify directory structures mentioned exist
   - Ensure configuration paths are correct

3. **Review code examples**
   - Check syntax is correct (visual)
   - Verify examples are complete
   - Ensure examples are realistic
   - Note: Do NOT execute code

4. **Validate technical details**
   - Check version numbers are current
   - Verify API specifications
   - Ensure technical explanations are accurate

### Phase 4: Formatting and Style Review (5-10 min)

1. **Check markdown formatting**
   - Proper heading hierarchy (H1 → H2 → H3)
   - Correct code fence syntax
   - Proper list formatting
   - Valid table syntax

2. **Verify visual consistency**
   - Consistent use of bold/italic
   - Consistent code span usage
   - Consistent callout formatting
   - Consistent diagram style

3. **Review code blocks**
   - All have language tags
   - Proper indentation
   - Syntax highlighting works
   - Examples are formatted well

### Phase 5: Links and Cross-References (5-10 min)

1. **Check internal links**
   - Verify all `[text](file.md)` links
   - Check all `#anchor` links
   - Validate relative paths
   - Ensure linked files exist

2. **Verify cross-references**
   - Check "See also" sections
   - Verify "Related topics" links
   - Ensure bidirectional linking where appropriate

3. **Validate external references**
   - Check external URLs are formatted correctly
   - Verify URLs are complete (http/https)
   - Note any suspicious or broken-looking URLs

### Phase 6: Production Readiness Check (5-10 min)

Go through the checklist:

- [ ] **No broken links**: All internal links work
- [ ] **No TODOs**: No `TODO`, `FIXME`, `TBD` markers
- [ ] **No placeholders**: All content is complete
- [ ] **Complete TOC**: All pages in TABLE_OF_CONTENTS.md
- [ ] **Valid cross-references**: All cross-refs exist
- [ ] **Spelling**: No obvious spelling errors
- [ ] **Grammar**: No obvious grammar issues
- [ ] **Reading times**: All pages have estimates
- [ ] **Navigation**: Clear paths through content
- [ ] **Beginner-friendly**: Accessible to newcomers
- [ ] **Security**: No security anti-patterns in examples
- [ ] **Costs**: Token/cost estimates are reasonable
- [ ] **Accessibility**: Jargon explained, progressive examples
- [ ] **Consistency**: Style guide followed throughout

### Phase 7: Generate Action Plan (5 min)

Create `DOCUMENTATION_REVIEW_PLAN.md` with:

1. **Executive Summary**
   - Overall assessment (Ready/Not Ready/Needs Work)
   - Critical issues count
   - Important issues count
   - Minor issues count
   - Estimated time to fix

2. **Critical Issues** (Must fix before production)
   - Broken links
   - Missing content
   - Technical inaccuracies
   - Security concerns

3. **Important Issues** (Should fix before production)
   - Incomplete sections
   - Formatting inconsistencies
   - Missing cross-references
   - Spelling/grammar errors

4. **Minor Issues** (Nice to fix)
   - Style improvements
   - Enhanced examples
   - Additional cross-references
   - Formatting polish

5. **Action Items**
   - Prioritized list of fixes
   - Specific file locations
   - Brief description of issue
   - No fix suggestions (just identification)

## Output Format

Create `DOCUMENTATION_REVIEW_PLAN.md` with this structure:

```markdown
# Documentation Review Report

**Date**: [Date]
**Reviewer**: Claude Opus 4.5 (documentation-reviewer skill)
**Scope**: Entire documentation project

---

## Executive Summary

**Overall Status**: [Ready for Production / Needs Work / Not Ready]

**Issue Summary**:
- 🔴 Critical Issues: [count]
- 🟡 Important Issues: [count]
- 🟢 Minor Issues: [count]
- **Total Issues**: [count]

**Estimated Fix Time**: [X hours]

**Recommendation**: [Proceed to production / Fix critical issues first / Substantial work needed]

---

## Production Readiness Checklist

- [x/☐] No broken links
- [x/☐] No TODOs or placeholders
- [x/☐] Complete table of contents
- [x/☐] Valid cross-references
- [x/☐] No spelling errors
- [x/☐] No grammar errors
- [x/☐] Reading time estimates
- [x/☐] Clear navigation
- [x/☐] Beginner-friendly
- [x/☐] Security best practices
- [x/☐] Accurate costs/tokens
- [x/☐] Style guide compliance

---

## Critical Issues (Must Fix)

### Issue 1: [Brief Description]
- **File**: `path/to/file.md`
- **Line**: [line number if applicable]
- **Category**: [Broken Link / Technical Error / Security / Missing Content]
- **Description**: [Detailed description of the issue]

### Issue 2: [Brief Description]
[Continue for all critical issues...]

---

## Important Issues (Should Fix)

### Issue 1: [Brief Description]
- **File**: `path/to/file.md`
- **Line**: [line number if applicable]
- **Category**: [Formatting / Consistency / Completeness]
- **Description**: [Detailed description]

[Continue for all important issues...]

---

## Minor Issues (Nice to Fix)

### Issue 1: [Brief Description]
- **File**: `path/to/file.md`
- **Category**: [Polish / Enhancement / Suggestion]
- **Description**: [Detailed description]

[Continue for all minor issues...]

---

## Action Plan

### Immediate Actions (Critical Fixes)
1. [ ] Fix broken link in `file.md` line X
2. [ ] Complete missing section in `file.md`
3. [ ] Correct technical error in `file.md`
[Continue...]

### Priority Actions (Important Fixes)
1. [ ] Fix spelling errors in `file.md`
2. [ ] Add missing cross-reference in `file.md`
3. [ ] Correct formatting in `file.md`
[Continue...]

### Optional Actions (Minor Fixes)
1. [ ] Polish formatting in `file.md`
2. [ ] Enhance example in `file.md`
3. [ ] Add additional cross-reference in `file.md`
[Continue...]

---

## Files Reviewed

- Total files: [count]
- Files with issues: [count]
- Clean files: [count]

### Files with Critical Issues
- `path/to/file1.md` ([count] issues)
- `path/to/file2.md` ([count] issues)

### Files with Important Issues
- `path/to/file3.md` ([count] issues)

### Files with Minor Issues
- `path/to/file4.md` ([count] issues)

---

## Review Statistics

- **Total pages reviewed**: [count]
- **Total words reviewed**: ~[estimate]
- **Total code examples**: [count]
- **Total links checked**: [count]
- **Broken links found**: [count]
- **Cross-references checked**: [count]
- **Invalid cross-refs found**: [count]

---

## Next Steps

1. Review this plan
2. Address critical issues first
3. Address important issues
4. Address minor issues (optional)
5. Re-run documentation-reviewer to verify fixes
6. Approve for production

---

## Notes

[Any additional observations, patterns noticed, or recommendations]
```

## Validation

After generating the plan:

1. **Verify completeness**: All issues documented
2. **Check categorization**: Issues properly categorized
3. **Validate file references**: All file paths correct
4. **Ensure actionability**: Each issue is clear

## Usage Example

```
You: "Use the documentation-reviewer skill to perform a comprehensive review of the entire documentation project and create an action plan for production readiness."

Claude: [Executes comprehensive review following all phases]

Output: DOCUMENTATION_REVIEW_PLAN.md created with:
- Executive summary with overall status
- Complete production readiness checklist
- Categorized issues (Critical/Important/Minor)
- Actionable items with file locations
- Statistics and next steps
```

## Cost Estimate

- **Model**: Claude Opus 4.5
- **Time**: 30-60 minutes for comprehensive review
- **Tokens**: ~40,000-80,000 tokens (entire project)
- **Cost**: ~$1.20-$2.40 per review

## Best Practices

1. **Run before major releases**: Always review before production
2. **Address critical issues first**: Fix blockers immediately
3. **Track progress**: Check off items in the action plan
4. **Re-review after fixes**: Run skill again to verify
5. **Keep plan**: Document for future reference

## Limitations

- Does NOT execute code examples (security concern)
- Does NOT actually visit external URLs (checks format only)
- Does NOT make fixes (only identifies issues)
- Does NOT modify files (read-only review)
- Requires human judgment for final approval

## Notes for AI

When executing this skill:

1. Be **thorough and systematic** - follow all phases
2. Be **specific** - include file names, line numbers when possible
3. Be **objective** - identify real issues, not preferences
4. Be **prioritized** - categorize by severity correctly
5. Be **actionable** - make issues clear and fixable
6. Be **comprehensive** - don't skip sections
7. **Don't suggest fixes** - only identify issues
8. **Focus on facts** - not opinions or style preferences
9. **Use the checklist** - verify all criteria
10. **Generate the plan** - always output DOCUMENTATION_REVIEW_PLAN.md

Remember: This is a production readiness review. Be thorough, be critical, but be fair. The goal is to ensure the documentation is polished, accurate, and ready for public release.
