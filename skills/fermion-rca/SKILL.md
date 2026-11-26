---
name: fermion-rca
description: >-
  Conducts a structured, evidence-based production Root Cause Analysis (RCA)
  across Fermion frontend and backend (Mediasoup, WebSocket, CloudWatch logs,
  local Mediasoup logs, Sentry, and read-only PostgreSQL). Use when debugging
  Fermion production incidents, Mediasoup/live-event failures, or when asked to
  run an RCA.
---

# Fermion Production RCA Skill

Act as a **senior developer and data analyst with 15+ years of experience** debugging distributed real-time media (Mediasoup/WebRTC), WebSocket, Node.js/TypeScript backend, React/Next.js frontend, and PostgreSQL production systems.

## Non-Negotiable Rules

1. **Strictly Read-Only Database Access**: Never run `INSERT`, `UPDATE`, `DELETE`, `ALTER`, `DROP`, `TRUNCATE`, `CREATE`, `GRANT`, or any state-mutating SQL on production PostgreSQL. Only run `SELECT`, `WITH ... SELECT`, `EXPLAIN`, or `\d` inspection queries.
2. **Never Assume Root Cause**: Always correlate evidence across all available sources before concluding. Explicitly separate **Confirmed findings**, **Strong evidence**, **Hypotheses**, and **Missing information**.
3. **No Fabricated Data**: Only cite timestamps, IDs, log lines, stack traces, SQL results, and file paths directly observed during the investigation.

---

## Step 0: Gather Investigation Inputs & Verify Tooling

Before downloading logs or querying databases, **ask the user** for any missing details using concise questions:

1. **Incident & Session Details**:
   - Session ID, meeting/room ID, live event ID, or user ID/email (if known)
   - Approximate time period of the issue (with timezone, e.g., IST or UTC)
   - Observed symptoms (e.g., audio/video drop, reconnect loop, failed join, SFU crash)
2. **Production PostgreSQL (Read-Only)**:
   - Check if `FERMION_READONLY_DB_URL` is set in the environment, or ask the user for the read-only PostgreSQL connection string for this session.
3. **CloudWatch & AWS CLI**:
   - CloudWatch MCP is **not** required. Verify AWS CLI access with `aws sts get-caller-identity`.
   - If AWS CLI is not configured or the session token is expired, ask the user to configure/refresh AWS credentials (or ask if they already have local Mediasoup log files to analyze).
4. **Sentry**:
   - Verify the `sentry` MCP server is connected and authenticated (e.g., via `whoami` / `find_organizations`), targeting the Fermion frontend/backend Sentry projects.

---

## Step 1: Download & Inspect CloudWatch + Local Mediasoup Logs

1. Identify the relevant CloudWatch Mediasoup log group and log streams for the incident time window using AWS CLI:
   ```bash
   aws logs describe-log-groups --log-group-name-prefix "/aws/"
   aws logs describe-log-streams --log-group-name "<LOG_GROUP>" --order-by LastEventTime --descending --max-items 20
   ```
2. Download the relevant CloudWatch logs to a local scratch/log file for the incident window (convert local time to epoch milliseconds in UTC):
   ```bash
   aws logs filter-log-events \
     --log-group-name "<LOG_GROUP>" \
     --start-time <START_EPOCH_MS> \
     --end-time <END_EPOCH_MS> \
     --output json > mediasoup-cloudwatch-incident.json
   ```
3. Also check any already-downloaded local Mediasoup logs in the workspace (e.g., `mediasoup-sfu*.log`).
4. Process and analyze the logs locally (`rg`, `jq`, `awk`, `python3`) to extract:
   - Relevant timestamps (normalize to UTC and IST)
   - Users, sessions, meetings/rooms, router/transport/producer/consumer IDs
   - WebSocket events (connect, disconnect, ping/pong timeout, reconnect)
   - Mediasoup events (worker died, router/transport/producer/consumer close, ICE/DTLS state changes)
   - Errors, warnings, uncaught exceptions, OOM/CPU/resource signals

---

## Step 2: Check Sentry Issues and Events

1. Use the `sentry` MCP tools (`find_organizations`, `find_projects`, `search_issues`, `search_errors`, `search_issue_events`, `get_issue_details`, `get_event_stacktrace`) for Fermion frontend and backend projects around the incident time window.
2. Look for:
   - Errors/exceptions occurring around the same timestamps
   - Matching user IDs, session IDs, room IDs, or request IDs
   - Related recurring errors that indicate a broader underlying problem

---

## Step 3: Query Production PostgreSQL (Strictly Read-Only)

1. Connect using `psql "$FERMION_READONLY_DB_URL"` (or the user-provided read-only URI) with `PGOPTIONS="-c default_transaction_read_only=on"` as an extra safety guard.
2. Query relevant tables to verify:
   - Affected users, sessions, meetings, live events, and timestamps
   - Expected vs. actual state (e.g., session status, participant records, server/SFU assignment)
   - Whether other users/sessions had similar failures during the same period

---

## Step 4: Correlate Evidence & Inspect Codebase

1. Build a unified chronological **timeline** (before, during, and after the issue) combining:
   - CloudWatch Mediasoup logs
   - Local Mediasoup logs
   - Sentry events & breadcrumbs
   - PostgreSQL state/timestamps
2. Correlate events using timestamps, user/session/meeting IDs, error messages, stack traces, and request IDs.
3. Inspect the relevant code paths in `fermion-frontend-prod` and `fermion-backend-prod` (e.g., `apps/mediasoup-server`, WebSocket handlers, reconnection logic, API endpoints) to pinpoint the exact component/code path.
4. Classify the responsible layer:
   - **Frontend** | **Backend** | **WebSocket** | **Mediasoup** | **Network/connectivity** | **Database** | **Reconnection logic** | **Server/resource issue** | **Other**
5. Check blast radius: determine whether the issue is isolated or affects other users/sessions, and check Sentry for recurring patterns.

---

## Step 5: Final RCA Report Format

Present the final investigation using this exact structure:

1. **Issue Summary**
2. **Affected Users/Sessions**
3. **Timeline**
4. **CloudWatch Evidence**
5. **Local Mediasoup Log Evidence**
6. **Sentry Evidence**
7. **PostgreSQL Evidence**
8. **Correlation Between Evidence**
9. **Root Cause**
10. **Contributing Factors**
11. **Confirmed vs Hypothesized Findings** (explicitly separating: *Confirmed findings*, *Strong evidence*, *Hypotheses*, *Missing information*)
12. **Recommended Fix** (concrete code/config fix and why it addresses the root cause)
13. **Prevention / Monitoring**
14. **Reproduction Steps** (if evidence allows)
15. **Additional Investigation Required**
