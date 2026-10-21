---
name: eng-team
description: Turn one agent into a small engineering team. A Senior Manager breaks the problem down and owns verification, fresh Engineer subagents implement one task each coordinating only through shared files, and a fresh Reviewer audits with no baggage from the first attempt. Use for hard bugs, refactors, and multi-file features where single-pass attempts stall or miss things.
license: MIT
metadata:
  opencode/slash: "true"
---

# eng-team — the small engineering team harness

One agent trying everything in one context accumulates baggage: failed attempts pollute reasoning, and the author can't see their own blind spots. This skill replaces that with a team: **fresh contexts per role, one shared file ledger, and running the code as the only ground truth.** (Pattern credit: the GVS5H harness idea — a manager breaking problems down, fresh workers coordinating through shared files, fresh reviewers catching what the first attempt missed.)

## When to use

- Hard bugs, refactors, multi-file features — anywhere a single pass stalls, loops, or ships subtle bugs.
- NOT for trivial work (one-liners, simple lookups, single-file edits you can see fully). The harness costs tokens; use it when you're stuck or when quality matters more than speed.

## Roles

1. **Senior Manager** — that's YOU, the main agent. You own the ledger, break the problem into tasks, spawn every other role as a fresh subagent, and RUN verification yourself. You never write implementation code. Your job is judgment, not typing.
2. **Architect** (fresh subagent; skip for well-understood tasks) — reads the problem cold and proposes 3+ genuinely distinct approaches (different algorithms or designs, not variations), each with pitfalls. No code.
3. **Engineer** (one fresh subagent PER TASK) — implements exactly ONE task. Receives: the task text, the ledger paths it may read/write, and the done-criteria. Nothing else — no prior attempts, no discussion history, no baggage.
4. **Reviewer** (fresh subagent — NEVER the Engineer who wrote the code) — reads the diff cold, hunts the bugs and missed edge cases the author couldn't see. Gets the task text + the diff + test files only.

Subagents NEVER talk to each other. The ledger files are the only coordination channel.

## The ledger

All state lives in `.eng-team/<slug>/`:

- `plan.md` — manager's strategy (3–6 sentences) + the task list. Written once, updated rarely.
- `tasks.json` — max 12 tasks. Each: `id`, `title`, `status` (todo/doing/done), `attempts`, `approach`.
- `notes.md` — hard cap 800 words. Findings only; PRUNE anything superseded — a bloated ledger is just baggage in another form.
- `solution.*` — the artifact being built (code, config, doc).
- `verify.log` — the manager's own verification runs, appended not overwritten.

## The loop

1. **PLAN** — manager writes `plan.md` + `tasks.json`: 3–6 concrete, verifiable tasks. Solves nothing yet.
2. **IDEATE** (skip if the approach is obvious) — architect proposes 3+ distinct approaches; manager picks one per task and records it in `tasks.json`.
3. **WORK** — spawn ONE fresh Engineer per task. Parallelize ONLY if tasks touch independent files (shared files = merge conflicts = serialize). Engineer implements, updates `solution.*`, rewrites `notes.md` (pruned).
4. **FRESH REVIEW** — spawn a Reviewer who never saw the implementation. Reviewer returns: bugs found, edge cases missed, verdict (ship / fix-list).
5. **VERIFY** — the MANAGER runs the code, tests, or build itself and appends to `verify.log`. A worker claiming "done" means nothing; a green verification overrides every claim. For app/UI work, verify real behavior (device, screenshot, or interaction) — never declare done from code inspection alone.
6. **MANAGE** — all green → done. Otherwise pick the next highest-value task: fix-list items first, then remaining tasks. Return to WORK.

## Anti-stuck guards (non-negotiable)

- **2 failed attempts** on one approach → switch to a different approach. Never polish a dead idea.
- **Same task reissued twice in a row** → STOP and surface to the user. No infinite loops, no burned quota.
- **Caps:** 10 loop iterations, 12 live tasks, `notes.md` ≤ 800 words.
- **Done** = non-empty artifact + green `verify.log`. No exceptions. A failed verify beats ten confident "it works".

## Briefing fresh subagents (token discipline)

Each subagent gets a SHORT brief: its role, its single task, the ledger paths, the done-criteria. Never paste conversation history or prior attempts — that is exactly the baggage this harness exists to destroy. Small briefs, fresh eyes, better code.

## Adapting the team

- **Solo / small model:** skip Architect — the manager ideates inline (still write down 3+ approaches before picking).
- **Engineer staffing:** the Engineer can be any code-writing agent your setup uses — a subagent, a teammate model, or your own code-writer workflow. The harness doesn't care who types; it cares that contexts stay fresh and verification stays honest.
- **Tiny tasks:** manager + one engineer, no reviewer. Scale the ceremony to the stakes.
