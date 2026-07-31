# Installing MCP Servers: Your Step-by-Step Guide

⏱️ **Time**: 30 minutes (hands-on)
📊 **Level**: Beginner
🎯 **You'll Learn**: Three installation methods, the three config scopes, authentication setup, testing, and troubleshooting

---

## What You'll Need

Before we begin, make sure you have:

**Required:**
- ✅ Claude Code installed ([installation guide](https://code.claude.com/docs/en/get-started))
- ✅ Command-line access (Terminal on macOS/Linux, PowerShell or Command Prompt on Windows)
- ✅ 15-30 minutes of focused time

**For Specific Servers:**
- 🔑 A GitHub fine-grained personal access token (for the GitHub MCP server)
- 🔑 Node.js 18+ (for `npx`-based local servers such as Playwright)
- 🔑 Nothing at all, for the practice server we start with

**Not sure if Claude Code is ready?** Run this quick check:

```bash
# Verify Claude Code is installed
claude --version
```

---

## Three Ways to Install MCP Servers

There are three installation methods, each with different trade-offs:

| Method | Difficulty | Best For | Pros | Cons |
|--------|-----------|----------|------|------|
| **`claude mcp add`** | ⭐ Easy | Any server, hosted or local | Fast, writes valid config for you | You need the URL or start command |
| **Hand-edited `.mcp.json`** | ⭐⭐ Medium | Team-shared setups | Configuration-as-code, reviewable in PRs | Requires JSON editing |
| **`claude mcp add-json`** | ⭐⭐ Medium | Copy-pasting a vendor's JSON block | Handles fields the flags don't cover | Shell escaping is fiddly |

**Recommendation for beginners**: start with `claude mcp add` for your first server.

> ⚠️ **There is no "official servers only" installer.** `claude mcp add` works identically for a first-party remote server and for a script you wrote this morning. Nothing about the CLI validates or vouches for the server you point it at — see [Authentication & Security](#authentication--security).

Let's explore each method with hands-on examples!

---

## Method 1: `claude mcp add` (Fastest)

One command registers a server. The shape of the command depends on the **transport** — how Claude Code talks to the server.

### The Three Transports

```mermaid
graph TB
    A["claude mcp add"] --> B{"Where does<br/>the server live?"}
    B -->|"At a URL"| C["--transport http<br/>(recommended for remote)"]
    B -->|"At a URL,<br/>legacy endpoint"| D["--transport sse<br/>(deprecated)"]
    B -->|"On your machine"| E["stdio (default)<br/>-- your command here"]

    style C fill:#d4f4dd
    style D fill:#fff2cc
    style E fill:#e1f5ff
```

| Transport | Flag | Use when |
|-----------|------|----------|
| **HTTP** | `--transport http` | Connecting to a hosted server. The recommended option for anything remote |
| **SSE** | `--transport sse` | The service only exposes an SSE endpoint. This transport is deprecated — prefer HTTP where the vendor offers it |
| **stdio** | default, no flag needed | The server is a program Claude Code starts as a subprocess on your machine |

### Example 1: Your First Server (No Credentials Needed)

The Claude Code documentation server is hosted, needs no authentication, and does something you can immediately verify — full-text search over the Claude Code docs. It's the best possible first server.

#### Step 1: Add It

```bash
claude mcp add --transport http claude-code-docs https://code.claude.com/docs/mcp
```

Reading the command left to right:

- `claude mcp add` — registers a server with Claude Code
- `--transport http` — the server is hosted at a URL rather than run locally
- `claude-code-docs` — **a name you make up**. Calling it `docs` would work identically. Claude Code uses this name to label the server's tools and to refer to the server in later commands
- `https://code.claude.com/docs/mcp` — where the server is hosted

You'll see a confirmation like `Added HTTP MCP server claude-code-docs with URL: ... to local config`, followed by a `File modified:` line telling you exactly which file it wrote.

#### Step 2: Check the Connection

```bash
claude mcp list
```

Each server appears with a status indicator:

| Status | Meaning |
|--------|---------|
| `✔ Connected` | Ready to use. This is what you want to see |
| `! Connected · tools fetch failed` | Connected, but couldn't list tools. Run `claude mcp get <name>` for detail |
| `! Needs authentication` | Reachable, but needs a browser sign-in or a token header |
| `✘ Failed to connect` | Didn't respond — see [Troubleshooting](#troubleshooting) |
| `⏸ Pending approval` | A project-scoped server you haven't approved yet. Run `claude` to approve it |

> 💡 **`Added` is not the same as `Connected`.** `claude mcp add` saves configuration without contacting the server. A typo'd URL or a bad token is accepted at add time and only shows up as a failure in `claude mcp list`. Always run the list command after adding.

#### Step 3: Use It

```bash
claude

> "Use the claude-code-docs server to look up what MCP_TIMEOUT does"
```

The first time Claude calls the server, you'll be asked to approve the new tool. Tool calls in Claude's output are labeled with the server name, which is how you confirm the answer came from the server rather than from Claude's built-in knowledge.

If you get an answer about startup timeouts, **congratulations!** 🎉 You've installed your first MCP server.

#### Step 4: Clean Up (Optional)

```bash
claude mcp remove claude-code-docs
```

---

### Example 2: A Local Server (Playwright)

A stdio server is a program Claude Code launches as a subprocess. Playwright is a good one to try — it gives Claude a real browser, and it needs no account.

```bash
claude mcp add playwright -- npx -y @playwright/mcp@latest
```

Three differences from the hosted example:

- **No `--transport` flag** — stdio is the default
- **Everything after `--` is the command** Claude Code runs to start the server
- `-y` tells `npx` to install the package without prompting

> 🚨 **The `--` separator is not optional decoration.** It divides Claude Code's own flags (`--transport`, `--env`, `--scope`) from the flags belonging to your server. Without it, `claude mcp add my-server -- python server.py --port 8080` would try to parse `--port` as one of *its* options and fail.

The first `claude mcp list` may show `✘ Failed to connect` while `npx` downloads the package. Wait a moment and run it again.

Then:

```bash
claude

> "Use playwright to open https://example.com and tell me the page title"
```

---

### Example 3: A Server That Needs a Token (GitHub)

GitHub's remote MCP server authenticates with a personal access token passed as a header.

#### Step 1: Create the Token

1. Open [GitHub token settings](https://github.com/settings/personal-access-tokens)
2. Generate a new **fine-grained** token
3. Grant it access only to the repositories you want Claude to work with
4. **Copy it immediately** — you won't see it again

#### Step 2: Add the Server

```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer YOUR_GITHUB_PAT"
```

#### Step 3: Verify

```bash
claude mcp list
```

A server with a bad token shows as failed here, not at add time. `--header` also has the short form `-H`.

---

### Example 4: A Server That Needs a Browser Sign-In (Sentry)

Many hosted services use OAuth. You add the URL with no credential at all, then sign in.

```bash
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

`claude mcp list` will show `! Needs authentication`. To complete sign-in, start a session and open the MCP panel:

```text
/mcp
```

Select `sentry`, press Enter, choose **Authenticate**, and approve in the browser that opens. The status changes to connected.

You can also do this without opening a session:

```bash
claude mcp login sentry

# On a headless box or over SSH, print the URL instead of launching a browser
claude mcp login sentry --no-browser

# To clear stored credentials later
claude mcp logout sentry
```

Tokens are stored securely and refreshed automatically. "Clear authentication" in the `/mcp` menu revokes access.

---

### Passing Environment Variables

Local servers usually take credentials through the environment:

```bash
claude mcp add --env AIRTABLE_API_KEY=YOUR_KEY --transport stdio airtable \
  -- npx -y airtable-mcp-server
```

`--env` (short form `-e`) accepts multiple `KEY=value` pairs.

> ⚠️ **Don't put the server name directly after `--env`.** The CLI reads the next word as another `KEY=value` pair and rejects it. Put at least one other option between them, as in the example above.

---

### CLI Installation Summary

**Pros:**
- ✅ Fastest method (< 2 minutes per server)
- ✅ Writes valid JSON so you can't typo the schema
- ✅ Tells you which file it modified
- ✅ Works for hosted and local servers alike

**Cons:**
- ❌ Shell escaping gets awkward for complex configs
- ❌ A few fields (`headersHelper`, `oauth`, `alwaysLoad`, `type: "ws"`) have no flag — use JSON for those

**When to use:** your first server, and most servers after that.

---

## Understanding Scopes (Read This Before Method 2)

Every server is registered at exactly one of three scopes. This determines **which projects it loads in** and **whether your team gets it**.

| Scope | Flag | Stored in | Loads in | Shared with team |
|-------|------|-----------|----------|------------------|
| **local** (default) | `--scope local` | `~/.claude.json`, under this project's entry | This project only | No |
| **project** | `--scope project` | `.mcp.json` in your project root | This project only | ✅ Yes, via version control |
| **user** | `--scope user` | `~/.claude.json`, under the top-level `mcpServers` key | All your projects | No |

```mermaid
graph TB
    subgraph Home["~/.claude.json"]
        L["local scope<br/>projects → /path/to/repo → mcpServers"]
        U["user scope<br/>top-level mcpServers"]
    end
    subgraph Repo["your repository"]
        P[".mcp.json<br/>project scope<br/>(commit this)"]
    end

    style P fill:#d4f4dd
    style U fill:#e1f5ff
    style L fill:#fff9e6
```

```bash
# Default: local — private to you, only in this project
claude mcp add --transport http stripe https://mcp.stripe.com

# User — private to you, in every project
claude mcp add --scope user --transport http hubspot https://mcp.hubspot.com/anthropic

# Project — shared with everyone who clones the repo
claude mcp add --scope project --transport http shared-server https://example.com/mcp
```

> ⚠️ **"Local scope" for MCP servers is not the same thing as `.claude/settings.local.json`.** MCP local-scoped servers live in `~/.claude.json` in your home directory. The similarly-named settings file is unrelated.

**A server's scope is fixed when you add it.** To change it, remove and re-add:

```bash
claude mcp remove claude-code-docs --scope local
claude mcp add --scope user --transport http claude-code-docs https://code.claude.com/docs/mcp
```

If the same server name exists at more than one scope, `remove` reports `exists in multiple scopes` and you must pass `--scope` to disambiguate. When the same server is *defined* at more than one scope, Claude Code connects once, using local, then project, then user, in that order — the whole entry from the winning scope, with no field-level merging.

---

## Method 2: Hand-Editing `.mcp.json` (Full Control)

Project scope is the one most worth writing by hand, because the file is checked into your repository where it doubles as configuration-as-code for the team.

### Where the File Goes

Create **`.mcp.json` at your project root** — the same directory as your `package.json` or `.git`.

> 🚨 **Claude Code does not read these paths**, no matter how plausible they look:
> `~/.claude/mcp.json`, `~/.claude/config/mcp.json`, `.claude/mcp.json`, `.claude/config.json`, `~/.config/claude/claude_desktop_config.json`, or `%APPDATA%\Claude\mcp.json`.
>
> The only two files Claude Code reads MCP servers from are **`.mcp.json`** at the project root and **`~/.claude.json`** in your home directory. (`claude_desktop_config.json` is the *Claude Desktop chat app's* file — a different application. See [importing from Claude Desktop](#importing-from-claude-desktop) if you have servers there.)
>
> On Windows, `~/.claude.json` resolves to `%USERPROFILE%\.claude.json`.

### Configuration File Structure

```json
{
  "mcpServers": {
    "claude-code-docs": {
      "type": "http",
      "url": "https://code.claude.com/docs/mcp"
    },
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    }
  }
}
```

**Key parts:**
- `mcpServers` — top-level object containing all servers
- the key (`playwright`) — the server name you choose
- `type` — `http`, `sse`, `stdio`, or `ws`
- `url` — the endpoint, for remote types
- `command` / `args` — the program to run, for `stdio`
- `env` — environment variables passed to a stdio server

> 🚨 **An entry with a `url` but no `type` is a configuration error.** Claude Code reads a typeless entry as stdio, skips it, and reports:
> `MCP server "<name>" has a "url" but no "type"; add "type": "http" (or "sse" / "ws") to this entry`
>
> The MCP specification calls the HTTP transport `streamable-http`, and Claude Code accepts that as an alias for `http`, so JSON copied from a vendor's docs works unmodified.

### Environment Variable Expansion

This is what lets a team share one committed file while each developer supplies their own secrets:

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

- `${VAR}` — expands to the value of `VAR`
- `${VAR:-default}` — expands to `VAR` if set, otherwise `default`

Expansion works in `command`, `args`, `env`, `url`, and `headers`. If a referenced variable isn't set and has no default, the config still loads — `claude mcp list` reports a missing-variable warning and the literal `${VAR}` text is used as-is, which will not work.

### Project Server Approval

For security, Claude Code **prompts before using project-scoped servers from `.mcp.json`**. The prompt exists so that cloning a repository can't silently launch processes on your machine.

Until you approve, the server shows as `⏸ Pending approval (run \`claude\` to approve)` in `claude mcp list` and `claude mcp get`.

Three settings in `.claude/settings.json` control this without prompting:

| Setting | Type | Effect |
|---------|------|--------|
| `enabledMcpjsonServers` | array of strings | Pre-approve these `.mcp.json` servers, e.g. `["memory", "github"]` |
| `disabledMcpjsonServers` | array of strings | Reject these, e.g. `["filesystem"]`. A reject here wins over any approval |
| `enableAllProjectMcpServers` | boolean | Approve every server in the project's `.mcp.json` |

```json
{
  "enabledMcpjsonServers": ["claude-code-docs", "playwright"],
  "disabledMcpjsonServers": ["risky-server"]
}
```

> ⚠️ **A cloned repository cannot approve its own servers.** Approvals committed to a project's `.claude/settings.json` are ignored in a folder you haven't trusted; the server stays at `⏸ Pending approval` until you run `claude` there and accept the workspace trust dialog. Approvals from your own `~/.claude/settings.json`, from managed settings, or from `--settings` still apply.

To reset your approval choices for a project:

```bash
claude mcp reset-project-choices
```

### Applying Changes

Claude Code reads `.mcp.json` **at session start**. Exit and restart the session after editing it. If servers still don't appear, run `/mcp` and look for a parse warning — malformed entries are skipped with the offending field shown.

### Manual Configuration Summary

**Pros:**
- ✅ Reviewable in pull requests
- ✅ Works with every config field, including ones with no CLI flag
- ✅ Team members get the same servers on clone
- ✅ Multiple servers in one file

**Cons:**
- ❌ Easy to make syntax errors
- ❌ Requires a session restart to take effect
- ❌ Teammates each hit an approval prompt the first time

**When to use:** anything your team should share.

---

## Method 3: `claude mcp add-json` (Copy-Paste a Vendor Block)

When a vendor's docs give you a JSON config, or when you need a field the flags don't expose, pass the JSON directly:

```bash
# Basic syntax
claude mcp add-json <name> '<json>'

# An HTTP server with headers
claude mcp add-json weather-api \
  '{"type":"http","url":"https://api.weather.com/mcp","headers":{"Authorization":"Bearer token"}}'

# A stdio server
claude mcp add-json local-weather \
  '{"type":"stdio","command":"/path/to/weather-cli","args":["--api-key","abc123"],"env":{"CACHE_DIR":"/tmp"}}'
```

Then verify:

```bash
claude mcp get weather-api
```

`add-json` accepts `--scope` just like `add`, so `--scope user` puts it in your user config.

### Running a Containerized Server

Docker publishes a large catalog of prepackaged MCP servers under the [`mcp` namespace on Docker Hub](https://hub.docker.com/u/mcp) — 200+ images at the time of writing. There's no special Claude Code integration for these: a container is just a stdio server whose `command` happens to be `docker`.

```json
{
  "mcpServers": {
    "some-server": {
      "type": "stdio",
      "command": "docker",
      "args": ["run", "-i", "--rm", "-e", "SOME_TOKEN", "mcp/some-server"]
    }
  }
}
```

The `-i` flag is required — the container must keep stdin open, because that's the transport. `--rm` cleans up the container when the session ends.

> ⚠️ **Consult the image's own documentation for its exact `docker run` arguments and required environment variables.** They vary per server, and Docker's [MCP Catalog and Toolkit docs](https://docs.docker.com/ai/mcp-catalog-and-toolkit/) describe Docker's own tooling for managing them.

### Importing from Claude Desktop

If you already configured servers in the Claude Desktop chat app:

```bash
claude mcp add-from-claude-desktop
```

An interactive dialog lets you pick which to import. This works on **macOS and WSL only**. Server names added through `claude mcp` may contain only letters, numbers, hyphens, and underscores — a Desktop server whose name has a space is reported and skipped while the rest import. Add `--scope user` to import into your user configuration.

---

## Authentication & Security

### Choosing an Auth Method

```mermaid
graph TB
    A["Server needs credentials?"] --> B{"What kind?"}
    B -->|"Hosted, OAuth"| C["Add the URL with no credential,<br/>then /mcp or claude mcp login"]
    B -->|"Hosted, static token"| D["--header 'Authorization: Bearer ...'"]
    B -->|"Local process"| E["--env KEY=value"]
    B -->|"SSO / short-lived"| F["headersHelper in JSON config"]

    style C fill:#d4f4dd
    style D fill:#e1f5ff
    style E fill:#fff9e6
    style F fill:#f0f0f0
```

### Dynamic Headers for Custom Auth

For Kerberos, short-lived tokens, or internal SSO, `headersHelper` runs a command at connection time and merges its stdout into the connection headers:

```json
{
  "mcpServers": {
    "internal-api": {
      "type": "http",
      "url": "https://mcp.internal.example.com",
      "headersHelper": "/opt/bin/get-mcp-auth-headers.sh"
    }
  }
}
```

Requirements:
- The command must write a JSON object of string key-value pairs to stdout
- It runs in a shell with a 10-second timeout
- Dynamic headers override static `headers` of the same name
- It runs fresh on each connection, with no caching

Claude Code sets `CLAUDE_CODE_MCP_SERVER_NAME` and `CLAUDE_CODE_MCP_SERVER_URL` in the helper's environment, so one script can serve several servers.

> ⚠️ `headersHelper` executes arbitrary shell commands. At project or local scope it only runs after you accept the workspace trust dialog.

### Security Checklist

**Before installing any MCP server:**

1. **Decide whether you trust it.** Anthropic reviews connectors listed in the [Anthropic Directory](https://claude.ai/directory) against its listing criteria, but **does not security-audit or manage arbitrary MCP servers**. A server that fetches external content — issues, web pages, tickets — can carry [prompt injection](https://code.claude.com/docs/en/security#protect-against-prompt-injection) into your session.

2. **Scope the credential, not the server.** MCP has no per-server permission scoping of its own; the limit is whatever the token allows.
   ```bash
   # ✅ Good: a fine-grained GitHub PAT limited to two repos
   # ✅ Good: a read-only database user in the connection string
   claude mcp add --transport stdio db -- npx -y @bytebase/dbhub \
     --dsn "postgresql://readonly:pass@db.example.com:5432/analytics"

   # ❌ Avoid: a classic token with org-wide `repo` scope
   ```
   There is no `--scope repo:owner/name` or `--scope org`. The `--scope` flag takes exactly `local`, `project`, or `user` and controls **where the config is stored**, nothing else.

3. **Keep secrets out of committed files.** Use `${VAR}` expansion in `.mcp.json`, or keep credential-bearing servers at local or user scope where they live in `~/.claude.json`.

4. **Restrict at the tool level if needed.** MCP tools are named `mcp__<server>__<tool>`, and permission rules accept that form:
   ```json
   {
     "permissions": {
       "deny": ["mcp__github__delete_repository"],
       "allow": ["mcp__github__get_*"]
     }
   }
   ```
   Allow rules accept a glob only *after* a literal `mcp__<server>__` prefix — `mcp__github__get_*` works, a bare `mcp__*` in the allow list is skipped with a warning. In a deny rule, `mcp__*` blocks every MCP tool.

5. **Rotate credentials regularly** and check the provider's dashboard for token usage.

### Organization-Level Controls

If you're an administrator restricting what your users can connect to, that's a separate mechanism with its own settings keys — `allowedMcpServers`, `deniedMcpServers`, `allowManagedMcpServersOnly`, and a `managed-mcp.json` file deployed to a system path. These are **managed settings only**; setting them in your own project settings does not enforce anything. See [Managed MCP configuration](https://code.claude.com/docs/en/managed-mcp).

---

## Testing Your Installation

### Test 1: Server List

```bash
claude mcp list
```

Every server appears with a health status. A `✘` next to one server means *that server* failed, not that the list command failed.

### Test 2: Server Detail

```bash
claude mcp get github
```

This shows the server's transport, its command or URL, which **scope** its definition came from, and whether OAuth credentials are configured. Use it when `list` shows a failure and you need the underlying error.

> 🚨 There is no `claude mcp status`, `claude mcp restart`, `claude mcp logs`, or `claude mcp test`. The complete set of subcommands is `add`, `add-from-claude-desktop`, `add-json`, `get`, `list`, `login`, `logout`, `remove`, `reset-project-choices`, and `serve`.

### Test 3: In-Session Panel

```text
/mcp
```

The panel shows each connected server, its tool count, and per-server actions: authenticate, re-authenticate, reconnect, and a toggle to disable a server without deleting its config. You can also drive it directly:

```text
/mcp reconnect github
/mcp disable playwright
/mcp enable all
```

### Test 4: Functional Test

```bash
claude

> "Use the github server to show me my open pull requests"
```

Naming the server in the prompt isn't normally necessary — Claude picks tools on its own — but it guarantees the test goes through the server you just added rather than some other tool that could answer the same question.

### Test 5: Error Handling

Break the credential on purpose and confirm the failure is legible:

```bash
claude mcp remove github
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer not-a-real-token"
claude mcp list
# Expect a failure status; claude mcp get github for the detail
```

---

## Troubleshooting

### Issue 1: `/mcp` shows "No MCP servers configured"

**Causes & Fixes:**

1. **You added the server from a different project.** Local scope is the default and ties a server to the directory you added it from. Re-add it from this project, or use `--scope user`.

2. **You edited a file Claude Code doesn't read.** The only two are `.mcp.json` at the project root and `~/.claude.json`. Paths like `~/.claude/mcp.json`, `.claude/mcp.json`, or `.claude/config.json` are not read — see [Where the file goes](#where-the-file-goes).

3. **You edited `.mcp.json` mid-session.** It's read at session start. Restart.

---

### Issue 2: `✘ Failed to connect` or `✘ Connection error`

**For HTTP servers**, confirm the URL is reachable:

```bash
curl -I https://mcp.sentry.dev/mcp
```

(In PowerShell use `curl.exe`, so the request goes to real curl rather than the `Invoke-WebRequest` alias.)

| Response | Meaning |
|----------|---------|
| `404` or `405` | The server is up. Many MCP endpoints answer POST only, so this still confirms reachability |
| `401` or `403` | The server is up and you need to authenticate. Use `/mcp`, or pass `--header` for token-based servers |
| No response | Check the URL and your network |

If the endpoint path itself is wrong, selecting the server in `/mcp` reports `MCP endpoint not found at <url>. Check the URL in your MCP config.` Remove and re-add with the corrected URL.

**For stdio servers**, run the configured command directly:

```bash
npx -y @playwright/mcp@latest
```

| What happens | What it means |
|--------------|---------------|
| It starts and waits for input | The server works. Run `claude mcp get <name>` and compare the recorded command to what you just ran — if they differ, you probably omitted the `--` separator. Remove and re-add |
| It errors | The message names what's missing, such as Node.js or a browser |

---

### Issue 3: Authentication Failed

**For OAuth servers:** run `/mcp`, select the server, choose **Authenticate** again. If the browser doesn't open, copy the URL from the terminal and open it manually. If the redirect fails after you've signed in, paste the full callback URL from your browser's address bar into the prompt Claude Code shows.

**For token-header servers:** the token may be expired, or scoped too narrowly. Note that if you configured `headers.Authorization` and the server rejects it, Claude Code reports the connection as **failed rather than falling back to OAuth**. Remove the header if you meant to use the OAuth flow.

**For pre-registered OAuth apps:** some servers reject Dynamic Client Registration with `Incompatible auth server: does not support dynamic client registration`. Register an app in the server's developer portal, then:

```bash
claude mcp add --transport http \
  --client-id your-client-id --client-secret --callback-port 8080 \
  my-server https://mcp.example.com/mcp
```

`--client-secret` prompts with masked input (or reads `MCP_CLIENT_SECRET`). `--callback-port` fixes the OAuth callback port so it matches a redirect URI of the form `http://localhost:PORT/callback` that you registered. These flags apply to HTTP and SSE only and have no effect on stdio servers.

---

### Issue 4: Connection Timed Out at Startup

The server exceeded the default 30-second startup timeout. A stdio server's first run is often slow while `npx` downloads the package.

```bash
MCP_TIMEOUT=60000 claude
```

```powershell
# PowerShell
$env:MCP_TIMEOUT = "60000"; claude
```

`MCP_TIMEOUT` is in milliseconds and governs **startup**. A separate `MCP_TOOL_TIMEOUT` governs how long an individual tool call may run, and a per-server `timeout` field in the server's JSON entry overrides it for that server only:

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

---

### Issue 5: Server Connects but No Tools Appear

Run `/mcp` and select the server to see its tool list. An empty list means the server started but registered nothing — usually a missing required environment variable such as an API key. Pass it with `--env KEY=value` on `claude mcp add`, or in the `env` field of the server's entry. The server's own documentation lists what it needs.

---

### Issue 6: "Server already exists"

You've already added a server with that name at the same scope:

```bash
claude mcp remove claude-code-docs
# or pick a different name
```

If the name exists at more than one scope, `remove` reports `exists in multiple scopes`; pass `--scope` to choose which copy to delete.

---

### Issue 7: MCP Output Is Too Large

Claude Code warns when any MCP tool's output exceeds **10,000 tokens** and truncates at **25,000 tokens** by default. Raise the limit with:

```bash
export MAX_MCP_OUTPUT_TOKENS=50000
claude
```

The warning threshold itself is fixed. If you control the server, a better fix is paginating the response.

---

## Verification Checklist

After installation, verify everything works:

### Basic Verification

- [ ] Server appears in `claude mcp list`
- [ ] Status shows `✔ Connected`
- [ ] `claude mcp get <name>` shows the scope and transport you intended
- [ ] For project scope: `.mcp.json` is at the repository root and is valid JSON

### Functional Verification

- [ ] `/mcp` shows a non-zero tool count for the server
- [ ] A prompt naming the server produces a tool call labeled with that server name
- [ ] Results include data that could only have come from the external service

### Security Verification

- [ ] No literal secrets in a committed `.mcp.json` — `${VAR}` expansion or a non-project scope instead
- [ ] Tokens are scoped to the minimum repositories/permissions needed
- [ ] Database connection strings use a read-only user
- [ ] You have actually looked at what the server is, and who publishes it

---

## Next Steps

Great! You've successfully installed MCP servers. You're ready to:

**→ [Explore Popular MCP Servers](3-popular-servers.md)** - Verified servers and their real install commands

**→ [Learn About Agents](../03-agents/1-overview.md)** - Understand how agents use MCP tools

**→ [Create Custom MCP Servers](4-creating-custom-servers.md)** - Build your own (advanced)

---

## Quick Reference

### Every `claude mcp` Subcommand

```bash
claude mcp add <name> <commandOrUrl> [args...]  # Add a server
claude mcp add-json <name> '<json>'             # Add from a JSON string
claude mcp add-from-claude-desktop              # Import (macOS/WSL only)
claude mcp list                                 # List with health status
claude mcp get <name>                           # Detail for one server
claude mcp remove <name>                        # Remove a server
claude mcp login <name>                         # Run OAuth from the shell
claude mcp logout <name>                        # Clear stored credentials
claude mcp reset-project-choices                # Reset .mcp.json approvals
claude mcp serve                                # Run Claude Code as an MCP server
```

### `claude mcp add` Flags

| Flag | Short | Purpose |
|------|-------|---------|
| `--transport <stdio\|sse\|http>` | `-t` | Transport type. Defaults to `stdio` |
| `--scope <local\|project\|user>` | `-s` | Where the config is stored. Defaults to `local` |
| `--env <KEY=value...>` | `-e` | Environment variables for a stdio server |
| `--header <"Name: value"...>` | `-H` | Headers for a remote server |
| `--client-id <id>` | | OAuth client ID for HTTP/SSE servers |
| `--client-secret` | | Prompt for the OAuth client secret |
| `--callback-port <port>` | | Fixed OAuth callback port |

### Configuration File Locations

```bash
# Project scope (commit this)
<project root>/.mcp.json

# Local and user scope
~/.claude.json                      # %USERPROFILE%\.claude.json on Windows

# Approval settings for project servers
<project root>/.claude/settings.json
~/.claude/settings.json
```

### Useful Environment Variables

```bash
MCP_TIMEOUT=10000          # Server startup timeout, ms
MCP_TOOL_TIMEOUT=60000     # Per tool call wall-clock limit, ms
MAX_MCP_OUTPUT_TOKENS=50000 # Raise the 25,000-token output cap
MCP_CLIENT_SECRET=...      # Supply an OAuth client secret non-interactively
```

---

## References & Further Reading

### 📚 Official Documentation

- [Connect Claude Code to tools via MCP](https://code.claude.com/docs/en/mcp) - The full reference: transports, scopes, auth, tool search
- [MCP quickstart](https://code.claude.com/docs/en/mcp-quickstart) - Guided walkthrough with troubleshooting
- [CLI reference](https://code.claude.com/docs/en/cli-reference) - Every command and flag
- [Settings reference](https://code.claude.com/docs/en/settings) - `enabledMcpjsonServers` and friends
- [Managed MCP configuration](https://code.claude.com/docs/en/managed-mcp) - Organization-level allowlists and denylists
- [Permissions](https://code.claude.com/docs/en/permissions) - `mcp__server__tool` rule syntax
- [MCP Specification](https://modelcontextprotocol.io/introduction) - Protocol reference
- [GitHub fine-grained tokens](https://github.com/settings/personal-access-tokens) - Create a scoped PAT

### 🔗 Related Topics

- [MCP Servers Overview](1-overview.md) - Conceptual foundation
- [Popular MCP Servers](3-popular-servers.md) - Discover available servers
- [Creating Custom Servers](4-creating-custom-servers.md) - Build your own

---

**Ready to explore what's available?** Continue to [Popular MCP Servers](3-popular-servers.md).
