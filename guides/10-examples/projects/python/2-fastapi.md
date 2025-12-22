# Python/FastAPI Project Template

**Reading Time**: 40 minutes
**Skill Level**: Intermediate
**Prerequisites**: Basic Python knowledge, async/await understanding

---

## Overview

This template provides a complete FastAPI project configuration optimized for Claude Code, including custom skills for endpoint generation, Pydantic model creation, and modern async patterns.

**What's Included**:
- Complete FastAPI project structure
- Custom skills for API development
- Async/await patterns
- Pydantic model generation
- Testing with pytest-asyncio
- Cost estimates and optimization

---

## Table of Contents

1. [Project Structure](#project-structure)
2. [CLAUDE.md Configuration](#claudemd-configuration)
3. [Custom Skills](#custom-skills)
4. [Example Workflows](#example-workflows)
5. [Testing Setup](#testing-setup)
6. [Cost Analysis](#cost-analysis)
7. [Deployment](#deployment)

---

## Project Structure

```
my-fastapi-project/
├── .claude/
│   ├── config.json
│   ├── skills/
│   │   ├── fastapi-endpoint/
│   │   │   └── SKILL.md
│   │   ├── pydantic-model/
│   │   │   └── SKILL.md
│   │   └── fastapi-test/
│   │       └── SKILL.md
│   └── commands/
│       ├── dev.md
│       ├── test.md
│       └── docs.md
├── CLAUDE.md
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── config.py
│   ├── api/
│   │   ├── __init__.py
│   │   ├── deps.py
│   │   └── v1/
│   │       ├── __init__.py
│   │       ├── endpoints/
│   │       │   ├── users.py
│   │       │   └── items.py
│   │       └── router.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── item.py
│   ├── schemas/
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── item.py
│   ├── crud/
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── item.py
│   └── db/
│       ├── __init__.py
│       ├── base.py
│       └── session.py
├── tests/
│   ├── conftest.py
│   └── api/
│       └── v1/
│           ├── test_users.py
│           └── test_items.py
├── alembic/
├── requirements.txt
└── pyproject.toml
```

---

## CLAUDE.md Configuration

**File**: `CLAUDE.md`

```markdown
# FastAPI Project - Claude Code Configuration

## Project Overview

Modern async API built with:
- FastAPI 0.109+
- Pydantic v2 for data validation
- SQLAlchemy 2.0 with async support
- PostgreSQL database
- pytest-asyncio for testing

## Development Guidelines

### FastAPI Conventions

1. **Endpoints**: In `app/api/v1/endpoints/`
2. **Schemas**: Pydantic models in `app/schemas/`
3. **Models**: SQLAlchemy models in `app/models/`
4. **CRUD**: Database operations in `app/crud/`

### Code Style

- Use async/await for all I/O operations
- Type hints required for all functions
- Pydantic models for request/response validation
- Dependency injection for database sessions
- Maximum line length: 100 characters

### Async Patterns

**Good**:
\```python
@router.get("/users/{user_id}")
async def get_user(
    user_id: int,
    db: AsyncSession = Depends(get_db)
):
    user = await crud.user.get(db, id=user_id)
    return user
\```

**Bad**:
\```python
@router.get("/users/{user_id}")
def get_user(user_id: int):  # Missing async, type hints, dependency
    user = db.query(User).get(user_id)  # Blocking call
    return user
\```

### Database

- Always use async SQLAlchemy
- Use Alembic for migrations
- Transactions for writes
- Connection pooling

### Testing

- Use pytest-asyncio
- Mock external services
- Test both success and error cases
- Target: 90%+ coverage

## Available Skills

- `/fastapi-endpoint`: Generate async endpoint with full CRUD
- `/pydantic-model`: Create Pydantic schema with validation
- `/fastapi-test`: Generate comprehensive async tests

## Available Commands

- `/dev`: Start development server with hot reload
- `/test`: Run test suite with coverage
- `/docs`: Open interactive API documentation

## Cost Optimization

- Use Haiku for simple Pydantic models
- Use Sonnet for endpoint generation
- Batch related operations

## Security

- Never commit DATABASE_URL or SECRET_KEY
- Use environment variables
- Validate all input with Pydantic
- Rate limiting on public endpoints
- CORS configuration

## Common Patterns

### Creating an Endpoint

\```python
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from app.api import deps
from app.schemas.user import User, UserCreate
from app.crud import user as crud_user

router = APIRouter()

@router.post("/", response_model=User, status_code=201)
async def create_user(
    user_in: UserCreate,
    db: AsyncSession = Depends(deps.get_db)
):
    """
    Create a new user.
    """
    user = await crud_user.get_by_email(db, email=user_in.email)
    if user:
        raise HTTPException(
            status_code=400,
            detail="Email already registered"
        )
    user = await crud_user.create(db, obj_in=user_in)
    return user
\```

### Pydantic Model

\```python
from pydantic import BaseModel, EmailStr, Field, ConfigDict
from datetime import datetime

class UserBase(BaseModel):
    email: EmailStr
    name: str = Field(..., min_length=1, max_length=100)

class UserCreate(UserBase):
    password: str = Field(..., min_length=8)

class User(UserBase):
    id: int
    is_active: bool = True
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)
\```

## Troubleshooting

- **Event loop errors**: Ensure using async/await correctly
- **Pydantic validation**: Check field types and constraints
- **Database connections**: Verify pool settings
- **Import errors**: Check __init__.py files
```

---

## Custom Skills

### Skill 1: FastAPI Endpoint Generator

**File**: `.claude/skills/fastapi-endpoint/SKILL.md`

```yaml
---
name: fastapi-endpoint
description: Generate async FastAPI endpoint with CRUD operations
model: claude-sonnet-4-5
invocationPattern: /fastapi-endpoint
---

# FastAPI Endpoint Generator

When invoked, I will create a complete async API endpoint.

## Usage

\```
/fastapi-endpoint Create CRUD endpoints for User resource
\```

## What I'll Generate

1. **Pydantic Schemas**:
   - Base schema
   - Create schema (for requests)
   - Update schema
   - Response schema

2. **CRUD Operations**:
   - get (retrieve single)
   - get_multi (list with pagination)
   - create
   - update
   - delete

3. **Router/Endpoints**:
   - All CRUD routes
   - Proper HTTP methods
   - Response models
   - Error handling
   - Dependencies

4. **Tests**:
   - Basic tests for all endpoints

## Example Output

**Schemas** (`app/schemas/user.py`):

\```python
from pydantic import BaseModel, EmailStr, Field, ConfigDict
from datetime import datetime
from typing import Optional

class UserBase(BaseModel):
    """Base User schema with common fields."""
    email: EmailStr
    name: str = Field(..., min_length=1, max_length=100)
    is_active: bool = True

class UserCreate(UserBase):
    """Schema for creating a new user."""
    password: str = Field(..., min_length=8, max_length=100)

class UserUpdate(BaseModel):
    """Schema for updating a user."""
    email: Optional[EmailStr] = None
    name: Optional[str] = Field(None, min_length=1, max_length=100)
    password: Optional[str] = Field(None, min_length=8, max_length=100)
    is_active: Optional[bool] = None

class UserInDB(UserBase):
    """Schema for user in database."""
    id: int
    created_at: datetime
    updated_at: datetime

    model_config = ConfigDict(from_attributes=True)

class User(UserInDB):
    """Public user schema (no sensitive fields)."""
    pass

class UserList(BaseModel):
    """Schema for paginated user list."""
    items: list[User]
    total: int
    page: int
    size: int
\```

**CRUD** (`app/crud/user.py`):

\```python
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.user import User
from app.schemas.user import UserCreate, UserUpdate
from typing import Optional

async def get(db: AsyncSession, id: int) -> Optional[User]:
    """Get user by ID."""
    result = await db.execute(select(User).where(User.id == id))
    return result.scalar_one_or_none()

async def get_by_email(
    db: AsyncSession,
    email: str
) -> Optional[User]:
    """Get user by email."""
    result = await db.execute(select(User).where(User.email == email))
    return result.scalar_one_or_none()

async def get_multi(
    db: AsyncSession,
    skip: int = 0,
    limit: int = 100
) -> list[User]:
    """Get multiple users with pagination."""
    result = await db.execute(
        select(User).offset(skip).limit(limit)
    )
    return result.scalars().all()

async def create(db: AsyncSession, obj_in: UserCreate) -> User:
    """Create new user."""
    db_obj = User(
        email=obj_in.email,
        name=obj_in.name,
        hashed_password=hash_password(obj_in.password),
        is_active=obj_in.is_active
    )
    db.add(db_obj)
    await db.commit()
    await db.refresh(db_obj)
    return db_obj

async def update(
    db: AsyncSession,
    db_obj: User,
    obj_in: UserUpdate
) -> User:
    """Update existing user."""
    update_data = obj_in.model_dump(exclude_unset=True)
    if "password" in update_data:
        update_data["hashed_password"] = hash_password(
            update_data.pop("password")
        )

    for field, value in update_data.items():
        setattr(db_obj, field, value)

    db.add(db_obj)
    await db.commit()
    await db.refresh(db_obj)
    return db_obj

async def delete(db: AsyncSession, id: int) -> User:
    """Delete user."""
    db_obj = await get(db, id=id)
    await db.delete(db_obj)
    await db.commit()
    return db_obj
\```

**Endpoints** (`app/api/v1/endpoints/users.py`):

\```python
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.ext.asyncio import AsyncSession
from app.api import deps
from app.schemas.user import (
    User,
    UserCreate,
    UserUpdate,
    UserList
)
from app.crud import user as crud_user

router = APIRouter()

@router.get("/", response_model=UserList)
async def list_users(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    db: AsyncSession = Depends(deps.get_db)
):
    """
    List users with pagination.
    """
    users = await crud_user.get_multi(db, skip=skip, limit=limit)
    total = len(users)  # In production, use count query

    return UserList(
        items=users,
        total=total,
        page=skip // limit + 1,
        size=limit
    )

@router.post("/", response_model=User, status_code=201)
async def create_user(
    user_in: UserCreate,
    db: AsyncSession = Depends(deps.get_db)
):
    """
    Create a new user.
    """
    user = await crud_user.get_by_email(db, email=user_in.email)
    if user:
        raise HTTPException(
            status_code=400,
            detail="Email already registered"
        )
    user = await crud_user.create(db, obj_in=user_in)
    return user

@router.get("/{user_id}", response_model=User)
async def get_user(
    user_id: int,
    db: AsyncSession = Depends(deps.get_db)
):
    """
    Get user by ID.
    """
    user = await crud_user.get(db, id=user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.put("/{user_id}", response_model=User)
async def update_user(
    user_id: int,
    user_in: UserUpdate,
    db: AsyncSession = Depends(deps.get_db)
):
    """
    Update existing user.
    """
    user = await crud_user.get(db, id=user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user = await crud_user.update(db, db_obj=user, obj_in=user_in)
    return user

@router.delete("/{user_id}", response_model=User)
async def delete_user(
    user_id: int,
    db: AsyncSession = Depends(deps.get_db)
):
    """
    Delete user.
    """
    user = await crud_user.get(db, id=user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user = await crud_user.delete(db, id=user_id)
    return user
\```

**Tests** (`tests/api/v1/test_users.py`):

\```python
import pytest
from httpx import AsyncClient
from app.main import app

@pytest.mark.asyncio
async def test_create_user():
    """Test creating a user."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.post(
            "/api/v1/users/",
            json={
                "email": "test@example.com",
                "name": "Test User",
                "password": "password123"
            }
        )
        assert response.status_code == 201
        data = response.json()
        assert data["email"] == "test@example.com"
        assert "id" in data

@pytest.mark.asyncio
async def test_get_user(test_user):
    """Test getting a user."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get(f"/api/v1/users/{test_user.id}")
        assert response.status_code == 200
        data = response.json()
        assert data["id"] == test_user.id

@pytest.mark.asyncio
async def test_list_users():
    """Test listing users with pagination."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/api/v1/users/?skip=0&limit=10")
        assert response.status_code == 200
        data = response.json()
        assert "items" in data
        assert "total" in data
\```

## After Generation

I'll remind you to:
1. Add router to `app/api/v1/router.py`
2. Create Alembic migration if model changed
3. Run tests: `pytest tests/api/v1/test_users.py`
4. Check OpenAPI docs: http://localhost:8000/docs

## Cost

- Tokens: ~10,000-14,000
- Cost: ~$0.20-$0.28 (Sonnet)
- Time: 10-15 minutes
```

---

### Skill 2: Pydantic Model Generator

**File**: `.claude/skills/pydantic-model/SKILL.md`

```yaml
---
name: pydantic-model
description: Generate Pydantic model with validation
model: claude-haiku-4-5
invocationPattern: /pydantic-model
---

# Pydantic Model Generator

When invoked, I will create Pydantic schemas with validation.

## Usage

\```
/pydantic-model Create User schema with email, name, and age validation
\```

## What I'll Generate

1. **Base Schema**: Common fields
2. **Create Schema**: For POST requests
3. **Update Schema**: For PUT/PATCH requests
4. **Response Schema**: For responses
5. **Validators**: Custom validation logic

## Example Output

\```python
from pydantic import (
    BaseModel,
    EmailStr,
    Field,
    ConfigDict,
    field_validator
)
from datetime import datetime
from typing import Optional

class UserBase(BaseModel):
    """Base user schema."""
    email: EmailStr = Field(..., description="User's email address")
    name: str = Field(..., min_length=1, max_length=100)
    age: int = Field(..., ge=18, le=120, description="Must be 18+")

class UserCreate(UserBase):
    """Schema for creating a user."""
    password: str = Field(..., min_length=8, max_length=100)

    @field_validator('password')
    @classmethod
    def password_strength(cls, v: str) -> str:
        """Validate password strength."""
        if not any(char.isdigit() for char in v):
            raise ValueError('Password must contain a digit')
        if not any(char.isupper() for char in v):
            raise ValueError('Password must contain uppercase letter')
        return v

class UserUpdate(BaseModel):
    """Schema for updating a user."""
    email: Optional[EmailStr] = None
    name: Optional[str] = Field(None, min_length=1, max_length=100)
    age: Optional[int] = Field(None, ge=18, le=120)
    password: Optional[str] = Field(None, min_length=8)

class UserInDB(UserBase):
    """User as stored in database."""
    id: int
    is_active: bool = True
    created_at: datetime
    updated_at: datetime

    model_config = ConfigDict(from_attributes=True)

class User(UserInDB):
    """Public user schema."""
    pass  # Could exclude sensitive fields here

# Example usage:
# user_data = UserCreate(
#     email="test@example.com",
#     name="Test User",
#     age=25,
#     password="SecurePass123"
# )
\```

## Cost

- Tokens: ~3,000-4,000
- Cost: ~$0.03-$0.04 (Haiku)
- Time: 3-5 minutes
```

---

## Example Workflows

### Workflow 1: Create New Resource API

**Goal**: Add `Product` resource with full CRUD

**Steps**:

1. **Generate Endpoint** (12 min, $0.24):
   ```
   You: "/fastapi-endpoint Create Product API with name, price, description"

   Claude: [Generates schemas, CRUD, endpoints, tests]
   ```

2. **Create Database Model** (5 min, $0.10):
   ```
   You: "Create SQLAlchemy async model for Product"

   Claude: [Generates model with async support]
   ```

3. **Create Migration** (2 min, free):
   ```bash
   alembic revision --autogenerate -m "Add product table"
   alembic upgrade head
   ```

4. **Run Tests** (2 min, free):
   ```
   You: "/test"

   Claude: [Runs async tests]
   ```

5. **Check Documentation** (1 min, free):
   ```
   You: "/docs"

   [Opens http://localhost:8000/docs]
   ```

**Total**: 22 minutes, $0.34

---

### Workflow 2: Add Custom Validation

**Goal**: Add complex validation to existing schema

**Steps**:

1. **Update Schema** (5 min, $0.05):
   ```
   You: "Add validation to Product schema:
   - Price must be positive
   - Name must not contain special characters
   - Description max 500 characters"

   Claude: [Adds field_validator methods]
   ```

2. **Update Tests** (5 min, $0.10):
   ```
   You: "Add tests for the new validations"

   Claude: [Generates validation tests]
   ```

**Total**: 10 minutes, $0.15

---

## Testing Setup

**File**: `pyproject.toml`

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
asyncio_mode = "auto"
addopts = [
    "--verbose",
    "--cov=app",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-fail-under=80"
]
markers = [
    "slow: marks tests as slow",
    "integration: marks tests as integration tests"
]
```

**File**: `tests/conftest.py`

```python
import pytest
import pytest_asyncio
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker
from app.main import app
from app.db.base import Base
from app.api.deps import get_db

# Test database URL
TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"

@pytest_asyncio.fixture
async def db_engine():
    """Create async test database engine."""
    engine = create_async_engine(TEST_DATABASE_URL, echo=True)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield engine
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
    await engine.dispose()

@pytest_asyncio.fixture
async def db_session(db_engine):
    """Create async database session for tests."""
    async_session = sessionmaker(
        db_engine,
        class_=AsyncSession,
        expire_on_commit=False
    )
    async with async_session() as session:
        yield session

@pytest_asyncio.fixture
async def client(db_session):
    """Create async HTTP client for API tests."""
    async def override_get_db():
        yield db_session

    app.dependency_overrides[get_db] = override_get_db

    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client

    app.dependency_overrides.clear()

@pytest_asyncio.fixture
async def test_user(db_session):
    """Create a test user."""
    from app.models.user import User
    from app.crud.user import create
    from app.schemas.user import UserCreate

    user_in = UserCreate(
        email="test@example.com",
        name="Test User",
        password="testpass123"
    )
    user = await create(db_session, obj_in=user_in)
    return user
```

---

## Cost Analysis

### Typical Monthly Usage

**Small API** (5-10 endpoints):
- Endpoint generation: 10 × $0.24 = $2.40
- Pydantic models: 10 × $0.03 = $0.30
- Bug fixes: 5 × $0.30 = $1.50
- Code reviews: 10 × $0.20 = $2.00
- **Total**: ~$6.20/month

**Medium API** (20-30 endpoints):
- Endpoint generation: 30 × $0.24 = $7.20
- Pydantic models: 30 × $0.03 = $0.90
- Bug fixes: 15 × $0.30 = $4.50
- Code reviews: 30 × $0.20 = $6.00
- Refactoring: 3 × $1.00 = $3.00
- **Total**: ~$21.60/month

**Large API** (50+ endpoints):
- Endpoint generation: 50 × $0.24 = $12.00
- Pydantic models: 50 × $0.03 = $1.50
- Bug fixes: 30 × $0.30 = $9.00
- Code reviews: 60 × $0.20 = $12.00
- Refactoring: 8 × $1.00 = $8.00
- **Total**: ~$42.50/month

---

## Deployment

### Docker Setup

**Dockerfile**:
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY ./app ./app
COPY ./alembic ./alembic
COPY alembic.ini .

# Run migrations and start server
CMD alembic upgrade head && \
    uvicorn app.main:app --host 0.0.0.0 --port 8000
```

**docker-compose.yml**:
```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql+asyncpg://user:pass@db:5432/mydb
      - SECRET_KEY=${SECRET_KEY}
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

---

## Quick Reference

### Common Commands

| Task | Command | Cost |
|------|---------|------|
| Create endpoint | `/fastapi-endpoint [description]` | $0.24 |
| Create schema | `/pydantic-model [description]` | $0.03 |
| Start dev server | `/dev` | Free |
| Run tests | `/test` | Free |
| View API docs | `/docs` | Free |

### Async Checklist

- [ ] All endpoint functions are `async def`
- [ ] Database operations use `await`
- [ ] HTTP clients are async (httpx)
- [ ] File operations are async (aiofiles)
- [ ] Proper exception handling
- [ ] Tests use `@pytest.mark.asyncio`

---

## Related Guides

- [Django Template](1-django.md) - Full-featured web framework
- [Flask Template](3-flask.md) - Lightweight framework
- [Bug Fixing Workflow](../../workflows/2-bug-fixing.md) - Debug async code
- [Testing Guide](../../../12-security/2-testing-quality.md) - Async testing patterns

---

**Last Updated**: 2025-01-15
**Maintained By**: Documentation Team
