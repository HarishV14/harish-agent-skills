#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Symlink Skills
SKILL_TARGETS=(
  "$HOME/.gemini/config/skills"     # Antigravity (global)
  "$HOME/.codex/skills"             # Codex (global)
  "$HOME/.config/opencode/skills"   # OpenCode (global)
  "$HOME/.agents/skills"            # Shared ~/.agents/skills standard
)

for target in "${SKILL_TARGETS[@]}"; do
  mkdir -p "$target"
  for skill_dir in "$REPO_DIR"/skills/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    ln -sfn "${skill_dir%/}" "$target/$skill_name"
    echo "Linked skill: $skill_name -> $target/$skill_name"
  done
done

# 2. Symlink Standing Rules (AGENTS.md)
if [ -f "$REPO_DIR/AGENTS.md" ]; then
  echo ""
  echo "Linking AGENTS.md rules..."

  # Antigravity global config
  mkdir -p "$HOME/.gemini/config"
  ln -sfn "$REPO_DIR/AGENTS.md" "$HOME/.gemini/config/AGENTS.md"
  echo "Linked rule: AGENTS.md -> $HOME/.gemini/config/AGENTS.md"

  # Codex rules
  mkdir -p "$HOME/.codex/rules"
  ln -sfn "$REPO_DIR/AGENTS.md" "$HOME/.codex/rules/AGENTS.md"
  echo "Linked rule: AGENTS.md -> $HOME/.codex/rules/AGENTS.md"

  # OpenCode global config
  mkdir -p "$HOME/.config/opencode"
  ln -sfn "$REPO_DIR/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
  echo "Linked rule: AGENTS.md -> $HOME/.config/opencode/AGENTS.md"
fi

echo ""
echo "Done! All skills and AGENTS.md are now configured for Antigravity, Codex, and OpenCode."
