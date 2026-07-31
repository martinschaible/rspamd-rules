---
name: safe-script-policy
description: 'Use when user asks to avoid external scripts, restrict shell script execution, or allow only specific script exceptions in this workspace.'
argument-hint: 'Optional: add allowed script names (comma-separated), e.g. validate-map-rules.ps1, validate-map-rules.bat'
user-invocable: true
---

# Safe Script Policy (Strict)

## Goal
Do not execute external scripts.

This is a strict policy:
- The agent must not run external scripts.
- No automatic or ad-hoc exceptions.

## Default Rule
Never run external scripts.

## Exception List (Workspace)
No exceptions.

## Behavior
1. First, use non-script alternatives (direct file edits, static checks, native tools).
2. If script execution would help, do not run it.
3. Explain that script execution is blocked by workspace policy.
4. If needed, ask the user to run the script manually outside the agent workflow.
5. Never run downloaded or remote scripts.
6. Never run scripts outside the workspace.

## Notes
- This policy guides behavior and is not a hard technical sandbox.
- For technical enforcement, add a PreToolUse hook with deny rules for script files.
