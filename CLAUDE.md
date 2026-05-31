# Skill Activation Rulebook

I maintain a curated set of global skills (in `~/.claude/skills/`). **At the start of any
task, match the request against the table below and proactively activate the relevant
skill(s) before doing the work — don't wait to be asked.** Match on *context and intent*,
not just literal keywords. When several apply, use them together (e.g. an authenticated
API endpoint → `backend-api-rulebook` + `secure-coding-rulebook` + `testing-rulebook`).
Activate a skill with the Skill tool (e.g. `/tldr`) or by following its guidance.

## Routing table

| Activate this skill | When the task involves… |
|---|---|
| **frontend-design** | Building or styling web UI — components, pages, landing pages, dashboards, "make this look good" |
| **web-design-guidelines** | Reviewing/auditing UI for accessibility, UX, or design-guideline compliance |
| **vercel-react-best-practices** | React/Next.js performance, data fetching, rendering, bundle size |
| **vercel-composition-patterns** | React component architecture — compound components, render props, reusable APIs |
| **vercel-react-native-skills** | React Native / Expo / mobile app work |
| **backend-api-rulebook** | Server-side code, REST/HTTP APIs, endpoints, DB schema/migrations, queries, reliability |
| **secure-coding-rulebook** | Auth, user input, injection/XSS/SSRF, secrets, crypto, "is this secure", "harden", threat-model |
| **testing-rulebook** | Writing/structuring tests, test strategy, mocking, or fixing a bug (always add a regression test) |
| **debugging-playbook** | Finding *why* something is broken — crashes, stack traces, failing/flaky tests, "it used to work" |
| **git-github-rulebook** | Git/GitHub mechanics — commits, branches, PRs, merge/rebase, conflicts, releases, "I messed up my branch" |
| **github-actions-docs** | GitHub Actions / CI-CD workflow YAML (triggers, matrices, caching, OIDC, reusable workflows) |
| **team-orchestration** | Building/shipping an app or feature with MULTIPLE agents end-to-end (full-stack + security + release + debug) |
| **context-engineering-collection** | Building, optimizing, or debugging agent systems / multi-agent architectures / context strategy |
| **skill-creator** | Creating, editing, optimizing, or evaluating a skill |
| **find-skills** | The user wants a capability that might exist as an installable skill ("is there a skill for…") |
| **tldr** | "What does this file do" / summarize a specific file (`/tldr <path>`) |
| **caveman** | The user wants ultra-terse, token-saving output ("caveman mode", "be brief", `/caveman`) |

## Built-in commands also available
`/code-review` (bug + cleanup review of the diff), `/security-review` (security review of a
diff), `/verify` (run the app and confirm a change works), `/run` (launch the app),
`/simplify` (quality cleanup of changed code), `deep-research`, `claude-api`.

## Activation rules
- **Prefer activating a matching skill over winging it.** These encode conventions and
  safety rules (e.g. never force-push shared branches, never commit secrets, regression-test
  every bug fix) that are easy to skip from memory.
- **Stack skills** for multi-faceted work rather than picking just one.
- **Don't force-trigger.** A *conceptual question about* a topic (e.g. "what is canary
  deployment?", "how does Team Topologies define a platform team?") is not the same as
  *doing the work* — answer directly; don't spin up the playbook. Single trivial tasks
  (rename a file, one-line tweak) usually don't need a skill either.
- For diff review prefer the built-in `/code-review` / `/security-review`; for *writing*
  new secure code prefer `secure-coding-rulebook`.

## Environment notes
- Native Windows 11 (PowerShell / Git Bash; no WSL). Installed dev tools: Node/npm, Python
  3.13, Go, OpenSSL, `gitleaks`, git. See `C:\Users\danie\dev-environment-manifest.md`.
- Agent teams are enabled, but `teammateMode: tmux` split panes only work under WSL+tmux —
  on this terminal teammates run in-process (cycle with Shift+Down).
