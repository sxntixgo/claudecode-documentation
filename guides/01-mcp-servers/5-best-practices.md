# MCP Server Best Practices

**Reading Time**: 20 minutes
**Skill Level**: Intermediate to Advanced
**Prerequisites**: [MCP Overview](1-overview.md), [Creating Custom MCP Servers](4-creating-custom-servers.md)

---

## Welcome to Production-Ready MCP! 🏆

You've learned how to create MCP servers. Now let's make them **production-ready** with security, performance, and reliability best practices.

By the end of this guide, you'll know:
- Security best practices to protect your MCP server
- Performance optimization strategies
- Error handling and recovery patterns
- Logging and monitoring approaches
- Testing and deployment strategies
- Maintenance and versioning practices

---

## Security Best Practices

### 1. ✅ Authentication and Authorization

**Authenticate at the transport boundary, not per request.**

> 🚨 There is no client-supplied credential inside an MCP request. `request.params._meta` does **not** carry an `apiKey`, and a handler that requires one will reject every call. Where authentication lives depends on how your server is reached:

| Transport | Trust boundary | Where the credential comes from |
|-----------|----------------|--------------------------------|
| **stdio** | The machine. Your process already runs as the user who configured it | Your process environment: the `env` field of the server entry, or `--env` on `claude mcp add` |
| **HTTP / SSE** | The network. Anyone who can reach the URL can try | The `Authorization` header — OAuth 2.0 (Claude Code manages and refreshes the token) or a static bearer token |

**For a stdio server**, validate configuration once, at startup, so a misconfiguration surfaces immediately in `claude mcp list` rather than as a confusing failure on the first tool call:

```typescript
function requireEnv(name: string): string {
  const value = process.env[name];
  if (!value) {
    // Fail loudly at startup, not per call
    throw new Error(`${name} environment variable is required`);
  }
  return value;
}

const octokit = new Octokit({ auth: requireEnv('GITHUB_TOKEN') });
```

**For an HTTP server**, validate the bearer token in your HTTP layer before the request reaches any MCP handler. Implementing standard OAuth 2.0 discovery is worth the effort: Claude Code discovers the authorization server automatically, runs the browser flow from `/mcp`, stores the token securely, and refreshes it — including a transparent retry of the failed call — without your server doing anything special.

**Use environment variables for secrets:**
```typescript
// ✅ Good
const apiKey = process.env.GITHUB_TOKEN;

// ❌ Bad
const apiKey = 'ghp_hardcoded_token_12345';
```

**Need a human in the loop on a specific tool?** That's a separate mechanism from authentication. Mark the tool in its `tools/list` entry:

```json
{
  "name": "grant_access",
  "_meta": { "anthropic/requiresUserInteraction": true }
}
```

Claude Code then prompts on every call to that tool, even in `acceptEdits`, `auto`, and `bypassPermissions` modes, and ignores matching allow rules.

---

### 2. ✅ Input Validation

**Validate all inputs with schema validation:**

```typescript
import { z } from 'zod';

// Define schema
const CreateIssueSchema = z.object({
  owner: z.string().min(1).max(100).regex(/^[a-zA-Z0-9-]+$/),
  repo: z.string().min(1).max(100).regex(/^[a-zA-Z0-9-_]+$/),
  title: z.string().min(1).max(256),
  body: z.string().max(65536).optional(),
  labels: z.array(z.string()).max(10).optional(),
});

// Validate in handler
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === 'create_issue') {
    try {
      // Validate input
      const validated = CreateIssueSchema.parse(request.params.arguments);

      // Use validated data
      return await createIssue(validated);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return {
          content: [{ type: 'text', text: `Validation error: ${error.message}` }],
          isError: true,
        };
      }
      throw error;
    }
  }
});
```

**Prevent injection attacks:**
```typescript
// ✅ Good: Parameterized queries
await pool.query('SELECT * FROM users WHERE id = $1', [userId]);

// ❌ Bad: String concatenation
await pool.query(`SELECT * FROM users WHERE id = '${userId}'`);
```

---

### 3. ✅ Rate Limiting

**What you're actually protecting** is the upstream API's quota. A stdio server has exactly one client — the session that spawned it — and MCP requests carry no client identifier, so per-process limiting is the right shape:

```typescript
class RateLimiter {
  private timestamps: number[] = [];

  isAllowed(maxRequests: number, windowMs: number): boolean {
    const now = Date.now();
    this.timestamps = this.timestamps.filter((t) => now - t < windowMs);

    if (this.timestamps.length >= maxRequests) {
      return false; // Rate limit exceeded
    }

    this.timestamps.push(now);
    return true;
  }
}

const limiter = new RateLimiter();

// Use in handler
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (!limiter.isAllowed(100, 60_000)) {
    return {
      content: [{
        type: 'text',
        text: 'Rate limit reached: 100 calls per minute. Try again in a moment.',
      }],
      isError: true,
    };
  }

  return await processRequest(request);
});
```

> 💡 Return `isError: true` rather than throwing. Claude reads the message, can wait or explain the limit to the user, and doesn't treat the tool as broken.

> 🚨 Don't key a limiter on `request.params._meta?.clientId`. That field isn't populated — every call would collapse into a single `"default"` bucket, which is at best an accident and at worst a limiter you think is per-user but isn't. For a **remote** server serving many users, key on the authenticated identity from the `Authorization` header.

---

### 4. ✅ Least Privilege Principle

**Only request necessary permissions:**

```typescript
// ✅ Good: Read-only GitHub access
const octokit = new Octokit({
  auth: process.env.GITHUB_READ_ONLY_TOKEN,
  // This token only has 'repo:read' scope
});

// ❌ Bad: Full access token
const octokit = new Octokit({
  auth: process.env.GITHUB_ADMIN_TOKEN,
  // Unnecessary admin privileges
});
```

**Validate operations are allowed:**
```typescript
const ALLOWED_OPERATIONS = ['read', 'list', 'search'];

function validateOperation(operation: string) {
  if (!ALLOWED_OPERATIONS.includes(operation)) {
    throw new Error(`Operation '${operation}' not allowed`);
  }
}
```

---

### 5. ✅ Secure Error Messages

**Don't leak sensitive information:**

```typescript
// ✅ Good: Safe error messages
try {
  await apiCall();
} catch (error: any) {
  console.error('Internal error:', error); // Log full error
  return {
    content: [{
      type: 'text',
      text: 'An error occurred while processing your request.',
    }],
    isError: true,
  };
}

// ❌ Bad: Leaking internal details
try {
  await apiCall();
} catch (error: any) {
  return {
    content: [{
      type: 'text',
      text: `Error: ${error.stack}`, // Exposes internal paths!
    }],
    isError: true,
  };
}
```

---

### Security Framework Reference

The MCP security practices above align with industry-standard security frameworks:

| MCP Security Practice | OWASP Top 10 | Priority |
|----------------------|--------------|----------|
| **Authentication & Authorization** (§1) | A01: Broken Access Control | 🔴 Critical |
| **Input Validation** (§2) | A03: Injection | 🔴 Critical |
| **Parameterized Queries** (§2) | A03: Injection | 🔴 Critical |
| **Environment Variables for Secrets** (§1) | A05: Security Misconfiguration | 🟡 High |
| **Safe Error Messages** (§5) | A04: Insecure Design | 🟡 High |
| **Rate Limiting** (§3) | A04: Insecure Design | 🟢 Medium |

**Additional Security Resources**:
- [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Web application security risks
- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/) - API-specific security risks
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework) - Enterprise security standards

> 💡 **MCP-Specific Risk**: Prompt injection via tool parameters. Always validate and sanitize tool inputs, even from trusted sources.

---

## Performance Best Practices

### 6. ✅ Connection Pooling

**Reuse database connections:**

```typescript
import { Pool } from 'pg';

// ✅ Good: Connection pool
const pool = new Pool({
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20, // Maximum connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Reuse pool across requests
async function queryDatabase(sql: string) {
  const client = await pool.connect();
  try {
    return await client.query(sql);
  } finally {
    client.release();
  }
}

// ❌ Bad: New connection each time
async function queryDatabase(sql: string) {
  const client = new Client({ /* config */ });
  await client.connect();
  const result = await client.query(sql);
  await client.end();
  return result;
}
```

---

### 7. ✅ Caching

**Cache expensive operations:**

```typescript
import NodeCache from 'node-cache';

const cache = new NodeCache({
  stdTTL: 300, // 5 minutes default TTL
  checkperiod: 60, // Check for expired keys every 60s
});

async function getRepositoryInfo(owner: string, repo: string) {
  const cacheKey = `repo:${owner}/${repo}`;

  // Check cache first
  const cached = cache.get(cacheKey);
  if (cached) {
    return cached;
  }

  // Fetch from API
  const data = await octokit.repos.get({ owner, repo });

  // Cache result
  cache.set(cacheKey, data.data, 300); // Cache for 5 minutes

  return data.data;
}
```

---

### 8. ✅ Async Operations

**Don't block the event loop:**

```typescript
// ✅ Good: Async I/O
async function processFiles(files: string[]) {
  const results = await Promise.all(
    files.map(async (file) => {
      const content = await fs.promises.readFile(file, 'utf-8');
      return analyzeFile(content);
    })
  );
  return results;
}

// ❌ Bad: Synchronous I/O
function processFiles(files: string[]) {
  return files.map((file) => {
    const content = fs.readFileSync(file, 'utf-8'); // Blocks!
    return analyzeFile(content);
  });
}
```

---

### 9. ✅ Handling Large Data

> 🚨 **You cannot stream a tool result.** A `tools/call` returns exactly once. There is no `stream: true` flag on a content block, and a handler that returns and then tries to `yield` more is unreachable code. Design around the single return.

**Three real options, in order of preference:**

**Paginate.** Take a cursor or offset, return one page plus a token for the next. Claude will ask for more if it needs more, and usually it doesn't:

```typescript
{
  name: 'list_records',
  inputSchema: {
    type: 'object',
    properties: {
      limit:  { type: 'number', description: 'Max records to return (default 50)' },
      cursor: { type: 'string', description: 'Opaque cursor from a previous call' },
    },
  },
}
```

**Summarize server-side.** A tool that returns 40,000 rows so Claude can count them is doing the wrong work in the wrong place. Return the count.

**Annotate, if the output genuinely must be large.** Claude Code warns above 10,000 tokens and truncates at 25,000 by default; results past a size threshold are persisted to disk and replaced with a file reference. For a tool whose whole purpose is a large payload — a full schema, a complete file tree — raise its own ceiling:

```json
{
  "name": "get_schema",
  "description": "Returns the full database schema",
  "_meta": {
    "anthropic/maxResultSizeChars": 200000
  }
}
```

This applies per tool, up to a hard ceiling of 500,000 characters, and works independently of the user's `MAX_MCP_OUTPUT_TOKENS`. Tools returning image data are still bound by the token limit.

**For long-running operations**, send progress notifications rather than trying to stream results. They keep the call alive against the idle timeout — 5 minutes for remote servers, 30 minutes for stdio — though they do **not** extend the wall-clock limit set by the per-server `timeout` or `MCP_TOOL_TIMEOUT`. See [Progress notifications](4-creating-custom-servers.md#feature-3-progress-notifications-for-long-operations) for the code.

---

## Error Handling Best Practices

### 10. ✅ Graceful Error Handling

**Handle errors at multiple levels:**

```typescript
class MCPServer {
  async handleToolCall(request: any) {
    try {
      // Validate request
      const validated = this.validateRequest(request);

      // Execute tool
      const result = await this.executeTool(validated);

      return { content: [{ type: 'text', text: result }] };
    } catch (error: any) {
      // Log error with context
      console.error('Tool execution error:', {
        tool: request.params.name,
        error: error.message,
        stack: error.stack,
      });

      // Return user-friendly error
      if (error instanceof ValidationError) {
        return {
          content: [{
            type: 'text',
            text: `Invalid input: ${error.message}`,
          }],
          isError: true,
        };
      }

      if (error instanceof RateLimitError) {
        return {
          content: [{
            type: 'text',
            text: 'Rate limit exceeded. Please try again later.',
          }],
          isError: true,
        };
      }

      // Generic error
      return {
        content: [{
          type: 'text',
          text: 'An unexpected error occurred.',
        }],
        isError: true,
      };
    }
  }
}
```

---

### 11. ✅ Retry Logic

**Retry transient failures:**

```typescript
async function retryWithBackoff<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3,
  initialDelay: number = 1000
): Promise<T> {
  let lastError: Error;

  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error: any) {
      lastError = error;

      // Don't retry on client errors (4xx)
      if (error.status >= 400 && error.status < 500) {
        throw error;
      }

      if (attempt < maxRetries - 1) {
        const delay = initialDelay * Math.pow(2, attempt);
        console.warn(`Attempt ${attempt + 1} failed. Retrying in ${delay}ms...`);
        await new Promise((resolve) => setTimeout(resolve, delay));
      }
    }
  }

  throw lastError!;
}

// Usage
const data = await retryWithBackoff(() => fetchFromAPI(), 3, 1000);
```

---

### 12. ✅ Timeout Protection

**Prevent hanging operations:**

```typescript
async function withTimeout<T>(
  promise: Promise<T>,
  timeoutMs: number,
  errorMessage: string = 'Operation timed out'
): Promise<T> {
  let timeoutHandle: NodeJS.Timeout;

  const timeoutPromise = new Promise<never>((_, reject) => {
    timeoutHandle = setTimeout(() => {
      reject(new Error(errorMessage));
    }, timeoutMs);
  });

  try {
    return await Promise.race([promise, timeoutPromise]);
  } finally {
    clearTimeout(timeoutHandle!);
  }
}

// Usage
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  try {
    const result = await withTimeout(
      processRequest(request),
      30000, // 30 second timeout
      'Request took too long to process'
    );
    return result;
  } catch (error: any) {
    return {
      content: [{ type: 'text', text: error.message }],
      isError: true,
    };
  }
});
```

**How this interacts with Claude Code's own timeouts.** Claude Code enforces its own limits regardless of what you do in-server, so your timeout should be *tighter* than theirs — you want your legible error message, not a generic abort:

| Limit | What it bounds | Default | Who sets it |
|-------|----------------|---------|-------------|
| `MCP_TIMEOUT` | Server **startup** | 30 seconds | The user, env var |
| `MCP_TOOL_TIMEOUT` | Per tool call, wall clock | Effectively unbounded unless set | The user, env var |
| `"timeout"` field in the server's config entry | Per tool call, this server only. Overrides `MCP_TOOL_TIMEOUT` | Unset | The user, in `.mcp.json` |
| `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT` | Silence — no response *and* no progress notification | 5 min remote, 30 min stdio | The user, env var |

Two consequences worth designing for:

- **Send progress notifications on anything slow.** They reset the idle timeout. They do not extend the wall-clock limit.
- **A call still running after two minutes moves to a background task** rather than blocking the session. Claude keeps working and picks up the result when it lands. This means a genuinely slow tool is tolerable — but only if it eventually returns.

If your server needs more time than the defaults allow, document the `"timeout"` value users should set in their config entry. You can't raise it from inside the server.

---

## Logging and Monitoring Best Practices

### 13. ✅ Structured Logging

**Use structured logs for better analysis:**

```typescript
import pino from 'pino';

const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  transport: {
    target: 'pino-pretty',
    options: { colorize: true },
  },
});

// Log with context
logger.info({
  tool: 'create_issue',
  owner: 'anthropics',
  repo: 'claude-code',
  duration: 123,
}, 'Issue created successfully');

// Log errors
logger.error({
  tool: 'create_issue',
  error: error.message,
  stack: error.stack,
}, 'Failed to create issue');
```

---

### 14. ✅ Metrics Collection

**Track performance metrics:**

```typescript
class Metrics {
  private metrics = new Map<string, number[]>();

  record(metric: string, value: number) {
    const values = this.metrics.get(metric) || [];
    values.push(value);
    this.metrics.set(metric, values);
  }

  getStats(metric: string) {
    const values = this.metrics.get(metric) || [];
    if (values.length === 0) return null;

    const sorted = [...values].sort((a, b) => a - b);
    return {
      count: values.length,
      min: sorted[0],
      max: sorted[sorted.length - 1],
      avg: values.reduce((a, b) => a + b, 0) / values.length,
      p50: sorted[Math.floor(sorted.length * 0.5)],
      p95: sorted[Math.floor(sorted.length * 0.95)],
      p99: sorted[Math.floor(sorted.length * 0.99)],
    };
  }
}

const metrics = new Metrics();

// Record metrics
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const startTime = Date.now();

  try {
    const result = await processRequest(request);

    // Record success
    metrics.record('tool.duration', Date.now() - startTime);
    metrics.record('tool.success', 1);

    return result;
  } catch (error) {
    // Record failure
    metrics.record('tool.duration', Date.now() - startTime);
    metrics.record('tool.error', 1);

    throw error;
  }
});

// Report metrics periodically
setInterval(() => {
  console.log('Metrics:', {
    duration: metrics.getStats('tool.duration'),
    successRate: metrics.getStats('tool.success'),
  });
}, 60000);
```

---

### 15. ✅ Health Checks

**Implement health check endpoints:**

```typescript
class HealthCheck {
  async check(): Promise<HealthStatus> {
    const checks = await Promise.all([
      this.checkDatabase(),
      this.checkExternalAPI(),
      this.checkDiskSpace(),
    ]);

    const healthy = checks.every((c) => c.healthy);

    return {
      healthy,
      timestamp: new Date().toISOString(),
      checks,
    };
  }

  private async checkDatabase(): Promise<Check> {
    try {
      await pool.query('SELECT 1');
      return { name: 'database', healthy: true };
    } catch (error) {
      return {
        name: 'database',
        healthy: false,
        error: error.message,
      };
    }
  }

  private async checkExternalAPI(): Promise<Check> {
    try {
      const response = await fetch('https://api.github.com');
      return {
        name: 'github_api',
        healthy: response.ok,
      };
    } catch (error) {
      return {
        name: 'github_api',
        healthy: false,
        error: error.message,
      };
    }
  }

  private async checkDiskSpace(): Promise<Check> {
    // Implementation depends on OS
    return { name: 'disk_space', healthy: true };
  }
}

// Expose health check — HTTP transport only, on your own Express/Fastify app
app.get('/health', async (req, res) => {
  const health = await healthCheck.check();
  res.status(health.healthy ? 200 : 503).json(health);
});
```

> ⚠️ **A stdio server has no HTTP surface to hang this on.** For stdio, health is expressed through the protocol instead: fail fast at startup so the process exits with a legible error (which the user sees via `claude mcp get`), and return `isError: true` with a specific message when a dependency is down mid-session. A `check_health` *tool* is also a reasonable pattern, since Claude can call it when something looks wrong.

> 💡 Claude Code reconnects HTTP and SSE servers automatically when they drop mid-session — five attempts, exponential backoff from one second. **Stdio servers are not reconnected automatically**, so for a local server, crashing is a much more expensive failure mode than degrading. Prefer returning an error result over letting the process die.

---

## Testing Best Practices

### 16. ✅ Unit Testing

**Test tools in isolation:**

```typescript
import { describe, it, expect, beforeEach } from '@jest/globals';
import { MCPServer } from '../src/server';

describe('GitHub MCP Server', () => {
  let server: MCPServer;

  beforeEach(() => {
    server = new MCPServer();
  });

  describe('create_issue tool', () => {
    it('should create issue with valid input', async () => {
      const request = {
        params: {
          name: 'create_issue',
          arguments: {
            owner: 'test-owner',
            repo: 'test-repo',
            title: 'Test issue',
          },
        },
      };

      const result = await server.handleToolCall(request);

      expect(result.content[0].text).toContain('Created issue');
    });

    it('should reject invalid owner name', async () => {
      const request = {
        params: {
          name: 'create_issue',
          arguments: {
            owner: 'invalid@owner',
            repo: 'test-repo',
            title: 'Test',
          },
        },
      };

      await expect(server.handleToolCall(request)).rejects.toThrow(
        'Invalid owner name'
      );
    });
  });
});
```

---

### 17. ✅ Integration Testing

**Test with real MCP protocol:**

```typescript
import { spawn } from 'child_process';

describe('MCP Protocol Integration', () => {
  it('should handle tools/list request', async () => {
    const server = spawn('node', ['dist/index.js']);

    const request = {
      jsonrpc: '2.0',
      id: 1,
      method: 'tools/list',
    };

    server.stdin.write(JSON.stringify(request) + '\n');

    const response = await new Promise((resolve) => {
      server.stdout.once('data', (data) => {
        resolve(JSON.parse(data.toString()));
      });
    });

    expect(response).toMatchObject({
      jsonrpc: '2.0',
      id: 1,
      result: {
        tools: expect.arrayContaining([
          expect.objectContaining({
            name: expect.any(String),
            description: expect.any(String),
          }),
        ]),
      },
    });

    server.kill();
  });
});
```

---

## Deployment Best Practices

### 18. ✅ Environment Configuration

**Use environment variables:**

```bash
# .env.example (commit to repo)
GITHUB_TOKEN=your_token_here
DATABASE_URL=postgresql://localhost/mydb
LOG_LEVEL=info
PORT=3000

# .env (never commit!)
GITHUB_TOKEN=ghp_actual_secret_token
DATABASE_URL=postgresql://user:pass@prod-db/mydb
LOG_LEVEL=warn
PORT=8080
```

```typescript
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Validate required variables
const requiredEnvVars = ['GITHUB_TOKEN', 'DATABASE_URL'];
for (const varName of requiredEnvVars) {
  if (!process.env[varName]) {
    throw new Error(`Missing required environment variable: ${varName}`);
  }
}
```

---

### 19. ✅ Docker Deployment

**Create optimized Docker image:**

```dockerfile
# Dockerfile
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Build TypeScript
COPY tsconfig.json ./
COPY src ./src
RUN npm run build

# Production image
FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Copy built code
COPY --from=builder /app/dist ./dist

# Run as non-root user
USER node

CMD ["node", "dist/index.js"]
```

**Docker Compose for development:**

```yaml
# docker-compose.yml
version: '3.8'

services:
  mcp-server:
    build: .
    ports:
      - "3000:3000"
    environment:
      - GITHUB_TOKEN=${GITHUB_TOKEN}
      - DATABASE_URL=postgresql://postgres:password@db:5432/mydb
      - LOG_LEVEL=debug
    depends_on:
      - db

  db:
    image: postgres:16-alpine
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb
    volumes:
      - postgres-data:/var/lib/postgresql/data

volumes:
  postgres-data:
```

---

### 20. ✅ Versioning

**Follow semantic versioning:**

```json
// package.json
{
  "name": "@yourname/mcp-server",
  "version": "1.2.3",
  "engines": {
    "node": ">=18.0.0"
  }
}
```

**Document breaking changes:**

```markdown
# CHANGELOG.md

## v2.0.0 (2024-12-20) - BREAKING CHANGES

### Breaking Changes
- Removed `list_all_issues` tool (use `list_issues` with `state=all`)
- Changed authentication from basic auth to API tokens

### Migration Guide
...

## v1.2.0 (2024-12-01)

### Added
- New `add_comment` tool

### Fixed
- Issue pagination now works correctly
```

---

## Designing for Claude Code's Context Model

### 21. ✅ Write Server Instructions Like a Skill Description

This is the highest-leverage thing you can do, and it's easy to miss.

Claude Code **defers MCP tool definitions by default**. At session start, only tool names and your server's `instructions` field load into context; Claude searches for and pulls in a definition when a task needs it. That means your server instructions are frequently the *only* thing Claude sees about your server when deciding whether to look at it at all.

```typescript
const server = new Server(
  { name: 'inventory-server', version: '1.0.0' },
  {
    capabilities: { tools: {} },
    instructions:
      'Tools for querying and updating warehouse inventory. Use these when the ' +
      'user asks about stock levels, SKUs, suppliers, or reorder thresholds. ' +
      'Queries are read-only; stock adjustments write to production.',
  }
);
```

Cover three things: **what category of tasks** your tools handle, **when Claude should search for them**, and **what your server can do**.

> ⚠️ Claude Code truncates tool descriptions and server instructions at **2KB each**. Put the critical details first.

### 22. ✅ Don't Optimize for a Context Cost That No Longer Applies

Advice written before tool search told server authors to minimize tool *count*, because every schema was loaded upfront on every request. With deferral on by default, that pressure is mostly gone: Claude Code imposes no per-server tool cap, and the practical limit is the user's context budget.

What actually costs context now, in order:

| Cost | Mitigation |
|------|------------|
| **Tool output size** | Paginate. This dominates everything else |
| **Tools marked `alwaysLoad`** | Reserve for tools needed on essentially every turn |
| **Overlong descriptions** | Concise, front-loaded, under 2KB |
| **Tool count** | Barely matters when deferred. Design for clarity instead |

**When deferral does not apply** — and your upfront cost is back — is worth knowing so you don't assume it away: `ENABLE_TOOL_SEARCH=false`, a non-first-party `ANTHROPIC_BASE_URL`, Google Cloud's Agent Platform, Microsoft Foundry on Azure, models without tool-reference support, and any server configured `"alwaysLoad": true`.

So: design tools for a **searchable, self-describing** catalog, not a minimal one. A tool whose name and description clearly state what it does gets found; a clever abstraction that packs six operations behind a `mode` parameter does not.

### 23. ✅ Keep Tool Schemas API-Compatible

The Claude API does not accept `anyOf`, `oneOf`, or `allOf` at the **top level** of a tool's `inputSchema`. Combinators nested inside `properties` are fine.

Recent Claude Code versions flatten a root-level combinator and describe the groupings in the tool description, but older versions and some deployments skip the tool entirely — silently, from the user's perspective. Write the flat form and validate the combination server-side.

### 24. ✅ Never Write to stdout on a stdio Server

stdout **is** the transport. A stray `console.log`, a dependency's banner, or a progress bar corrupts the JSON-RPC stream and the connection dies in a way that's genuinely hard to diagnose.

```typescript
// ✅ Good
console.error('Server starting...');

// ❌ Fatal
console.log('Server starting...');
```

Audit your dependencies for this too — it's a common source of "works standalone, fails under Claude Code".

---

## Quick Reference Checklists

### Security Checklist
- [ ] Authentication at the transport boundary — env for stdio, `Authorization` header for HTTP
- [ ] No handler reads a credential from `request.params._meta`
- [ ] Required configuration validated at startup, so failures show in `claude mcp get`
- [ ] Input validation with schemas
- [ ] Rate limiting enabled (per process for stdio, per identity for HTTP)
- [ ] Secrets in environment variables, never in a committed `.mcp.json`
- [ ] Least privilege principle followed (read-only DB user, fine-grained token)
- [ ] Safe error messages (no leaks)
- [ ] Dependencies audited (npm audit)

### Performance Checklist
- [ ] Connection pooling for databases
- [ ] Caching for expensive operations
- [ ] Async operations (no blocking)
- [ ] Large results paginated, not streamed — `tools/call` returns once
- [ ] Progress notifications on anything slow, to hold off the idle timeout
- [ ] In-server timeout tighter than Claude Code's, so your error message wins
- [ ] Resource cleanup

### Claude Code Integration Checklist
- [ ] Server `instructions` written — this is what Claude sees before it searches for your tools
- [ ] Descriptions and instructions under 2KB, critical details first
- [ ] No root-level `anyOf` / `oneOf` / `allOf` in any tool's `inputSchema`
- [ ] Nothing but JSON-RPC on stdout (`console.error` for all logging)
- [ ] `anthropic/maxResultSizeChars` set on any tool that must return a large payload
- [ ] `anthropic/requiresUserInteraction` set on any consent or access-grant tool
- [ ] `alwaysLoad` used only where genuinely justified
- [ ] `CLAUDE_PROJECT_DIR` used for project-relative paths, or `roots/list` implemented
- [ ] `list_changed` notifications sent if the tool set changes at runtime

### Error Handling Checklist
- [ ] Try-catch at multiple levels
- [ ] Retry logic for transient errors
- [ ] User-friendly error messages
- [ ] Detailed logging for debugging
- [ ] Graceful degradation

### Monitoring Checklist
- [ ] Structured logging
- [ ] Metrics collection
- [ ] Health check endpoint
- [ ] Performance tracking
- [ ] Error rate monitoring

### Testing Checklist
- [ ] Unit tests (>80% coverage)
- [ ] Integration tests
- [ ] Error case testing
- [ ] Load testing
- [ ] Security testing

### Deployment Checklist
- [ ] Environment variables documented
- [ ] Docker image optimized
- [ ] Semantic versioning
- [ ] Changelog maintained
- [ ] Rollback plan ready

---

## Next Steps

**You've completed Phase 1 - Foundation Documentation! 🎉**

**Continue to Phase 2:**
- [Model Selection](../06-models/1-overview.md) - Deep dive into Haiku, Sonnet, and Opus
- [Thinking Modes](../08-thinking/1-overview.md) - Control reasoning depth and quality
- [Context Management](../09-context/1-overview.md) - Advanced context control strategies

**Explore Advanced Topics:**
- [Token Optimization](../12-optimization/1-cost-optimization.md) - Achieve 70%+ cost savings
- [Keywords & Triggers](../10-keywords/) - Power user features and automation

---

## References and Further Reading

### Claude Code MCP Reference
- [Connect Claude Code to tools via MCP](https://code.claude.com/docs/en/mcp) - Transports, scopes, auth, output limits, tool search, `_meta` annotations
- [Scale with MCP tool search](https://code.claude.com/docs/en/mcp#scale-with-mcp-tool-search) - Deferral behavior and `ENABLE_TOOL_SEARCH`
- [Environment variables](https://code.claude.com/docs/en/env-vars) - `MCP_TIMEOUT`, `MCP_TOOL_TIMEOUT`, `MAX_MCP_OUTPUT_TOKENS`
- [Permissions](https://code.claude.com/docs/en/permissions) - How users restrict `mcp__server__tool`
- [Managed MCP configuration](https://code.claude.com/docs/en/managed-mcp) - What administrators can block

### Security
- [Claude Code security](https://code.claude.com/docs/en/security) - MCP threat model and prompt injection
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Node.js Security Best Practices](https://nodejs.org/en/docs/guides/security/)
- [API Security Checklist](https://github.com/shieldfy/API-Security-Checklist)

### Performance
- [Node.js Performance Best Practices](https://nodejs.org/en/docs/guides/simple-profiling/)
- [Database Connection Pooling](https://node-postgres.com/features/pooling)

### Monitoring
- [Pino Logger](https://github.com/pinojs/pino)
- [Prometheus Metrics](https://prometheus.io/)

### Testing
- [Jest Testing Framework](https://jestjs.io/)
- [Supertest (API Testing)](https://github.com/visionmedia/supertest)

---

**Questions or Feedback?**
Found a mistake? Have a suggestion? [Open an issue](https://github.com/anthropics/claude-code/issues) or contribute to this documentation!
