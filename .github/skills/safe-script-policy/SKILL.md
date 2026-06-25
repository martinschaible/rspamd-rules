---
name: safe-script-policy
description: 'Use when user asks to avoid external scripts, restrict shell script execution, or allow only specific script exceptions in this workspace.'
argument-hint: 'Optional: add allowed script names (comma-separated), e.g. validate-map-rules.ps1, validate-map-rules.bat'
user-invocable: true
---

# Safe Script Policy (Soft)

## Goal
Prefer solutions that do not execute external scripts.

This is a soft policy:
- The agent should avoid script execution by default.
- The agent may run scripts that are explicitly allowed as exceptions.
- The user can approve additional exceptions per request.

## Default Rule
Do not run external scripts unless one of these is true:
1. The script is in the exception list below.
2. The user explicitly approves a one-time exception in the current chat.

## Exception List (Workspace)
No default exceptions are configured yet.

Until the exception list is defined, any external script execution requires
explicit one-time approval from the user in the current chat.

## Behavior
1. First, try non-script alternatives (direct file edits, static checks, native tools).
2. If script execution would help, check if it matches the exception list.
3. If it is allowed, run the script with a short explanation.
4. If no exceptions are configured, ask for explicit one-time approval before running.
5. If it is not allowed, ask for explicit one-time approval before running.
6. Never run downloaded or remote scripts.
7. Never run scripts outside the workspace unless user explicitly requests it.

## Notes
- This policy guides behavior and is not a hard technical sandbox.
- For hard enforcement, use a PreToolUse hook with deny rules.
