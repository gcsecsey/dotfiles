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

## Work Notes

Maintain a Zettelkasten-style note in my Obsidian vault for each meaningful unit of work, writing on an ongoing basis as you work. Review and finalize the note at completion points (creating a PR, merging, completing an implementation, resolving a bug), then reference it from today's daily note.

### How it works

1. **When to write**: Start writing the note when beginning a meaningful unit of work, and update it continuously as you make progress, discover insights, or encounter challenges. Plan files (`.claude/plans/`) can be used as source material. At completion points (PR created, code committed for review, bug resolved, or a significant investigation concluded), review the note to ensure it accurately captures the full context and outcomes.
2. **Where to write**: `~/projects/notes/Claude Notes/`
3. **Filename**: `<PREFIX> <descriptive-title>.md` where the prefix identifies the work source:
   - `STU-1234` / `DOTDEV-567` — Linear issue ID (most common)
   - `PR-1234` — GitHub PR number (use repo-scoped form `PR-studio-1234` if ambiguous)
   - `SLACK-<channel>-<threadTs>` — Slack thread reference
   - `P2DRAFT-<slug>` — P2 post draft
   - `INVESTIGATION-<topic>` — exploratory work without a ticket
   - Examples: `STU-1199 Benchmark site editor performance.md`, `PR-2212 Resumable uploads for Studio sync.md`, `P2DRAFT-sync-architecture Sync architecture proposal.md`
4. **Note format**:
   ```markdown
   # <Title>

   **Source**: <repository name, branch, PR link if available>
   **Date**: YYYY-MM-DD
   **Tags**: #<project> #<technology> #<type: bugfix|feature|refactor|investigation>

   ## Context

   What problem were we solving and why.

   ## What we did

   Concise summary of the approach and key decisions. Reference specific files and functions.
   Link to the PR or commit if available.

   ## Key takeaways

   What's worth remembering — gotchas, patterns discovered, decisions and their reasoning.

   ## Related

   - [[links to related vault notes if any]]
   ```
5. **Daily note reference**: After creating the note, append a bullet to `## Journal` in today's daily note (`~/projects/notes/Daily/YYYY-MM-DD.md`), linking to the new note:
   ```
   - Created [[YYYYMMDDHHMMSS descriptive-title]] — one-line summary of the work
   ```
   If the daily note doesn't exist yet, create it with `## To Do` and `## Journal` sections.

### Guidelines

- Keep notes atomic — one note per unit of work, not one note per session
- Write for my future self: assume I've forgotten the context
- Use [[wikilinks]] to connect to existing vault notes when relevant
- Don't duplicate the full PR description; focus on context and reasoning that wouldn't be obvious from the diff
