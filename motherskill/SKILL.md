---
name: motherskill
description: The FIRST stop for any website task (build, redesign, audit, improve). The agent analyzes the website first, gives the single best recommendation, then asks sharp questions for further improvement. Never write code before this skill runs.
---

# MotherSkill

You are the entry gate for website work. When the user gives you ANY website-related task, you come HERE first — before grilling, before specs, before code. Your job runs in three phases: DEKHO → RECOMMEND → PUCHHO.

## Phase 1 — DEKHO (Analyze)

Look at the website FIRST. Get the URL or the local files and inspect it across these categories (inspired by the vibe-coder's resource map — the right category fixes the right problem):

1. **Design quality** — AI slop check. Generic purple gradients? Inter font everywhere? Random rocket emojis? Cookie-cutter hero?
2. **Component reuse** — MANDATORY: check 21st.dev and SmoothUI (shadcn-compatible registries) BEFORE hand-writing any component. Registry gives speed, taste still yours.
3. **Animations** — Dated PowerPoint feel? Check what's used: Framer Motion / GSAP / Lenis / CSS transitions. Motion should feel alive, not decorative.
4. **Design system** — Are fonts and colors consistent, or does the AI change them every section? One typeface pairing, one palette.
5. **Mobile** — Is it a real mobile design or a squeezed desktop? Sticky mobile CTA present?
6. **Assets** — Icons, illustrations, 3D, backgrounds, mockups: SOURCED (free licensed) or generated? Sourced first, always.
7. **Copy** — AI-slop text? Run the no-ai-slop pass: cut filler, keep the human voice.
8. **Landing sections** — Hero with CTA above the fold? Social proof? Clear conversion path?
9. **Performance** — Image weights, load behavior, obvious bottlenecks.

Apply the standing gates during inspection: the @uiuxaadi 8 rules (compulsory), taste-skill pre-flight, impeccable audit. Note every finding with WHERE (page/section) and WHY it matters.

## Phase 2 — RECOMMEND (Best recommendation)

Give the user your honest verdict FIRST — then options:

- **ONE best recommendation**, stated decisively with the single strongest reason.
- Max **3 ranked alternatives**, one line each: what + why.
- Never dump 10 options. Decisiveness is the skill.
- Frame in user terms: what changes, what it costs (tokens/time), what it earns.

## Phase 3 — PUCHHO (Questions for improvement)

Now ask sharp questions to sharpen the plan further:

- **2–4 questions max**, ordered by cost-of-getting-it-wrong (goal > scope > constraints > polish).
- Each question must be answerable in one line. No essays demanded.
- If the user says "you decide", record it as YOUR explicit decision.

## Handoff

When the user approves the recommendation:

- New build / redesign → hand to **grilling** → **to-spec** → **to-tickets** → **tdd** → **code-review**.
- Small fix / polish → **tdd** (reproducer first) → **code-review**.
- The 20-point website checklist remains the final ship gate — items 18 (analytics) and 19 (real address) always need the user's explicit input.

## Rules

- **This skill runs FIRST.** No website code, no spec, no tickets before DEKHO → RECOMMEND → PUCHHO completes.
- **Never skip Phase 1.** Recommending without looking is guessing.
- **Never hand-write a component before the registry check.** (Standing rule.)
- **One best recommendation**, not a menu. The user asked for YOUR judgment.
- Keep every reply compact. Long analysis goes to a file; the chat gets the verdict.
