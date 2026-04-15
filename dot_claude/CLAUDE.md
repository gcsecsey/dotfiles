## Git commits

Do not commit changes without explicit permission. Only make file changes, then let me know when they're ready to be reviewed and committed.

## Pull Request descriptions

When writing PR descriptions, follow this structure and tone:

### Structure
1. **Related issues** - Link issues with "Fixes" (if PR resolves it) or "Related to" (if separate work needed)
2. **Proposed Changes** - Problem-first explanation, then bullet list of how the PR addresses it
3. **Testing Instructions** - Step-by-step numbered instructions to verify the fix

### Style guidelines
- Explain the problem and its symptoms before describing the solution
- When helpful, first explain how the current system works, then show what breaks
- Use cause-and-effect language ("This happened because...")
- Use contrast to highlight edge cases ("This logic works well for X. However, it breaks when Y...")
- Explain the reasoning behind existing design decisions ("The reason we do it this way is...")
- Add context notes when a change's value isn't immediately obvious (e.g., internal tooling improvements)
- Reference specific files, functions, and related PRs when relevant
- Break down complex changes into numbered points
- Keep testing steps concrete and reproducible
- Avoid vague descriptions; be technically specific

## Learnings

Capture learnings from meaningful work in the Obsidian vault. Write for my future self — assume I have forgotten all context.

### Auto-invocation

The `/learnings` skill has auto modes. Invoke it at these lifecycle points:

1. **After committing** — invoke `/learnings auto-commit` after creating a git commit. The skill applies its own quality gate and stays silent if there's nothing worth capturing.
2. **After creating a PR** — invoke `/learnings auto-pr` after running `gh pr create`. This is a natural summary point where the full arc of work is visible.
3. **After merging a PR** — invoke `/learnings auto-merge` after running `gh pr merge`. Review discussions often contain valuable insights from reviewers.

The skill handles deduplication (finding and updating existing learnings for the same work unit) and quality gating (skipping trivial work) internally. Trust it to stay silent when appropriate.

### When to write (manual)

Start a draft early when work looks substantial, update as you go, and finalize at completion points (PR created, bug resolved, investigation concluded). Plan files (`.claude/plans/`) can be used as source material.

**Write when**: PR created/merged, non-trivial bug resolved, significant investigation concludes, meaningful gotcha or pattern discovered.

**Skip when**: trivial work (typo fix, dependency bump, simple config), nothing beyond what the PR/issue already captures, purely informational sessions.

**Quality gate**: Before writing, ask "Is there something my future self would want to know that isn't obvious from the PR diff or issue?" If no, skip it.

### Where to write

`~/projects/notes/Learnings/`

### Filename

```
YYYY-MM-DDTHHMM <PREFIX> <descriptive-title>.md
```

Use the current timestamp. The PREFIX is optional and identifies the work source:
- `STU-1234` / `DOTDEV-567` — Linear issue ID (most common)
- `PR-1234` — GitHub PR number (use repo-scoped form `PR-studio-1234` if ambiguous)
- `SLACK-<channel>-<threadTs>` — Slack thread reference
- `P2DRAFT-<slug>` — P2 post draft
- `INVESTIGATION-<topic>` — exploratory work without a ticket

If the learning is a standalone insight without an external reference, omit the prefix.

Examples:
- `2026-02-04T1100 STU-1249 Fix CLI installation for AppX packages.md`
- `2026-03-04T1530 Auditing commercial WooCommerce payment plugins.md`
- `2026-03-06T0930 INVESTIGATION-saferpay-audit Saferpay security findings.md`

### Note format

```markdown
---
date: YYYY-MM-DD
tags:
  - <technology or language>
  - <project or repo name>
  - <category: bugfix|feature|refactor|investigation|performance|architecture|tooling|debugging|pattern>
source: <repo name, branch, PR link if applicable>
---

# <Descriptive title>

## Context

What we were doing and what problem we were solving.
2-4 sentences. Assume the reader has forgotten everything.

## What happened

What we tried, what we observed, what the root cause was.
Reference specific files, functions, line numbers, and git commits.
Link to the PR or commit if available.

## Code patterns

Specific code snippets, configurations, or patterns worth remembering.
Use fenced code blocks with language tags. Keep snippets minimal.
(Omit this section if there are no code-level takeaways.)

## Key takeaways

Bullet list of the most important things to remember.
Each bullet should be self-contained and scannable.

## Rules

Compressed, actionable guidelines derived from this experience:
- **Do**: <thing to do>
- **Don't**: <thing to avoid>
- **Watch out for**: <gotcha or edge case>
(Omit this section if there are no prescriptive rules to extract.)

## Related

- [[wikilinks to related vault notes]]
```

### Daily note reference

After creating or updating a learning, add it under a `## Learnings` heading in today's daily note (`~/projects/notes/Daily/YYYY-MM-DD.md`). Place this heading above `## Journal`:

```
## Learnings

- [[FILENAME]] — one-line summary
```

Only add the `## Learnings` heading when there are learnings for that day. If the daily note doesn't exist, create it with `## To Do`, `## Learnings`, and `## Journal` sections.

### Guidelines

- Keep learnings **atomic** — one per unit of work or insight, not a session dump
- Write for a future reader with **zero context**
- **Specific > general**: reference exact file paths, function names, error messages, commit SHAs
- The "Rules" section should be **compressed and prescriptive** — imagine grep will surface these lines in the future
- If there isn't enough substance for a meaningful learning, don't force it
- Use [[wikilinks]] to connect to existing vault notes
- Don't duplicate the full PR description; focus on context and reasoning not obvious from the diff