FROM python:3.13.7-slim

# Install system packages and Node.js
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    libpq-dev \
    curl \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm \
    && rm -rf /var/lib/apt/lists/*

# Build and install gettext 0.26 (matches local Mac version)
RUN curl -fsSL https://ftp.gnu.org/pub/gnu/gettext/gettext-0.26.tar.gz -o gettext.tar.gz \
    && tar xzf gettext.tar.gz \
    && cd gettext-0.26 \
    && ./configure --prefix=/usr/local --disable-java --disable-csharp \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && cd .. && rm -rf gettext-0.26 gettext.tar.gz

# Install uv package manager
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Environment setup for optimal Python and uv performance
ENV PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_CACHE_DIR=/root/.cache/uv

# Set working directory
WORKDIR /app

# Default command
CMD ["/bin/bash"]