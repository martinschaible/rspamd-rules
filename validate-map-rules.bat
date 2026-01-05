@echo off
REM ==============================================================================
REM Batch wrapper for validate-map-rules.ps1
REM ==============================================================================

PowerShell -ExecutionPolicy Bypass -File "%~dp0validate-map-rules.ps1" %*
pause
