---
name: pr-walkthrough
description: Use after finishing a code implementation headed for a PR (bug fix, feature, refactor) when the dev did not write most of the code. Offer a concise interactive walkthrough of Problem, Cause, and Fix so the dev understands the change before opening or updating a PR. Always ask first; skip if trivial or if the dev declines.
---

# PR Walkthrough & Learning

## Purpose

A dev should never raise a PR they cannot explain. When the agent writes the code, this skill helps the dev quickly grasp the changes through an interactive 3-step conversation: **Problem -> Cause -> Fix**.

Keep it practical, focused, and conversational.

## When to Offer

Offer when the code implementation is finished and a PR / commit is the next step.

**Do NOT offer when:**
- The change is trivial (typos, formatting, version bumps, small config tweaks).
- The dev already directed/wrote most of the code and clearly understands it.
- The dev already declined in this session.
- Follow-up commits to an existing PR are minor adjustments.

## How to Offer

Ask once in 1–2 lines:
> "The implementation is ready. Would you like a quick walkthrough (Problem, Cause, Fix) before we commit and raise the PR? (You can say 'skip' to proceed directly)."

If the dev says **"skip"**, **"no"**, or asks to commit directly, proceed immediately without asking any learning questions.

## Ground Rules

- **Read the real diff first** (`git diff`, `git log`) before explaining.
- **One stage per turn:** Keep explanations concise, followed by one simple question.
- **Respect skips:** If the dev wants to skip to the next step, do so immediately.

---

## The 3 Stages

### Stage 1: The Problem
- Explain what issue or limitation existed in plain terms.
- Ask the dev to briefly state the problem or how they would summarize it to a reviewer.

### Stage 2: The Cause
- Point to the specific file and line where the issue originated (or the missing logic).
- Ask a quick check question about why this triggered the problem.

### Stage 3: The Fix & Code Changes
- Summarize the fix approach.
- Walk through the key modified files and functions with concise diff references.

---

## PR & Commit Structure

When drafting the commit message and PR description (whether after completing the walkthrough or when skipped), use this clean format:

### Commit Message Format
```text
<type>: <short summary without conventional scopes>

- Problem: <one-line summary>
- Cause: <file/function where the issue was>
- Fix: <one-line summary of what changed>
```
*Example:* `fix: Mediasoup transport reconnect failure` or `feat: add live stream optimization controls`

### PR Description Format
```markdown
## Problem
<Plain explanation of the issue or feature requirement>

## Cause
<Specific file and line or missing piece that caused the issue>

## Fix & Code Changes
- **`<file-path>`**: <Concise explanation of changes made>
- **`<file-path>`**: <Concise explanation of changes made>
```
*(No Blast Radius, Risks, Testing matrices, or Open Questions sections needed unless specifically requested).*
