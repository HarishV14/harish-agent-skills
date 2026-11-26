# harish-agent-skills

Personal shared skills repository for **Antigravity**, **Codex**, and **OpenCode** across all machines.

## Repository Structure

```text
harish-agent-skills/
├── install.sh              # Symlinks all skills into Antigravity, Codex, OpenCode, and ~/.agents/skills
├── README.md               # Setup & usage guide
└── skills/
    └── fermion-rca/
        └── SKILL.md        # Fermion production RCA workflow (CloudWatch, Mediasoup, Sentry, Read-Only Postgres)
```

---

## 1. First-Time Push to GitHub (Current Machine)

1. Create a **private** repository named `harish-agent-skills` on GitHub (`https://github.com/HarishV14`).
2. Push this local repo:
   ```bash
   cd ~/harish-agent-skills
   git add .
   git commit -m "Add fermion-rca skill and cross-agent installer"
   git branch -M main
   git remote add origin git@github.com:HarishV14/harish-agent-skills.git
   git push -u origin main
   ```

---

## 2. Setup on Any New Computer

1. **Clone and install symlinks:**
   ```bash
   git clone git@github.com:HarishV14/harish-agent-skills.git ~/harish-agent-skills
   cd ~/harish-agent-skills
   chmod +x install.sh
   ./install.sh
   ```
   This links every skill in `skills/` to:
   - `~/.gemini/config/skills/` (Antigravity)
   - `~/.codex/skills/` (Codex)
   - `~/.config/opencode/skills/` (OpenCode)
   - `~/.agents/skills/` (shared standard)

2. **Set the read-only PostgreSQL URL locally** (add to `~/.zshrc` or `~/.bashrc` — never commit secrets to Git):
   ```bash
   export FERMION_READONLY_DB_URL="postgres://readonly_user:<PASSWORD>@fermion-production-instance-1.c3sqyua6ifsz.ap-south-1.rds.amazonaws.com:5432/postgres"
   ```
   Then reload your shell: `source ~/.zshrc`.

3. **Verify prerequisites on the machine:**
   - **AWS CLI** configured (`aws sts get-caller-identity`) for CloudWatch Mediasoup logs.
   - **Sentry MCP** configured in your agent's MCP settings for Fermion frontend/backend Sentry issues.
   - **`psql`** installed (`brew install libpq`) for read-only PostgreSQL queries.

---

## 3. Updating Skills Across Machines

Because `install.sh` creates symlinks:
- **Editing an existing skill:** Just run `git pull` inside `~/harish-agent-skills` — all 3 agents see the update immediately.
- **Adding a new skill:** Run `git pull && ./install.sh` to create symlinks for the new skill folder.

---

## 4. How to Use This Skill in Agent Chat

You can trigger `fermion-rca` in **Antigravity**, **Codex**, or **OpenCode** from any Fermion workspace (`fermion/`, `fermion-frontend-prod/`, or `fermion-backend-prod/`):

- **Natural prompt (works in all 3):**
  > `Use the fermion-rca skill to debug session <SESSION_ID> around <TIME_WINDOW>.`
- **Codex explicit mention:**
  > `$fermion-rca debug live event <EVENT_ID> failure at 14:30 IST`
- **Antigravity / OpenCode:**
  Simply mention `fermion-rca` or ask to run a Fermion production RCA — the agent automatically loads `SKILL.md` and asks for any missing session/DB/CloudWatch details before starting.
