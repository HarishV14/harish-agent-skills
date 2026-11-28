# harish-agent-skills

Personal shared skills repository for **Antigravity**, **Codex**, and **OpenCode** across all machines.

## Repository Structure

```text
harish-agent-skills/
├── install.sh                          # Symlinks all skills into Antigravity, Codex, OpenCode, and ~/.agents/skills
├── README.md                           # Generic setup, sync, and skill-specific docs
└── skills/
    ├── fermion-rca/                    # Fermion production RCA workflow (CW, SFU, Sentry, DB)
    ├── pr-walkthrough/                 # Interactive PR learning (Problem -> Cause -> Fix)
    ├── verification-before-completion/ # Proof before claiming fixed/passing
    ├── brainstorm/                     # Align on problem & solution before writing code
    ├── build-with-me/                  # Interactive 1-step-at-a-time pair programmer
    ├── debug-bug/                      # Scientific debugging loop for hard bugs & regressions
    ├── spec-driven-implementation/     # Spec-first workflow (PRODUCT.md / TECH.md)
    └── feature-audit/                  # Audit existing/merged features against requirements
```

---

## 1. Setup on Any Computer

Clone the repo and run `install.sh` once:

```bash
git clone git@github.com:HarishV14/harish-agent-skills.git ~/harish-agent-skills
cd ~/harish-agent-skills
chmod +x install.sh
./install.sh
```

This symlinks every folder in `skills/` to:
- `~/.gemini/config/skills/` (Antigravity)
- `~/.codex/skills/` (Codex)
- `~/.config/opencode/skills/` (OpenCode)
- `~/.agents/skills/` (shared standard)

---

## 2. Updating & Syncing Skills Across Machines

Because `install.sh` uses **symlinks** (not copies), syncing is simple:

### Case A: You updated an existing skill
1. **On the machine where you made the edit:**
   ```bash
   cd ~/harish-agent-skills
   git add . && git commit -m "Update <skill-name>" && git push
   ```
2. **On your other computers:**
   ```bash
   cd ~/harish-agent-skills && git pull
   ```
   No need to re-run `./install.sh` — the symlinks already point to the updated files.

### Case B: You added a brand-new skill (e.g., `commit`, `pr`)
1. **On the machine where you added the skill:**
   ```bash
   cd ~/harish-agent-skills
   ./install.sh
   git add . && git commit -m "Add <skill-name> skill" && git push
   ```
2. **On your other computers:**
   ```bash
   cd ~/harish-agent-skills && git pull && ./install.sh
   ```
   Running `./install.sh` creates symlinks for the new skill folder in Antigravity, Codex, and OpenCode.

> **Note:** If you already have an agent chat/CLI open when you pull or add a skill, start a new chat/session so the agent picks up the new or updated skill.

---

## 3. How to Use Skills in Agent Chat

- **Antigravity / OpenCode:** Mention the skill name or describe the matching task, e.g.:
  > `Use the <skill-name> skill to ...`
- **Codex:** Mention `$<skill-name>` or describe the task:
  > `$<skill-name> ...`

---

## 4. Skill-Specific Setup

### `fermion-rca` (Fermion Production RCA)

Conducts a structured, evidence-based RCA across Fermion frontend & backend using CloudWatch Mediasoup logs, local Mediasoup logs, Sentry, and read-only PostgreSQL.

- **Database URL (two options — never commit secrets to Git):**
  1. **Environment variable (recommended):** Add to `~/.zshrc` or `~/.bashrc` and run `source ~/.zshrc`:
     ```bash
     export FERMION_READONLY_DB_URL="postgres://readonly_user:<PASSWORD>@fermion-production-instance-1.c3sqyua6ifsz.ap-south-1.rds.amazonaws.com:5432/postgres"
     ```
  2. **Directly in chat:** If `FERMION_READONLY_DB_URL` is not set, the agent will ask for it in chat — you can paste the read-only URL directly there for that session.
- **Prerequisites:**
  - **AWS CLI** configured (`aws sts get-caller-identity`) for CloudWatch Mediasoup logs
  - **Sentry MCP** configured in your agent's MCP settings for Fermion frontend/backend Sentry issues
  - **`psql`** installed (`brew install libpq`) for read-only PostgreSQL queries
- **Example prompt:**
  > `Use the fermion-rca skill to debug session <SESSION_ID> around <TIME_WINDOW>.`
