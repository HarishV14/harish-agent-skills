#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TARGETS=(
  "$HOME/.gemini/config/skills"     # Antigravity (global)
  "$HOME/.codex/skills"             # Codex (global)
  "$HOME/.config/opencode/skills"   # OpenCode (global)
  "$HOME/.agents/skills"            # Shared ~/.agents/skills standard
)

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  for skill_dir in "$REPO_DIR"/skills/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    ln -sfn "${skill_dir%/}" "$target/$skill_name"
    echo "Linked $skill_name -> $target/$skill_name"
  done
done

echo ""
echo "Done! All skills in $REPO_DIR/skills are now linked for Antigravity, Codex, and OpenCode."
