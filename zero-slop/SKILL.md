---
name: zero-slop
description: The definitive anti-slop gate — code, writing, design. Research-backed patterns from 15+ open-source anti-slop projects (stop-slop, stop-ai-slop, kill-ai-slop, anti-slop, Wikipedia's Signs of AI Writing). Severity-graded BLOCKER/SMELL system, slop self-score, red-team pass, agent-behavior checks, and a mandatory pre-ship ritual. Run on every deliverable before calling it done.
license: MIT
metadata:
  opencode/slash: "true"
---

# Zero Slop — the final gate

Slop ships when nobody checks. **This skill IS the check.** Built from deep research across the web and GitHub's best anti-slop projects. Run it on every deliverable. No exceptions, no "it's probably fine."

## How this skill works

1. **Scan** your output against the patterns below.
2. **Grade** each hit: BLOCKER (fix now, no debate) or SMELL (fix if cheap; say so if you can't).
3. **3+ SMELLs = BLOCKER.** Redo the work.
4. **Score** yourself 0–10 (ship only at 8+).
5. **Red-team** important work (find 3 flaws in your own output).
6. **Ritual**: answer the 6 pre-ship questions. All green → ship.

## Code slop

### BLOCKERS

- **Fake implementation.** `// TODO: implement`, `pass`, empty `catch {}`, hardcoded returns disguised as logic. → Implement it or declare it unimplemented. Never both pretend and ship.
- **Hallucinated APIs.** Imports from packages/functions that don't exist — ~1 in 5 AI-generated code samples references a nonexistent package (USENIX Security 2025). → Run it, typecheck it, grep the docs. Never trust an import's shape.
- **Invented behavior.** Code claiming to handle cases it never handles (validation that validates nothing, retries that don't retry). → Delete or make real.
- **Swallowed errors.** `catch (e) { log("error"); }` then continuing as if nothing happened; `except Exception: amount = 0` turning bad data into silent zeroes. → Handle, rethrow, or fail loudly. Silence is a lie.
- **Injection holes.** SQL, shell, or HTML built by concatenating user input. → Parameterize. Escape. Always.
- **Secrets in code/logs.** Hardcoded tokens, keys printed in output. → Never. Scan before shipping.
- **Test slop.** Assertions that can't fail; tests edited to make broken code pass; tests mirroring the bug instead of the spec. → Tests must be able to fail. An always-green test is decoration.

### SMELLS (bad → good)

- **Comment restates code:** `// increment counter` above `counter++`. → Delete. Comments explain WHY, never WHAT.
- **Meaningless names:** `data`, `tmp`, `result2`, `handleThing`. → `unpaidInvoices`, `retryDelayMs`.
- **Magic numbers:** `setTimeout(86400000)`. → `const DAY_MS = 86_400_000 // session expiry`.
- **Copy-paste blocks:** same 10 lines × 4. → Extract a function. Twice is coincidence, three times is a function.
- **Dead code:** commented blocks, unused imports. → Delete. Git remembers.
- **Speculative abstraction:** one-implementation interfaces, single-product factories (54 lines → 8). → Simplest thing that works. Complexity must be earned.
- **Fabricated type evidence:** `input as object as User` — chained assertions manufacturing certainty. → Validate at boundaries; don't launder types.
- **God function:** 100+ lines doing 5 jobs. → Split by job.
- **N+1 queries / unbounded results.** → Batch + limit.
- **Missing trust-boundary checks:** new endpoint, no auth, validation client-side only. → Every entry point gets auth + server-side validation.
- **Silent data loss:** truncating/rounding/dropping data without warning. → Warn loudly or don't do it.
- **The portability test:** if a function, comment, or sentence could move unchanged into an unrelated project, it carries no information about this one. → Rewrite so it only makes sense *here*.

## Writing slop

**Banned outright** (measured AI-vs-human frequency): delve (48x), tapestry (35x), multifaceted (28x), nuanced (22x), landscape-as-metaphor (19x), comprehensive (17x), pivotal (16x), crucial (14x), leverage (13x), robust (12x), streamline (11x), utilize/facilitate (10x), endeavor/paramount (9x), foster, harness, ever-evolving, embark, supercharge, elevate, intricate, beacon, realm, substrate, wedge, vector.

**Banned filler phrases:** "it's worth noting" (31x), "in today's digital age" (24x), "in the realm of" (22x), "it goes without saying" (then say nothing), "at the end of the day", "when it comes to", "in order to", "additionally/basically/clearly/obviously/certainly/indeed" as empty emphasis.

**BLOCKER patterns:**
- **Invented specifics.** Stat, quote, date, name with no source. → Source or cut. Worst slop there is.
- **False agency.** "The data tells us", "the market rewards" — inanimate things doing human verbs. → Name the actual human actor.

**SMELL patterns:**
- **Negative parallelism:** "It's not X, it's Y." → Just say Y.
- **Rule of three:** "Fast, efficient, reliable." → Keep the one or two claims that are true and specific.
- **Copula avoidance:** "serves as", "boasts", "stands as" → is / has.
- **Uniform sentence length.** The single most measurable AI signal — vary rhythm deliberately.
- **Throat-clearing:** "Here's the thing," "The brutal truth". → Delete, state the point.
- **Fake-profound kickers / encore paragraphs.** → End on the clearest concrete sentence.
- **Synonym cycling.** Pick one term, repeat it.
- **Vague attribution.** "Experts believe" → name them or cut it.

## Design slop

**Grep-able code signals** (search your code for these): `from-indigo-500 to-purple-500`, `bg-clip-text text-transparent`, `shadow-purple-500/50`, `via-purple`, glassmorphism glow stacks.

### BLOCKERS
- **Fake content as final.** Lorem ipsum, "coming soon" boxes, placeholder images shipped as design. → Real content or honest labeled placeholders.
- **Invented proof.** Fake stats ("Trusted by 10,000+ teams"), fake testimonials with AI headshots, fake logo walls, fake terminals reporting 0.0001ms. → Never. Fraud with better kerning.
- **Dead navigation.** Links to `#`, non-functional controls. → Wire or remove.
- **Inaccessible contrast.** Light-grey-on-white, no focus indicators. → WCAG AA minimum. Aesthetics never outrank readability.

### SMELLS
- **Default gradients.** Purple-to-blue hero #4,382,901. → One justifiable accent or solid color.
- **Cookie-cutter layout.** Centered hero → three cards → testimonial carousel. → If it could be anyone's site, redesign.
- **The business-name swap test:** cover the logo — if the headline still works for any company, rewrite it until it contains a fact only THIS product could say.
- **Serif-italic one-word swap** for "emphasis". → Emphasize with weight/position, one voice.
- **Mark-[DEFAULT]:** any element you chose without a stated reason is an unchosen default. Name the reason or change it.
- **Stock-photo sameness / emoji bullets / pulsing badges.** → Purpose or delete.
- **Tiny tap targets** (<44px mobile). → Enlarge.

## Agent-behavior checks (the agent reviewing ITSELF)

Slop isn't only in artifacts — it's in behavior:
- **False success reporting.** Claiming tests passed on an errored run. → CI output is the judge, not your word.
- **Test tampering.** Editing tests to fit broken code. → Tests are sacred; fix the code.
- **Task-boundary violations.** Editing files outside the task, reformatting unrelated modules. → Touch only what the task needs.
- **Silent behavior changes.** A refactor that drops a guard or changes a default without mentioning it. → Declare every behavior change.
- **Self-review blindness.** The writer of the bug is the worst reviewer of it. → For important work, get a second pass (different model, skill, or human).

## Universal rules

1. **Never invent.** Numbers, names, dates, prices, quotes. No source = don't write it.
2. **Approve the contract, not the code.** For important work: state what it will do (behavior + edge cases) BEFORE writing it.
3. **Cap the diff.** ~200 changed lines max per pass; bigger = split it. No "while we're here" refactors.
4. **Prove, don't claim.** "Done/fixed/verified" without evidence is slop. Show output, tests, screenshots.
5. **No hedging spam.** "It seems this might could potentially..." → Say it or say you don't know.
6. **No AI self-reference.** Never "as an AI." Do the work.
7. **Match the ask.** A 2-line question gets a 2-line answer.

## The slop score

After fixing everything found, score your output 0–10. Brutally honest — inflating your score is the ultimate slop.
- **10** — you'd sign your name on it publicly. **8–9** — ship. **6–7** — one more pass. **0–5** — rebuild, don't polish.
- Below 8 = not shippable. No exceptions.

## Red-team pass (mandatory for important work)

1. Be a **hostile reviewer paid to find flaws**.
2. List **3 specific weaknesses** — concrete, with locations.
3. Fix at least the **worst one**; note the others openly.
4. Can't find 3? **You didn't look hard enough.** Look again.

## The pre-ship ritual (MANDATORY)

Before typing done / fixed / ready / shipped, answer all six honestly:
1. **Did I invent anything?** → Source or remove.
2. **Anything fake-as-final?** → Finish or declare unfinished.
3. **Could this be anyone's?** (portability / business-name swap) → Make it specific.
4. **Did I claim completion?** → Where's the evidence?
5. **Would I defend every line in review?** → Fix the flinching lines.
6. **Slop score?** → Below 8: don't ship. Important work: red-teamed?

All six green → ship. Any red → fix, re-run.

## Standing on shoulders

Patterns synthesized from: hardikpandya/stop-slop, kirankunapuli/stop-ai-slop (22 patterns), yetone/kill-ai-slop (33 tells), miqdadbadjuber/anti-slop (38 rules), dmmulroy/anti-slop (Oxlint), Wikipedia's "Signs of AI writing", scanaislop, smoothui/ui-craft. Re-validate this skill against fresh model output ~every 6 months — banned-word lists age as models change.
