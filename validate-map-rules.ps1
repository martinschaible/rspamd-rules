# ==============================================================================
# Script to validate regex rules in Rspamd map files
# ==============================================================================
# 
# This script checks that all rules in .map files:
# - Start with "/"
# - End with "/i" or "/iu"
#
# Usage: .\validate-map-rules.ps1
# ==============================================================================

param(
    [string]$Path = ".\maps.d",
    [switch]$Verbose
)

# Initialize counters
$totalFiles = 0
$totalRules = 0
$invalidRules = 0
$errors = @()

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Rspamd Map Rules Validator" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Get all .map files recursively
$mapFiles = Get-ChildItem -Path $Path -Filter "*.map" -Recurse -File

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
            
            # Check format based on file type
            $isValid = $false
            
            if ($isUcaseFile) {
                # For .ucase files: only check for /.../ format (with optional score)
                # Valid formats: /REGEX/, /REGEX/ -10.0, /REGEX/ +5.5
                if ($trimmedLine -match '^/.+/(?:\s+[+-]?\d+(?:\.\d+)?)?$') {
                    $isValid = $true
                }
            } else {
                # For normal files: check for /.../(i|iu|g) format (with optional score)
                # Valid formats: /regex/i, /regex/iu, /regex/g, /regex/i -10.0, /regex/iu +5.5
                if ($trimmedLine -match '^/.*/(?:iu?|g)(?:\s+[+-]?\d+(?:\.\d+)?)?$') {
                    $isValid = $true
                }
            }
            
            if (-not $isValid) {
                $invalidRules++
                $fileHasErrors = $true
                
                # Print file header only once when first error is found
                if (-not $fileErrorsPrinted) {
                    Write-Host ""
                    Write-Host "[FILE] $($file.FullName)" -ForegroundColor Magenta
                    $fileErrorsPrinted = $true
                }
                
                $errorInfo = [PSCustomObject]@{
                    File = $file.FullName.Replace((Get-Location).Path + "\", "")
                    Line = $lineNumber
                    Content = $trimmedLine
                    Issue = if (-not $trimmedLine.StartsWith("/")) {
                        "Does not start with '/'"
                    } elseif ($isUcaseFile) {
                        "Does not end with '/' (optionally with score) - ucase format: /REGEX/"
                    } elseif (-not ($trimmedLine -match '/(iu?|g)(?:\s+[+-]?\d+(?:\.\d+)?)?$')) {
                        "Does not end with '/i', '/iu', or '/g' (optionally with score)"
                    } else {
                        "Invalid format"
                    }
                }
                
                $errors += $errorInfo
                
                Write-Host "  [ERROR] Line $lineNumber" -ForegroundColor Red -NoNewline
                Write-Host ": $trimmedLine" -ForegroundColor Yellow
                Write-Host "          Issue: $($errorInfo.Issue)" -ForegroundColor Red
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
Write-Host "Rules validated:  $totalRules" -ForegroundColor White
Write-Host "Invalid rules:    $invalidRules" -ForegroundColor $(if ($invalidRules -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($invalidRules -eq 0) {
    Write-Host "[OK] All rules are valid!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "[ERROR] Found $invalidRules invalid rule(s)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please fix the issues listed above." -ForegroundColor Yellow
    
    # Optional: Export errors to CSV
    if ($errors.Count -gt 0) {
        $csvPath = ".\validation-errors.csv"
        $errors | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        Write-Host ""
        Write-Host "Errors exported to: $csvPath" -ForegroundColor Cyan
    }
    
    exit 1
}
