# Python/Flask Project Template

**Reading Time**: 45 minutes
**Skill Level**: Beginner to Intermediate
**Prerequisites**: Basic Python knowledge

---

## Overview

Lightweight Flask project configuration optimized for Claude Code with blueprints, database migrations, forms, and comprehensive testing.

**What's Included**:
- Complete Flask project structure with blueprints
- 5 custom skills for rapid development
- Database models and migrations with Alembic
- Form handling with Flask-WTF
- Authentication patterns
- RESTful API blueprints
- Comprehensive testing setup
- Deployment configurations
- Cost-effective development workflows

---

## Table of Contents

1. [Project Structure](#project-structure)
2. [CLAUDE.md Configuration](#claudemd-configuration)
3. [Custom Skills](#custom-skills)
4. [Example Workflows](#example-workflows)
5. [Authentication Patterns](#authentication-patterns)
6. [API Development](#api-development)
7. [Testing Setup](#testing-setup)
8. [Cost Analysis](#cost-analysis)
9. [Deployment](#deployment)

---

## Project Structure

```
my-flask-project/
├── .claude/
│   ├── config.json
│   ├── skills/
│   │   ├── flask-blueprint/
│   │   │   └── SKILL.md
│   │   ├── flask-model/
│   │   │   └── SKILL.md
│   │   ├── flask-form/
│   │   │   └── SKILL.md
│   │   ├── flask-api/
│   │   │   └── SKILL.md
│   │   └── flask-test/
│   │       └── SKILL.md
│   └── commands/
│       ├── run.md
│       ├── shell.md
│       ├── test.md
│       └── db.md
├── CLAUDE.md
├── app/
│   ├── __init__.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── base.py
│   ├── forms/
│   │   ├── __init__.py
│   │   └── auth.py
│   ├── blueprints/
│   │   ├── __init__.py
│   │   ├── auth/
│   │   │   ├── __init__.py
│   │   │   ├── routes.py
│   │   │   └── forms.py
│   │   ├── main/
│   │   │   ├── __init__.py
│   │   │   └── routes.py
│   │   └── api/
│   │       ├── __init__.py
│   │       └── v1/
│   │           ├── __init__.py
│   │           └── users.py
│   ├── templates/
│   │   ├── base.html
│   │   ├── auth/
│   │   │   ├── login.html
│   │   │   └── register.html
│   │   └── main/
│   │       └── index.html
│   ├── static/
│   │   ├── css/
│   │   ├── js/
│   │   └── images/
│   └── utils/
│       ├── __init__.py
│       └── decorators.py
├── migrations/
│   └── versions/
├── tests/
│   ├── conftest.py
│   ├── test_models.py
│   ├── test_auth.py
│   └── test_api.py
├── config.py
├── requirements/
│   ├── base.txt
│   ├── dev.txt
│   └── prod.txt
├── .env.example
├── .flaskenv
└── wsgi.py
```

---

## CLAUDE.md Configuration

**File**: `CLAUDE.md`

```markdown
# Flask Project - Claude Code Configuration

## Project Overview

Modular Flask web application with:
- Flask 3.0+
- SQLAlchemy 2.0 for ORM
- Flask-Migrate (Alembic) for migrations
- Flask-WTF for forms
- Flask-Login for authentication
- pytest for testing

## Development Guidelines

### Flask Conventions

1. **Blueprints**: Feature-based organization in `app/blueprints/`
   - auth: Authentication and user management
   - main: Core application routes
   - api: RESTful API endpoints

2. **Models**: In `app/models/` with one file per model
   - Use SQLAlchemy declarative style
   - Always include timestamps (created_at, updated_at)
   - Add __repr__ methods for debugging

3. **Forms**: In `app/forms/` using Flask-WTF
   - One file per blueprint
   - Include CSRF protection
   - Custom validators where needed

4. **Templates**: Jinja2 templates in `app/templates/`
   - Use template inheritance (base.html)
   - Blueprint-specific subdirectories
   - Include macros for reusable components

### Code Style

- Follow PEP 8
- Use type hints for function signatures
- Factory pattern for app creation (`create_app()`)
- Environment-based configuration (dev, test, prod)
- Maximum line length: 100 characters

### Database

- Always review migrations before applying
- Use transactions for multi-step operations
- Avoid N+1 queries (use joinedload/selectinload)
- Add indexes for frequently queried fields

### Security

- Never commit SECRET_KEY or database credentials
- Use environment variables for all secrets
- Enable CSRF protection (Flask-WTF)
- Validate all user input
- Use password hashing (bcrypt via Flask-Bcrypt)

## Available Skills

- `/flask-blueprint`: Create new blueprint with routes and templates
- `/flask-model`: Generate SQLAlchemy model with fields
- `/flask-form`: Create Flask-WTF form with validation
- `/flask-api`: Build RESTful API endpoint
- `/flask-test`: Generate comprehensive tests

## Available Commands

- `/run`: Start development server
- `/shell`: Open Flask shell for debugging
- `/test`: Run test suite with coverage
- `/db`: Database operations (migrate, upgrade, downgrade)

## Cost Optimization

- Use Haiku for simple routes and forms
- Use Sonnet for complex business logic and API endpoints
- Batch related operations (create model + form + routes together)

## Common Patterns

### Creating a Model

\```python
from app.models.base import BaseModel
from app import db

class Product(BaseModel):
    __tablename__ = 'products'

    name = db.Column(db.String(200), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    description = db.Column(db.Text)

    def __repr__(self):
        return f'<Product {self.name}>'
\```

### Creating a Form

\```python
from flask_wtf import FlaskForm
from wtforms import StringField, DecimalField, TextAreaField
from wtforms.validators import DataRequired, NumberRange

class ProductForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    price = DecimalField('Price', validators=[
        DataRequired(),
        NumberRange(min=0)
    ])
    description = TextAreaField('Description')
\```

### Creating a Route

\```python
@bp.route('/products', methods=['GET', 'POST'])
def products():
    form = ProductForm()
    if form.validate_on_submit():
        product = Product(
            name=form.name.data,
            price=form.price.data,
            description=form.description.data
        )
        db.session.add(product)
        db.session.commit()
        flash('Product created!', 'success')
        return redirect(url_for('main.products'))

    products = Product.query.order_by(Product.created_at.desc()).all()
    return render_template('main/products.html', form=form, products=products)
\```

## Troubleshooting

- **Import errors**: Check blueprint registration in `__init__.py`
- **Migration conflicts**: Delete migration and recreate
- **Template not found**: Verify blueprint template_folder setting
- **Form validation fails**: Check CSRF token in template
```

---

## Custom Skills

### Skill 1: Flask Blueprint Generator

**File**: `.claude/skills/flask-blueprint/SKILL.md`

```yaml
---
name: flask-blueprint
description: Create Flask blueprint with routes, templates, and forms
model: claude-haiku-4-5
invocationPattern: /flask-blueprint
---

# Flask Blueprint Generator

Generate a complete Flask blueprint with routes, templates, and optional forms.

## Usage

\```
/flask-blueprint Create products blueprint with list, detail, create, and edit routes
\```

## What I'll Generate

1. **Blueprint initialization** (`app/blueprints/[name]/__init__.py`)
2. **Routes file** (`routes.py`) with CRUD operations
3. **Templates** (list, detail, form) with Jinja2
4. **Forms** (if needed) with Flask-WTF validation

## Example Output

**Blueprint Init** (`app/blueprints/products/__init__.py`):

\```python
from flask import Blueprint

bp = Blueprint(
    'products',
    __name__,
    url_prefix='/products',
    template_folder='templates'
)

from app.blueprints.products import routes
\```

**Routes** (`app/blueprints/products/routes.py`):

\```python
from flask import render_template, request, redirect, url_for, flash, abort
from app.blueprints.products import bp
from app.models.product import Product
from app.forms.product import ProductForm
from app import db

@bp.route('/')
def list():
    """List all products."""
    page = request.args.get('page', 1, type=int)
    products = Product.query.order_by(
        Product.created_at.desc()
    ).paginate(page=page, per_page=20)
    return render_template('products/list.html', products=products)

@bp.route('/<int:id>')
def detail(id):
    """Show product detail."""
    product = Product.query.get_or_404(id)
    return render_template('products/detail.html', product=product)

@bp.route('/create', methods=['GET', 'POST'])
def create():
    """Create new product."""
    form = ProductForm()
    if form.validate_on_submit():
        product = Product(
            name=form.name.data,
            price=form.price.data,
            description=form.description.data
        )
        db.session.add(product)
        db.session.commit()
        flash(f'Product "{product.name}" created successfully!', 'success')
        return redirect(url_for('products.detail', id=product.id))

    return render_template('products/form.html', form=form, title='Create Product')

@bp.route('/<int:id>/edit', methods=['GET', 'POST'])
def edit(id):
    """Edit existing product."""
    product = Product.query.get_or_404(id)
    form = ProductForm(obj=product)

    if form.validate_on_submit():
        form.populate_obj(product)
        db.session.commit()
        flash(f'Product "{product.name}" updated successfully!', 'success')
        return redirect(url_for('products.detail', id=product.id))

    return render_template('products/form.html', form=form, title='Edit Product', product=product)

@bp.route('/<int:id>/delete', methods=['POST'])
def delete(id):
    """Delete product."""
    product = Product.query.get_or_404(id)
    db.session.delete(product)
    db.session.commit()
    flash(f'Product "{product.name}" deleted.', 'info')
    return redirect(url_for('products.list'))
\```

**Template** (`app/templates/products/list.html`):

\```html
{% extends "base.html" %}

{% block title %}Products{% endblock %}

{% block content %}
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Products</h1>
        <a href="{{ url_for('products.create') }}" class="btn btn-primary">
            Create Product
        </a>
    </div>

    <div class="row">
        {% for product in products.items %}
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">{{ product.name }}</h5>
                    <p class="card-text">${{ product.price }}</p>
                    <a href="{{ url_for('products.detail', id=product.id) }}"
                       class="btn btn-sm btn-outline-primary">
                        View Details
                    </a>
                </div>
            </div>
        </div>
        {% endfor %}
    </div>

    <!-- Pagination -->
    {% if products.has_prev or products.has_next %}
    <nav>
        <ul class="pagination">
            {% if products.has_prev %}
            <li class="page-item">
                <a class="page-link" href="{{ url_for('products.list', page=products.prev_num) }}">
                    Previous
                </a>
            </li>
            {% endif %}
            {% if products.has_next %}
            <li class="page-item">
                <a class="page-link" href="{{ url_for('products.list', page=products.next_num) }}">
                    Next
                </a>
            </li>
            {% endif %}
        </ul>
    </nav>
    {% endif %}
</div>
{% endblock %}
\```

## After Generation

I'll remind you to:
1. Register blueprint in `app/__init__.py`
2. Create corresponding model and form
3. Run database migration if needed
4. Test routes manually

## Cost

- Tokens: ~5,000-7,000
- Cost: ~$0.05-$0.07 (Haiku)
- Time: 5-8 minutes
```

---

### Skill 2: Flask Model Generator

**File**: `.claude/skills/flask-model/SKILL.md`

```yaml
---
name: flask-model
description: Generate SQLAlchemy model with relationships and validation
model: claude-haiku-4-5
---

# Flask Model Generator

Generate SQLAlchemy models with fields, relationships, and validation.

## Usage

\```
/flask-model Create Product model with name, price, description, and category relationship
\```

## Example Output

\```python
from sqlalchemy import event
from app.models.base import BaseModel
from app import db

class Product(BaseModel):
    """Product model."""
    __tablename__ = 'products'

    # Fields
    name = db.Column(db.String(200), nullable=False, index=True)
    slug = db.Column(db.String(200), unique=True, nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    description = db.Column(db.Text)
    is_active = db.Column(db.Boolean, default=True)

    # Relationships
    category_id = db.Column(db.Integer, db.ForeignKey('categories.id'))
    category = db.relationship('Category', backref='products')

    def __repr__(self):
        return f'<Product {self.name}>'

    def to_dict(self):
        """Serialize to dictionary."""
        return {
            'id': self.id,
            'name': self.name,
            'slug': self.slug,
            'price': float(self.price),
            'description': self.description,
            'is_active': self.is_active,
            'category_id': self.category_id,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }

    @staticmethod
    def generate_slug(name):
        """Generate URL-friendly slug from name."""
        import re
        slug = re.sub(r'[^\w\s-]', '', name.lower())
        slug = re.sub(r'[-\s]+', '-', slug)
        return slug

# Auto-generate slug before insert
@event.listens_for(Product, 'before_insert')
def set_slug(mapper, connection, target):
    if not target.slug:
        target.slug = Product.generate_slug(target.name)
\```

**Base Model** (`app/models/base.py`):

\```python
from datetime import datetime
from app import db

class BaseModel(db.Model):
    """Base model with common fields."""
    __abstract__ = True

    id = db.Column(db.Integer, primary_key=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
\```

## Cost
- Tokens: ~3,000-4,000
- Cost: ~$0.03-$0.04 (Haiku)
- Time: 3-5 minutes
```

---

### Skill 3: Flask Form Generator

**File**: `.claude/skills/flask-form/SKILL.md`

```yaml
---
name: flask-form
description: Create Flask-WTF form with validation
model: claude-haiku-4-5
---

# Flask Form Generator

Generate Flask-WTF forms with custom validators.

## Example Output

\```python
from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, DecimalField, TextAreaField, SelectField, BooleanField
from wtforms.validators import DataRequired, Length, NumberRange, Optional, ValidationError
from app.models.product import Product

class ProductForm(FlaskForm):
    """Form for creating/editing products."""

    name = StringField(
        'Product Name',
        validators=[
            DataRequired(),
            Length(min=3, max=200, message='Name must be 3-200 characters')
        ]
    )

    price = DecimalField(
        'Price',
        places=2,
        validators=[
            DataRequired(),
            NumberRange(min=0.01, message='Price must be greater than 0')
        ]
    )

    description = TextAreaField(
        'Description',
        validators=[Optional(), Length(max=2000)]
    )

    category_id = SelectField(
        'Category',
        coerce=int,
        validators=[DataRequired()]
    )

    is_active = BooleanField('Active', default=True)

    image = FileField(
        'Product Image',
        validators=[FileAllowed(['jpg', 'png', 'gif'], 'Images only!')]
    )

    def validate_name(self, field):
        """Check if product name already exists."""
        # Skip if editing existing product
        if hasattr(self, '_obj') and self._obj and self._obj.name == field.data:
            return

        if Product.query.filter_by(name=field.data).first():
            raise ValidationError('Product with this name already exists.')
\```

## Cost
- Tokens: ~2,500-3,500
- Cost: ~$0.02-$0.03 (Haiku)
- Time: 3-4 minutes
```

---

### Skill 4: Flask API Generator

**File**: `.claude/skills/flask-api/SKILL.md`

```yaml
---
name: flask-api
description: Build RESTful API endpoint with JSON responses
model: claude-sonnet-4-5
---

# Flask API Generator

Generate RESTful API endpoints with JSON responses and error handling.

## Example Output

\```python
from flask import jsonify, request
from app.blueprints.api.v1 import bp
from app.models.product import Product
from app import db

@bp.route('/products', methods=['GET'])
def get_products():
    """List all products with pagination."""
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 20, type=int)
    search = request.args.get('search', '')

    query = Product.query.filter_by(is_active=True)

    if search:
        query = query.filter(Product.name.ilike(f'%{search}%'))

    products = query.order_by(
        Product.created_at.desc()
    ).paginate(page=page, per_page=per_page)

    return jsonify({
        'products': [p.to_dict() for p in products.items],
        'total': products.total,
        'page': products.page,
        'pages': products.pages
    })

@bp.route('/products/<int:id>', methods=['GET'])
def get_product(id):
    """Get single product by ID."""
    product = Product.query.get_or_404(id)
    return jsonify(product.to_dict())

@bp.route('/products', methods=['POST'])
def create_product():
    """Create new product."""
    data = request.get_json()

    # Validation
    if not data or 'name' not in data or 'price' not in data:
        return jsonify({'error': 'Missing required fields'}), 400

    try:
        product = Product(
            name=data['name'],
            price=data['price'],
            description=data.get('description'),
            category_id=data.get('category_id')
        )
        db.session.add(product)
        db.session.commit()

        return jsonify(product.to_dict()), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 400

@bp.route('/products/<int:id>', methods=['PUT'])
def update_product(id):
    """Update existing product."""
    product = Product.query.get_or_404(id)
    data = request.get_json()

    try:
        if 'name' in data:
            product.name = data['name']
        if 'price' in data:
            product.price = data['price']
        if 'description' in data:
            product.description = data['description']
        if 'category_id' in data:
            product.category_id = data['category_id']

        db.session.commit()
        return jsonify(product.to_dict())

    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 400

@bp.route('/products/<int:id>', methods=['DELETE'])
def delete_product(id):
    """Delete product."""
    product = Product.query.get_or_404(id)

    try:
        db.session.delete(product)
        db.session.commit()
        return '', 204

    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 400

# Error handlers
@bp.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Resource not found'}), 404

@bp.errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return jsonify({'error': 'Internal server error'}), 500
\```

## Cost
- Tokens: ~6,000-8,000
- Cost: ~$0.12-$0.16 (Sonnet)
- Time: 8-12 minutes
```

---

## Example Workflows

### Workflow 1: Create Complete CRUD Feature

**Goal**: Add Product management with UI and API

**Steps**:

1. **Create Model** (4 min, $0.03):
   ```
   You: "/flask-model Create Product with name, price, description, category relationship"
   ```

2. **Create Form** (3 min, $0.03):
   ```
   You: "/flask-form Create ProductForm for Product model"
   ```

3. **Create Blueprint** (6 min, $0.06):
   ```
   You: "/flask-blueprint Create products blueprint with CRUD routes"
   ```

4. **Create Migration** (2 min, free):
   ```bash
   flask db migrate -m "Add products table"
   flask db upgrade
   ```

5. **Create API** (10 min, $0.14):
   ```
   You: "/flask-api Create REST API for products"
   ```

6. **Write Tests** (8 min, $0.08):
   ```
   You: "/flask-test Create tests for Product model and routes"
   ```

**Total**: 33 minutes, $0.34

---

### Workflow 2: Add Authentication

**Goal**: Implement user login/registration

**Steps**:

1. **Create User Model** (5 min, $0.04):
   ```python
   from flask_login import UserMixin
   from werkzeug.security import generate_password_hash, check_password_hash

   class User(BaseModel, UserMixin):
       email = db.Column(db.String(120), unique=True, nullable=False)
       password_hash = db.Column(db.String(255))

       def set_password(self, password):
           self.password_hash = generate_password_hash(password)

       def check_password(self, password):
           return check_password_hash(self.password_hash, password)
   ```

2. **Create Auth Forms** (4 min, $0.03):
   ```
   You: "/flask-form Create LoginForm and RegisterForm"
   ```

3. **Create Auth Blueprint** (8 min, $0.07):
   ```
   You: "/flask-blueprint Create auth blueprint with login, logout, register"
   ```

4. **Configure Flask-Login** (3 min, manual):
   ```python
   from flask_login import LoginManager

   login_manager = LoginManager()
   login_manager.login_view = 'auth.login'

   @login_manager.user_loader
   def load_user(user_id):
       return User.query.get(int(user_id))
   ```

**Total**: 20 minutes, $0.14

---

## Authentication Patterns

### Complete Auth Blueprint

**app/blueprints/auth/routes.py**:

```python
from flask import render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, current_user, login_required
from werkzeug.urls import url_parse
from app.blueprints.auth import bp
from app.models.user import User
from app.forms.auth import LoginForm, RegisterForm
from app import db

@bp.route('/login', methods=['GET', 'POST'])
def login():
    """User login."""
    if current_user.is_authenticated:
        return redirect(url_for('main.index'))

    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()

        if user is None or not user.check_password(form.password.data):
            flash('Invalid email or password', 'danger')
            return redirect(url_for('auth.login'))

        login_user(user, remember=form.remember_me.data)

        # Redirect to next page or index
        next_page = request.args.get('next')
        if not next_page or url_parse(next_page).netloc != '':
            next_page = url_for('main.index')

        flash(f'Welcome back, {user.email}!', 'success')
        return redirect(next_page)

    return render_template('auth/login.html', form=form)

@bp.route('/register', methods=['GET', 'POST'])
def register():
    """User registration."""
    if current_user.is_authenticated:
        return redirect(url_for('main.index'))

    form = RegisterForm()
    if form.validate_on_submit():
        user = User(email=form.email.data)
        user.set_password(form.password.data)
        db.session.add(user)
        db.session.commit()

        flash('Congratulations, you are now registered!', 'success')
        return redirect(url_for('auth.login'))

    return render_template('auth/register.html', form=form)

@bp.route('/logout')
@login_required
def logout():
    """User logout."""
    logout_user()
    flash('You have been logged out.', 'info')
    return redirect(url_for('main.index'))
```

---

## API Development

### Error Handling Decorator

```python
from functools import wraps
from flask import jsonify

def handle_api_errors(f):
    """Decorator for consistent API error handling."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        try:
            return f(*args, **kwargs)
        except ValidationError as e:
            return jsonify({'error': str(e)}), 400
        except NotFound:
            return jsonify({'error': 'Resource not found'}), 404
        except Exception as e:
            db.session.rollback()
            return jsonify({'error': 'Internal server error'}), 500
    return decorated_function

# Usage
@bp.route('/products', methods=['POST'])
@handle_api_errors
def create_product():
    # ... implementation
```

---

## Testing Setup

**conftest.py**:

```python
import pytest
from app import create_app, db
from app.models.user import User
from app.models.product import Product

@pytest.fixture(scope='session')
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

@pytest.fixture
def auth_client(client, test_user):
    """Authenticated test client."""
    with client:
        client.post('/auth/login', data={
            'email': test_user.email,
            'password': 'password'
        })
        yield client

@pytest.fixture
def test_user(app):
    """Create test user."""
    user = User(email='test@example.com')
    user.set_password('password')
    db.session.add(user)
    db.session.commit()
    return user

@pytest.fixture
def test_product(app):
    """Create test product."""
    product = Product(
        name='Test Product',
        price=19.99,
        description='Test description'
    )
    db.session.add(product)
    db.session.commit()
    return product
```

**test_models.py**:

```python
from app.models.product import Product

def test_product_creation(app):
    """Test creating a product."""
    product = Product(name='Widget', price=9.99)
    db.session.add(product)
    db.session.commit()

    assert product.id is not None
    assert product.name == 'Widget'
    assert float(product.price) == 9.99

def test_product_slug_generation(app):
    """Test automatic slug generation."""
    product = Product(name='Cool Product!', price=9.99)
    db.session.add(product)
    db.session.commit()

    assert product.slug == 'cool-product'
```

**test_api.py**:

```python
import json

def test_get_products(client, test_product):
    """Test GET /api/v1/products."""
    response = client.get('/api/v1/products')
    assert response.status_code == 200

    data = json.loads(response.data)
    assert 'products' in data
    assert len(data['products']) > 0

def test_create_product(client):
    """Test POST /api/v1/products."""
    response = client.post('/api/v1/products', json={
        'name': 'New Product',
        'price': 29.99,
        'description': 'A great product'
    })
    assert response.status_code == 201

    data = json.loads(response.data)
    assert data['name'] == 'New Product'
    assert 'id' in data
```

---

## Cost Analysis

### Monthly Usage Estimates

**Small Flask App** (5-10 blueprints):
- Model generation: 10 × $0.03 = $0.30
- Form generation: 10 × $0.03 = $0.30
- Blueprint generation: 5 × $0.06 = $0.30
- API endpoints: 5 × $0.14 = $0.70
- Bug fixes: 8 × $0.25 = $2.00
- Code reviews: 12 × $0.20 = $2.40
- **Total**: ~$6.00/month

**Medium Flask App** (15-20 blueprints):
- Model generation: 20 × $0.03 = $0.60
- Form generation: 20 × $0.03 = $0.60
- Blueprint generation: 15 × $0.06 = $0.90
- API endpoints: 15 × $0.14 = $2.10
- Bug fixes: 20 × $0.25 = $5.00
- Code reviews: 30 × $0.20 = $6.00
- Refactoring: 3 × $1.00 = $3.00
- **Total**: ~$18.20/month

**Large Flask App** (30+ blueprints):
- Model generation: 40 × $0.03 = $1.20
- Form generation: 40 × $0.03 = $1.20
- Blueprint generation: 30 × $0.06 = $1.80
- API endpoints: 30 × $0.14 = $4.20
- Bug fixes: 40 × $0.25 = $10.00
- Code reviews: 60 × $0.20 = $12.00
- Refactoring: 8 × $1.00 = $8.00
- **Total**: ~$38.40/month

---

## Deployment

### Production Configuration

**config.py**:

```python
import os
from dotenv import load_dotenv

basedir = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(basedir, '.env'))

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
        'sqlite:///' + os.path.join(basedir, 'app.db')
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class DevelopmentConfig(Config):
    DEBUG = True

class ProductionConfig(Config):
    DEBUG = False
    TESTING = False

class TestingConfig(Config):
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'

config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}
```

### Gunicorn Deployment

**wsgi.py**:

```python
from app import create_app

app = create_app('production')

if __name__ == '__main__':
    app.run()
```

**Run with Gunicorn**:

```bash
gunicorn -w 4 -b 0.0.0.0:8000 wsgi:app
```

### Docker Configuration

**Dockerfile**:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements/prod.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Run migrations and start server
CMD flask db upgrade && \
    gunicorn -w 4 -b 0.0.0.0:8000 wsgi:app
```

**docker-compose.yml**:

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    environment:
      - FLASK_ENV=production
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
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
| Create blueprint | `/flask-blueprint [desc]` | $0.06 |
| Create model | `/flask-model [desc]` | $0.03 |
| Create form | `/flask-form [desc]` | $0.03 |
| Create API | `/flask-api [desc]` | $0.14 |
| Create tests | `/flask-test [desc]` | $0.08 |
| Run server | `/run` | Free |
| Run tests | `/test` | Free |
| Database migrate | `/db migrate -m "message"` | Free |

### Development Checklist

- [ ] Models created with relationships
- [ ] Forms created with validation
- [ ] Blueprints registered in `__init__.py`
- [ ] Templates created with inheritance
- [ ] Tests written for routes and models
- [ ] Migrations applied
- [ ] CSRF protection enabled
- [ ] Error handlers defined
- [ ] Environment variables configured

---

## Related Guides

- [Django Template](1-django.md) - Full-featured framework
- [FastAPI Template](2-fastapi.md) - Modern async API
- [Bug Fixing Workflow](../../workflows/2-bug-fixing.md)
- [Testing Guide](../../../12-security/2-testing-quality.md)
- [Security Guide](../../../12-security/1-security-compliance.md)

---

**Last Updated**: 2025-01-15
**Maintained By**: Documentation Team
