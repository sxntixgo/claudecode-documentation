# Thinking Output Modes

**Reading Time**: 10 minutes
**Prerequisites**: [Thinking Overview](1-overview.md)

---

## Understanding Thinking Output 📊

When Claude uses thinking mode, you see the reasoning process before the final answer.

---

## Output Structure

### Normal Mode Output
```
[Direct answer]
```

### Thinking Mode Output
```
<thinking>
[Internal reasoning process]
- Considering option A...
- Evaluating trade-offs...
- Best approach is...
</thinking>

[Final answer based on reasoning]
```

---

## Benefits of Seeing Thinking

**1. Transparency**
- Understand why Claude chose this approach
- See what alternatives were considered

**2. Debugging**
- If answer is wrong, see where reasoning failed
- Provide corrections to reasoning process

**3. Learning**
- See expert-level problem-solving process
- Learn new approaches and considerations

---

## Controlling Output Verbosity

**Show thinking** (default in thinking mode):
```bash
"Think through the best caching strategy"
# Output includes <thinking> tags
```

**Hide thinking** (just get the answer):
```bash
"Think through the best caching strategy, but only show the final recommendation"
# Output shows just the conclusion
```

---

## Next Steps

**Phase 2 Completion:**
- [Context Management Overview](../09-context/1-overview.md) - Advanced context control

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
