# Skills Catalog

Short, crisp reference for every skill in this repository: what it does, when it triggers, and how to use it in chat.

---

## 1. `fermion-rca`
* **What it does:** Conducts an evidence-based production Root Cause Analysis across Fermion frontend & backend using CloudWatch Mediasoup logs (AWS CLI), local SFU logs, Sentry events, and read-only PostgreSQL.
* **When to use:** Production incidents, live-event drops, SFU crashes, or WebRTC reconnect failures.
* **Chat prompt:**
  > `"Use fermion-rca to debug session <SESSION_ID> around <TIME_WINDOW>."`
* **Setup:** Set `export FERMION_READONLY_DB_URL="..."` in `~/.zshrc` (or paste it directly in chat when asked). Requires AWS CLI and Sentry MCP.

---

## 2. `pr-walkthrough`
* **What it does:** Teaches AI-written changes back to the dev through a 3-step conversation (**Problem -> Cause -> Fix**) before raising a PR. Ensures the dev understands the change and generates a clean PR description focused on logic (no blast radius/risks clutter).
* **When to use:** When the agent finishes a feature, refactor, or fix.
* **Chat prompt:**
  > `"Use pr-walkthrough before opening the PR."` (Or simply say `"skip"` when offered to jump directly to the PR draft).

---

## 3. `verification-before-completion`
* **What it does:** The Iron Law: forbids the agent from claiming a bug is fixed or tests pass without executing the fresh test/build command and verifying an `exit 0`. Prevents untested claims.
* **When to use:** Automatic before PRs/commits, or when finalizing any code change.
* **Chat prompt:**
  > `"Verify all tests and builds pass before claiming done."`

---

## 4. `brainstorm`
* **What it does:** Forces the agent to align with you on the problem, root cause, and proposed fix in 1–2 quick questions *before* touching code.
* **When to use:** Non-trivial features or bug fixes where you want to agree on the approach first.
* **Chat prompt:**
  > `"Let's brainstorm this fix before writing any code."` (Say `"just fix it"` to bypass).

---

## 5. `build-with-me`
* **What it does:** Interactive pair-programming mentor. Makes only one approved file edit at a time, explaining each step and waiting for your approval.
* **When to use:** Learning a new codebase area or building sensitive components step-by-step.
* **Chat prompt:**
  > `"/build-with-me let's implement the stream volume controls"`

---

## 6. `debug-bug`
* **What it does:** A structured scientific debugging loop for tough bugs. Focuses on building a reproducible feedback loop and testing hypotheses before editing code.
* **When to use:** Intermittent bugs, tricky exceptions, or performance regressions.
* **Chat prompt:**
  > `"Debug the bug: why does the consumer disconnect on room join?"`

---

## 7. `spec-driven-implementation`
* **What it does:** Drives a spec-first workflow by drafting `PRODUCT.md` and `TECH.md` before implementation, keeping documentation in sync with code.
* **When to use:** Large or architecture-heavy features.
* **Chat prompt:**
  > `"Use spec-driven-implementation to plan the interactive whiteboard feature."`

---

## 8. `feature-audit`
* **What it does:** Audits already-merged or legacy code against business requirements and edge cases using code inspection and real evidence.
* **When to use:** Reviewing inherited code or verifying whether a shipped feature is completely sound.
* **Chat prompt:**
  > `"Run a feature-audit on the live-event sales data API."`

---

## 9. `skill-gap-discovery`
* **What it does:** Identifies when you repeatedly hit a complex domain that lacks a dedicated skill (e.g. AWS CDK, Kubernetes, Playwright, Tailwind). It spots the recurring gap and recommends installable skills to handle it reliably.
* **When to use:** When you notice the agent repeatedly having to solve the same external tool or framework problems from scratch.
* **Chat prompt:**
  > `"Use skill-gap-discovery to check what skills we might be missing for our workflow."`

---

## 10. `find-skills`
* **What it does:** Discovers and searches installable agent skills from the open ecosystem when you want new capabilities or automated workflows.
* **When to use:** Whenever you ask *"How do I do X with an agent skill?"* or *"Find a skill for X"*.
* **Chat prompt:**
  > `"Find a skill for Docker deployment automation."` or `"Is there an agent skill for GraphQL schema testing?"`
