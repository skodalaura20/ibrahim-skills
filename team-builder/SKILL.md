# Team Builder — koi bhi task, khud-banti team

**Purpose:** Jab Ibrahim koi bhi task de, to main agent turant ek specialist team banaye: task samjho → todo → roles chuno → subagents spawn karo → critic check → final synthesis. Koi naya framework install nahi hota — harness ke native subagents use hote hain (OpenCode / Claude Code / fcc-claude me Task tool, mere paas subagent.spawn).

## Trigger

Jab ye skill invoke ho ("team-builder", "team banao", "agentic team"), ya jab task me 3+ independent workstreams dikhen. **Trivial 1-step task ho to team mat banao** — seedha kar do (JEV rule: bounded + high-confidence = act immediately).

## Protocol

### 1. SAMJHO (Understand)

- Task ko **ek line** me restate karo — galat samjha to team galat banegi.
- Final deliverable ka naam lo; "done" ke 2–3 checkpoints likho.
- Ambiguous ho to **max 2 tez sawal** poochho (grilling-lite). Andaza lagakar aage mat badho.

### 2. TODO (Decompose)

- Kaam ko workstreams me todo. Har workstream: goal, inputs, done-criteria.
- **Parallel vs sequential** mark karo — kisko kiska output chahiye, ye pehle tay karo.

### 3. TEAM BANAO (Draft team)

Roster se **2–5 roles** chuno (5 se zyada kabhi nahi — token discipline). Prefer 2–3.

| Role | Karta kya hai | Kab chuno |
|---|---|---|
| researcher | Facts/options jama karta hai (web, docs, sources) | Task me "pata karo / compare karo" ho |
| planner | Complex kaam ko ordered steps me todta hai | 5+ steps ya dependencies hon |
| coder | Code likhta hai | Koi bhi build/fix/script |
| data-wrangler | Files, sheets, PDFs, transforms sambhalta hai | Data in/out ho |
| writer | Text/content draft karta hai | Email, doc, post, proposal |
| critic | Output ko done-criteria par check karta hai | **Consequential kaam me hamesha** |
| verifier | Daavon ko sources se verify karta hai | Numbers/dates/claims matter karte hon |

Har role ke liye likho: **goal (1 line) + inputs (kya milega) + done-criteria (kaise pata chalega ho gaya) + output format**.

### 4. SPAWN

- Independent roles **ek saath parallel** spawn karo — harness ka subagent mechanism (OpenCode/Claude Code me Task tool).
- Sequential roles tab spawn karo jab unka input ready ho.
- Har subagent ko brief do: role, goal, exact inputs, done-criteria, output format, model.
- **Briefs English me** likho; har brief **≤15 lines** (token discipline).

### 5. JUDGE (Critic pass)

- Critic har output ko done-criteria se check kare.
- Fail hua to **ek baar** wapas bhejo (exact gap batakar); phir bhi fail to Ibrahim ko escalate karo — teesra retry nahi.

### 6. SYNTHESIZE

- Sab outputs ko **ek final deliverable** me jodo.
- Har agent ne kya kiya — **ek line me** report karo. Lambi kahani nahi.

## Rules

- **Free lane only:** default model GLM-5.3-Flash (NIM); fallback local Ollama (jo available ho — qwen3.5:4b ya similar). Paid API kabhi nahi.
- Max 5 agents; ek subagent = ek workstream; overlapping assignments nahi.
- Briefs English me, chhote, exact — vague brief = vague output.
- Subagent ko aisa CHECK mat do jo uske paas capability hi nahi (bina browser ke visual check mat maango).

## Example

Task: *"3 CRM options research karo, chhote business ke liye"*

Team:
1. **researcher-A** — features + pricing nikalo (sources ke saath)
2. **researcher-B** — reviews + complaints nikalo (sources ke saath)
→ dono parallel; phir:
3. **critic** — dono ki findings done-criteria par check karo (3 options? pricing real? sources cited?)
→ **synthesis:** ranked table + ek line per option + ek "Go?"

## Anti-patterns (mat karna)

- Har chhote kaam par 5 agents — JEV rule todo.
- Critic ke bina consequential kaam ship karna.
- Brief me "achhe se kar do" jaisi vague lines — exact inputs do.
- Sequential kaam ko parallel spawn karke input ka wait karwana.
