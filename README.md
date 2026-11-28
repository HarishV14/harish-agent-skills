# harish-agent-skills

Personal shared AI agent skills repository for **Antigravity**, **Codex**, and **OpenCode** across all machines.

This repository centrally maintains your custom workflows and engineering standards. With a single install script, all skills are symlinked so that any `git pull` instantly updates all three AI tools.

---

## Repository Structure

```text
harish-agent-skills/
├── install.sh                          # Symlinks all skills into Antigravity, Codex, OpenCode, and ~/.agents/skills
├── README.md                           # Setup, sync, and core usage guide
├── SKILLS.md                           # Crisp guide for each skill (what it does, triggers, examples)
└── skills/
    ├── fermion-rca/                    # Fermion production RCA workflow (CW, SFU, Sentry, DB)
    ├── pr-walkthrough/                 # Interactive PR learning (Problem -> Cause -> Fix)
    ├── verification-before-completion/ # Proof before claiming fixed/passing
    ├── brainstorm/                     # Align on problem & solution before writing code
    ├── build-with-me/                  # Interactive 1-step-at-a-time pair programmer
    ├── debug-bug/                      # Systematic debugging loop for hard bugs & regressions
    ├── spec-driven-implementation/     # Spec-first workflow (PRODUCT.md / TECH.md)
    └── feature-audit/                  # Audit existing/merged features against requirements
```

---

## 1. Setup on Any Computer

Clone the repository and run `install.sh` once:

```bash
git clone git@github.com:HarishV14/harish-agent-skills.git ~/harish-agent-skills
cd ~/harish-agent-skills
chmod +x install.sh
./install.sh
```

This symlinks every skill directory in `skills/` directly to:
- `~/.gemini/config/skills/` (Antigravity)
- `~/.codex/skills/` (Codex)
- `~/.config/opencode/skills/` (OpenCode)
- `~/.agents/skills/` (Standard shared agents directory)

---

## 2. Syncing & Updating Across Machines

Because `install.sh` uses **symlinks** instead of copying files:

- **When you update an existing skill:**
  ```bash
  cd ~/harish-agent-skills && git pull
  ```
  *(All tools see the update immediately. No need to re-run `install.sh`.)*

- **When you add a brand-new skill:**
  ```bash
  cd ~/harish-agent-skills && git pull && ./install.sh
  ```
  *(Creates symlinks for the new skill directory.)*

---

## 3. How to Use Skills in Agent Chat

You can invoke skills in any of the three agents:
- **Antigravity / OpenCode:** Mention the skill name or describe the task (e.g., `Use the <skill-name> skill to...`).
- **Codex:** Mention `$<skill-name>` or describe the task (e.g., `$<skill-name> ...`).

---

## 4. Skills Catalog

For a concise summary of what each skill does, when it triggers, and chat command examples, see:

👉 **[SKILLS.md](./SKILLS.md)** (Full catalog of all skills, including `fermion-rca`, `pr-walkthrough`, `verification-before-completion`, and more).
