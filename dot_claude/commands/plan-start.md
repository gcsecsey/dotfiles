---
description: Start a new plan with optional Linear issue integration. Creates a plan file in .gcsecsey/ with problem, solution, and implementation steps.
---

# Plan Start

You are helping the user start a new plan for a piece of work.

## Workflow

### 1. Parse Input for Linear Issue

Check `$ARGUMENTS` for a Linear issue reference:
- **Issue ID pattern:** `[A-Z]+-\d+` (e.g., `ABC-123`, `TEAM-456`)
- **Linear URL pattern:** Extract issue ID from URLs like `https://linear.app/*/issue/ABC-123*`

### 2. Fetch Linear Issue (if found)

If a Linear issue ID was detected:
1. Load the Linear provider: use `mcp__plugin_context-a8c_context-a8c__context-a8c-load-provider` with provider "linear"
2. Fetch the issue using `mcp__plugin_context-a8c_context-a8c__context-a8c-execute-tool` with:
   - provider: "linear"
   - tool: "get-issue"
   - params: { "issueId": "[THE-ID]" }
3. Extract: title, description, acceptance criteria (if present)

### 3. Setup .gcsecsey/ Folder

1. Check if `.gcsecsey/` exists in the current project root
2. If not, create it: `mkdir -p .gcsecsey`
3. Check if `.gcsecsey` is in `.gitignore`
4. If not, append `.gcsecsey` to `.gitignore` (create the file if it doesn't exist)

### 4. Ask Planning Questions

Ask the user these questions to build the plan. Use the AskUserQuestion tool or conversational questions:

**If Linear issue exists:**
- Review the Linear description and acceptance criteria
- Ask: "What's your proposed solution/approach?"
- Ask: "What are the implementation steps?" (ask for 3-7 concrete steps)

**If no Linear issue:**
- Ask: "What problem does this solve?"
- Ask: "What's your proposed solution/approach?"
- Ask: "What are the implementation steps?" (ask for 3-7 concrete steps)

### 5. Generate Filename

Create the filename automatically:
- Format: `YYYY-MM-DD-[LINEAR-ID-]slug.md`
- Date: Use today's date
- Linear ID: Include if a Linear issue was fetched
- Slug: Derive from Linear issue title OR from the problem statement
  - Lowercase, hyphens instead of spaces
  - Remove special characters
  - Keep it under 50 characters
  - Example: "Add user metrics tracking" -> "add-user-metrics-tracking"

Examples:
- With Linear: `2026-01-26-ABC-123-add-user-metrics-tracking.md`
- Without Linear: `2026-01-26-fix-authentication-timeout.md`

### 6. Create Plan File

Write the plan file to `.gcsecsey/[filename]`:

**If Linear issue exists:**

```markdown
# Linear Issue

**ID:** [ISSUE-ID]
**Title:** [Issue title]
**URL:** https://linear.app/[team]/issue/[ISSUE-ID]

## Description

[Description from Linear]

## Acceptance Criteria

[Acceptance criteria from Linear, or "None specified" if not present]

---

# Plan

## Problem

[Derived from Linear description or user input]

## Solution

[User's proposed solution]

## Implementation Steps

1. [Step 1]
2. [Step 2]
3. [Step 3]
...

## Notes

[Empty - for adding notes during implementation]

---

# PR Description

[To be added when creating PR]
```

**If no Linear issue:**

```markdown
# Plan

## Problem

[User's problem statement]

## Solution

[User's proposed solution]

## Implementation Steps

1. [Step 1]
2. [Step 2]
3. [Step 3]
...

## Notes

[Empty - for adding notes during implementation]

---

# PR Description

[To be added when creating PR]
```

### 7. Create Todo List

Use the TodoWrite tool to create todos from the implementation steps:
- Convert each implementation step to a todo item
- Set all items to "pending" status
- Use imperative form for content (e.g., "Add metrics endpoint")
- Use present continuous for activeForm (e.g., "Adding metrics endpoint")

### 8. Confirm Creation

Tell the user:
- The plan file path (e.g., `.gcsecsey/2026-01-26-ABC-123-add-user-metrics.md`)
- Summary of what was captured
- Remind them the todo list is ready for tracking progress

## Important Notes

- Always create the plan file in `.gcsecsey/` in the current working directory
- The `.gcsecsey` folder is personal and should be gitignored
- If the Linear MCP provider fails, continue without Linear data and note the error
- Keep the slug concise but descriptive
- The plan file should be a complete record - include all relevant context
