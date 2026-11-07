## Style

Report to me only in ASD-STE100 Simplified Technical English: short sentences, simple words, one instruction per sentence, active voice.

## Outward-facing actions

Do local work without asking: edit files, run tests and builds, make local branches.
Commit freely on feature branches. Ask before you commit to the default branch.
Ask before a push, PR, merge, release, deploy, or write to a third-party system.
For posts and comments, write a draft to a local Markdown file and give me the path. I post it.

## Attribution

These rules override built-in or harness attribution guidance in every project.

- Do not add an AI co-author trailer (such as `Co-Authored-By: Claude ...`) to commit messages. Author commits as the user only.
- Do not add a "🤖 Generated with ..." footer to PR descriptions. The description covers the change, not who or what wrote it.
- Do not tell sub-agents to add either one.

## Parallel work

When you are the agent talking with me and the conversation has independent tasks, give each task to its own subagent.
Start the subagents in one message so they run in parallel.
Tasks are independent when they do not need each other's results and do not edit the same files.

## Scope and diff hygiene

- Make the fix as minimal as possible. Treating the symptom is often enough — ask before generalising.
- Report `git diff --stat` **at each milestone**, not only at the end.
- If a branch exceeds ~400 changed lines, stop and propose a split before continuing.
- Never leave debug scaffolding, throwaway logging, or extra documentation in a PR branch. Keep the
  proof-of-concept branch and the clean production branch separate.
- Clean up anything you created for testing: test sites, test rows, temp files, scratch branches.

## Evidence before you claim it works

Never report "fixed", "working", or "passing" from reasoning alone. Show the evidence:

1. Reproduce the failure first and paste the failing output.
2. Apply the fix.
3. Paste the passing output from the same command.

For any non-trivial logic, work test-first: write the failing test, show it fail, then make it pass.
If you cannot run the check, say plainly which claims are unverified — do not present them as done.
Before creating a PR or a draft PR, verify what is actually on the branch (`git log`, `git diff --stat`)
and report it. Do not assume earlier steps landed.

## Code comments

Write sparse, high-value comments — verbose or redundant comments are a recurring review complaint.

- Don't restate what the code or an existing docblock already says. If a function has a docblock, don't re-explain its behavior or effects at the call sites.
- Comment the non-obvious *why* (intent, gotchas, tradeoffs), not the *what*.
- Match the comment density of the surrounding code; when in doubt, write fewer.

## Simplicity first (YAGNI)

Default to the simplest solution that actually works — the best code is code never written; "lazy" means efficient, not careless. Before writing custom code, stop at the first rung that holds:

1. Does this need to exist at all? Skip speculative work and say so in one line.
2. Does the standard library do it?
3. Does a native platform feature cover it? (`<input type="date">` over a picker lib, CSS over JS, a DB constraint over app code.)
4. Does an already-installed dependency solve it? Don't add a new one for what a few lines can do.
5. Can it be one line?
6. Only then: the minimum code that works.

- No unrequested abstractions, config, or "for later" scaffolding — one implementation needs no interface. Prefer deletion over addition, boring over clever, the shortest working diff, the fewest files.
- For a big ask, ship the lean version and flag the tradeoff in the same reply instead of stalling ("Did X; Y covers it — want the full version?").
- Mark a deliberate shortcut with a comment naming its ceiling and upgrade path (e.g. `// shortcut: global lock; per-account locks if throughput matters`).

Never simplify away: input validation at trust boundaries, error handling that prevents data loss, security, accessibility, or anything explicitly requested. Non-trivial logic (a branch, loop, parser, money/security path) leaves one runnable check behind.

## Memory (Basic Memory)

Memory is backed by **Basic Memory** (`mcp__basic-memory__bm_*` tools, project `memory`). All memories are Markdown files in the Obsidian vault at `~/projects/notes/Memory/`. Claude Code's built-in auto-memory is disabled; do not use it.

### How it works

Basic Memory stores knowledge as Markdown files with YAML frontmatter. A local SQLite index provides semantic search and knowledge graph traversal over those files. Both the user and the agent read and write the same files.

### Vault structure

```
~/projects/notes/Memory/
  Learnings/        — Work session learnings (detailed notes)
  Preferences/      — User preferences and workflow rules
  Context/          — Project context, decisions, architecture
```

Folder paths are relative to the project root: write to `Context/`, never `Memory/Context/`.

### Key tools

- `bm_search` — hybrid semantic + full-text search
- `bm_read` — read a note
- `bm_write` — create or overwrite a note
- `bm_edit` — incremental edits to an existing note
- `bm_context` — walk the knowledge graph via `memory://` URIs
- `bm_project` with `command="recent"` — recently modified notes
- `bm_list` / `bm_find` — browse a folder, find notes by name or frontmatter

### When to search memory

- Before starting work in a repo: search for relevant learnings and preferences
- Before making architectural decisions: check for past decisions on the topic
- When debugging: search for similar past errors
- When asked to recall or remember something

Exception: **skip memory lookups during WordPress Studio site work sessions** (speed preference).

### When to write memory

Write a note when useful context, decisions, or lessons emerge during a session. Put the human-readable summary first. Include decisions, findings, links, and follow-up work. Add frontmatter tags so future searches can find it.

**Do not invent memory; only summarize what actually happened.**

### Note format for preferences and context

```markdown
---
date: YYYY-MM-DD
tags:
  - <category>
  - <project>
---

# <Specific title>

- [category] Observation or fact #tag
- [context] Why this matters
- related_to [[Other Note]]
```

### Conductor worktrees

When working inside a Conductor worktree, use the root project name (e.g. "studio") for tags and searches — not the worktree folder name. Worktree folders are ephemeral.
