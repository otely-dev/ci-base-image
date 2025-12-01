# CI Base Image

A lightweight base image for Django CI/CD workflows with Python, Node.js, and common development tools.

## Included Tools

- **Python 3.13.7** - Latest stable Python
- **Node.js 22.x** - LTS version with npm
- **pnpm** - Fast Node.js package manager  
- **uv** - Ultra-fast Python package manager
- **gettext** - Translation tools for Django
- **Git** - Version control
- **Build tools** - gcc, make, libpq-dev for Python package compilation

## Usage

```yaml
# In GitHub Actions
container:
  image: ghcr.io/otely-dev/ci-base-image:latest

steps:
  - uses: actions/checkout@v5
  - run: uv sync --frozen --all-extras --dev
  - run: pytest
```

## Size

Approximately ~500MB (much smaller than project-specific images with dependencies)

## Updates

This image is updated monthly or when major tool versions change, not on every project dependency update.