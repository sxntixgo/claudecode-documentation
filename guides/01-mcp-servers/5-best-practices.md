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

**Always validate credentials:**

```typescript
import { Server } from '@modelcontextprotocol/sdk/server/index.js';

class SecureMCPServer {
  private validateApiKey(key: string | undefined): boolean {
    if (!key) {
      throw new Error('API key required');
    }

    const validKeys = process.env.VALID_API_KEYS?.split(',') || [];
    return validKeys.includes(key);
  }

  async handleRequest(request: any) {
    // Extract API key from request metadata
    const apiKey = request.params._meta?.apiKey;

    if (!this.validateApiKey(apiKey)) {
      throw new Error('Unauthorized: Invalid API key');
    }

    // Process authenticated request
    return await this.processRequest(request);
  }
}
```

**Use environment variables for secrets:**
```typescript
// ✅ Good
const apiKey = process.env.GITHUB_TOKEN;

// ❌ Bad
const apiKey = 'ghp_hardcoded_token_12345';
```

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

**Protect against abuse:**

```typescript
class RateLimiter {
  private requests = new Map<string, number[]>();

  isAllowed(clientId: string, maxRequests: number, windowMs: number): boolean {
    const now = Date.now();
    const clientRequests = this.requests.get(clientId) || [];

    // Remove old requests outside window
    const recentRequests = clientRequests.filter(
      (timestamp) => now - timestamp < windowMs
    );

    if (recentRequests.length >= maxRequests) {
      return false; // Rate limit exceeded
    }

    // Add current request
    recentRequests.push(now);
    this.requests.set(clientId, recentRequests);

    return true;
  }

  // Cleanup old entries periodically
  cleanup() {
    const now = Date.now();
    for (const [clientId, requests] of this.requests.entries()) {
      const recent = requests.filter((t) => now - t < 60000);
      if (recent.length === 0) {
        this.requests.delete(clientId);
      } else {
        this.requests.set(clientId, recent);
      }
    }
  }
}

const limiter = new RateLimiter();

// Use in handler
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const clientId = request.params._meta?.clientId || 'default';

  if (!limiter.isAllowed(clientId, 100, 60000)) {
    throw new Error('Rate limit exceeded: 100 requests per minute');
  }

  return await processRequest(request);
});

// Cleanup every minute
setInterval(() => limiter.cleanup(), 60000);
```

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

### 9. ✅ Streaming for Large Data

**Stream large responses:**

```typescript
import { Readable } from 'stream';

async function streamLargeFile(filePath: string) {
  const stream = fs.createReadStream(filePath);

  return {
    content: [
      {
        type: 'text',
        text: '', // Start with empty
        stream: true,
      },
    ],
    _meta: {
      stream: true,
    },
  };

  // Send data in chunks
  for await (const chunk of stream) {
    yield {
      content: [{
        type: 'text',
        text: chunk.toString(),
      }],
    };
  }
}
```

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

// Expose health check (if using HTTP transport)
app.get('/health', async (req, res) => {
  const health = await healthCheck.check();
  res.status(health.healthy ? 200 : 503).json(health);
});
```

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

## Quick Reference Checklists

### Security Checklist
- [ ] Authentication implemented
- [ ] Input validation with schemas
- [ ] Rate limiting enabled
- [ ] Secrets in environment variables
- [ ] Least privilege principle followed
- [ ] Safe error messages (no leaks)
- [ ] Dependencies audited (npm audit)

### Performance Checklist
- [ ] Connection pooling for databases
- [ ] Caching for expensive operations
- [ ] Async operations (no blocking)
- [ ] Streaming for large data
- [ ] Timeout protection
- [ ] Resource cleanup

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

### Security
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
