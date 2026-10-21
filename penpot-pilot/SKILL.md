---
name: penpot-pilot
description: Fully automate the Penpot MCP connection. Opens the Penpot file in a persistent logged-in browser via Playwright, clicks File → MCP Server → Connect, verifies the connection, does the design work, and auto-reconnects on disconnect. Zero manual Penpot UI steps per session after a one-time login. Use whenever the user asks to work on a Penpot design.
license: MIT
metadata:
  opencode/slash: "true"
---

# Penpot Pilot — automatic Penpot MCP connection

You are the pilot. The user names a Penpot file; you handle EVERYTHING — browser, login check, Connect click, verification, and the design work. The user never touches Penpot's UI after the one-time setup.

## One-time setup (do once, then never again)

1. Via Playwright MCP, navigate to `https://design.penpot.app`.
2. If a login page appears: tell the user a browser window has opened on their machine and ask them to log in to Penpot there directly. Then poll/navigate again until login succeeds.
3. The persistent browser profile remembers the login forever. Never ask for login again unless it actually expired (then redo this step once and say so).

## Per-task flow (every time the user says "work on this Penpot design")

### 1. Get the file
- User gave a file URL or name → use it.
- Not given → ask exactly one question: "Kaunsi Penpot file? (URL ya naam de do)"

### 2. Open + Connect (automatic — your job, not the user's)
1. `browser_navigate` to the file URL (or open it from the Penpot dashboard).
2. Wait for the design UI to fully load.
3. Snapshot → click the **File** menu → click **MCP Server** → click **Connect**.
4. Element not found → wait 3s, retry once → still missing → screenshot and report exactly what's visible. Never guess-click.

### 3. Verify (mandatory, no skipping)
- Call a Penpot MCP **read-only** tool (e.g., list pages in the file).
- Success → proceed to work. Failure → repeat step 2 once → still failing → report honestly.

### 4. Do the work
- **Read-only first:** inspect, list, analyze before touching anything.
- **Describe write operations BEFORE applying them.** Small, reversible steps — never "refactor everything" in one go.
- The agent CAN edit designs through this MCP — treat every write as consequential.

### 5. Auto-reconnect (during the session)
- If any Penpot MCP call fails with a disconnect/no-plugin error → automatically repeat steps 2–3 (max 2 retries), then continue.
- Keep the Penpot tab as the **active tab** in the Playwright browser while doing Penpot work.
- Never ask the user to click Connect, refresh the tab, or "check Penpot". Reconnecting is your job.

## Rules
- The user's MCP key/token stays in THEIR local config. Never print it, never write it into any file you create, never ask for it.
- Never invent file URLs. Ask when unsure.
- If the session's work is done, you may close the browser. The next task re-runs steps 1–3 automatically.
- Report honestly: "connected" only after step 3 succeeds. No fake success.
