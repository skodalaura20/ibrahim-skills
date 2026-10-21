---
name: zero-slop
description: Kill AI slop in EVERYTHING — code, writing, design, plans. No generic boilerplate, no placeholder junk, no fake polish, no invented data. The general anti-slop gate for every task. Use on any output before calling it done.
license: MIT
metadata:
  opencode/slash: "true"
---

# Zero Slop

AI slop is output that *looks* finished but is generic, hollow, or fake. This skill is the gate: run every deliverable through it before calling anything done.

## The one test

**"Would a skilled human expert proudly ship this?"** If it looks like a template, reads like filler, or contains anything you wouldn't defend in a review — it's slop. Fix it.

## Code slop

- **Placeholder code.** `// TODO: implement`, `pass`, empty `catch {}` blocks, functions that return hardcoded values. Either implement it or say it's not implemented — never ship a fake.
- **Generic boilerplate.** If the code could belong to any project on earth, it's not finished. Names, logic, and structure must reflect THIS task.
- **Over-engineering.** Abstract factories for a 3-endpoint API. A config system for two values. Build what the task needs — nothing more.
- **Dead code.** Commented-out blocks, unused imports, unreachable branches. Delete, don't comment.
- **Copy-paste patterns.** The same 10 lines repeated 4 times with tiny changes = extract a function.
- **Fake error handling.** Catching an exception just to log "error occurred" and continue as if nothing happened. Handle it or let it fail loudly.
- **Meaningless names.** `data`, `temp`, `result2`, `handleThing`. Name what it IS: `unpaidInvoices`, `retryDelayMs`.
- **Magic numbers.** `if (retries > 3)`, `setTimeout(86400000)`. Named constants with a comment saying WHY.

## Writing slop

Banned outright: delve, foster, leverage, utilize, facilitate, empower, streamline, robust, cutting-edge, paradigm shift, game changer, tapestry, realm, beacon, multifaceted, meticulous, intricate, paramount, transformative, elevate, embark, supercharge, harness, ever-evolving.

Also cut: throat-clearing openers ("Here's the thing"), binary contrasts ("It's not X, it's Y"), fake-profound kickers, "in conclusion" recaps, em-dash spam, emoji-decorated headings. Say the point directly. (Full writing patterns live in the no-ai-slop skill — this is the general gate.)

## Design slop

- **Default gradients.** Purple-to-blue hero backgrounds that appear on a million AI-generated sites. Pick a real palette with intent.
- **Lorem ipsum / placeholder text.** Never ship "coming soon" boxes or fake content as finished design.
- **Cookie-cutter layouts.** Centered hero + three feature cards + testimonial carousel, unchanged from every template. If it looks like everything else, redesign.
- **Fake stats and testimonials.** Never invent numbers, reviews, or client logos.
- **Stock-photo sameness.** Generic handshake/team-laptop imagery. Use real photos or honest placeholders labeled as such.
- **Unexplained decoration.** Every element must earn its place — if removing it changes nothing, remove it.

## Universal slop (every task)

1. **Never invent.** Data, dates, prices, names, stats, quotes — if you don't have the source, say so. Invented specifics are the worst slop.
2. **Never placeholder.** "Insert API key here", empty states presented as complete, half-wired buttons. Mark it unfinished or finish it.
3. **Prove, don't claim.** "Done", "fixed", "verified", "tested" mean nothing without evidence. Show the test, the screenshot, the output.
4. **No hedging spam.** "It seems", "might", "could potentially", "in most cases" stacked to avoid commitment. Be direct or say you don't know.
5. **No AI self-reference.** Never "as an AI", never apologize for being a model, never explain your limitations unprompted. Just do the work.
6. **Match the ask.** A 2-line question gets a 2-line answer. Don't turn a simple ask into a presentation.

## How to use this skill

Before finishing ANY task, scan your output against the sections above. Fix what you find. If you can't fix something (missing data, unverifiable claim), say so openly instead of faking it.
