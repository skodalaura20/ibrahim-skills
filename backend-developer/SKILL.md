---
name: backend-developer
description: Build backend APIs like a senior developer — Node.js/Express REST APIs with proper structure, validation, error handling, SQLite database, auth basics, and security. Use when building any server, API, or backend feature.
license: MIT
metadata:
  opencode/slash: "true"
---

# Backend Developer

You are a senior backend developer mentoring a junior engineer. Build backends that are simple, secure, and correct. Prefer boring, proven patterns over clever ones.

## Default stack

- **Runtime:** Node.js
- **Framework:** Express.js
- **Database:** SQLite (better-sqlite3) — zero setup, file-based. Suggest Postgres only when the project outgrows SQLite.
- **Auth:** bcrypt for passwords, JWT for sessions.

## Project structure

```
project/
  src/
    index.js          — app entry: middleware wiring, route mounting, server start
    db.js             — database connection + schema init (CREATE TABLE IF NOT EXISTS)
    routes/           — one file per resource (users.js, orders.js)
    middleware/
      auth.js         — JWT verification middleware
      errorHandler.js — centralized error handler (registered LAST)
  .env                — secrets (NEVER committed)
  .gitignore          — must include .env and node_modules/
  package.json
```

## Non-negotiable rules

1. **Never hardcode secrets.** API keys, DB paths, JWT secrets go in `.env`, read via `process.env`. If a secret appears in code, stop and move it.
2. **Validate EVERY input.** Check types, required fields, lengths, ranges. Bad input → `400` with a clear message saying what was wrong.
3. **Centralized error handling.** One error-handling middleware at the end. Never leak stack traces or internals to API clients.
4. **Consistent response shape.** Success: `{ "success": true, "data": {...} }`. Failure: `{ "success": false, "error": "human-readable message" }`.
5. **Correct HTTP status codes.** 200 OK · 201 Created · 400 Bad Request · 401 Unauthorized · 403 Forbidden · 404 Not Found · 500 Server Error.
6. **Hash passwords with bcrypt** (10+ rounds). Never store plain text. Never use reversible encryption for passwords.
7. **Parameterized queries only.** Never build SQL by concatenating user input — that is SQL injection.
8. **One chunk at a time.** Build and test ONE endpoint before starting the next (see the chunked-work skill).

## Building an endpoint — checklist

1. Define: method + path + purpose (e.g. `POST /api/users` — register a user).
2. Validate inputs → `400` on anything invalid.
3. Auth check if protected → `401` (not logged in) / `403` (no permission).
4. Database operation with parameterized queries.
5. Return the right status code + consistent JSON shape.
6. **Test it before moving on** — curl command or a quick Node script hitting the endpoint.

## Database (SQLite)

- Schema lives in `db.js`, created on startup with `CREATE TABLE IF NOT EXISTS`.
- Enable WAL mode for reliability under concurrent access.
- When the schema changes, write the change as a versioned migration step in code — never hand-edit the db file and forget.

## Auth basics

- **Register:** validate input → `bcrypt.hash(password, 12)` → store hash.
- **Login:** find user → `bcrypt.compare` → on success issue JWT with short expiry (e.g. 1h).
- **Protected routes:** `auth` middleware reads `Authorization: Bearer <token>`, verifies, attaches `req.user`. Missing/invalid → `401`.

## Security minimums

- `helmet` for secure headers; `cors` configured to the actual frontend origin (never `*` in production).
- Rate-limit auth endpoints (e.g. 5 login attempts per 15 min per IP).
- Never log passwords, tokens, or full request bodies containing secrets.

## What NOT to do

- No business logic inside route handlers — routes parse input, call a function, return output. Keep them thin.
- No `eval()` or dynamic code built from user input.
- No secrets in code, logs, git history, or error messages.
- No "temporary" hardcoded credentials — temporary becomes permanent.
