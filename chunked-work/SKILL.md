---
name: chunked-work
description: Break any large task into small, verifiable chunks and execute one chunk at a time. Use when a task has multiple parts or would need a very long single generation.
---

# Chunked Work

Long single generations break (stream drops, timeouts). Always divide and conquer.

## When to use

Any task where you catch yourself thinking "Part 1... Part 2... Part 3..." — STOP. That is the signal to chunk.

## How it works

### 1. Decompose first (no execution yet)

Break the task into chunks. Each chunk MUST:
- Produce ONE verifiable output (one file, one function, one section)
- Be completable in a few minutes of generation — never 15+ minutes
- Be testable on its own, without later chunks

Show the user the numbered chunk list. Proceed when they approve (or immediately if they said "go ahead" / "continue").

### 2. Execute ONE chunk per response

- Complete chunk 1 fully. Show the result. STOP.
- Only then move to chunk 2 in the next response.
- NEVER combine multiple chunks into one giant generation — that is exactly what causes stream failures.

### 3. Verify each chunk before moving on

- After each chunk: confirm the output exists and is correct (read it back, run it, or show a summary).
- If a chunk fails or the stream drops, retry ONLY that chunk — never restart the whole task.

## Rules

- One chunk per response. No exceptions.
- Prefer many small file writes over one giant file.
- For code: one component or function per chunk.
- For content: one section per chunk.
- If the user says "do it all at once", warn them once that long generations risk stream drops, then respect their choice.
- Track progress visibly: "✅ Chunk 2/5 done — next: circuit path module".
