# ibrahim-skills

My custom OpenCode agent skills.

## Skills

| Skill | What it does |
|-------|--------------|
| `backend-developer` | Build backend APIs like a senior developer — Node.js/Express REST APIs with proper structure, validation, error handling, SQLite, auth basics, and security. |
| `chunked-work` | Break large tasks into small verifiable chunks and execute one at a time. Prevents long-generation stream failures. |
| `flutter-dev` | Build Flutter apps like a senior mobile developer — clean Dart, Material 3 theming, encoding hygiene, device gate, reproducer-first bug fixing. |
| `zero-slop` | General anti-slop gate for everything — kills AI slop in code, writing, and design before anything ships. |
| `penpot-pilot` | Fully automates the Penpot MCP connection — opens the file, clicks File → MCP Server → Connect, verifies, and auto-reconnects. Zero manual steps after one-time login. |
| `eng-team` | Turn one agent into a small engineering team — Senior Manager breaks problems down, fresh Engineer subagents implement one task each via shared files, fresh Reviewer audits with no baggage. |

## Install

```powershell
npx skills add skodalaura20/ibrahim-skills -g -a opencode -y
```

Install a single skill:

```powershell
npx skills add skodalaura20/ibrahim-skills --skill penpot-pilot -g -a opencode -y
```

## License

MIT
