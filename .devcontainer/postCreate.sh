#!/usr/bin/env bash
set -euo pipefail
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

uv venv .venv
uv sync --all-extras

uv run ruff --version
uv run black --version
uv run pytest -q || true
