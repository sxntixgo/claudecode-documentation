# Popular MCP Servers: Your Complete Catalog

⏱️ **Time**: 25 minutes
📊 **Level**: Beginner to Intermediate
🎯 **You'll Learn**: The most useful MCP servers, their capabilities, when to use each one, and how to get the most value from them

---

## What's in This Guide?

Now that you understand [what MCP servers are](1-overview.md) and [how to install them](2-installation.md), let's explore the most popular and useful servers available. Think of this as your shopping guide—we'll show you what's available, what each server does best, and help you choose the right ones for your workflow.

**By the end of this guide**, you'll know:
- ✅ Where to discover all available MCP servers
- ✅ The top 5 must-have MCP servers and what they do
- ✅ Specialized servers for databases, cloud services, and development tools
- ✅ How to access 200+ pre-built servers via Docker
- ✅ Which servers to install first based on your work

---

## 🔍 Discovering MCP Servers

Before exploring specific servers, know where to find the complete catalog:

### Official Registry

**[Model Context Protocol Servers](https://github.com/modelcontextprotocol/servers)**
- 50+ official pre-built servers
- Community-maintained and tested
- Official Anthropic support
- Regular updates and improvements

### Popular Discovery Methods

**1. Browse the Official Registry**
- Visit [github.com/modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers)
- Explore by category (Development, Cloud, Data, etc.)
- Read detailed READMEs for each server

**2. Search Package Managers**
```bash
# npm (JavaScript/TypeScript servers)
npm search @modelcontextprotocol

# PyPI (Python servers)
pip search mcp-server
```

**3. Community Resources**
- [MCP Documentation](https://modelcontextprotocol.io)
- [GitHub Topics: mcp-server](https://github.com/topics/mcp-server)
- [Anthropic MCP Registry](https://github.com/modelcontextprotocol)

**4. Check Integration Marketplaces**
- Look for "MCP-compatible" tools
- Third-party server collections
- Framework-specific integrations

> 💡 **Tip**: The official registry is updated weekly. Star the repo to get notifications about new servers!

---

## The Essential Five

Let's start with the five MCP servers that provide the most value for developers. If you're just getting started, install these first.

### Quick Comparison

| Server | Best For | Setup Time | Must-Have For |
|--------|----------|-----------|---------------|
| **GitHub** | Code hosting, PRs, issues | 5 min | All developers |
| **Perplexity** | Real-time web search | 3 min | Research-heavy work |
| **Context7** | Framework documentation | 3 min | Web/mobile developers |
| **Sequential Thinking** | Complex problem solving | 2 min | Architecture, planning |
| **Filesystem** | Local file operations | 2 min | File management tasks |

Now let's dive into each one!

---

## 1. GitHub MCP Server

**The #1 most popular MCP server** for developers working with Git repositories.

### What It Does

Connects Claude Code directly to GitHub, enabling:
- ✅ Create, update, and close issues
- ✅ Create and manage pull requests
- ✅ Review code and leave PR comments
- ✅ Check CI/CD status
- ✅ Search repositories
- ✅ Manage branches and commits
- ✅ Read repository metadata

### Real-World Scenarios

#### Scenario 1: End-to-End Feature Development

**Without GitHub MCP:**
```bash
# You: Manual workflow, 15-20 minutes
1. Write code in Claude Code
2. Switch to terminal: git add, git commit, git push
3. Open browser, navigate to GitHub
4. Click "New Pull Request"
5. Fill out PR template
6. Add reviewers manually
7. Copy PR link
8. Back to Claude Code to continue
```

**With GitHub MCP:**
```bash
# In Claude Code: One natural command, 30 seconds
> "Implement user authentication, commit it, and create a PR for review"

Claude:
✅ Implemented authentication (auth.js, routes.js, tests.js)
✅ Created commit: "Add user authentication with JWT"
✅ Pushed to origin/feature/user-auth
✅ Created PR #42: "Add user authentication"
✅ Added reviewers: @teammate1, @teammate2

PR URL: https://github.com/you/repo/pull/42
```

**Time saved**: 15 minutes per feature → 60+ minutes per day

---

#### Scenario 2: Code Review Workflow

**The task**: Review a colleague's PR and provide feedback.

```bash
> "Review PR #42 and check for security issues"

Claude:
📖 Fetching PR #42: "Add payment processing"
🔍 Analyzing changes (4 files, 320 lines)

Security concerns found:
1. ❌ API key hardcoded in payment.js:45
2. ❌ SQL injection vulnerability in database.js:112
3. ⚠️ Missing input validation in checkout.js:67

Performance notes:
- ✅ Good: Implemented caching
- ⚠️ Consider: Database connection pooling

✍️ Adding review comments to PR...
✅ Posted 3 comments with code suggestions
```

**Value**: Automated security scanning + direct PR feedback without leaving Claude Code.

---

#### Scenario 3: Issue Triage

**The task**: Review open issues and prioritize them.

```bash
> "Show me open bugs, prioritize by severity, and add labels"

Claude:
📋 Found 12 open bugs

High Priority (Fix This Week):
1. Issue #156: Login fails on Safari → Added label: "critical", "browser-compat"
2. Issue #142: Data loss in checkout → Added label: "critical", "data-integrity"

Medium Priority:
3. Issue #134: Slow page load → Added label: "performance", "enhancement"
4. Issue #128: UI misalignment → Added label: "ui", "minor"

✅ Updated 12 issues with priority labels
✅ Created milestone: "v2.1.0 Critical Fixes"
✅ Assigned high-priority issues to team leads
```

---

### Installation

```bash
# Quick install via CLI
claude mcp add github --scope user

# Or manual configuration
# See installation guide for details
```

**Authentication**: Requires GitHub Personal Access Token with `repo`, `workflow`, and `read:org` scopes.

### Best Practices

**Scope your tokens appropriately:**
```bash
# ✅ Good: Limit to specific repos
GITHUB_TOKEN with access to specific repositories

# ⚠️ OK: User-level access
GITHUB_TOKEN with user scope

# ❌ Avoid: Org-wide access unless necessary
Only use org scope when managing multiple repos
```

**Use Claude for**:
- Creating issues from error logs
- Batch PR operations (reviewing multiple PRs)
- Automating repetitive git workflows
- Generating PR descriptions from commit history

**Don't use Claude for**:
- Force pushes (too dangerous)
- Deleting branches in production
- Modifying other people's commits without permission

---

## 2. Perplexity MCP Server

**Real-time web search with AI-powered answers** and source citations.

### What It Does

Gives Claude access to current web information:
- ✅ Search the web in real-time
- ✅ Get recent documentation updates
- ✅ Research latest best practices
- ✅ Fact-check with sources
- ✅ Find current package versions
- ✅ Access recent blog posts and articles

### Real-World Scenarios

#### Scenario 1: Staying Current with Framework Updates

**The problem**: You need to use React Server Components but Claude's training data is from early 2024.

```bash
> "What are the latest best practices for React Server Components in 2025?"

Claude (without Perplexity):
"Based on my training data from early 2024, React Server Components are experimental..."
# Potentially outdated information!

Claude (with Perplexity):
[Searches web via Perplexity]

"According to the React documentation updated in December 2024 and recent blog posts:

✅ **Current Best Practices** (as of 2025):
1. Server Components are now stable in React 19
2. Use async/await directly in components
3. New streaming patterns introduced
4. Updated bundler integration required

📚 **Sources**:
- React 19 Official Docs (react.dev)
- Vercel Blog: "React Server Components in Production" (Dec 2024)
- Dan Abramov: "RSC Patterns" (Nov 2024)

Here's how to implement it with the latest patterns..."
```

**Value**: Always current, sourced information instead of potentially outdated training data.

---

#### Scenario 2: Package Selection

**The task**: Choose between multiple libraries for a task.

```bash
> "Should I use Prisma or Drizzle ORM for my Next.js 15 project in 2025?"

Claude (with Perplexity):
[Searches for recent comparisons and benchmarks]

"Based on recent benchmarks and community feedback (December 2024):

**Prisma** (More mature):
✅ Better TypeScript support
✅ Larger ecosystem and community
⚠️ Slower query performance
⚠️ Larger bundle size

**Drizzle** (Rising star):
✅ 2-3x faster queries (recent benchmarks)
✅ Smaller bundle size
✅ Better edge runtime support
⚠️ Smaller community
⚠️ Fewer integrations

**Recommendation for Next.js 15**:
Drizzle ORM - better performance for edge functions, actively developed

📚 **Sources**:
- ORM Benchmark 2024 (github.com/drizzle-team/benchmarks)
- Next.js 15 + Drizzle Guide (vercel.com/guides)
- Reddit r/nextjs discussion (1,200 upvotes, Nov 2024)
```

**Value**: Data-driven decisions with recent benchmarks and community consensus.

---

#### Scenario 3: Debugging with Current Solutions

**The problem**: Error message that might have recent solutions.

```bash
> "I'm getting 'Module not found: Can't resolve 'next/server'' in Next.js 15"

Claude (with Perplexity):
[Searches for this specific error in Next.js 15 context]

"This is a known issue introduced in Next.js 15.0.3 (December 2024):

**Quick Fix**:
```bash
# Update to Next.js 15.0.4 or later
npm install next@latest
```

**Why it happened**:
Breaking change in module resolution for edge runtime

**Alternative workaround** (if can't update):
```javascript
// Use dynamic import instead
const { NextResponse } = await import('next/server')
```

📚 **Sources**:
- Next.js GitHub Issue #58234 (Closed, Fixed in 15.0.4)
- Next.js Docs: Migration Guide 15.0.3 → 15.0.4
```

**Value**: Find solutions to recent issues that weren't in Claude's training data.

---

### Installation

```bash
# Quick install
claude mcp add perplexity

# Requires PERPLEXITY_API_KEY environment variable
export PERPLEXITY_API_KEY="pplx_your_key"
```

**API Access**: Sign up at [Perplexity API](https://www.perplexity.ai/api) for an API key.

### Best Practices

**Use Perplexity when**:
- 🔍 You need current information (last 6-12 months)
- 📚 Researching new frameworks, libraries, or tools
- 🐛 Debugging recent issues or error messages
- 📊 Comparing packages/tools with recent data
- ✅ Fact-checking or verifying information

**Don't use Perplexity for**:
- Basic programming questions (use Claude's built-in knowledge)
- Searching your codebase (use Explore agent)
- Timeless concepts (algorithms, data structures)

**Cost awareness**: Perplexity API calls cost money—use strategically for questions that benefit from recency.

---

## 3. Context7 MCP Server

**AI-powered documentation search** for frameworks and libraries.

### What It Does

Provides instant access to up-to-date documentation:
- ✅ Framework documentation (React, Next.js, Vue, Angular)
- ✅ Library references (TypeScript, Node.js, Python)
- ✅ API documentation with version awareness
- ✅ Code examples from official docs
- ✅ Migration guides and changelogs

### Real-World Scenarios

#### Scenario 1: Learning New Framework Patterns

**The task**: Implement Next.js App Router patterns correctly.

```bash
> "How do I implement route handlers in Next.js 15 App Router?"

Claude (with Context7):
[Queries Context7 for Next.js 15 documentation]

"According to the official Next.js 15 documentation:

**Route Handlers** replace API routes in the App Router:

```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  const users = await db.users.findMany()
  return NextResponse.json({ users })
}

export async function POST(request: NextRequest) {
  const body = await request.json()
  const user = await db.users.create({ data: body })
  return NextResponse.json({ user }, { status: 201 })
}
```

**Key differences from Pages Router**:
- ✅ Use `route.ts` instead of `/pages/api`
- ✅ Export HTTP method functions (GET, POST, etc.)
- ✅ Use `NextRequest`/`NextResponse` (not req/res)
- ✅ Automatically optimized for edge runtime

📚 **Source**: Next.js 15 Official Docs - Route Handlers"
```

**Value**: Accurate, version-specific documentation without manual searching.

---

#### Scenario 2: API Reference Lookup

**The task**: Use a specific TypeScript utility type.

```bash
> "Show me how to use TypeScript's Partial<T> and Required<T> types"

Claude (with Context7):
[Fetches TypeScript documentation]

"From the TypeScript 5.3 documentation:

**Partial<T>**: Makes all properties optional
```typescript
interface User {
  id: string
  name: string
  email: string
}

// All properties optional
type PartialUser = Partial<User>
// Same as: { id?: string, name?: string, email?: string }

// Use case: Updates where only some fields change
function updateUser(id: string, updates: Partial<User>) {
  return db.users.update({ where: { id }, data: updates })
}

updateUser('123', { name: 'New Name' }) // ✅ Valid
```

**Required<T>**: Makes all properties required
```typescript
interface Config {
  host?: string
  port?: number
}

// All properties required
type RequiredConfig = Required<Config>
// Same as: { host: string, port: number }

// Use case: Ensure full configuration
function validateConfig(config: Required<Config>) {
  // TypeScript ensures host and port exist
  console.log(`${config.host}:${config.port}`)
}
```

📚 **Source**: TypeScript Handbook - Utility Types"
```

---

### Installation

```bash
# Quick install
claude mcp add context7

# Requires CONTEXT7_API_KEY
export CONTEXT7_API_KEY="your_key"
```

**API Access**: Sign up at [Context7](https://context7.com) for documentation access.

### Best Practices

**Use Context7 when**:
- 📖 Learning new framework patterns
- 🔍 Looking up API references
- 📚 Finding official code examples
- 🆕 Understanding version-specific changes
- ✅ Verifying syntax and best practices

**Advantages over Perplexity**:
- More accurate for official documentation
- Version-aware (shows docs for specific versions)
- No random blog posts—only authoritative sources
- Better code examples from official docs

---

## 4. Sequential Thinking MCP Server

**Advanced reasoning for complex problems** that require multi-step thinking.

### What It Does

Enables Claude to break down complex tasks systematically:
- ✅ Architectural planning
- ✅ Multi-step problem solving
- ✅ Design decision analysis
- ✅ Trade-off evaluation
- ✅ Edge case identification

### Real-World Scenarios

#### Scenario 1: System Design

**The task**: Design a caching strategy for a high-traffic API.

```bash
> "Design a caching strategy for our API that handles 10k req/s"

Claude (with Sequential Thinking):
[Activates multi-step reasoning]

**Step 1: Analyze Requirements**
- 10k requests/second = 600k req/min
- Need sub-100ms response times
- Mixed read/write traffic
- Cache hit rate target: 80%+

**Step 2: Identify Constraints**
- Database can handle 2k req/s max
- Need 5x reduction via caching
- Cache invalidation complexity
- Distributed cache coordination

**Step 3: Evaluate Options**
1. **In-memory (Redis)**
   ✅ Fastest (sub-1ms)
   ✅ Good for high read traffic
   ❌ Eviction policy complexity
   ❌ Memory limits

2. **CDN Edge Caching**
   ✅ Global distribution
   ✅ Handles static content
   ❌ Less control over invalidation
   ❌ Not suitable for personalized data

3. **Multi-tier Strategy**
   ✅ Best of both approaches
   ✅ L1: In-memory, L2: Redis, L3: DB
   ⚠️ More complex to implement

**Step 4: Recommendation**
Multi-tier caching with:
- L1 Cache: In-process LRU (10ms TTL)
- L2 Cache: Redis (5min TTL)
- L3 Cache: Database with query optimization

**Step 5: Implementation Plan**
[Detailed implementation steps...]

**Step 6: Edge Cases to Handle**
- Cache stampede protection
- Stale-while-revalidate pattern
- Graceful degradation if cache fails
```

**Value**: Systematic analysis with explicit reasoning steps visible to you.

---

#### Scenario 2: Debugging Complex Issues

**The problem**: Intermittent production bug that's hard to reproduce.

```bash
> "Our checkout fails randomly ~2% of the time. Help debug this systematically."

Claude (with Sequential Thinking):
**Step 1: Gather Information**
What do we know?
- Failure rate: 2% (1 in 50 transactions)
- Symptom: Checkout doesn't complete
- No error logs in most cases
- Cannot reproduce locally

**Step 2: Generate Hypotheses**
Possible causes:
1. Race condition in payment processing
2. Network timeout to payment gateway
3. Database connection pool exhaustion
4. Session expiration mid-checkout
5. Browser-specific issue

**Step 3: Prioritize by Likelihood**
High probability:
- Network timeout (2% failure matches typical timeout rate)
- Database connection pool exhaustion (intermittent)

Low probability:
- Session expiration (would affect more users)
- Browser-specific (would show pattern in analytics)

**Step 4: Design Diagnostic Tests**
Test 1: Add detailed logging around payment gateway calls
Test 2: Monitor database connection pool metrics
Test 3: Implement retry logic with exponential backoff
Test 4: Add distributed tracing

**Step 5: Implement Incremental Fixes**
[Step-by-step implementation plan]
```

---

### Installation

```bash
# Quick install
claude mcp add sequential-thinking

# No API key required - local processing
```

### Best Practices

**Use Sequential Thinking when**:
- 🏗️ Designing system architecture
- 🐛 Debugging complex, intermittent issues
- ⚖️ Evaluating multiple approaches
- 📋 Planning multi-step implementations
- 🔍 Analyzing edge cases

**Combine with other servers**:
```bash
# Example: Use with Perplexity for research + reasoning
> "Research current microservices patterns [Perplexity], then design our service architecture [Sequential Thinking]"
```

---

## 5. Filesystem MCP Server

**Local file operations** for advanced file management.

### What It Does

Extends file operations beyond basic read/write:
- ✅ Recursive directory operations
- ✅ File pattern matching (glob)
- ✅ Bulk file operations
- ✅ Permission management
- ✅ File metadata queries
- ✅ Safe file manipulation

### Real-World Scenarios

#### Scenario 1: Codebase Refactoring

**The task**: Rename a component across the entire codebase.

```bash
> "Rename all instances of 'UserCard' to 'ProfileCard' across the codebase"

Claude (with Filesystem):
🔍 Scanning for files containing 'UserCard'...

Found 47 files:
- 23 TypeScript files (.ts, .tsx)
- 12 test files (.test.ts)
- 8 style files (.css)
- 4 documentation files (.md)

✏️ Renaming...
✅ Renamed components/UserCard.tsx → ProfileCard.tsx
✅ Updated 46 import statements
✅ Updated 12 test files
✅ Updated 8 style class references
✅ Updated 4 documentation references

⚠️ Manual review needed:
- UserCard in database schema (migrations/001_users.sql:45)
- UserCard in API response (types/api.ts:23)

Would you like me to update those as well?
```

---

#### Scenario 2: Project Cleanup

**The task**: Remove unused files and dependencies.

```bash
> "Find and remove unused component files"

Claude (with Filesystem):
🔍 Analyzing project structure...

**Unused Components** (no imports found):
1. components/old/LegacyHeader.tsx (last modified: 6 months ago)
2. components/deprecated/OldButton.tsx (last modified: 8 months ago)
3. utils/unused/helper.ts (last modified: 1 year ago)

**Unused Stylesheets**:
1. styles/legacy.css (not imported anywhere)
2. components/Modal/old-modal.css (component deleted)

✅ Moved to archive/unused/:
- 3 component files
- 2 stylesheet files
- Total: 2.3 KB saved

**Recommendation**: Review archive/unused/ before permanent deletion
```

---

### Installation

```bash
# Usually pre-installed with Claude Code
# Or install manually
claude mcp add filesystem
```

### Best Practices

**Use Filesystem for**:
- 🔄 Bulk refactoring operations
- 🧹 Project cleanup
- 📂 Complex file organization
- 🔍 Pattern-based file operations

**Safety features**:
- Creates backups before destructive operations
- Asks for confirmation on bulk deletes
- Preserves file permissions
- Handles symlinks correctly

---

## Database Connectors

MCP servers for direct database access.

### PostgreSQL MCP Server

**Query and manage PostgreSQL databases** directly from Claude.

**What it does**:
- ✅ Execute SQL queries
- ✅ Schema inspection
- ✅ Data migrations
- ✅ Natural language to SQL
- ✅ Query optimization suggestions

**Example usage**:
```bash
> "Show me users who signed up this week"

Claude:
[Generates and executes SQL]

```sql
SELECT id, email, created_at
FROM users
WHERE created_at >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY created_at DESC;
```

Found 47 users:
- Monday: 12 signups
- Tuesday: 8 signups
- Wednesday: 15 signups
...
```

**Installation**:
```bash
npm install -g @modelcontextprotocol/server-postgres
# Configure with database URL
```

---

### MongoDB MCP Server

**Work with MongoDB databases** and document collections.

**What it does**:
- ✅ Query documents with natural language
- ✅ Aggregation pipeline generation
- ✅ Index optimization
- ✅ Schema validation

**Example**:
```bash
> "Find all products with low inventory and email suppliers"

Claude:
[Queries MongoDB]

Found 12 products with inventory < 10:
- Product A (SKU: 12345): 3 units remaining
- Product B (SKU: 67890): 7 units remaining
...

Suppliers to contact:
- Supplier X: 5 products low
- Supplier Y: 7 products low

Draft emails prepared for review.
```

---

## Cloud Service Integrations

### AWS MCP Server

**Manage AWS resources** directly from Claude.

**Capabilities**:
- ✅ EC2 instance management
- ✅ S3 bucket operations
- ✅ Lambda function deployment
- ✅ CloudWatch log analysis
- ✅ Cost optimization recommendations

**Example**:
```bash
> "Show me EC2 instances that have been running for >30 days unused"

Claude:
[Queries AWS API]

Found 3 idle instances (< 5% CPU for 30+ days):

1. i-abc123 (t3.medium)
   - Running: 47 days
   - Cost: $35/month
   - Recommendation: Stop or downsize

2. i-def456 (t3.large)
   - Running: 62 days
   - Cost: $70/month
   - Recommendation: Terminate (no activity)

Total potential savings: $105/month

Would you like me to stop these instances?
```

---

### Google Cloud Platform MCP Server

**Manage GCP resources**.

**Capabilities**:
- ✅ Compute Engine management
- ✅ Cloud Storage operations
- ✅ BigQuery analytics
- ✅ Cloud Functions deployment

---

### Azure MCP Server

**Manage Microsoft Azure resources**.

**Capabilities**:
- ✅ Virtual machine management
- ✅ Blob storage operations
- ✅ Azure Functions deployment
- ✅ Resource cost analysis

---

## Development Tools

### Jira MCP Server

**Project management integration**.

**What it does**:
- ✅ Create and update tickets
- ✅ Sprint planning
- ✅ Status tracking
- ✅ Time logging

**Example**:
```bash
> "Create Jira tickets for all TODO comments in the codebase"

Claude:
[Scans codebase for TODO comments]

Found 23 TODOs:

Created tickets:
- PROJ-401: Refactor authentication logic (src/auth.ts:45)
- PROJ-402: Add error handling (api/users.ts:112)
- PROJ-403: Optimize database query (db/queries.ts:89)
...

✅ Created 23 tickets in "Backlog"
✅ Tagged with "tech-debt"
✅ Assigned to current sprint
```

---

### Slack MCP Server

**Team communication integration**.

**What it does**:
- ✅ Send messages to channels
- ✅ Post code snippets
- ✅ Share deployment status
- ✅ Create threads for discussions

**Example**:
```bash
> "Deploy to staging and notify the team in #deployments"

Claude:
[Deploys application]

✅ Deployed to staging: v2.1.0-rc.1
✅ All tests passed (347/347)
✅ Posted to #deployments:

"🚀 Staging Deployment: v2.1.0-rc.1
- ✅ All tests passed
- ✅ Performance: 15% faster load time
- 📋 Changes: 12 features, 5 bug fixes
- 🔗 Preview: https://staging.example.com
- 👀 Ready for QA testing"
```

---

## Docker MCP Toolkit: 200+ Servers

The **Docker MCP Toolkit** provides access to over 200 pre-built MCP servers in containers.

### Categories Available

**Development Tools** (40+ servers):
- GitHub, GitLab, Bitbucket
- Jira, Linear, Asana
- Slack, Discord, Teams
- Notion, Confluence

**Search & Research** (25+ servers):
- Perplexity, Brave Search, Google Search
- Wikipedia, Archive.org
- Academic databases (arXiv, PubMed)
- News aggregators

**Databases** (30+ servers):
- PostgreSQL, MySQL, MongoDB
- Redis, Elasticsearch
- Neo4j, CouchDB
- ClickHouse, TimescaleDB

**Cloud Platforms** (20+ servers):
- AWS, Google Cloud, Azure
- DigitalOcean, Heroku
- Cloudflare, Vercel

**AI & ML** (15+ servers):
- Hugging Face
- OpenAI API
- Anthropic API
- TensorFlow Serving

**Productivity** (20+ servers):
- Google Workspace
- Microsoft 365
- Trello, Monday.com
- Calendly, Zoom

**And 50+ more** including:
- Payment processors (Stripe, PayPal)
- Analytics (Google Analytics, Mixpanel)
- Monitoring (Datadog, New Relic)
- Email (SendGrid, Mailgun)

### Quick Start with Docker Toolkit

```bash
# Pull the toolkit
docker pull anthropic/mcp-toolkit:latest

# List all available servers
docker run anthropic/mcp-toolkit:latest list

# Run a specific server
docker run -d \
  --name mcp-github \
  -e GITHUB_TOKEN="${GITHUB_TOKEN}" \
  anthropic/mcp-toolkit:latest github

# Try multiple servers
docker run -d --name mcp-perplexity -e PERPLEXITY_API_KEY="${PERPLEXITY_API_KEY}" anthropic/mcp-toolkit:latest perplexity
docker run -d --name mcp-slack -e SLACK_TOKEN="${SLACK_TOKEN}" anthropic/mcp-toolkit:latest slack
```

### Benefits of Docker Toolkit

**Exploration**:
- Try servers without installing dependencies
- Quickly test 5-10 servers to find the right fit
- No cleanup needed—just remove containers

**Consistency**:
- Same server version across team
- Predictable behavior
- Easy updates (`docker pull latest`)

**Isolation**:
- No dependency conflicts
- Separate environment per server
- Easy to debug issues

---

## Choosing the Right Servers

### Decision Matrix

Use this matrix to decide which servers to install:

| Your Work | Must-Have | Nice-to-Have | Optional |
|-----------|-----------|--------------|----------|
| **Web Development** | GitHub, Context7 | Perplexity, Filesystem | Vercel, Cloudflare |
| **Backend/API** | GitHub, PostgreSQL | Perplexity, AWS | Redis, MongoDB |
| **Data Science** | GitHub, Sequential Thinking | Perplexity, Python | Jupyter, TensorFlow |
| **DevOps** | GitHub, AWS/GCP/Azure | Slack, Jira | Datadog, New Relic |
| **Research** | Perplexity, Context7 | Sequential Thinking | arXiv, PubMed |
| **Full-Stack** | GitHub, Perplexity, Context7 | Filesystem, Database | Slack, Jira |

### Starter Packs

**Minimal Setup** (3 servers):
1. GitHub - Code management
2. Perplexity - Research
3. Filesystem - File operations

**Standard Developer** (5 servers):
1. GitHub - Code management
2. Perplexity - Research
3. Context7 - Documentation
4. PostgreSQL/MongoDB - Database
5. Filesystem - File operations

**Power User** (8+ servers):
1. GitHub - Code management
2. Perplexity - Research
3. Context7 - Documentation
4. Sequential Thinking - Complex reasoning
5. PostgreSQL/MongoDB - Database
6. AWS/GCP/Azure - Cloud
7. Slack - Communication
8. Jira - Project management

**Team Lead** (10+ servers):
Add to Power User:
9. Datadog/New Relic - Monitoring
10. Stripe - Payments
11. SendGrid - Email
12. Google Analytics - Analytics

---

## Usage Tips

### Combining Servers

**Example 1: Research → Implement → Deploy**
```bash
# Research best practices (Perplexity)
> "What's the best way to implement rate limiting in Express.js?"

# Implement with framework docs (Context7)
> "Show me Express.js middleware pattern for rate limiting"

# Deploy and monitor (AWS + Slack)
> "Deploy to staging and notify team when ready"
```

**Example 2: Debug → Fix → Track**
```bash
# Find issue (Filesystem + Sequential Thinking)
> "Analyze why our checkout flow is failing"

# Research solution (Perplexity)
> "Latest solutions for race conditions in Node.js"

# Fix and track (GitHub + Jira)
> "Implement fix, create PR, and update Jira ticket"
```

---

### Performance Considerations

**MCP server overhead**:
- Each server adds ~100-200ms latency per request
- Multiple servers in one query: Runs in parallel when possible
- Docker servers: +50-100ms overhead vs. native

**Optimization strategies**:
1. **Use specific servers**: Ask Claude to use a specific server when you know which one
2. **Batch operations**: Combine related requests
3. **Cache results**: For frequently accessed data (docs, APIs)

---

## Quick Reference

### Most Popular Servers

| Server | Command | Key Use Case |
|--------|---------|--------------|
| GitHub | `claude mcp add github` | Code management, PRs |
| Perplexity | `claude mcp add perplexity` | Real-time web search |
| Context7 | `claude mcp add context7` | Framework documentation |
| Sequential Thinking | `claude mcp add sequential-thinking` | Complex reasoning |
| PostgreSQL | `npm install -g @mcp/server-postgres` | Database operations |
| AWS | `claude mcp add aws` | Cloud management |

### By Use Case

**"I need current information"** → Perplexity
**"I need framework docs"** → Context7
**"I need to manage code/PRs"** → GitHub
**"I need to solve complex problems"** → Sequential Thinking
**"I need database access"** → PostgreSQL/MongoDB
**"I need cloud management"** → AWS/GCP/Azure

---

## Troubleshooting Common Issues

### Issue 1: MCP Server Not Connecting

**Symptom**: "Failed to connect to MCP server" or server appears offline

**Common Causes**:
- Server not installed correctly
- Missing API credentials
- Port conflicts
- Server process crashed

**Solutions**:
```bash
# Check if server is installed
claude mcp list

# Restart the server
claude mcp restart <server-name>

# Check server logs
claude mcp logs <server-name>

# Reinstall the server
claude mcp remove <server-name>
claude mcp add <server-name>
```

---

### Issue 2: API Key Errors

**Symptom**: "Invalid API key" or "Unauthorized" errors

**Common Causes**:
- API key not set in environment variables
- Expired or revoked API key
- Wrong environment variable name

**Solutions**:
```bash
# Check if API key is set
echo $GITHUB_TOKEN
echo $PERPLEXITY_API_KEY

# Set the API key (add to ~/.bashrc or ~/.zshrc for persistence)
export GITHUB_TOKEN="your_token_here"

# Verify the server can access the key
claude mcp test <server-name>
```

---

### Issue 3: Server Performance Issues

**Symptom**: Slow responses or timeouts from MCP server

**Common Causes**:
- Network latency
- Rate limiting from external API
- Large data payloads
- Server resource constraints

**Solutions**:
```bash
# Check server resource usage
claude mcp status <server-name>

# Reduce concurrent requests
# Add to .claude/config.json:
{
  "mcp": {
    "servers": {
      "<server-name>": {
        "maxConcurrentRequests": 5,
        "timeout": 30000
      }
    }
  }
}

# Use caching for frequently accessed data
# (configure in server-specific settings)
```

---

### Issue 4: Docker MCP Toolkit Problems

**Symptom**: Docker container won't start or can't access servers

**Common Causes**:
- Docker not running
- Port mapping conflicts
- Volume mount permissions

**Solutions**:
```bash
# Check Docker is running
docker ps

# Pull latest MCP toolkit image
docker pull modelcontextprotocol/mcp-toolkit:latest

# Run with proper port mapping
docker run -p 8080:8080 modelcontextprotocol/mcp-toolkit

# Check container logs
docker logs <container-id>
```

---

### Still Having Issues?

1. **Check the official troubleshooting guide**: See [Troubleshooting MCP Servers](../14-reference/2-troubleshooting.md)
2. **Search existing issues**: Check [GitHub Issues](https://github.com/modelcontextprotocol/specification/issues)
3. **Ask the community**: Join [MCP Discord](https://discord.gg/anthropic) for help
4. **Report bugs**: Open an issue at [MCP GitHub](https://github.com/modelcontextprotocol/specification/issues/new)

---

## Next Steps

Excellent! You now know:
- ✅ The top 5 essential MCP servers
- ✅ Specialized servers for databases, cloud, and tools
- ✅ How to access 200+ servers via Docker
- ✅ Which servers to install based on your work

**Ready to explore further?**

**→ [Create Custom MCP Servers](4-creating-custom-servers.md)** - Build your own for internal tools

**→ [Learn About Agents](../03-agents/1-overview.md)** - Understand how agents use these MCP tools

**→ [MCP Best Practices](5-best-practices.md)** - Security, performance, error handling

---

## References & Further Reading

Want to explore more? Here are excellent resources:

### 📚 Official Documentation

- [MCP Server Registry](https://github.com/modelcontextprotocol/servers) - Complete list of official servers
- [MCP Specification](https://modelcontextprotocol.io) - Protocol documentation
- [Docker MCP Toolkit](https://hub.docker.com/r/anthropic/mcp-toolkit) - Container image and usage
- [Building Efficient MCP Servers](https://vercel.com/blog/building-efficient-mcp-servers) - Performance and optimization guide
- [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) - Efficiency and best practices
- [Introducing Vercel MCP](https://vercel.com/blog/introducing-vercel-mcp-connect-vercel-to-your-ai-tools) - Production integration guide
- [Building the Future of AI Coding with MCP](https://www.anthropic.com/webinars/future-of-ai-coding-mcp-vs-code) - Webinar with live demos

### 🔗 Related Topics

- [MCP Overview](1-overview.md) - Conceptual foundation
- [Installation Guide](2-installation.md) - Setup instructions
- [Agents Overview](../03-agents/1-overview.md) - How agents use MCP servers
- [Creating Custom Servers](4-creating-custom-servers.md) - Build your own

### 💬 Community & Support

- [MCP Community Discord](https://discord.gg/anthropic) - Server recommendations and support
- [GitHub MCP Discussions](https://github.com/modelcontextprotocol/specification/discussions) - Q&A
- [Awesome MCP Servers](https://github.com/awesome-mcp/servers) - Community-curated list

### 📖 Server-Specific Documentation

- [GitHub MCP Server Docs](https://github.com/modelcontextprotocol/servers/tree/main/github) - Complete API reference
- [Perplexity API Docs](https://docs.perplexity.ai) - Search API documentation
- [Context7 Documentation](https://docs.context7.com) - Framework documentation access

---

**Ready to dive into agents?** Continue to [Agents Overview](../03-agents/1-overview.md) to learn how Claude uses these MCP tools effectively!
