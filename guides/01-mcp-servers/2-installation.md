# Installing MCP Servers: Your Step-by-Step Guide

⏱️ **Time**: 30 minutes (hands-on)
📊 **Level**: Beginner
🎯 **You'll Learn**: Three installation methods, authentication setup, testing, and troubleshooting

---

## What You'll Need

Before we begin, make sure you have:

**Required:**
- ✅ Claude Code installed ([installation guide](https://code.claude.com/docs/en/get-started))
- ✅ Command-line access (Terminal on macOS/Linux, PowerShell/WST on Windows)
- ✅ 15-30 minutes of focused time

**For Specific Servers:**
- 🔑 GitHub Personal Access Token (for GitHub MCP server)
- 🔑 Perplexity API Key (for Perplexity MCP server)
- 🔑 Context7 API Key (for Context7 MCP server)

**Not sure if Claude Code is ready?** Run this quick check:

```bash
# Verify Claude Code is installed
claude --version

# Should output something like: Claude Code v1.x.x
```

---

## Three Ways to Install MCP Servers

There are three installation methods, each with different trade-offs:

| Method | Difficulty | Best For | Pros | Cons |
|--------|-----------|----------|------|------|
| **CLI** | ⭐ Easy | Quick setup, official servers | Fast, automated | Limited to official servers |
| **Manual** | ⭐⭐ Medium | Custom configs, advanced setups | Full control, any server | Requires JSON editing |
| **Docker** | ⭐⭐⭐ Advanced | Exploring many servers | 200+ pre-built servers | Requires Docker knowledge |

**Recommendation for beginners**: Start with CLI method for your first server.

Let's explore each method with hands-on examples!

---

## Method 1: CLI Installation (Fastest)

The CLI method is the quickest way to get started with official MCP servers.

### How It Works

```
You run → claude mcp add <server> → Claude Code configures everything → Server ready!
```

No configuration files, no JSON editing—just one command.

### Example 1: Installing GitHub MCP Server

Let's install the GitHub MCP server step by step.

#### Step 1: Get Your GitHub Token

You need a Personal Access Token (PAT) for authentication.

**Creating your token:**

1. Visit [GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)](https://github.com/settings/tokens)
2. Click **"Generate new token (classic)"**
3. Give it a descriptive name: `claude-code-mcp`
4. Select scopes:
   - ✅ `repo` (full repository access)
   - ✅ `workflow` (update GitHub Actions workflows)
   - ✅ `read:org` (read organization data)
5. Click **"Generate token"**
6. **IMPORTANT**: Copy the token immediately (you won't see it again!)

Your token looks like: `ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

#### Step 2: Store Your Token Securely

**Never hardcode tokens in config files!** Use environment variables instead.

**On macOS/Linux:**

```bash
# Add to your shell profile (~/.bashrc, ~/.zshrc, etc.)
export GITHUB_TOKEN="ghp_your_actual_token_here"

# Reload your shell
source ~/.zshrc  # or ~/.bashrc
```

**On Windows (PowerShell):**

```powershell
# Set environment variable
[System.Environment]::SetEnvironmentVariable('GITHUB_TOKEN', 'ghp_your_actual_token_here', 'User')

# Restart your terminal
```

**Verify it's set:**

```bash
echo $GITHUB_TOKEN
# Should display your token
```

#### Step 3: Install the Server

Now the easy part!

```bash
# Install GitHub MCP server
claude mcp add github --scope user

# Output:
# ✅ GitHub MCP server installed successfully
# ✅ Configured to use $GITHUB_TOKEN
# ✅ Ready to use!
```

**What just happened?**
- Claude Code downloaded the GitHub MCP server
- Configured it to use your `GITHUB_TOKEN` environment variable
- Added it to your MCP configuration automatically

#### Step 4: Test It

Let's verify the installation works:

```bash
# Start Claude Code
claude

# Try asking Claude to use GitHub
> "List my GitHub repositories"

# Claude will use the GitHub MCP server to fetch your repos!
```

If you see your repositories, **congratulations!** 🎉 You've successfully installed your first MCP server.

---

### Example 2: Installing Perplexity MCP Server

Perplexity provides real-time web search capabilities. Perfect for getting current information!

#### Step 1: Get Your Perplexity API Key

1. Sign up at [Perplexity API](https://www.perplexity.ai/api)
2. Navigate to your API dashboard
3. Generate a new API key
4. Copy the key (format: `pplx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`)

#### Step 2: Store the API Key

```bash
# Add to your shell profile
export PERPLEXITY_API_KEY="pplx_your_actual_key_here"

# Reload
source ~/.zshrc
```

#### Step 3: Install

```bash
# Install Perplexity MCP server
claude mcp add perplexity

# Output:
# ✅ Perplexity MCP server installed
# ✅ Configured to use $PERPLEXITY_API_KEY
# ✅ Ready for web search!
```

#### Step 4: Test

```bash
claude

> "What are the latest best practices for React Server Components in 2025?"

# Claude will search the web via Perplexity and provide current, sourced answers!
```

---

### CLI Installation Summary

**Pros:**
- ✅ Fastest method (< 5 minutes per server)
- ✅ Automatic configuration
- ✅ No manual file editing
- ✅ Perfect for official servers

**Cons:**
- ❌ Limited to officially supported servers
- ❌ Less customization options
- ❌ Can't install community/custom servers

**When to use:** Your first MCP server, or any time you're installing official servers (GitHub, Perplexity, Context7).

---

## Method 2: Manual Configuration (Full Control)

Manual configuration gives you complete control over MCP server settings. You'll edit the Claude Code configuration file directly.

### Configuration File Location

Claude Code stores MCP configuration at:

**macOS:**
```
~/.config/claude/claude_desktop_config.json
```

**Linux:**
```
~/.config/claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```

### Configuration File Structure

Here's what the configuration file looks like:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "node",
      "args": ["/path/to/server/index.js"],
      "env": {
        "API_KEY": "your-api-key-here"
      }
    }
  }
}
```

**Key parts:**
- `mcpServers`: Top-level object containing all MCP servers
- `server-name`: Unique identifier for the server (you choose this)
- `command`: The executable to run (usually `node`, `python`, or `npx`)
- `args`: Array of arguments passed to the command
- `env`: Environment variables (for API keys, configuration)

### Example 1: Manually Installing GitHub MCP Server

Let's install the GitHub server manually to understand the process.

#### Step 1: Install the Server Package

```bash
# Install GitHub MCP server globally
npm install -g @modelcontextprotocol/server-github
```

#### Step 2: Find Installation Path

```bash
# Find where npm installed it
npm list -g @modelcontextprotocol/server-github

# Output shows path like:
# /usr/local/lib/node_modules/@modelcontextprotocol/server-github
```

#### Step 3: Edit Configuration File

Open the configuration file in your editor:

```bash
# macOS/Linux
nano ~/.config/claude/claude_desktop_config.json

# Windows
notepad %APPDATA%\Claude\claude_desktop_config.json
```

Add this configuration:

```json
{
  "mcpServers": {
    "github": {
      "command": "node",
      "args": [
        "/usr/local/lib/node_modules/@modelcontextprotocol/server-github/dist/index.js"
      ],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Important notes:**
- Replace `/usr/local/lib/node_modules/...` with your actual path from Step 2
- `${GITHUB_TOKEN}` references your environment variable (keep the `${}` syntax!)
- Make sure JSON syntax is valid (commas, quotes, brackets)

#### Step 4: Validate JSON

Before saving, validate your JSON is correct:

```bash
# Use jq to validate (install with: brew install jq or apt install jq)
cat ~/.config/claude/claude_desktop_config.json | jq .

# If valid, you'll see formatted JSON
# If invalid, you'll see an error message
```

#### Step 5: Restart Claude Code

```bash
# Close any running Claude Code instances
# Then start fresh
claude

# Test the server
> "List my GitHub repositories"
```

---

### Example 2: Multiple Servers Configuration

Here's how to configure multiple MCP servers at once:

```json
{
  "mcpServers": {
    "github": {
      "command": "node",
      "args": [
        "/usr/local/lib/node_modules/@modelcontextprotocol/server-github/dist/index.js"
      ],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "perplexity": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-perplexity"
      ],
      "env": {
        "PERPLEXITY_API_KEY": "${PERPLEXITY_API_KEY}"
      }
    },
    "context7": {
      "command": "npx",
      "args": [
        "-y",
        "@context7/mcp-server"
      ],
      "env": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      }
    }
  }
}
```

**What's happening:**
- Three servers configured: GitHub, Perplexity, Context7
- Each has its own command, args, and environment variables
- All three will be available in Claude Code

---

### Manual Configuration Best Practices

**Security:**
```json
// ✅ Good: Use environment variables
"env": {
  "API_KEY": "${MY_API_KEY}"
}

// ❌ Bad: Hardcode secrets
"env": {
  "API_KEY": "sk-actual-key-here"  // Never do this!
}
```

**Path Management:**
```json
// ✅ Good: Use npx for npm packages (no path needed)
"command": "npx",
"args": ["-y", "@modelcontextprotocol/server-github"]

// ⚠️ OK: Absolute path (but less portable)
"command": "node",
"args": ["/usr/local/lib/node_modules/..."]

// ❌ Bad: Relative paths (won't work)
"command": "node",
"args": ["../server/index.js"]
```

**Debugging:**
```json
// Add verbose logging
"env": {
  "DEBUG": "mcp:*",
  "LOG_LEVEL": "debug"
}
```

---

### Manual Configuration Summary

**Pros:**
- ✅ Full control over configuration
- ✅ Works with any MCP server (official or custom)
- ✅ Can customize environment variables, paths, args
- ✅ Can configure multiple servers at once

**Cons:**
- ❌ Requires JSON editing skills
- ❌ Easy to make syntax errors
- ❌ Must manually find installation paths
- ❌ No automatic validation

**When to use:** Installing custom/community servers, advanced configurations, batch setup.

---

## Method 3: Docker MCP Toolkit (200+ Servers)

The Docker MCP Toolkit provides access to over 200 pre-built MCP servers in containers. Perfect for exploring what's available!

### Prerequisites

**Required:**
- ✅ Docker installed ([Get Docker](https://docs.docker.com/get-docker/))
- ✅ Docker running (check with `docker ps`)

### Quick Start with Docker Toolkit

#### Step 1: Install Docker (if needed)

```bash
# macOS (Homebrew)
brew install --cask docker

# Linux (Ubuntu/Debian)
sudo apt update
sudo apt install docker.io

# Start Docker
sudo systemctl start docker

# Verify
docker --version
```

#### Step 2: Pull the MCP Toolkit Image

```bash
# Pull the official toolkit
docker pull anthropic/mcp-toolkit:latest

# Verify it's downloaded
docker images | grep mcp-toolkit
```

#### Step 3: List Available Servers

```bash
# See all 200+ available servers
docker run anthropic/mcp-toolkit list

# Output shows categories:
# - Development (GitHub, GitLab, Bitbucket)
# - Search (Perplexity, Brave, Google)
# - Databases (PostgreSQL, MongoDB, Redis)
# - Cloud (AWS, GCP, Azure)
# - And many more...
```

#### Step 4: Run a Server

```bash
# Example: Run GitHub server
docker run -d \
  --name mcp-github \
  -e GITHUB_TOKEN="${GITHUB_TOKEN}" \
  -p 3000:3000 \
  anthropic/mcp-toolkit:latest github

# -d: Run in background
# --name: Give it a friendly name
# -e: Pass environment variables
# -p: Map port 3000
```

#### Step 5: Configure Claude Code to Use Docker Server

Edit your configuration:

```json
{
  "mcpServers": {
    "github-docker": {
      "command": "docker",
      "args": [
        "exec",
        "-i",
        "mcp-github",
        "mcp-server"
      ]
    }
  }
}
```

#### Step 6: Test

```bash
claude

> "List my GitHub repositories"
# Uses the dockerized GitHub MCP server
```

---

### Docker Toolkit Benefits

**Explore without installing:**
```bash
# Try out servers without npm/pip installations
docker run anthropic/mcp-toolkit:latest perplexity
docker run anthropic/mcp-toolkit:latest context7
docker run anthropic/mcp-toolkit:latest sequential-thinking
```

**Isolated environments:**
- Each server runs in its own container
- No dependency conflicts
- Easy cleanup (just remove containers)

**Version management:**
```bash
# Use specific versions
docker run anthropic/mcp-toolkit:1.2.0 github

# Update to latest
docker pull anthropic/mcp-toolkit:latest
```

---

### Docker Installation Summary

**Pros:**
- ✅ Access to 200+ pre-built servers
- ✅ Isolated environments (no conflicts)
- ✅ Easy to try/remove servers
- ✅ Consistent across platforms

**Cons:**
- ❌ Requires Docker knowledge
- ❌ Higher resource usage (containers)
- ❌ Network configuration can be complex
- ❌ Overkill for simple setups

**When to use:** Exploring many servers, production deployments, complex environments.

---

## Authentication & Security

MCP servers often require authentication to external services. Here's how to handle it securely.

### Environment Variables (Recommended)

**Why environment variables?**
- ✅ Never committed to version control
- ✅ Easy to rotate credentials
- ✅ Same approach across all platforms
- ✅ Can be different per user/environment

**Setting them up:**

```bash
# macOS/Linux: Add to shell profile
echo 'export GITHUB_TOKEN="ghp_..."' >> ~/.zshrc
echo 'export PERPLEXITY_API_KEY="pplx_..."' >> ~/.zshrc
echo 'export CONTEXT7_API_KEY="..."' >> ~/.zshrc

# Reload shell
source ~/.zshrc

# Windows: Use PowerShell
[System.Environment]::SetEnvironmentVariable('GITHUB_TOKEN', 'ghp_...', 'User')
```

### Security Checklist

**Before installing any MCP server:**

1. **Review permissions**
   - What can this server access?
   - Does it need read-only or write access?
   - Can you limit its scope?

2. **Use minimal tokens**
   ```bash
   # ✅ Good: Scope to specific repo
   claude mcp add github --scope repo:my-org/my-repo

   # ⚠️ OK: User-scoped
   claude mcp add github --scope user

   # ❌ Avoid: Organization-wide unless needed
   claude mcp add github --scope org
   ```

3. **Rotate credentials regularly**
   ```bash
   # Every 90 days, generate new tokens
   # Update environment variables
   # Restart Claude Code
   ```

4. **Monitor usage**
   ```bash
   # Check GitHub token usage
   # https://github.com/settings/tokens

   # Check API usage for Perplexity, Context7
   # Review their dashboards
   ```

### Common Authentication Patterns

**OAuth Tokens (GitHub, GitLab):**
```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

**API Keys (Perplexity, Context7):**
```json
{
  "env": {
    "API_KEY": "${SERVICE_API_KEY}"
  }
}
```

**Database Credentials:**
```json
{
  "env": {
    "DB_HOST": "localhost",
    "DB_USER": "${DB_USER}",
    "DB_PASSWORD": "${DB_PASSWORD}",
    "DB_NAME": "myapp"
  }
}
```

**Multiple credentials:**
```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}",
    "GITLAB_TOKEN": "${GITLAB_TOKEN}",
    "AWS_ACCESS_KEY": "${AWS_ACCESS_KEY}",
    "AWS_SECRET_KEY": "${AWS_SECRET_KEY}"
  }
}
```

---

## Testing Your Installation

After installing an MCP server, verify it works properly.

### Test 1: Server List

```bash
# List all configured MCP servers
claude mcp list

# Output should show:
# ✅ github (active)
# ✅ perplexity (active)
# ✅ context7 (active)
```

### Test 2: Server Status

```bash
# Check specific server status
claude mcp status github

# Output:
# Server: github
# Status: ✅ Connected
# Tools: 12 available
# Last used: 5 minutes ago
```

### Test 3: Functional Test

Try using the server with Claude:

**GitHub:**
```bash
claude

> "List my GitHub repositories"
> "Create an issue in my repo: test issue"
> "Show me open pull requests"
```

**Perplexity:**
```bash
> "What are the latest React 19 features?"
> "Search for Next.js 15 server actions best practices"
```

**Context7:**
```bash
> "Show me the documentation for Next.js App Router"
> "Explain React Server Components"
```

### Test 4: Error Handling

Verify errors are clear:

```bash
# Remove token temporarily
unset GITHUB_TOKEN

# Try using GitHub server
> "List my repositories"

# Should see clear error:
# ❌ GitHub MCP server error: GITHUB_TOKEN not set
# 💡 Set your token: export GITHUB_TOKEN="ghp_..."
```

---

## Troubleshooting

### Issue 1: Server Not Found

**Symptom:**
```
❌ Error: MCP server 'github' not found
```

**Causes & Fixes:**

1. **Configuration file not saved**
   ```bash
   # Check config exists
   cat ~/.config/claude/claude_desktop_config.json
   ```

2. **JSON syntax error**
   ```bash
   # Validate JSON
   cat ~/.config/claude/claude_desktop_config.json | jq .
   # Fix any errors shown
   ```

3. **Server name mismatch**
   ```json
   // Config file has:
   "github-server": { ... }

   // But Claude Code looks for:
   "github": { ... }

   // Fix: Use consistent names
   ```

---

### Issue 2: Authentication Failed

**Symptom:**
```
❌ GitHub MCP server error: Authentication failed (401)
```

**Causes & Fixes:**

1. **Token not set**
   ```bash
   # Check if variable exists
   echo $GITHUB_TOKEN

   # If empty, set it:
   export GITHUB_TOKEN="ghp_..."
   ```

2. **Token expired**
   ```bash
   # Generate new token at:
   # https://github.com/settings/tokens

   # Update environment variable
   export GITHUB_TOKEN="ghp_new_token"

   # Restart Claude Code
   ```

3. **Insufficient permissions**
   ```bash
   # Check token scopes on GitHub
   # Regenerate with required scopes:
   # - repo
   # - workflow
   # - read:org
   ```

---

### Issue 3: Server Won't Start

**Symptom:**
```
❌ Failed to start MCP server 'github'
```

**Causes & Fixes:**

1. **Node/Python not installed**
   ```bash
   # Check Node.js
   node --version  # Should be v18+

   # Install if needed:
   # macOS: brew install node
   # Linux: sudo apt install nodejs
   ```

2. **Package not installed**
   ```bash
   # Reinstall the server
   npm install -g @modelcontextprotocol/server-github

   # Or use npx (no install needed)
   # Change config to use npx instead
   ```

3. **Path incorrect**
   ```bash
   # Find actual path
   which node  # /usr/local/bin/node
   npm list -g @modelcontextprotocol/server-github

   # Update config with correct paths
   ```

---

### Issue 4: Slow Performance

**Symptom:**
MCP server responses take 10+ seconds

**Causes & Fixes:**

1. **Network latency**
   ```bash
   # Test API directly
   curl -H "Authorization: token $GITHUB_TOKEN" \
     https://api.github.com/user/repos

   # If slow, issue is with GitHub API, not MCP
   ```

2. **Rate limiting**
   ```bash
   # Check rate limit status
   curl -H "Authorization: token $GITHUB_TOKEN" \
     https://api.github.com/rate_limit

   # If near limit, wait or use different token
   ```

3. **Docker overhead**
   ```bash
   # If using Docker, try native installation
   # Compare performance
   ```

---

### Issue 5: Configuration Changes Not Applied

**Symptom:**
Changed config, but Claude Code still uses old settings

**Fix:**
```bash
# 1. Completely close Claude Code
# 2. Kill any background processes
pkill -f claude

# 3. Clear any cached configs
rm -rf ~/.cache/claude/

# 4. Restart Claude Code
claude

# 5. Verify new config loaded
claude mcp list
```

---

## Verification Checklist

After installation, verify everything works:

### Basic Verification

- [ ] Server appears in `claude mcp list`
- [ ] Server status shows "Connected"
- [ ] Environment variables are set (`echo $TOKEN_NAME`)
- [ ] Configuration JSON is valid (`cat config.json | jq .`)

### Functional Verification

- [ ] Can make a simple request (e.g., "list repos")
- [ ] Claude recognizes the server is available
- [ ] Responses include data from the external service
- [ ] Error messages are clear and helpful

### Security Verification

- [ ] No hardcoded credentials in config files
- [ ] All tokens stored as environment variables
- [ ] Tokens have minimal necessary permissions
- [ ] Configuration file has appropriate permissions (`chmod 600`)

---

## Next Steps

Great! You've successfully installed MCP servers. You're ready to:

**→ [Explore Popular MCP Servers](3-popular-servers.md)** - Discover GitHub, Perplexity, Context7, and 200+ more

**→ [Learn About Agents](../02-agents/1-overview.md)** - Understand how agents use MCP tools

**→ [Create Custom MCP Servers](4-creating-custom-servers.md)** - Build your own (advanced)

---

## Quick Reference

### Installation Commands Summary

```bash
# CLI method (official servers only)
claude mcp add github --scope user
claude mcp add perplexity
claude mcp add context7

# List installed servers
claude mcp list

# Check server status
claude mcp status github

# Remove server
claude mcp remove github
```

### Configuration File Locations

```bash
# macOS/Linux
~/.config/claude/claude_desktop_config.json

# Windows
%APPDATA%\Claude\claude_desktop_config.json
```

### Common Environment Variables

```bash
# GitHub
export GITHUB_TOKEN="ghp_..."

# Perplexity
export PERPLEXITY_API_KEY="pplx_..."

# Context7
export CONTEXT7_API_KEY="..."
```

---

## References & Further Reading

### 📚 Official Documentation

- [MCP Specification](https://modelcontextprotocol.io) - Complete protocol reference
- [Claude Code MCP Guide](https://code.claude.com/docs/en/mcp) - Official installation docs
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers) - Official server list

### 🎥 Video Tutorials

- [Installing Your First MCP Server](https://youtube.com/watch?v=example) (10 min) - Step-by-step CLI installation
- [Manual MCP Configuration Deep Dive](https://youtube.com/watch?v=example) (20 min) - Advanced config patterns
- [Docker MCP Toolkit Tutorial](https://youtube.com/watch?v=example) (15 min) - Container-based setup

### 📝 Articles & Guides

- [MCP Security Best Practices](https://anthropic.com/security/mcp) - Authentication and permissions guide
- [Troubleshooting MCP Servers](https://code.claude.com/docs/en/mcp/troubleshooting) - Common issues and solutions
- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) - Official GitHub guide

### 🔗 Related Topics

- [MCP Servers Overview](1-overview.md) - Conceptual foundation
- [Popular MCP Servers](3-popular-servers.md) - Discover available servers
- [Creating Custom Servers](creating-custom-servers.md) - Build your own

### 💬 Community & Support

- [MCP GitHub Issues](https://github.com/modelcontextprotocol/specification/issues) - Report bugs
- [Claude Code Discord](https://discord.gg/anthropic) - Get community help
- [Stack Overflow: mcp](https://stackoverflow.com/questions/tagged/mcp) - Q&A

---

**Ready to explore what's available?** Continue to [Popular MCP Servers](3-popular-servers.md) to discover GitHub, Perplexity, Context7, and hundreds more!
