---
name: safe-script-policy
description: 'Use when user asks to avoid external scripts, restrict shell script execution, or allow only specific script exceptions in this workspace.'
argument-hint: 'Optional: add allowed script names (comma-separated), e.g. validate-map-rules.ps1, validate-map-rules.bat'
user-invocable: true
---

# Safe Script Policy (Strict)

## Goal
Never execute external scripts in this workspace.

## Default Rule
Never run external scripts. No exceptions.

## Exception List (Workspace)
No exceptions.

## Behavior
1. First, use non-script alternatives (direct file edits, static checks, native tools).
2. If script execution would help, explain that it is blocked by workspace policy.
3. If needed, ask the user to run the script manually outside the agent workflow.
4. Never run downloaded or remote scripts.
5. Never run scripts outside the workspace.

## Notes
- This policy guides behavior and is not a hard technical sandbox.
- For technical enforcement, add a PreToolUse hook with deny rules for script files.
