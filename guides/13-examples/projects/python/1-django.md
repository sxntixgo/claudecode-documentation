# Python/Django Project Template

**Reading Time**: 45 minutes
**Skill Level**: Intermediate
**Prerequisites**: Basic Python and Django knowledge

---

## Overview

This template provides a complete Django project configuration optimized for Claude Code, including custom skills for model generation, admin panel creation, API endpoints, and Django-specific workflows.

**What's Included**:
- Complete Django project structure
- Custom skills for Django development
- Slash commands for common Django operations
- Testing configuration
- Celery task management setup
- Cost estimates and optimization strategies

---

## Table of Contents

1. [Project Structure](#project-structure)
2. [CLAUDE.md Configuration](#claudemd-configuration)
3. [Custom Skills](#custom-skills)
4. [Slash Commands](#slash-commands)
5. [Example Workflows](#example-workflows)
6. [Testing Setup](#testing-setup)
7. [Cost Analysis](#cost-analysis)
8. [Deployment](#deployment)

---

## Project Structure

```
my-django-project/
├── .claude/
│   ├── config.json
│   ├── skills/
│   │   ├── django-model-generator/
│   │   │   └── SKILL.md
│   │   ├── django-admin-creator/
│   │   │   └── SKILL.md
│   │   ├── django-api-builder/
│   │   │   └── SKILL.md
│   │   └── django-test-generator/
│   │       └── SKILL.md
│   └── commands/
│       ├── makemigrations.md
│       ├── migrate.md
│       ├── test.md
│       └── runserver.md
├── CLAUDE.md
├── myproject/
│   ├── __init__.py
│   ├── settings/
│   │   ├── base.py
│   │   ├── development.py
│   │   └── production.py
│   ├── urls.py
│   └── wsgi.py
├── apps/
│   ├── users/
│   ├── core/
│   └── api/
├── manage.py
├── requirements/
│   ├── base.txt
│   ├── dev.txt
│   └── prod.txt
├── tests/
├── celery_app.py
└── pytest.ini
```

---

## CLAUDE.md Configuration

**File**: `CLAUDE.md`

```markdown
# Django Project - Claude Code Configuration

## Project Overview

This is a Django web application using:
- Django 5.0+
- PostgreSQL database
- Celery for background tasks
- Django REST Framework for APIs
- pytest for testing

## Development Guidelines

### Django Conventions

1. **Models**: Always in `apps/{app_name}/models.py`
2. **Views**: Use class-based views when possible
3. **Serializers**: For DRF APIs in `apps/{app_name}/serializers.py`
4. **Tests**: Mirror app structure in `tests/apps/{app_name}/`

### Code Style

- Follow PEP 8
- Use type hints for all functions
- Maximum line length: 100 characters
- Use Black for formatting
- Use isort for imports

### Database

- **Never commit migrations without reviewing**
- Always use migrations for schema changes
- Run `makemigrations` before `migrate`
- Use database transactions for data modifications

### Testing

- Write tests BEFORE implementing features (TDD)
- Target: 90%+ coverage
- Run tests before committing: `pytest`
- Use factory_boy for test data

## Available Skills

- `/django-model`: Generate Django model with fields
- `/django-admin`: Create admin panel configuration
- `/django-api`: Build REST API endpoint
- `/django-test`: Generate comprehensive tests

## Available Commands

- `/makemigrations`: Create database migrations
- `/migrate`: Apply migrations to database
- `/test`: Run test suite with coverage
- `/runserver`: Start development server

## Cost Optimization

- Use Haiku for simple model generation
- Use Sonnet for API endpoint creation
- Use Sonnet for complex business logic
- Batch related operations to save context

## Security

- Never commit SECRET_KEY or database credentials
- Always use environment variables for secrets
- Validate all user input
- Use Django's CSRF protection
- Enable SQL injection protection (use ORM)

## Common Patterns

### Creating a New Model

\```python
from django.db import models

class MyModel(models.Model):
    name = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'myapp_mymodel'
        ordering = ['-created_at']

    def __str__(self):
        return self.name
\```

### Creating an API Endpoint

\```python
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

class MyModelViewSet(viewsets.ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
    permission_classes = [IsAuthenticated]
\```

## Troubleshooting

- **Migration conflicts**: Delete and recreate migrations
- **Import errors**: Check PYTHONPATH and installed apps
- **Test failures**: Check test database setup
- **Celery not running**: Verify Redis connection
```

---

## Custom Skills

### Skill 1: Django Model Generator

**File**: `.claude/skills/django-model-generator/SKILL.md`

```yaml
---
name: django-model
description: Generate Django model with fields, Meta class, and methods
model: claude-haiku-4-5
invocationPattern: /django-model
---

# Django Model Generator

When invoked, I will help you create a Django model.

## Usage

\```
/django-model Create a User model with email, name, and profile picture
\```

## What I'll Generate

1. **Model Class**:
   - Appropriate field types
   - Field constraints (max_length, null, blank)
   - Relationships (ForeignKey, ManyToMany)
   - Meta class (db_table, ordering, indexes)

2. **Methods**:
   - `__str__()` method
   - Custom methods if needed
   - Properties if applicable

3. **Best Practices**:
   - created_at/updated_at timestamps
   - Proper indexing for common queries
   - Type hints
   - Docstrings

## Example Output

\```python
from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    """
    Custom user model with additional fields.
    """
    email = models.EmailField(
        unique=True,
        db_index=True,
        help_text="User's email address"
    )
    name = models.CharField(
        max_length=200,
        help_text="User's full name"
    )
    profile_picture = models.ImageField(
        upload_to='profiles/',
        null=True,
        blank=True,
        help_text="User's profile picture"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'users'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['email']),
            models.Index(fields=['created_at']),
        ]

    def __str__(self) -> str:
        return self.email

    @property
    def has_profile_picture(self) -> bool:
        return bool(self.profile_picture)
\```

## After Generation

I'll remind you to:
1. Add the model to `apps/{app}/models.py`
2. Run `/makemigrations`
3. Run `/migrate`
4. Register in admin if needed
5. Write tests

## Cost

- Tokens: ~3,000-5,000
- Cost: ~$0.03-$0.05 (Haiku)
- Time: 2-5 minutes
```

---

### Skill 2: Django Admin Creator

**File**: `.claude/skills/django-admin-creator/SKILL.md`

```yaml
---
name: django-admin
description: Create Django admin panel configuration
model: claude-haiku-4-5
invocationPattern: /django-admin
---

# Django Admin Creator

When invoked, I will create a customized Django admin configuration.

## Usage

\```
/django-admin Create admin for User model with search and filters
\```

## What I'll Generate

1. **Admin Class**:
   - list_display configuration
   - list_filter for common fields
   - search_fields for text search
   - fieldsets for organized forms
   - readonly_fields if needed
   - Inline admin for related models

2. **Customizations**:
   - Custom actions
   - Display methods with decorators
   - Permissions and access control

## Example Output

\```python
from django.contrib import admin
from .models import User

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    """
    Admin interface for User model.
    """
    list_display = [
        'email',
        'name',
        'is_active',
        'has_profile_pic',
        'created_at'
    ]
    list_filter = [
        'is_active',
        'is_staff',
        'created_at'
    ]
    search_fields = [
        'email',
        'name'
    ]
    readonly_fields = [
        'created_at',
        'updated_at'
    ]
    fieldsets = (
        ('User Information', {
            'fields': ('email', 'name', 'profile_picture')
        }),
        ('Permissions', {
            'fields': ('is_active', 'is_staff', 'is_superuser')
        }),
        ('Timestamps', {
            'fields': ('created_at', 'updated_at')
        }),
    )

    @admin.display(boolean=True, description='Has Profile Picture')
    def has_profile_pic(self, obj):
        return obj.has_profile_picture

    actions = ['activate_users', 'deactivate_users']

    @admin.action(description='Activate selected users')
    def activate_users(self, request, queryset):
        updated = queryset.update(is_active=True)
        self.message_user(
            request,
            f'{updated} users activated successfully.'
        )

    @admin.action(description='Deactivate selected users')
    def deactivate_users(self, request, queryset):
        updated = queryset.update(is_active=False)
        self.message_user(
            request,
            f'{updated} users deactivated successfully.'
        )
\```

## After Generation

I'll remind you to:
1. Add to `apps/{app}/admin.py`
2. Test in admin interface at `/admin/`
3. Verify permissions

## Cost

- Tokens: ~3,000-4,000
- Cost: ~$0.03-$0.04 (Haiku)
- Time: 2-4 minutes
```

---

### Skill 3: Django API Builder

**File**: `.claude/skills/django-api-builder/SKILL.md`

```yaml
---
name: django-api
description: Build REST API endpoint with DRF
model: claude-sonnet-4-5
invocationPattern: /django-api
---

# Django API Builder

When invoked, I will create a complete REST API endpoint using Django REST Framework.

## Usage

\```
/django-api Create CRUD API for User model with authentication
\```

## What I'll Generate

1. **Serializer**:
   - Field definitions
   - Validation methods
   - Nested serializers if needed
   - Custom create/update logic

2. **ViewSet**:
   - CRUD operations
   - Permissions
   - Filtering and pagination
   - Custom actions if needed

3. **URL Configuration**:
   - Router setup
   - URL patterns

4. **Tests**:
   - Basic API tests

## Example Output

**Serializer** (`apps/users/serializers.py`):

\```python
from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
    """
    Serializer for User model.
    """
    has_profile_picture = serializers.BooleanField(read_only=True)

    class Meta:
        model = User
        fields = [
            'id',
            'email',
            'name',
            'profile_picture',
            'has_profile_picture',
            'created_at',
            'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']

    def validate_email(self, value):
        """
        Check that email is not already in use.
        """
        if User.objects.filter(email=value).exists():
            raise serializers.ValidationError(
                "This email is already in use."
            )
        return value

    def create(self, validated_data):
        """
        Create and return a new User instance.
        """
        user = User.objects.create_user(**validated_data)
        return user

class UserDetailSerializer(UserSerializer):
    """
    Detailed serializer with additional fields.
    """
    class Meta(UserSerializer.Meta):
        fields = UserSerializer.Meta.fields + [
            'is_active',
            'is_staff',
            'last_login'
        ]
\```

**ViewSet** (`apps/users/views.py`):

\```python
from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import User
from .serializers import UserSerializer, UserDetailSerializer

class UserViewSet(viewsets.ModelViewSet):
    """
    ViewSet for viewing and editing User instances.
    """
    queryset = User.objects.all()
    permission_classes = [IsAuthenticated]
    filter_backends = [
        DjangoFilterBackend,
        filters.SearchFilter,
        filters.OrderingFilter
    ]
    filterset_fields = ['is_active', 'created_at']
    search_fields = ['email', 'name']
    ordering_fields = ['created_at', 'email']
    ordering = ['-created_at']

    def get_serializer_class(self):
        """
        Return appropriate serializer class.
        """
        if self.action == 'retrieve':
            return UserDetailSerializer
        return UserSerializer

    def get_permissions(self):
        """
        Set permissions based on action.
        """
        if self.action in ['create', 'update', 'destroy']:
            return [IsAdminUser()]
        return [IsAuthenticated()]

    @action(detail=True, methods=['post'])
    def activate(self, request, pk=None):
        """
        Activate a user account.
        """
        user = self.get_object()
        user.is_active = True
        user.save()
        serializer = self.get_serializer(user)
        return Response(serializer.data)

    @action(detail=True, methods=['post'])
    def deactivate(self, request, pk=None):
        """
        Deactivate a user account.
        """
        user = self.get_object()
        user.is_active = False
        user.save()
        serializer = self.get_serializer(user)
        return Response(serializer.data)

    @action(detail=False, methods=['get'])
    def me(self, request):
        """
        Get current user profile.
        """
        serializer = UserDetailSerializer(request.user)
        return Response(serializer.data)
\```

**URLs** (`apps/users/urls.py`):

\```python
from rest_framework.routers import DefaultRouter
from .views import UserViewSet

router = DefaultRouter()
router.register(r'users', UserViewSet)

urlpatterns = router.urls
\```

**Tests** (`tests/apps/users/test_api.py`):

\```python
from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework import status
from apps.users.models import User

class UserAPITestCase(TestCase):
    """
    Tests for User API endpoints.
    """

    def setUp(self):
        self.client = APIClient()
        self.admin_user = User.objects.create_superuser(
            email='admin@example.com',
            password='admin123'
        )
        self.regular_user = User.objects.create_user(
            email='user@example.com',
            password='user123',
            name='Test User'
        )

    def test_list_users_authenticated(self):
        """Test listing users requires authentication."""
        # Unauthenticated
        response = self.client.get('/api/users/')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

        # Authenticated
        self.client.force_authenticate(user=self.regular_user)
        response = self.client.get('/api/users/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_create_user_admin_only(self):
        """Test creating user requires admin permissions."""
        data = {
            'email': 'newuser@example.com',
            'name': 'New User',
            'password': 'password123'
        }

        # Regular user cannot create
        self.client.force_authenticate(user=self.regular_user)
        response = self.client.post('/api/users/', data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

        # Admin can create
        self.client.force_authenticate(user=self.admin_user)
        response = self.client.post('/api/users/', data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_me_endpoint(self):
        """Test current user profile endpoint."""
        self.client.force_authenticate(user=self.regular_user)
        response = self.client.get('/api/users/me/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['email'], 'user@example.com')
\```

## After Generation

I'll remind you to:
1. Install django-rest-framework: `pip install djangorestframework django-filter`
2. Add to INSTALLED_APPS in settings.py
3. Include URLs in main urls.py
4. Run tests: `pytest tests/apps/users/test_api.py`
5. Test endpoints manually

## Cost

- Tokens: ~8,000-12,000
- Cost: ~$0.16-$0.24 (Sonnet)
- Time: 8-15 minutes
```

---

## Slash Commands

### Command 1: Make Migrations

**File**: `.claude/commands/makemigrations.md`

```markdown
Run Django makemigrations to create database migrations:

\```bash
python manage.py makemigrations
\```

Review the generated migration files and explain what changed.
```

---

### Command 2: Migrate

**File**: `.claude/commands/migrate.md`

```markdown
Apply database migrations:

\```bash
python manage.py migrate
\```

Show which migrations were applied and check for any issues.
```

---

### Command 3: Test

**File**: `.claude/commands/test.md`

```markdown
Run the test suite with coverage:

\```bash
pytest --cov=apps --cov-report=term-missing --cov-report=html
\```

Display test results and coverage report.
```

---

### Command 4: Run Server

**File**: `.claude/commands/runserver.md`

```markdown
Start Django development server:

\```bash
python manage.py runserver
\```

The server will start at http://127.0.0.1:8000/
```

---

## Example Workflows

### Workflow 1: Create New Model with API

**Goal**: Add a `Product` model with full CRUD API

**Steps**:

1. **Generate Model** (3 min, $0.03):
   ```
   You: "/django-model Create Product model with name, price, description, and image"

   Claude: [Generates model code]
   ```

2. **Create Migration** (1 min, free):
   ```
   You: "/makemigrations"

   Claude: [Creates migration, shows changes]
   ```

3. **Apply Migration** (1 min, free):
   ```
   You: "/migrate"

   Claude: [Applies migration]
   ```

4. **Create Admin** (2 min, $0.03):
   ```
   You: "/django-admin Create admin for Product with price filter"

   Claude: [Generates admin config]
   ```

5. **Build API** (10 min, $0.20):
   ```
   You: "/django-api Create REST API for Product with pagination and search"

   Claude: [Generates serializer, viewset, URLs, tests]
   ```

6. **Run Tests** (2 min, free):
   ```
   You: "/test"

   Claude: [Runs tests, shows coverage]
   ```

**Total**: 19 minutes, $0.26

---

### Workflow 2: Add Celery Task

**Goal**: Add background task for sending emails

**Steps**:

1. **Create Task** (Use Sonnet):
   ```
   You: "Create a Celery task for sending welcome emails to new users"

   Claude: [Generates task code in tasks.py]
   ```

2. **Update Model**:
   ```python
   # In apps/users/signals.py
   from django.db.models.signals import post_save
   from django.dispatch import receiver
   from .models import User
   from .tasks import send_welcome_email

   @receiver(post_save, sender=User, created=True)
   def user_created(sender, instance, created, **kwargs):
       if created:
           send_welcome_email.delay(instance.id)
   ```

3. **Write Tests**:
   ```
   You: "Write tests for the welcome email task"

   Claude: [Generates tests with mocking]
   ```

**Total**: 15 minutes, $0.15

---

## Testing Setup

**File**: `pytest.ini`

```ini
[pytest]
DJANGO_SETTINGS_MODULE = myproject.settings.development
python_files = tests.py test_*.py *_tests.py
python_classes = *Test *TestCase
python_functions = test_*
addopts =
    --verbose
    --strict-markers
    --tb=short
    --cov=apps
    --cov-report=term-missing
    --cov-report=html
    --cov-fail-under=80
markers =
    slow: marks tests as slow (deselect with '-m "not slow"')
    integration: marks tests as integration tests
```

**File**: `tests/conftest.py`

```python
import pytest
from rest_framework.test import APIClient
from apps.users.models import User

@pytest.fixture
def api_client():
    """
    Fixture for DRF API client.
    """
    return APIClient()

@pytest.fixture
def admin_user(db):
    """
    Fixture for admin user.
    """
    return User.objects.create_superuser(
        email='admin@test.com',
        password='admin123',
        name='Admin User'
    )

@pytest.fixture
def regular_user(db):
    """
    Fixture for regular user.
    """
    return User.objects.create_user(
        email='user@test.com',
        password='user123',
        name='Test User'
    )

@pytest.fixture
def authenticated_client(api_client, regular_user):
    """
    Fixture for authenticated API client.
    """
    api_client.force_authenticate(user=regular_user)
    return api_client
```

---

## Cost Analysis

### Typical Monthly Usage

**Small Project** (Solo developer, 2-3 models):
- Model generation: 3 models × $0.03 = $0.09
- Admin creation: 3 admins × $0.03 = $0.09
- API endpoints: 3 APIs × $0.20 = $0.60
- Bug fixes: 5 bugs × $0.30 = $1.50
- Code reviews: 10 PRs × $0.20 = $2.00
- **Total**: ~$4.28/month

**Medium Project** (Small team, 10-15 models):
- Model generation: 15 models × $0.03 = $0.45
- Admin creation: 15 admins × $0.03 = $0.45
- API endpoints: 15 APIs × $0.20 = $3.00
- Bug fixes: 20 bugs × $0.30 = $6.00
- Code reviews: 40 PRs × $0.20 = $8.00
- Refactoring: 5 × $1.00 = $5.00
- **Total**: ~$22.90/month

**Large Project** (Team, 30+ models):
- Model generation: 30 models × $0.03 = $0.90
- Admin creation: 30 admins × $0.03 = $0.90
- API endpoints: 30 APIs × $0.20 = $6.00
- Bug fixes: 50 bugs × $0.30 = $15.00
- Code reviews: 100 PRs × $0.20 = $20.00
- Refactoring: 10 × $1.00 = $10.00
- **Total**: ~$52.80/month

### Optimization Tips

1. **Use Haiku for Simple Tasks**:
   - Model generation
   - Admin creation
   - Simple views
   - **Savings**: 60%+ vs. Sonnet

2. **Batch Operations**:
   ```
   "Create models for User, Product, and Order"
   [Generates all 3 in one session]
   [Saves ~30% on context]
   ```

3. **Use Skills**:
   - Pre-configured for Django patterns
   - Consistent output
   - Faster than ad-hoc prompts

4. **Save Common Patterns**:
   ```
   You: "Save to memory: Our Django models always include:
   - created_at/updated_at timestamps
   - Custom Meta class with db_table
   - __str__() method
   - Type hints on all methods"
   ```

---

## Deployment

### Production Checklist

**Settings**:
```python
# myproject/settings/production.py

DEBUG = False
ALLOWED_HOSTS = [os.environ.get('ALLOWED_HOST')]
SECRET_KEY = os.environ.get('SECRET_KEY')

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),
        'PASSWORD': os.environ.get('DB_PASSWORD'),
        'HOST': os.environ.get('DB_HOST'),
        'PORT': os.environ.get('DB_PORT', '5432'),
    }
}

# Security
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_HSTS_SECONDS = 31536000
```

**Environment Variables** (`.env.example`):
```bash
# Django
DJANGO_SETTINGS_MODULE=myproject.settings.production
SECRET_KEY=your-secret-key-here
ALLOWED_HOST=yourdomain.com

# Database
DB_NAME=your_db_name
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=localhost
DB_PORT=5432

# Celery
CELERY_BROKER_URL=redis://localhost:6379/0
CELERY_RESULT_BACKEND=redis://localhost:6379/0

# Email
EMAIL_HOST=smtp.example.com
EMAIL_PORT=587
EMAIL_HOST_USER=your_email@example.com
EMAIL_HOST_PASSWORD=your_password
```

**Docker Compose**:
```yaml
version: '3.8'

services:
  web:
    build: .
    command: gunicorn myproject.wsgi:application --bind 0.0.0.0:8000
    volumes:
      - .:/app
    ports:
      - "8000:8000"
    env_file:
      - .env
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=${DB_NAME}
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_PASSWORD=${DB_PASSWORD}

  redis:
    image: redis:7
    ports:
      - "6379:6379"

  celery:
    build: .
    command: celery -A celery_app worker --loglevel=info
    volumes:
      - .:/app
    env_file:
      - .env
    depends_on:
      - db
      - redis

volumes:
  postgres_data:
```

---

## Quick Reference

### Common Commands

| Task | Command | Cost |
|------|---------|------|
| Create model | `/django-model [description]` | $0.03 |
| Create admin | `/django-admin [description]` | $0.03 |
| Build API | `/django-api [description]` | $0.20 |
| Make migrations | `/makemigrations` | Free |
| Apply migrations | `/migrate` | Free |
| Run tests | `/test` | Free |
| Start server | `/runserver` | Free |

### Model Checklist

- [ ] Use appropriate field types
- [ ] Add field constraints (max_length, null, blank)
- [ ] Include created_at/updated_at
- [ ] Define Meta class
- [ ] Add __str__() method
- [ ] Add type hints
- [ ] Write docstrings

### API Checklist

- [ ] Create serializer with validation
- [ ] Define viewset with permissions
- [ ] Add filtering and pagination
- [ ] Configure URLs
- [ ] Write comprehensive tests
- [ ] Document endpoints

---

## Related Guides

- [FastAPI Template](2-fastapi.md) - Modern async Python API
- [Flask Template](3-flask.md) - Lightweight Python web framework
- [Testing & Quality Guide](../../15-security/2-testing-quality.md) - Comprehensive testing strategies
- [Bug Fixing Workflow](../../workflows/2-bug-fixing.md) - Debug Django apps
- [API Development](../../01-mcp-servers/1-overview.md) - MCP server patterns

---

**Last Updated**: 2025-01-15
**Maintained By**: Documentation Team
