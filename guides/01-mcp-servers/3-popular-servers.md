# Popular MCP Servers: Your Complete Catalog

⏱️ **Time**: 25 minutes
📊 **Level**: Beginner to Intermediate
🎯 **You'll Learn**: Which MCP servers are worth connecting, their real install commands, when to use each one, and how to find more

---

## What's in This Guide?

Now that you understand [what MCP servers are](1-overview.md) and [how to install them](2-installation.md), let's explore the servers worth connecting. Think of this as your shopping guide—we'll show you what's available, what each server does best, and help you choose the right ones for your workflow.

**By the end of this guide**, you'll know:
- ✅ Where to discover MCP servers
- ✅ Servers with verified, working install commands
- ✅ How to evaluate a server you found somewhere else
- ✅ Which servers to install first based on your work

> 📋 **How this page was checked**: every install command below was verified against either the [Claude Code MCP documentation](https://code.claude.com/docs/en/mcp) or the package's own published metadata. Servers we could **not** verify are called out explicitly in [Servers we could not verify](#servers-we-could-not-verify) rather than given a plausible-looking command. If a command here doesn't work for you, the vendor's docs win — tell us and we'll fix the page.

---

## 🔍 Discovering MCP Servers

Before exploring specific servers, know where to find them.

> ⚠️ **Claude Code has no built-in server registry.** There is no browse-and-install UI, and no `claude mcp search`. Discovery happens entirely through the external sources below.

### 1. The Anthropic Directory

**[claude.ai/directory](https://claude.ai/directory)** is the closest thing to an official list. Anthropic reviews connectors there against its [listing criteria](https://claude.com/docs/connectors/building/review-criteria) before adding them. Directory connectors use the same MCP infrastructure as Claude Code, so any remote server listed there can be added with `claude mcp add`.

> ⚠️ Review is not a security audit. Anthropic explicitly does not security-audit or manage MCP servers. Reviewing a server before you connect it remains your job.

### 2. The Reference Implementations

**[modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers)** holds the protocol project's own servers, published to npm under the `@modelcontextprotocol/` scope.

```bash
# See what's currently published under the official scope
npm search @modelcontextprotocol
```

> 🚨 **Check for deprecation before you install from this scope.** Several early servers have been retired and now emit `Package no longer supported` on install. Verify with:
> ```bash
> npm view @modelcontextprotocol/server-<name> deprecated
> ```
> Known-deprecated at the time of writing: `@modelcontextprotocol/server-github`, `@modelcontextprotocol/server-postgres`, and `server-perplexity-ask`. Alternatives for each are given below.

### 3. The Docker MCP Catalog

Docker publishes containerized MCP servers under the [`mcp` namespace on Docker Hub](https://hub.docker.com/u/mcp) — over 200 images. See [Docker's MCP Catalog and Toolkit docs](https://docs.docker.com/ai/mcp-catalog-and-toolkit/) for their tooling, and [Running a containerized server](2-installation.md#running-a-containerized-server) for how to wire one into `.mcp.json`.

### 4. The Vendor's Own Docs

For a hosted service, the vendor's documentation is the authoritative source for its MCP endpoint URL. Endpoints change; a URL copied from a blog post may be stale.

---

## The Essential Five

If you're just getting started, these five give the most value for the least setup.

### Quick Comparison

| Server | Type | Best For | Auth | Must-Have For |
|--------|------|----------|------|---------------|
| **Claude Code docs** | HTTP | Looking up Claude Code behavior | None | Everyone — the ideal first server |
| **GitHub** | HTTP | Issues, PRs, code review | PAT header | All developers |
| **Sentry** | HTTP | Production errors | OAuth | Anyone shipping to production |
| **Playwright** | stdio | Browser control and testing | None | Web developers |
| **Context7** | stdio or HTTP | Library documentation | Optional API key | Anyone using fast-moving frameworks |

Now let's dive into each one!

---

## 1. Claude Code Docs MCP Server

**The best first server**, because it requires no account, no token, and no configuration, and you can immediately tell whether it worked.

### What It Does

Full-text search over the Claude Code documentation. When Claude answers a question about Claude Code behavior, it can consult current docs rather than its training data.

### Installation

```bash
claude mcp add --transport http claude-code-docs https://code.claude.com/docs/mcp
```

**Authentication**: none.

### Try It

```bash
claude

> "Use the claude-code-docs server to look up what MCP_TIMEOUT does"
```

If the answer describes a server startup timeout in milliseconds, the server is working.

---

## 2. GitHub MCP Server

**The most useful server for most developers**, connecting Claude to issues, pull requests, and repository state.

### What It Does

- ✅ Create, update, and close issues
- ✅ Read and comment on pull requests
- ✅ Search repositories
- ✅ Read repository metadata and CI status

### Real-World Scenario: Code Review Workflow

**The task**: review a colleague's PR and provide feedback.

```bash
> "Review PR #42 and check for security issues"

Claude:
📖 Fetching PR #42: "Add payment processing"
🔍 Analyzing changes (4 files, 320 lines)

Security concerns found:
1. ❌ API key hardcoded in payment.js:45
2. ❌ SQL injection risk in database.js:112
3. ⚠️ Missing input validation in checkout.js:67

✍️ Adding review comments to PR...
✅ Posted 3 comments with code suggestions
```

**Value**: review and feedback without leaving Claude Code.

### Installation

GitHub runs a hosted MCP server that authenticates with a personal access token passed as a header:

```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer YOUR_GITHUB_PAT"
```

Get the token from [GitHub token settings](https://github.com/settings/personal-access-tokens). Generate a **fine-grained** token with access only to the repositories Claude should touch.

> 🚨 **`claude mcp add` does not validate the token.** A placeholder is accepted here and the server simply fails to connect later. Run `claude mcp list` and confirm `✔ Connected` before assuming it worked.

> 🚨 **Don't use the old npm package.** `@modelcontextprotocol/server-github` is deprecated and no longer supported. Use the hosted server above.

### Best Practices

**Scope the token, not the server:**

```bash
# ✅ Good: fine-grained token, two specific repositories
# ⚠️ OK:   fine-grained token across your personal repositories
# ❌ Avoid: classic token with org-wide `repo` scope
```

There is no `--scope repo:owner/name`. `--scope` takes only `local`, `project`, or `user`, and controls where the *configuration* is written.

**Restrict destructive tools with permission rules** in `.claude/settings.json`:

```json
{
  "permissions": {
    "deny": ["mcp__github__delete_repository"]
  }
}
```

**Use Claude for**: creating issues from error logs, batch PR review, generating PR descriptions from commit history.

**Don't use Claude for**: force pushes, deleting branches in production, modifying other people's commits without permission.

---

## 3. Sentry MCP Server

**Production error data**, so Claude debugs against what actually happened rather than what you remember.

### What It Does

- ✅ Query recent issues and their frequency
- ✅ Pull full stack traces by error ID
- ✅ Correlate new errors with deployments

### Real-World Scenario

```bash
> "What are the most common errors in the last 24 hours?"
> "Show me the stack trace for error ID abc123"
> "Which deployment introduced these new errors?"
```

The third question is the one that's hard to answer by hand and easy for Claude once it can see both your Sentry data and your git history.

### Installation

Sentry authenticates through OAuth, so you pass no credential when adding it:

```bash
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

Then sign in:

```text
/mcp
```

Select `sentry`, choose **Authenticate**, and complete the browser flow. Or, without opening a session:

```bash
claude mcp login sentry
```

---

## 4. Playwright MCP Server

**A real browser Claude can drive** — navigate, click, fill forms, and read what's on the page.

### What It Does

- ✅ Open pages and report what's rendered
- ✅ Click, type, and navigate
- ✅ Reproduce a bug report step by step
- ✅ Verify a UI change against a running dev server

### Real-World Scenario

```bash
> "Open http://localhost:3000/checkout, add an item to the cart,
   and tell me what happens when I submit an empty email field"
```

Claude walks through it in a visible browser window. This turns "does my change actually work in the browser" from a manual check into something Claude can confirm.

### Installation

```bash
claude mcp add playwright -- npx -y @playwright/mcp@latest
```

**Requires** Node.js 18 or later. **Authentication**: none.

Playwright drives whichever Chrome is already installed. For a different browser, append the flag after the package:

```bash
claude mcp add playwright -- npx -y @playwright/mcp@latest --browser firefox
```

> 💡 The first `claude mcp list` may show `✘ Failed to connect` while `npx` downloads the package. Wait a moment and check again.

---

## 5. Context7 MCP Server

**Version-aware library documentation**, pulled from the source rather than from training data.

### What It Does

- ✅ Framework documentation (React, Next.js, Vue, Angular)
- ✅ Library references with version awareness
- ✅ Code examples from official docs

### Real-World Scenario

```bash
> "How do I implement route handlers in the Next.js App Router? use context7"
```

Claude resolves the library ID, fetches the current docs, and answers from them:

```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  const users = await db.users.findMany()
  return NextResponse.json({ users })
}
```

> Key differences from the Pages Router: use `route.ts` instead of `/pages/api`, export HTTP method functions, and use `NextRequest`/`NextResponse` rather than `req`/`res`.

The value is that this reflects the version currently published, not whatever the model absorbed during training.

### Installation

Context7 offers both a local package and a hosted endpoint. An API key is **optional** — it raises rate limits and unlocks private repositories. Get one at [context7.com/dashboard](https://context7.com/dashboard).

**Local (stdio):**

```bash
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp --api-key YOUR_API_KEY
```

**Remote (HTTP):**

```bash
claude mcp add --scope user --header "CONTEXT7_API_KEY: YOUR_API_KEY" \
  --transport http context7 https://mcp.context7.com/mcp
```

Drop `--scope user` to install for the current project only. Requires Node.js 20.18.1 or later for the local form.

> 🚨 The package is **`@upstash/context7-mcp`**, published by Upstash. There is no `@context7/mcp-server` package.

### Best Practices

Context7 activates most reliably when you say `use context7` in your prompt. To avoid typing it every time, add a line to your `CLAUDE.md`:

```markdown
Always use context7 when I need code generation, setup steps, or library/API
documentation, without me having to explicitly ask.
```

---

## Databases

### DBHub (Recommended)

The Claude Code documentation uses [DBHub](https://github.com/bytebase/dbhub) as its worked database example. It connects to a relational database through a connection string.

```bash
claude mcp add --transport stdio db -- npx -y @bytebase/dbhub \
  --dsn "postgresql://readonly:pass@prod.db.com:5432/analytics"
```

Then query naturally:

```bash
> "What's our total revenue this month?"
> "Show me the schema for the orders table"
> "Find customers who haven't made a purchase in 90 days"
```

> 🚨 **Use a read-only database user in the connection string.** This is the actual security boundary. Claude will happily write a `DELETE` if the credential permits one, and no Claude Code setting restricts SQL by statement type.

> 🚨 `@modelcontextprotocol/server-postgres` is **deprecated** and no longer supported. Use DBHub or a vendor-maintained server instead.

### MongoDB and Others

MongoDB, Redis, and most other engines have community or vendor MCP servers, but we have not verified a specific one to recommend here. See [Servers we could not verify](#servers-we-could-not-verify) for how to evaluate one you find.

---

## Reference Servers

These come from [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) and are actively published.

### Filesystem

Structured filesystem access scoped to directories you name.

```bash
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem /path/to/allowed/dir
```

> 💡 **You probably don't need this in Claude Code.** Claude Code already has native `Read`, `Write`, `Edit`, `Glob`, and `Grep` tools, plus a [working-directory permission model](https://code.claude.com/docs/en/permissions). The filesystem MCP server exists mainly for clients that lack built-in file tools. Add it only if you specifically want its directory-scoping semantics.

### Sequential Thinking

Structured multi-step reasoning as a tool.

```bash
claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
```

**Authentication**: none.

> 💡 **Consider whether you need it.** Claude Code has its own [extended thinking modes](../08-thinking/1-overview.md) and a planning permission mode. This server predates much of that. Try the built-in options first and add this only if you want the explicit numbered-thought output format.

---

## Other Hosted Servers

These endpoints appear in the Claude Code documentation's own examples, so the URLs are verified:

| Service | Command |
|---------|---------|
| **Notion** | `claude mcp add --transport http notion https://mcp.notion.com/mcp` |
| **Stripe** | `claude mcp add --transport http stripe https://mcp.stripe.com` |
| **HubSpot** | `claude mcp add --scope user --transport http hubspot https://mcp.hubspot.com/anthropic` |
| **Asana** | `claude mcp add --transport sse asana https://mcp.asana.com/sse` |
| **Airtable** | `claude mcp add --env AIRTABLE_API_KEY=YOUR_KEY --transport stdio airtable -- npx -y airtable-mcp-server` |

> ⚠️ Asana is listed with `--transport sse` because that's the endpoint it exposes. **SSE is deprecated** — prefer HTTP wherever a vendor offers it.

Most of these require a browser sign-in after adding. Run `/mcp` and authenticate.

---

## Servers We Could Not Verify

This section exists on purpose. These are servers people commonly ask about where we could **not** confirm a current, working install command from a primary source. Rather than guess at one, here's what we know:

| Server | Status | What to do |
|--------|--------|------------|
| **Perplexity** | The `server-perplexity-ask` npm package is **deprecated**. Perplexity documents a current MCP offering, but we could not reach that documentation to verify the endpoint or auth header | Check [Perplexity's own MCP documentation](https://docs.perplexity.ai) for the current endpoint before configuring anything |
| **Jira / Atlassian** | Atlassian publishes an MCP server, but we have not verified its endpoint | Check Atlassian's docs or the [Anthropic Directory](https://claude.ai/directory) |
| **Slack** | Multiple community servers exist; the officially-supported path is the Slack **claude.ai connector**, not a locally-added server | Add it at [claude.ai/customize/connectors](https://claude.ai/customize/connectors), where it becomes available in Claude Code automatically |
| **AWS / GCP / Azure** | Cloud vendors publish MCP servers, but we have not verified specific install commands | Check the vendor's own documentation. **There is no `claude mcp add aws`** — that command form, with a bare service name and no URL or start command, is not valid syntax |

> 🚨 **`claude mcp add <name>` with nothing after it does not work.** Every add needs either a URL (with `--transport http` or `sse`) or a start command after `--`. Any snippet you see of the form `claude mcp add github` or `claude mcp add aws`, with no second argument, is wrong.

### How to Evaluate a Server You Found

1. **Find the publisher.** A GitHub org you recognize, a vendor's own docs, or the Anthropic Directory. An unattributed npm package that wants an API key deserves suspicion.
2. **Check it isn't deprecated**: `npm view <package> deprecated`.
3. **Read what it does with your credential.** A stdio server runs on your machine with your environment.
4. **Add it at local scope first**, so a mistake doesn't propagate to your team through a committed `.mcp.json`.
5. **Check `claude mcp list`** for `✔ Connected`, then `/mcp` for its actual tool list. A server that advertises tools but exposes none is flagged there.

---

## Choosing the Right Servers

### Decision Matrix

| Your Work | Start With | Add Next | Consider |
|-----------|-----------|----------|----------|
| **Web Development** | Claude Code docs, Playwright | GitHub, Context7 | Vendor connector for your host |
| **Backend/API** | GitHub, DBHub | Sentry | Context7 |
| **DevOps** | GitHub, Sentry | Cloud vendor's own server | Monitoring vendor's own server |
| **Full-Stack** | GitHub, Playwright, Context7 | DBHub, Sentry | Project-tracking connector |

### Starter Packs

**Minimal Setup** (2 servers):
1. Claude Code docs — no auth, immediate payoff
2. GitHub — code and PR management

**Standard Developer** (4 servers):
1. GitHub
2. Sentry
3. Playwright
4. Context7

**Add a database** when you find yourself pasting query results into chat, and **add a project-tracker connector** when you find yourself pasting ticket descriptions.

> 💡 **Add servers one at a time and use each for a week.** The cost of a server you never call is small (see below) but not zero, and an unused server is one more thing whose credentials you have to rotate.

---

## Performance and Context Cost

### What Adding a Server Actually Costs

This is worth getting right, because the intuition most people carry is out of date.

**Tool definitions are deferred by default.** With [tool search](https://code.claude.com/docs/en/mcp#scale-with-mcp-tool-search) enabled — which is the default — only tool *names* and each server's instructions load at session start. Full schemas enter context only when Claude searches for and uses a tool. Claude Code imposes no fixed per-server tool cap; your context window budget is the practical limit.

```mermaid
graph LR
    A["10 servers connected"] --> B["Session start:<br/>names + server<br/>instructions only"]
    B --> C["You ask for<br/>one thing"]
    C --> D["1-2 tool definitions<br/>enter context"]

    style B fill:#d4f4dd
    style D fill:#d4f4dd
```

**When this doesn't apply.** Tool search is off, and all definitions load upfront, in these cases:

- `ENABLE_TOOL_SEARCH=false` is set
- `ANTHROPIC_BASE_URL` points at a non-first-party host (most proxies don't forward the required blocks)
- On Google Cloud's Agent Platform and Microsoft Foundry deployments hosted on Azure
- On models that don't support tool-reference blocks
- For any server configured with `"alwaysLoad": true`

`ENABLE_TOOL_SEARCH` accepts `true`, `false`, `auto` (load upfront if the schemas fit within 10% of the context window), and `auto:N` for a custom percentage.

**The real cost drivers**, in rough order:

| Driver | Why it costs | What to do |
|--------|--------------|------------|
| **Tool output size** | A single large result can dwarf every tool schema you have | Claude Code warns above 10,000 tokens and truncates at 25,000; raise with `MAX_MCP_OUTPUT_TOKENS` |
| **`alwaysLoad: true` servers** | Their schemas load every session, unconditionally | Use only for tools Claude needs on every turn |
| **Long tool descriptions** | Truncated at 2KB each, but count fully below that | Server authors: keep descriptions tight and front-load what matters |
| **Latency of the service itself** | Network round-trips to the vendor | Not a Claude Code knob — check the server's own docs |

Use `/context` to see how much of your window MCP is actually consuming, rather than guessing.

### Exempting a Server From Deferral

If a server's tools should always be visible without a search step:

```json
{
  "mcpServers": {
    "core-tools": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "alwaysLoad": true
    }
  }
}
```

> ⚠️ This also blocks startup until that server connects, capped at the 5-second connect timeout. Use it sparingly.

---

## Usage Tips

### Combining Servers

**Example 1: Research → Implement → Verify**
```bash
# Look up the current API (Context7)
> "Show me the Express.js middleware pattern for rate limiting. use context7"

# Implement, commit, open a PR (GitHub)
> "Implement it, commit, and open a PR"

# Confirm it works in a browser (Playwright)
> "Open the dev server and confirm a 429 after 11 rapid requests"
```

**Example 2: Debug → Fix → Track**
```bash
# Find the failure (Sentry)
> "What's the most frequent new error since yesterday's deploy?"

# Fix and ship (GitHub)
> "Find the commit that introduced it, write a fix, and open a PR referencing the Sentry issue"
```

### Naming a Server Explicitly

You don't normally need to — Claude picks tools on its own. But naming one is useful when you want to guarantee which path an answer came from:

```bash
> "Use the claude-code-docs server to check whether alwaysLoad is a real field"
```

---

## Quick Reference

### Verified Install Commands

| Server | Command |
|--------|---------|
| Claude Code docs | `claude mcp add --transport http claude-code-docs https://code.claude.com/docs/mcp` |
| GitHub | `claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer PAT"` |
| Sentry | `claude mcp add --transport http sentry https://mcp.sentry.dev/mcp` |
| Playwright | `claude mcp add playwright -- npx -y @playwright/mcp@latest` |
| Context7 | `claude mcp add context7 -- npx -y @upstash/context7-mcp --api-key KEY` |
| DBHub | `claude mcp add --transport stdio db -- npx -y @bytebase/dbhub --dsn "postgresql://..."` |
| Filesystem | `claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem /path` |
| Sequential Thinking | `claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking` |
| Notion | `claude mcp add --transport http notion https://mcp.notion.com/mcp` |
| Stripe | `claude mcp add --transport http stripe https://mcp.stripe.com` |

### By Use Case

**"I need to manage code/PRs"** → GitHub
**"I need production error data"** → Sentry
**"I need to check something in a browser"** → Playwright
**"I need current library docs"** → Context7
**"I need database access"** → DBHub
**"I need to know how Claude Code itself behaves"** → Claude Code docs server

---

## Troubleshooting Common Issues

### Issue 1: MCP Server Not Connecting

**Symptom**: `✘ Failed to connect` in `claude mcp list`, or the server appears offline in `/mcp`

**Solutions:**

```bash
# See the underlying error for one server
claude mcp get <server-name>

# Reconnect a single disconnected server, from inside a session
/mcp reconnect <server-name>

# Reinstall
claude mcp remove <server-name>
claude mcp add ...   # with the full, correct command
```

> 🚨 There is no `claude mcp restart`, `claude mcp logs`, `claude mcp status`, or `claude mcp test`. Use `claude mcp get` from the shell, and `/mcp` from inside a session. See [the full subcommand list](2-installation.md#every-claude-mcp-subcommand).

Claude Code automatically reconnects HTTP and SSE servers that drop mid-session — five attempts with exponential backoff starting at one second. Stdio servers are local processes and are **not** reconnected automatically.

---

### Issue 2: API Key Errors

**Symptom**: "Invalid API key", `401`, or `403`

**Solutions:**

```bash
# Confirm the variable is actually set in the shell that launches claude
echo $GITHUB_TOKEN

# Check what Claude Code recorded for this server
claude mcp get github
```

For OAuth servers, run `/mcp`, select the server, and choose **Re-authenticate**. If a stored refresh token has been rejected, Claude Code shows a notice pointing at `/mcp`.

If you configured `headers.Authorization` yourself and the server rejects it, Claude Code reports the connection as **failed rather than falling back to OAuth**. Remove the header if you meant to use the browser flow.

---

### Issue 3: Slow or Timing-Out Servers

**Symptom**: long waits, or tool calls that abort

Claude Code gives you three timeout knobs and one structural lever:

| Control | Scope | Default |
|---------|-------|---------|
| `MCP_TIMEOUT` | Server **startup**, milliseconds | 30 seconds |
| `MCP_TOOL_TIMEOUT` | Per tool call wall clock, milliseconds | Very long; effectively unbounded unless set |
| `"timeout"` field in a server's JSON entry | Per tool call, that server only. Overrides `MCP_TOOL_TIMEOUT` | Unset |
| `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT` | Aborts a call that sends nothing at all for this long | 5 min remote, 30 min stdio |

```json
{
  "mcpServers": {
    "slow-server": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "timeout": 600000
    }
  }
}
```

> 💡 A main-conversation tool call still running after two minutes moves to a background task rather than blocking your session, so a slow server no longer freezes your work. The per-call limits still apply while it runs in the background.

**The structural lever** is which servers load at all. To narrow that:

- Toggle a server off in the `/mcp` panel, or run `/mcp disable <server>`. This keeps its configuration but stops Claude Code connecting to it, recorded per project in `~/.claude.json`
- For project `.mcp.json` servers, list the ones you want in `enabledMcpjsonServers` in `.claude/settings.json`, or reject specific ones with `disabledMcpjsonServers`

```json
{
  "enabledMcpjsonServers": ["github", "sentry"],
  "disabledMcpjsonServers": ["slow-server"]
}
```

> 🚨 **`allowedMcpServers` and `deniedMcpServers` are a different mechanism** and won't work here. They are **managed settings only** — administrator policy, not a per-developer toggle — and each entry is an **object**, not a bare string: `[{ "serverName": "github" }]`, not `["github"]`. Putting them in your own project settings does not restrict anything. See [Managed MCP configuration](https://code.claude.com/docs/en/managed-mcp).

Use `/context` to confirm how much room the remaining servers are taking.

For anything server-side — caching, batching, rate-limit backoff — check that server's own documentation. Those knobs belong to the server, not to Claude Code.

---

### Issue 4: Changes to `.mcp.json` Don't Take Effect

Claude Code reads `.mcp.json` at session start. Exit and restart.

If servers still don't appear, run `/mcp` and look for a parse warning — malformed entries are skipped with the offending field shown. If you previously rejected the server at the approval prompt:

```bash
claude mcp reset-project-choices
```

---

### Still Having Issues?

1. **Check the official troubleshooting section**: [MCP quickstart → Troubleshooting](https://code.claude.com/docs/en/mcp-quickstart#troubleshooting)
2. **Check this project's guide**: [Troubleshooting](../14-reference/2-troubleshooting.md)
3. **Report a server bug** to that server's own repository — most connection problems are server-side, not Claude Code side

---

## Next Steps

Excellent! You now know:
- ✅ Servers with verified install commands, and which ones are deprecated
- ✅ Where discovery actually happens, since there's no built-in registry
- ✅ What connecting a server really costs in context
- ✅ How to evaluate a server nobody has vetted for you

**Ready to explore further?**

**→ [Create Custom MCP Servers](4-creating-custom-servers.md)** - Build your own for internal tools

**→ [Learn About Agents](../03-agents/1-overview.md)** - Understand how agents use these MCP tools

**→ [MCP Best Practices](5-best-practices.md)** - Security, performance, error handling

---

## References & Further Reading

### 📚 Official Documentation

- [Connect Claude Code to tools via MCP](https://code.claude.com/docs/en/mcp) - Transports, scopes, auth, tool search
- [MCP quickstart](https://code.claude.com/docs/en/mcp-quickstart) - Step-by-step with a troubleshooting section
- [Anthropic Directory](https://claude.ai/directory) - Reviewed connectors
- [Managed MCP configuration](https://code.claude.com/docs/en/managed-mcp) - `allowedMcpServers`, `deniedMcpServers`, `managed-mcp.json`
- [MCP Specification](https://modelcontextprotocol.io/introduction) - Protocol documentation
- [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) - Reference implementations
- [Docker MCP Catalog and Toolkit](https://docs.docker.com/ai/mcp-catalog-and-toolkit/) - Containerized servers

### 🔗 Related Topics

- [MCP Overview](1-overview.md) - Conceptual foundation
- [Installation Guide](2-installation.md) - Setup instructions, scopes, every subcommand
- [Agents Overview](../03-agents/1-overview.md) - How agents use MCP servers
- [Creating Custom Servers](4-creating-custom-servers.md) - Build your own

### 📖 Server-Specific Documentation

- [Playwright MCP](https://github.com/microsoft/playwright-mcp) - Browser automation server
- [DBHub](https://github.com/bytebase/dbhub) - Database server
- [Context7](https://github.com/upstash/context7) - Documentation server

---

**Ready to dive into agents?** Continue to [Agents Overview](../03-agents/1-overview.md) to learn how Claude uses these MCP tools effectively!
