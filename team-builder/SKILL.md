# Team Builder — koi bhi task, khud-banti team

**Purpose:** Jab Ibrahim koi bhi task de, to main agent turant ek specialist team banaye: gate → samjho → todo + budget → team banao → spawn → critic check → synthesize. Koi naya framework install nahi hota — harness ke native subagents use hote hain (OpenCode / Claude Code / fcc-claude me Task tool, mere paas subagent.spawn). Research-backed v2: control loop likhe hue protocol me rehta hai, model ke dimaag me nahi.

## Trigger

Jab ye skill invoke ho ("team-builder", "team banao", "agentic team"), ya jab task me 3+ independent workstreams dikhen.

## 0. GATE — pehle justify karo, phir team banao

Team banane se PEHLE ek line likho — inme se kaunsa lagoo hota hai:
- independent workstreams ≥2, ya
- cross-domain tools/expertise chahiye, ya
- independent verification chahiye, ya
- single-agent prompt ~2000 tokens se bada ho jayega

**Koi bhi na lage → team mat banao.** Single agent se karo. (Research: galat task par team single agent se *battar* karti hai — strictly sequential planning tasks par −39% se −70% worse. "A well-designed single agent beats a poorly coordinated team every time.")

## 1. SAMJHO (Understand)

- Task ko **ek line** me restate karo — galat samjha to team galat banegi.
- Final deliverable ka naam lo; "done" ke 2–3 checkpoints likho.
- **Original goal ko verbatim note karo** — ye har subagent brief me jayega (telephone-game guard: handoff me goal ghisna nahi chahiye).
- Ambiguous ho to **max 2 tez sawal** poochho (grilling-lite). Andaza lagakar aage mat badho.

## 2. TODO + BUDGET (Decompose)

- Kaam ko workstreams me todo. Har workstream: goal, inputs, done-criteria.
- **Parallel vs sequential** mark karo — kisko kiska output chahiye, ye pehle tay karo. Sequential/coupled kaam ko parallel mat karo (conflicting implicit decisions compound hote hain).
- **BUDGET BLOCK** — har team plan ke top par ye likho:
  ```
  MAX_SUBAGENTS=5 (default 3) · MAX_ROUNDS_TOTAL=<n> · MAX_WORDS_PER_RETURN=200
  ```
  Budget se zyada spawn karna ho to ek line me justify karo, warna nahi. (Multi-agent ~15× tokens khata hai — cap ke bina free tier par bhi rate-limit lagenge.)

## 3. TEAM BANAO (Draft team)

Roster se **2–5 roles** chuno (default 3; 5 se zyada kabhi nahi):

| Role | Karta kya hai | Kab chuno |
|---|---|---|
| researcher | Facts/options jama karta hai (web, docs, sources) | Task me "pata karo / compare karo" ho |
| planner | Complex kaam ko ordered steps me todta hai | 5+ steps ya dependencies hon |
| coder | Code likhta hai | Koi bhi build/fix/script |
| data-wrangler | Files, sheets, PDFs, transforms sambhalta hai | Data in/out ho |
| writer | Text/content draft karta hai | Email, doc, post, proposal |
| critic | Output ko done-criteria par check karta hai | **Consequential kaam me hamesha** |
| verifier | Daavon ko sources se verify karta hai | Numbers/dates/claims matter karte hon |

Har role ke liye: goal (1 line) + non-overlap scope ("Subagent B, X cover mat karna — wo Subagent A ka hai").

**TASK LEDGER** banao (numbered) — yehi control loop hai:
```
# | Step | Owner | Status (pending/doing/done/blocked)
```
Har spawn/return ke baad ledger update karo; **har decision se pehle ledger re-read karo.** Loop likhe hue protocol me, model ke dimaag me nahi — free/small models ke liye ye sabse important rule hai.

## 4. SPAWN

Har subagent ko **self-contained brief** do — ye template follow karo, koi exception nahi:

```
[LABEL] · Goal (1 sentence)
Original goal (verbatim): <user ka task shabd-ba-shabd>
Context: file paths, line numbers, prior findings (pronouns mat use karo — "this issue" nahi)
Orchestrator ka analysis: <tumhara apna nishkarsh — understanding delegate mat karo>
Constraints: kya NAHI karna (explicit exclusions)
Tools: least privilege (sirf zaroori tools)
Output contract: exact format + length cap (e.g. ≤200 words, bullets, sabse important finding pehle)
```

- **No brief, no spawn.** Brief me "see conversation above" ho to invalid — dobara likho.
- Parallel spawn karte waqt subagents ko naam do (Subagent 1 — researcher-A, …) aur **"parallel" shabd explicit** likho.
- Research outputs me **har claim par [source] tag** mandatory (source URL ke saath). Ek agent ka confident-jhooth doosre ke liye "sach" nahi ban-na chahiye.
- Mutating briefs me exact files/scope naam lo; read-only briefs me "read-only, do not modify files" likho.

## 5. JUDGE (Critic pass — v2)

- Ek **alag critic subagent**, written checklist ke saath — "is this good?" nahi, checklist.
- Verdict format: **PASS/REVISE + score + fix_list**. Har REVISE me **violated checklist item cite karna lazmi** — bina wajah revise karne se achha output bigadta hai (self-critique paradox).
- **Max 2 revision rounds** — phir best version rakho (best-version fallback).
- **Grounded verification prefer karo:** code → tests chalao aur failures wapas bhejo; research → har claim cited source se check karo; structured data → schema validate karo. Bina grounding ke self-critique max 1 round.
- Critic loop sirf tab jab stakes justify karein (2–3× cost/latency); quick replies aur single-fact lookups me skip.

## 6. SYNTHESIZE

- **Expected-results checklist** rakho (N expected, M aaye) — deterministic fan-in.
- Raw results pehle **labels ke saath** dikhao, phir synthesize — taaki achhi finding buri synthesis me na kho jaye.
- **Timeout/missing par kabhi stall mat karo:** jo results aaye unse synthesize karo + gaps ko explicitly list karo ("X ka result nahi aaya — ye missing hai").
- Final output ko **ORIGINAL request se check karo** (intermediate briefs se nahi). Subagents ke beech contradictions chhupao mat — surface karo.
- Har agent ne kya kiya — **ek line me** report karo. Lambi kahani nahi.

## Rules

- **Free lane only:** default model GLM-5.3-Flash (NIM); fallback local Ollama (jo available ho). Paid API kabhi nahi.
- Default team size 3 (range 2–5). Ek subagent = ek workstream; overlapping assignments nahi.
- Briefs English me, ≤15 lines; small models ke liye <300 words target rakho.
- **Artifacts pass karo, transcripts nahi.** Subagents ko file paths / pasted excerpts do — "conversation padh lo" kabhi nahi. Single-writer-per-artifact (edit collisions se bachao).
- **Runtime probe:** harness ki tool-calling / structured-output limits pehle check karo, assume mat karo (GLM-5.3-Flash aur qwen3.5:4b par exact limits unverified hain). Verify na ho to simple text contracts use karo.
- Subagent ko aisa CHECK mat do jo uske paas capability hi nahi (bina browser ke visual check mat maango).
- Critic ke verdicts terminal hain — PASS milte hi loop khatam. "Stop and report partial results" hamesha ek allowed outcome hai.

## Example

Task: *"3 CRM options research karo, chhote business ke liye"*

```
BUDGET: MAX_SUBAGENTS=5 (use 3) · MAX_ROUNDS_TOTAL=6 · MAX_WORDS_PER_RETURN=200
LEDGER:
# | Step                        | Owner        | Status
1 | Features+pricing nikalo     | researcher-A | pending
2 | Reviews+complaints nikalo   | researcher-B | pending
3 | Dono findings check karo    | critic       | pending
4 | Ranked table + Go?          | orchestrator | pending
```

Team:
1. **researcher-A** — features + pricing (sources ke saath, [source] tags)
2. **researcher-B** — reviews + complaints (sources ke saath) — *dono parallel, non-overlap*
→ 3. **critic** — checklist: 3 options? pricing real? sources cited? → PASS/REVISE
→ **synthesis:** ranked table + ek line per option + ek "Go?"

## Anti-patterns (mat karna)

- Gate ke bina har kaam par team banana — JEV rule todo.
- Budget ke bina spawn karna (50 subagents wali galti).
- Vague brief ("achhe se kar do") — exact inputs do.
- Critic ke bina consequential kaam ship karna.
- Brief me original goal bhoolna (telephone game).
- Fan-in par atakna — partial synthesize + gaps list karo.
- Transcripts forward karna — artifacts do.
