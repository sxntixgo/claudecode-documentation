# Python/Flask Project Template

**Reading Time**: 30 minutes
**Skill Level**: Beginner to Intermediate
**Prerequisites**: Basic Python knowledge

---

## Overview

Lightweight Flask project configuration optimized for Claude Code with blueprints, database migrations, and testing.

**What's Included**:
- Flask project structure with blueprints
- Custom skills for route and blueprint generation
- Alembic migrations
- Testing with pytest
- Cost-effective development workflow

---

## Project Structure

```
my-flask-project/
├── .claude/
│   ├── config.json
│   ├── skills/
│   │   ├── flask-blueprint/
│   │   │   └── SKILL.md
│   │   └── flask-route/
│   │       └── SKILL.md
│   └── commands/
│       ├── run.md
│       └── test.md
├── CLAUDE.md
├── app/
│   ├── __init__.py
│   ├── models.py
│   ├── blueprints/
│   │   ├── __init__.py
│   │   ├── auth/
│   │   └── api/
│   ├── templates/
│   └── static/
├── migrations/
├── tests/
├── config.py
└── requirements.txt
```

---

## CLAUDE.md Configuration

```markdown
# Flask Project - Claude Code Configuration

## Project Overview

Simple Flask web application with:
- Flask 3.0+
- SQLAlchemy for ORM
- Alembic for migrations
- pytest for testing

## Development Guidelines

### Flask Conventions
- **Blueprints**: Organize by feature in `app/blueprints/`
- **Models**: In `app/models.py` or `app/models/`
- **Templates**: Jinja2 templates in `app/templates/`
- **Static files**: In `app/static/`

### Code Style
- Use blueprints for code organization
- Factory pattern for app creation
- Environment-based configuration
- Type hints where appropriate

## Available Skills
- `/flask-blueprint`: Create new blueprint
- `/flask-route`: Add route to blueprint

## Cost Optimization
- Use Haiku for simple routes
- Use Sonnet for complex business logic
```

---

## Custom Skills

### Flask Blueprint Generator

**.claude/skills/flask-blueprint/SKILL.md**:

```yaml
---
name: flask-blueprint
description: Create Flask blueprint with routes
model: claude-haiku-4-5
---

# Flask Blueprint Generator

Generate a new Flask blueprint with routes and templates.

## Usage

\```
/flask-blueprint Create auth blueprint with login and register routes
\```

## Example Output

**Blueprint** (`app/blueprints/auth/__init__.py`):

\```python
from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models import User
from app import db

bp = Blueprint('auth', __name__, url_prefix='/auth')

@bp.route('/login', methods=['GET', 'POST'])
def login():
    """User login route."""
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        user = User.query.filter_by(email=email).first()
        if user and user.check_password(password):
            # Handle login
            flash('Logged in successfully!', 'success')
            return redirect(url_for('index'))

        flash('Invalid credentials', 'error')

    return render_template('auth/login.html')

@bp.route('/register', methods=['GET', 'POST'])
def register():
    """User registration route."""
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        if User.query.filter_by(email=email).first():
            flash('Email already registered', 'error')
            return render_template('auth/register.html')

        user = User(email=email)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()

        flash('Registration successful!', 'success')
        return redirect(url_for('auth.login'))

    return render_template('auth/register.html')
\```

## Cost
- Tokens: ~3,000-4,000
- Cost: ~$0.03 (Haiku)
- Time: 3-5 minutes
```

---

## Example Workflows

### Create New Feature

1. **Generate Blueprint** (4 min, $0.03):
   ```
   You: "/flask-blueprint Create products blueprint with list and detail views"
   ```

2. **Create Model** (5 min, $0.05):
   ```
   You: "Create Product model with name, price, description"
   ```

3. **Create Migration** (2 min, free):
   ```bash
   flask db migrate -m "Add product table"
   flask db upgrade
   ```

4. **Create Templates** (5 min, $0.05):
   ```
   You: "Create Jinja2 templates for product list and detail pages"
   ```

**Total**: 16 minutes, $0.13

---

## Testing Setup

**conftest.py**:

```python
import pytest
from app import create_app, db

@pytest.fixture
def app():
    """Create application for testing."""
    app = create_app('testing')
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()

@pytest.fixture
def client(app):
    """Create test client."""
    return app.test_client()

@pytest.fixture
def runner(app):
    """Create CLI runner."""
    return app.test_cli_runner()
```

---

## Cost Analysis

**Small Flask App** (3-5 blueprints):
- Blueprint generation: 5 × $0.03 = $0.15
- Routes: 15 × $0.02 = $0.30
- Bug fixes: 5 × $0.25 = $1.25
- **Total**: ~$1.70/month

---

## Quick Reference

| Task | Command | Cost |
|------|---------|------|
| Create blueprint | `/flask-blueprint [desc]` | $0.03 |
| Add route | `/flask-route [desc]` | $0.02 |
| Run server | `/run` | Free |
| Run tests | `/test` | Free |

---

## Related Guides

- [Django Template](1-django.md) - Full-featured framework
- [FastAPI Template](2-fastapi.md) - Modern async API
- [Testing Guide](../../../11-security/2-testing-quality.md)

---

**Last Updated**: 2025-01-15
