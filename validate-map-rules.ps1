# ==============================================================================
# Script to validate regex rules in Rspamd map files
# ==============================================================================
# 
# This script checks that all rules in .map files:
# - Start with "/"
# - End with "/i" or "/iu" (or "/" for *.ucase.map)
# - Use /iu when german umlauts are present (except *.ucase.map)
# - Do not contain double pipe (||)
# - Use quantifiers only after a valid token
# - Have balanced brackets and parentheses
#
# Usage: .\validate-map-rules.ps1
# ==============================================================================

param(
    [string]$Path = ".\maps.d",
    [switch]$Verbose
)

$SKIP_HINT = "# AI Hint: No RegEx"

# Rule IDs
$RULE_FORMAT_START = "FORMAT_START"
$RULE_FORMAT_END = "FORMAT_END"
$RULE_UMLAUT_FLAG = "UMLAUT_FLAG"
$RULE_DOUBLE_PIPE = "DOUBLE_PIPE"
$RULE_QUANTIFIER = "QUANTIFIER"
$RULE_BRACKETS = "BRACKETS"

function Add-ValidationError {
    param(
        [string]$File,
        [int]$Line,
        [string]$Content,
        [string]$RuleId,
        [string]$Issue,
        [System.Collections.ArrayList]$ErrorList
    )

    [void]$ErrorList.Add([PSCustomObject]@{
        File = $File
        Line = $Line
        RuleId = $RuleId
        Issue = $Issue
        Content = $Content
    })
}

function Get-LineWithoutScore {
    param(
        [string]$Line
    )

    if ($Line -match '^(?<core>.+?)(?:\s+[+-]?\d+(?:\.\d+)?)?$') {
        return $Matches['core']
    }

    return $Line
}

function Get-LastUnescapedSlashIndex {
    param(
        [string]$Text
    )

    if ([string]::IsNullOrEmpty($Text)) {
        return -1
    }

    $escaped = $false
    $lastSlash = -1

    for ($i = 0; $i -lt $Text.Length; $i++) {
        $ch = $Text[$i]

        if ($escaped) {
            $escaped = $false
            continue
        }

        if ($ch -eq '\') {
            $escaped = $true
            continue
        }

        if ($ch -eq '/') {
            $lastSlash = $i
        }
    }

    return $lastSlash
}

function Parse-RegexLine {
    param(
        [string]$Line
    )

    $lineWithoutScore = Get-LineWithoutScore -Line $Line

    if (-not $lineWithoutScore.StartsWith('/')) {
        return [PSCustomObject]@{
            Parsed = $false
            Body = $null
            Flags = $null
        }
    }

    $lastSlash = Get-LastUnescapedSlashIndex -Text $lineWithoutScore
    if ($lastSlash -le 0) {
        return [PSCustomObject]@{
            Parsed = $false
            Body = $null
            Flags = $null
        }
    }

    $body = $lineWithoutScore.Substring(1, $lastSlash - 1)
    $flags = $lineWithoutScore.Substring($lastSlash + 1)

    return [PSCustomObject]@{
        Parsed = $true
        Body = $body
        Flags = $flags
    }
}

function Test-RegexSyntax {
    param(
        [string]$PatternBody
    )

    $hasDoublePipe = $false
    $hasInvalidQuantifier = $false
    $hasBracketError = $false

    $parenDepth = 0
    $inCharClass = $false
    $escaped = $false
    $previousCanBeQuantified = $false

    for ($i = 0; $i -lt $PatternBody.Length; $i++) {
        $ch = $PatternBody[$i]

        if ($escaped) {
            $escaped = $false
            $previousCanBeQuantified = $true
            continue
        }

        if ($ch -eq '\') {
            $escaped = $true
            continue
        }

        if ($inCharClass) {
            if ($ch -eq ']') {
                $inCharClass = $false
                $previousCanBeQuantified = $true
            }
            continue
        }

        switch ($ch) {
            '[' {
                $inCharClass = $true
                $previousCanBeQuantified = $false
                continue
            }
            ']' {
                $hasBracketError = $true
                $previousCanBeQuantified = $false
                continue
            }
            '(' {
                $parenDepth++
                $previousCanBeQuantified = $false
                continue
            }
            ')' {
                if ($parenDepth -eq 0) {
                    $hasBracketError = $true
                } else {
                    $parenDepth--
                }
                $previousCanBeQuantified = $true
                continue
            }
            '|' {
                if (($i + 1) -lt $PatternBody.Length -and $PatternBody[$i + 1] -eq '|') {
                    $hasDoublePipe = $true
                }
                $previousCanBeQuantified = $false
                continue
            }
            '*' {
                if (-not $previousCanBeQuantified) {
                    $hasInvalidQuantifier = $true
                }
                $previousCanBeQuantified = $true
                continue
            }
            '+' {
                if (-not $previousCanBeQuantified) {
                    $hasInvalidQuantifier = $true
                }
                $previousCanBeQuantified = $true
                continue
            }
            '?' {
                # (?...) starts non-capturing / lookaround groups and is valid.
                if (-not $previousCanBeQuantified -and -not ($i -gt 0 -and $PatternBody[$i - 1] -eq '(')) {
                    $hasInvalidQuantifier = $true
                }
                $previousCanBeQuantified = $true
                continue
            }
            '{' {
                $closeIndex = $PatternBody.IndexOf('}', $i + 1)
                if ($closeIndex -lt 0) {
                    $hasBracketError = $true
                    $previousCanBeQuantified = $false
                    continue
                }

                $quantText = $PatternBody.Substring($i + 1, $closeIndex - $i - 1)
                if ($quantText -match '^\d+(,\d*)?$') {
                    if (-not $previousCanBeQuantified) {
                        $hasInvalidQuantifier = $true
                    }
                    $previousCanBeQuantified = $true
                    $i = $closeIndex
                    continue
                }

                # A paired but malformed quantifier is a quantifier error, not a bracket-pair error.
                $hasInvalidQuantifier = $true
                $previousCanBeQuantified = $false
                $i = $closeIndex
                continue
            }
            '^' {
                $previousCanBeQuantified = $false
                continue
            }
            '$' {
                $previousCanBeQuantified = $false
                continue
            }
            default {
                $previousCanBeQuantified = $true
                continue
            }
        }
    }

    if ($escaped -or $inCharClass -or $parenDepth -ne 0) {
        $hasBracketError = $true
    }

    return [PSCustomObject]@{
        HasDoublePipe = $hasDoublePipe
        HasInvalidQuantifier = $hasInvalidQuantifier
        HasBracketError = $hasBracketError
    }
}

# Initialize counters
$totalFiles = 0
$totalRules = 0
$invalidRules = 0
$skippedFiles = 0
$errors = New-Object System.Collections.ArrayList
$ruleCounts = @{}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Rspamd Map Rules Validator" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Get all .map files recursively
$mapFiles = Get-ChildItem -Path $Path -Filter "*.map" -Recurse -File |
    Where-Object {
        $_.FullName -notmatch '[\\/](?:_offduty|legacy)(?:[\\/]|$)'
    }

if ($mapFiles.Count -eq 0) {
    Write-Host "No .map files found in path: $Path" -ForegroundColor Yellow
    exit 1
}

Write-Host "Found $($mapFiles.Count) map files to validate..." -ForegroundColor Green
Write-Host ""

foreach ($file in $mapFiles) {
    $totalFiles++
    $fileHasErrors = $false
    $lineNumber = 0
    $fileErrorsPrinted = $false
    $isUcaseFile = $file.Name -match '\.ucase'
    
    if ($Verbose) {
        Write-Host "Checking: $($file.FullName)" -ForegroundColor Gray
        if ($isUcaseFile) {
            Write-Host "  (ucase file - checking for /.../ format only)" -ForegroundColor DarkGray
        }
    }
    
    try {
        $content = Get-Content -Path $file.FullName -Encoding UTF8 -ErrorAction Stop

        if ($content -contains $SKIP_HINT) {
            $skippedFiles++
            if ($Verbose) {
                Write-Host "  Skipped (AI hint: No RegEx)" -ForegroundColor DarkYellow
            }
            continue
        }
        
        foreach ($line in $content) {
            $lineNumber++
            
            # Trim whitespace
            $trimmedLine = $line.Trim()
            
            # Skip empty lines and comments
            if ($trimmedLine -eq "" -or $trimmedLine.StartsWith("#")) {
                continue
            }
            
            # This should be a regex rule
            $totalRules++

            $lineErrors = New-Object System.Collections.ArrayList

            if (-not $trimmedLine.StartsWith('/')) {
                Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                    -Line $lineNumber -Content $trimmedLine -RuleId $RULE_FORMAT_START `
                    -Issue "Does not start with '/'" -ErrorList $lineErrors
            }

            $parsed = Parse-RegexLine -Line $trimmedLine
            if (-not $parsed.Parsed) {
                Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                    -Line $lineNumber -Content $trimmedLine -RuleId $RULE_FORMAT_END `
                    -Issue "Cannot parse regex delimiters and flags" -ErrorList $lineErrors
            } else {
                if ($isUcaseFile) {
                    if ($parsed.Flags -ne "") {
                        Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                            -Line $lineNumber -Content $trimmedLine -RuleId $RULE_FORMAT_END `
                            -Issue "Ucase rule must end with '/' (optional score only)" -ErrorList $lineErrors
                    }
                } else {
                    if ($parsed.Flags -ne "i" -and $parsed.Flags -ne "iu") {
                        Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                            -Line $lineNumber -Content $trimmedLine -RuleId $RULE_FORMAT_END `
                            -Issue "Rule must end with '/i' or '/iu' (optional score)" -ErrorList $lineErrors
                    }

                    if ($parsed.Body -match '[äöüÄÖÜß]' -and $parsed.Flags -ne 'iu') {
                        Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                            -Line $lineNumber -Content $trimmedLine -RuleId $RULE_UMLAUT_FLAG `
                            -Issue "Pattern with german umlauts must use '/iu'" -ErrorList $lineErrors
                    }
                }

                $syntax = Test-RegexSyntax -PatternBody $parsed.Body

                if ($syntax.HasDoublePipe) {
                    Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                        -Line $lineNumber -Content $trimmedLine -RuleId $RULE_DOUBLE_PIPE `
                        -Issue "Contains double pipe '||'" -ErrorList $lineErrors
                }

                if ($syntax.HasInvalidQuantifier) {
                    Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                        -Line $lineNumber -Content $trimmedLine -RuleId $RULE_QUANTIFIER `
                        -Issue "Quantifier does not have a valid preceding token" -ErrorList $lineErrors
                }

                if ($syntax.HasBracketError) {
                    Add-ValidationError -File $file.FullName.Replace((Get-Location).Path + "\", "") `
                        -Line $lineNumber -Content $trimmedLine -RuleId $RULE_BRACKETS `
                        -Issue "Unbalanced or invalid bracket usage" -ErrorList $lineErrors
                }
            }

            if ($lineErrors.Count -gt 0) {
                $invalidRules += $lineErrors.Count
                $fileHasErrors = $true

                if (-not $fileErrorsPrinted) {
                    Write-Host ""
                    Write-Host "[FILE] $($file.FullName)" -ForegroundColor Magenta
                    $fileErrorsPrinted = $true
                }

                foreach ($lineError in $lineErrors) {
                    [void]$errors.Add($lineError)

                    if (-not $ruleCounts.ContainsKey($lineError.RuleId)) {
                        $ruleCounts[$lineError.RuleId] = 0
                    }
                    $ruleCounts[$lineError.RuleId]++

                    Write-Host "  [ERROR] Line $lineNumber" -ForegroundColor Red -NoNewline
                    Write-Host " [$($lineError.RuleId)]" -ForegroundColor DarkRed -NoNewline
                    Write-Host ": $trimmedLine" -ForegroundColor Yellow
                    Write-Host "          Issue: $($lineError.Issue)" -ForegroundColor Red
                }
            }
        }
        
        if ($Verbose -and -not $fileHasErrors) {
            Write-Host "  OK" -ForegroundColor Green
        }
        
    } catch {
        Write-Host "  [ERROR] Failed to read file: $($file.Name)" -ForegroundColor Red
        Write-Host "          Reason: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Summary
Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Validation Summary" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Files checked:    $totalFiles" -ForegroundColor White
Write-Host "Files skipped:    $skippedFiles" -ForegroundColor White
Write-Host "Rules validated:  $totalRules" -ForegroundColor White
Write-Host "Violations found: $invalidRules" -ForegroundColor $(if ($invalidRules -eq 0) { "Green" } else { "Red" })

if ($ruleCounts.Count -gt 0) {
    Write-Host "" 
    Write-Host "Violations by rule:" -ForegroundColor White
    foreach ($ruleKey in ($ruleCounts.Keys | Sort-Object)) {
        Write-Host ("  {0,-14} {1}" -f $ruleKey, $ruleCounts[$ruleKey]) -ForegroundColor White
    }
}
Write-Host ""

if ($errors.Count -eq 0) {
    Write-Host "[OK] All rules are valid!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "[ERROR] Found $($errors.Count) validation violation(s)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please fix the issues listed above." -ForegroundColor Yellow
    
    # Optional: Export errors to CSV
    if ($errors.Count -gt 0) {
        $csvPath = ".\validation-errors.csv"
        $errors |
            Sort-Object File, Line, RuleId, Issue -Unique |
            Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        Write-Host ""
        Write-Host "Errors exported to: $csvPath" -ForegroundColor Cyan
    }
    
    exit 1
}
