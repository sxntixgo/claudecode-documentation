# React + TypeScript Project Template

**Project Type**: Frontend Web Application
**Tech Stack**: React 18, TypeScript, Vite, TailwindCSS
**Team Size**: 1-5 developers

---

## Complete .claude/ Directory Structure

```
.claude/
├── CLAUDE.md                 # Project context
├── config.json              # Agent and skill configuration
├── commands/                # Custom slash commands
│   ├── component.md
│   ├── test.md
│   └── review.md
├── skills/                  # Custom skills
│   └── component-generator/
│       └── SKILL.md
└── workflows/              # Workflow templates
    └── feature.md
```

---

## 1. CLAUDE.md (Project Context)

`.claude/CLAUDE.md`:
```markdown
# MyApp - React + TypeScript SPA

Modern single-page application built with React 18 and TypeScript.

## Tech Stack

**Frontend**:
- React 18.2+ with TypeScript 5.0+
- Vite 5.0 (build tool)
- TailwindCSS 3.4 (styling)
- Radix UI (component primitives)

**State Management**:
- TanStack Query v5 (server state)
- Zustand 4.4 (client state)

**Forms & Validation**:
- React Hook Form 7.48
- Zod 3.22 (schema validation)

**Routing**:
- React Router v6

**Testing**:
- Vitest + React Testing Library
- Playwright (E2E)

## Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── ui/             # Base UI components (buttons, inputs)
│   └── features/       # Feature-specific components
├── pages/              # Route pages
├── hooks/              # Custom React hooks
├── lib/                # Utilities and helpers
├── api/                # API client functions
├── stores/             # Zustand stores
└── types/              # TypeScript type definitions
```

## File Naming Conventions

- Components: `PascalCase.tsx` (e.g., `UserProfile.tsx`)
- Hooks: `use*.ts` (e.g., `useAuth.ts`)
- Utils: `camelCase.ts` (e.g., `formatDate.ts`)
- Types: `*.types.ts` (e.g., `user.types.ts`)
- Tests: `*.test.tsx` or `*.spec.tsx`
- Styles: `*.module.css` (CSS modules)

## Coding Standards

### TypeScript
- Strict mode enabled
- No `any` types (use `unknown` if needed)
- Explicit return types for functions
- Prefer `interface` over `type` for object shapes

### React
- Functional components only (no class components)
- Use hooks for state and side effects
- Prefer composition over prop drilling
- Extract custom hooks for reusable logic

### Styling
- TailwindCSS utility classes
- CSS modules for component-specific styles
- Mobile-first responsive design
- Dark mode support via Tailwind

### State Management
- **Server state**: TanStack Query (API data, caching)
- **Client state**: Zustand (UI state, user preferences)
- **Form state**: React Hook Form (form data, validation)

## Component Template

```tsx
import { FC } from 'react';
import styles from './ComponentName.module.css';

interface ComponentNameProps {
  title: string;
  onAction?: () => void;
}

export const ComponentName: FC<ComponentNameProps> = ({
  title,
  onAction
}) => {
  return (
    <div className={styles.container}>
      <h2>{title}</h2>
      {onAction && (
        <button onClick={onAction}>Action</button>
      )}
    </div>
  );
};
```

## API Client Pattern

```ts
// src/api/users.ts
import { useQuery, useMutation } from '@tanstack/react-query';
import { api } from './client';
import type { User } from '@/types/user.types';

export const useUsers = () => {
  return useQuery({
    queryKey: ['users'],
    queryFn: () => api.get<User[]>('/users'),
  });
};

export const useCreateUser = () => {
  return useMutation({
    mutationFn: (user: Omit<User, 'id'>) =>
      api.post<User>('/users', user),
  });
};
```

## Form Handling Pattern

```tsx
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

type FormData = z.infer<typeof schema>;

export const LoginForm = () => {
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(schema),
  });

  const onSubmit = (data: FormData) => {
    // Handle form submission
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}

      <input type="password" {...register('password')} />
      {errors.password && <span>{errors.password.message}</span>}

      <button type="submit">Login</button>
    </form>
  );
};
```

## Testing Guidelines

### Unit Tests (Vitest + RTL)
```tsx
import { render, screen } from '@testing-library/react';
import { ComponentName } from './ComponentName';

describe('ComponentName', () => {
  it('renders title correctly', () => {
    render(<ComponentName title="Test Title" />);
    expect(screen.getByText('Test Title')).toBeInTheDocument();
  });

  it('calls onAction when button clicked', async () => {
    const onAction = vi.fn();
    render(<ComponentName title="Test" onAction={onAction} />);

    await userEvent.click(screen.getByRole('button'));
    expect(onAction).toHaveBeenCalledTimes(1);
  });
});
```

### E2E Tests (Playwright)
```ts
import { test, expect } from '@playwright/test';

test('user can login', async ({ page }) => {
  await page.goto('/login');

  await page.fill('input[name="email"]', 'user@example.com');
  await page.fill('input[name="password"]', 'password123');
  await page.click('button[type="submit"]');

  await expect(page).toHaveURL('/dashboard');
});
```

## Common Tasks

### Create New Component
1. Create `src/components/ComponentName.tsx`
2. Create `src/components/ComponentName.module.css`
3. Create `src/components/__tests__/ComponentName.test.tsx`
4. Export from `src/components/index.ts`

### Add New Page
1. Create `src/pages/PageName.tsx`
2. Add route in `src/App.tsx`
3. Add navigation link if needed
4. Create E2E test

### Add API Endpoint
1. Define types in `src/types/`
2. Create API functions in `src/api/`
3. Create React Query hooks
4. Add tests

## Environment Variables

```env
# .env.example
VITE_API_URL=http://localhost:3000/api
VITE_APP_NAME=MyApp
VITE_ENABLE_ANALYTICS=false
```

## Scripts

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:e2e": "playwright test",
    "lint": "eslint . --ext ts,tsx",
    "format": "prettier --write \"src/**/*.{ts,tsx,css}\""
  }
}
```

## Notes

- Always run `npm run lint` before committing
- Maintain 80%+ test coverage
- Use semantic commit messages
- All PRs require code review
- Deploy to staging before production
```

---

## 2. config.json (Configuration)

`.claude/config.json`:
```json
{
  "agents": {
    "Explore": {
      "model": "haiku",
      "description": "Fast file searches and navigation"
    },
    "general-purpose": {
      "model": "sonnet",
      "description": "Standard development tasks"
    }
  },
  "skills": {
    "component-generator": {
      "path": ".claude/skills/component-generator",
      "model": "sonnet",
      "enabled": true
    },
    "code-review": {
      "model": "haiku",
      "modelOverrides": {
        "deep": "sonnet"
      },
      "enabled": true
    },
    "test-generator": {
      "model": "sonnet",
      "enabled": true
    }
  },
  "defaultModel": "sonnet",
  "costTracking": {
    "enabled": true,
    "logFile": ".claude/cost-log.json",
    "dailyBudget": 50000
  }
}
```

---

## 3. Slash Commands

### Component Generator Command

`.claude/commands/component.md`:
```markdown
---
command: component
description: Generate React component with TypeScript
usage: /component <ComponentName> [--page]
examples:
  - /component Button
  - /component UserProfile --page
skill: component-generator
model: sonnet
options:
  - name: page
    type: boolean
    default: false
    description: Generate as page component
---

# Component Generator

## Instructions

Generate a complete React component with:

1. Component file (`ComponentName.tsx`)
2. CSS module (`ComponentName.module.css`)
3. Test file (`__tests__/ComponentName.test.tsx`)
4. Export in `index.ts`

### Component Template

```tsx
import { FC } from 'react';
import styles from './ComponentName.module.css';

interface ComponentNameProps {
  // Props here
}

export const ComponentName: FC<ComponentNameProps> = (props) => {
  return (
    <div className={styles.container}>
      {/* Component content */}
    </div>
  );
};
```

### Test Template

```tsx
import { render, screen } from '@testing-library/react';
import { ComponentName } from '../ComponentName';

describe('ComponentName', () => {
  it('renders correctly', () => {
    render(<ComponentName />);
    // Assertions
  });
});
```

If `--page` flag:
- Place in `src/pages/`
- Add route to `App.tsx`
- Create basic layout structure
```

### Test Generator Command

`.claude/commands/test.md`:
```markdown
---
command: test
description: Generate tests for React component
usage: /test <ComponentPath>
examples:
  - /test src/components/Button.tsx
model: sonnet
---

# Test Generator

## Instructions

Generate comprehensive tests using Vitest and React Testing Library:

1. Import the component
2. Generate test cases:
   - Renders correctly
   - Props work as expected
   - User interactions
   - Edge cases
   - Accessibility

### Test Template

```tsx
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { ComponentName } from './ComponentName';

describe('ComponentName', () => {
  it('renders with required props', () => {
    render(<ComponentName prop="value" />);
    expect(screen.getByRole('...')).toBeInTheDocument();
  });

  it('handles user interaction', async () => {
    const onClick = vi.fn();
    render(<ComponentName onClick={onClick} />);

    await userEvent.click(screen.getByRole('button'));
    expect(onClick).toHaveBeenCalled();
  });

  it('handles edge cases', () => {
    render(<ComponentName emptyData={[]} />);
    expect(screen.getByText('No data')).toBeInTheDocument();
  });
});
```
```

---

## 4. Component Generator Skill

`.claude/skills/component-generator/SKILL.md`:
```markdown
---
name: component-generator
version: 1.0.0
description: Generate React components with TypeScript
model: sonnet
category: code-generation
---

# Component Generator Skill

## Instructions

When generating a React component:

1. **Analyze component name**
   - Convert to PascalCase
   - Determine appropriate location (components/ or pages/)

2. **Generate component file**
   ```tsx
   import { FC } from 'react';
   import styles from './ComponentName.module.css';

   interface ComponentNameProps {
     // Infer props from context
   }

   export const ComponentName: FC<ComponentNameProps> = (props) => {
     return (
       <div className={styles.container}>
         {/* Implementation */}
       </div>
     );
   };
   ```

3. **Generate CSS module**
   ```css
   .container {
     /* Base styles */
   }
   ```

4. **Generate test file**
   ```tsx
   import { render } from '@testing-library/react';
   import { ComponentName } from '../ComponentName';

   describe('ComponentName', () => {
     it('renders correctly', () => {
       const { container } = render(<ComponentName />);
       expect(container).toBeInTheDocument();
     });
   });
   ```

5. **Update exports**
   Add to `src/components/index.ts`:
   ```ts
   export { ComponentName } from './ComponentName';
   ```

## Examples

Input: `/component UserAvatar`

Output:
```
Created:
✅ src/components/UserAvatar.tsx
✅ src/components/UserAvatar.module.css
✅ src/components/__tests__/UserAvatar.test.tsx
✅ Updated src/components/index.ts

Component ready to use:
import { UserAvatar } from '@/components';
```
```

---

## Usage Example

```bash
# Initialize project with this template
cp -r guides/9-examples/projects/react-typescript/.claude/ .

# Generate a new component
/component UserProfile

# Generate tests
/test src/components/UserProfile.tsx

# Review code
/review --quick

# Run tests
npm test
```

---

## Cost Estimate

**Daily development (1 developer)**:
- 10 component generations: $1.50
- 15 file searches: $0.30
- 5 code reviews: $0.40
- 10 test generations: $1.80

**Total**: ~$4.00/day

---

## Next Steps

- [Node.js API Template](2-nodejs-api.md)
- [Full-Stack Template](4-fullstack.md)
- [Workflow Templates](../workflows/1-feature-development.md)

---

**Questions or Feedback?**
[Open an issue](https://github.com/anthropics/claude-code/issues)
