# claudito-code-config-lssctx

Shared **Claude Code** configuration for our team — a curated set of global skills, a
skill auto-activation rulebook, and baseline settings. Clone it onto any machine
(macOS / Linux / Windows), run the bootstrap script, log in, and you have the same
Claude Code setup everyone else does.

## Install the skills (npm / npx — quickest)

The skills are installable directly from this GitHub repo with the open-source `skills`
CLI (requires **Node.js / npm**, which provides `npx`). Replace `danielguerrarmz-create`
with wherever this repo is pushed.

**All skills, installed globally:**
```bash
npx skills add https://github.com/danielguerrarmz-create/claudito-code-config-lssctx --skill '*' --global --copy
```

**A single skill** (e.g. the team-orchestration playbook):
```bash
npx skills add https://github.com/danielguerrarmz-create/claudito-code-config-lssctx --skill team-orchestration --global --copy
```

> `--global` installs into `~/.claude/skills` (every project); `--copy` writes real files
> (needed on Windows, which can't symlink without admin). Restart Claude Code once after
> installing so it watches the skills directory.

This installs the **skills** only. For the **full** setup (skills + the `CLAUDE.md`
auto-activation rulebook + settings + dev toolchain), use the bootstrap script below.

## Full setup (skills + rulebook + settings + tools)

**macOS / Linux**
```bash
git clone https://github.com/danielguerrarmz-create/claudito-code-config-lssctx.git
cd claudito-code-config-lssctx
./bootstrap.sh
```

**Windows (PowerShell)**
```powershell
git clone https://github.com/danielguerrarmz-create/claudito-code-config-lssctx.git
cd claudito-code-config-lssctx
powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
```

Then: start Claude Code, run `/login`, and **restart once** so it begins watching
`~/.claude/skills`. After that first restart, skill edits hot-reload.

## What's in here

| Path | What it is |
|---|---|
| `skills/` | 16 global skills (custom rulebooks + vetted third-party). Copied into `~/.claude/skills/`. |
| `CLAUDE.md` | Skill **auto-activation rulebook** — loaded into every session; routes requests to the right skill by context. Copied into `~/.claude/CLAUDE.md`. |
| `settings.json` | Portable baseline: agent-teams enabled, `teammateMode: tmux`, update channel, theme. Copied into `~/.claude/settings.json`. |
| `bootstrap.sh` / `bootstrap.ps1` | One-shot installer for macOS-Linux / Windows. |

## The skills

**Custom rulebooks (authored in-house):** `team-orchestration`, `git-github-rulebook`,
`backend-api-rulebook`, `testing-rulebook`, `secure-coding-rulebook`, `debugging-playbook`,
`tldr`.
**Vetted third-party:** `frontend-design`, `web-design-guidelines`,
`vercel-react-best-practices`, `vercel-composition-patterns`, `vercel-react-native-skills`,
`github-actions-docs`, `context-engineering-collection`, `skill-creator`, `find-skills`.

See `CLAUDE.md` for the full routing table (which skill fires for which kind of task).

## Security

- **Never commit credentials.** `~/.claude/.credentials.json` and any `.env`/keys are
  git-ignored. Authentication is per-machine — run `/login` after bootstrap.
- Skills run with full agent permissions. Review `SKILL.md` files before trusting new ones,
  and only add skills from sources you trust (we removed a third-party skill that contained
  a prompt-injection — vet before installing).

## Per-OS notes

- **macOS:** `teammateMode: tmux` gives real split-pane teammates if `tmux` or iTerm2 is
  installed. Dev tools install via Homebrew.
- **Windows:** split-pane teammates require WSL+tmux; on a native terminal teammates run
  in-process (cycle with Shift+Down). Dev tools install via winget.
- **statusLine** is intentionally omitted from the shared `settings.json` because it's
  machine-specific (e.g. a local script path). Add your own locally after bootstrap.

## Updating

Pull the latest and re-run bootstrap:
```bash
git pull && ./bootstrap.sh    # or .\bootstrap.ps1 on Windows
```
To contribute a skill: add it under `skills/<name>/SKILL.md`, update the routing table in
`CLAUDE.md`, and open a PR.
