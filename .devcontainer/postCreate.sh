#!/usr/bin/env bash
set -euxo pipefail

# Make hardlink warnings go away in container FS
export UV_LINK_MODE=copy

# Ensure uv on PATH (install only if missing)
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# Create venv, sync deps, and install your package editable
uv venv .venv
uv sync --all-extras || true
uv pip install -e .
uv pip install pytest ruff black

# Quick sanity test (don’t fail the whole script if tests red)
uv run python -m pytest -q || true
