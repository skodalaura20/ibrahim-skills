---
name: zero-slop
description: Kill AI slop in EVERYTHING — code, writing, design, plans. Severity-graded patterns (BLOCKER vs SMELL), bad-to-good examples, slop self-score gate, mandatory red-team pass, and a pre-ship ritual. The final gate before anything ships. Use on any output before calling it done.
license: MIT
metadata:
  opencode/slash: "true"
---

# Zero Slop — the final gate

Slop ships when nobody checks. **This skill IS the check.** Run it on every deliverable. No exceptions, no "it's probably fine."

## Severity

- **BLOCKER** — fix before shipping. No debate, no "later."
- **SMELL** — fix if cheap; if you can't, say so openly.

**3+ SMELLs = treat as BLOCKER.** Redo the work.

## The slop score (NEW — quantitative gate)

After fixing everything you found, score your own output 0–10. Be brutally honest — inflating your own score is the ultimate slop.

- **10** — you'd sign your name on it publicly.
- **8–9** — ship it.
- **6–7** — one more pass. Fix the smells first.
- **0–5** — redo. Don't polish slop — rebuild it.

Score below 8 = not shippable. No exceptions.

## Red-team pass (NEW — mandatory for important work)

For anything that matters (client work, public content, production code, money decisions):

1. Pretend you're a **hostile reviewer paid to find flaws** in this output.
2. List **3 specific weaknesses** — not vibes, concrete flaws with locations.
3. Fix at least the **worst one**. Note the other two openly.
4. **Can't find 3 flaws? You didn't look hard enough.** Look again. Nobody's first draft is flawless — claiming otherwise is slop.

## Code slop

### BLOCKERS

- **Fake implementation.** `// TODO: implement`, `pass`, empty `catch {}`, functions returning hardcoded values disguised as logic. → Implement it, or declare it unimplemented. Never both pretend and ship.
- **Invented behavior.** Code that claims to handle cases it never actually handles (validation that validates nothing, retries that don't retry). → Delete it or make it real.
- **Swallowed errors.** `catch (e) { console.log("error"); }` then carrying on as if nothing happened. → Handle it, retry it, or fail loudly. Silence is a lie.
- **Injection holes.** SQL, shell, or HTML built by concatenating user input. → Parameterize. Escape. Always. No exceptions.

### SMELLS (bad → good)

- **Comment restates code:** `// increment counter` above `counter++`. → Delete the comment. Comments explain WHY, never WHAT.
- **Meaningless names:** `data`, `tmp`, `result2`, `handleThing`. → `unpaidInvoices`, `retryDelayMs`, `validateGstNumber`.
- **Magic numbers:** `setTimeout(86400000)`, `if (retries > 3)`. → `const DAY_MS = 86_400_000 // session expiry window`.
- **Copy-paste blocks:** same 10 lines repeated 4× with tiny changes. → Extract a function. Twice is coincidence, three times is a function.
- **Dead code:** commented-out blocks, unused imports, unreachable branches. → Delete. Git remembers.
- **Over-engineering:** abstract factory for 2 endpoints, config system for 2 values. → Simplest thing that works. Complexity must be earned.
- **Inconsistent style:** mixed quotes, random indentation, half-formatted. → Match the file around it.
- **Silent data loss:** truncating, rounding, or dropping data without telling anyone. → Warn loudly or don't do it. Lost data with no warning is a betrayal.
- **God function:** 100+ lines doing 5 jobs. → Split by job. One function, one job.
- **Vague timelines (plans/work):** "soon", "ASAP", "in a bit". → Give a real estimate or admit you can't. Vagueness is schedule slop.

## Writing slop

**Banned outright:** delve, foster, leverage, utilize, facilitate, empower, streamline, robust, cutting-edge, paradigm shift, game changer, tapestry, realm, beacon, multifaceted, meticulous, intricate, paramount, transformative, elevate, embark, supercharge, harness, ever-evolving, nestled, boasts, vibrant, bustling.

**BLOCKER patterns:**
- **Invented specifics.** A stat, quote, date, or name with no source. → Source it or cut it. This is the worst slop there is.
- **Throat-clearing openers.** "Here's the thing," "Let me be clear," "The uncomfortable truth is." → Delete. State the point.

**SMELL patterns:**
- **Binary contrasts.** "It's not X, it's Y." → Just say Y.
- **Fake-profound kickers.** A "deep" final line that's really a Hallmark card. → End on the clearest concrete sentence.
- **Summary recaps.** "In conclusion," "Ultimately." → The reader was just there. Cut it.
- **Em-dash spam.** One decorative dash is style; five is a crutch. → Use commas or periods.
- **Portability test.** If a sentence fits any company, product, or country unchanged, it's filler. → Replace with a specific fact or cut it.

## Design slop

### BLOCKERS

- **Fake content shipped as final.** Lorem ipsum, "coming soon" boxes, placeholder images presented as design. → Real content or an honest labeled placeholder. Never fake-as-final.
- **Invented proof.** Fake stats, fake testimonials, fake client logos, fake review counts. → Never. This is fraud with better kerning.
- **Inaccessible contrast.** Text that fails WCAG AA. → Fix the colors. Aesthetics never outrank readability.

### SMELLS

- **Default gradients.** Purple-to-blue hero #4,382,901. → Pick a palette with intent or go solid.
- **Cookie-cutter layout.** Centered hero → three cards → testimonial carousel, zero adaptation. → If it could be anyone's site, redesign.
- **Stock-photo sameness.** Handshake photos, laptop-on-desk. → Real photos or honest abstract visuals.
- **Tiny tap targets.** Under 44px on mobile. → Enlarge.
- **Unexplained decoration.** Remove it mentally — if nothing changes, delete it for real.

## Universal rules (every task, every time)

1. **Never invent.** Numbers, names, dates, prices, quotes. No source = don't write it.
2. **Never placeholder-as-done.** Half-wired buttons, empty states, "insert X here." → Finish it or mark it unfinished. Loudly.
3. **Prove, don't claim.** "Done / fixed / verified / tested" without evidence is slop. Show the output, the test, the screenshot.
4. **No hedging spam.** "It seems this might could potentially..." → Say it or say you don't know.
5. **No AI self-reference.** Never "as an AI," never unprompted limitation speeches. Do the work.
6. **Match the ask.** A 2-line question gets a 2-line answer. Don't gild it.

## The pre-ship ritual (MANDATORY)

Before typing done / fixed / ready / shipped, answer all six. In your head, honestly:

1. **Did I invent anything?** Any number, name, date, quote without a source → source it or remove it.
2. **Anything fake-as-final?** Placeholder, TODO, half-wired element → finish it or declare it unfinished.
3. **Could this be anyone's?** If it fits another project/company unchanged → make it specific.
4. **Did I claim completion?** Where is the evidence — test output, screenshot, file?
5. **Would I defend every line in review?** If any line makes you flinch → fix that line.
6. **What's my slop score?** Below 8 → don't ship. (Important work: did I red-team it?)

All six green → ship it. Any red → fix first, then re-run the ritual.
