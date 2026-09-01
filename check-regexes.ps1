param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,

    [Parameter(Mandatory = $true)]
    [string]$RegexFile,

    [int]$MaxMatches = 100
)

if (-not (Test-Path -LiteralPath $InputFile)) {
    throw "Input-Datei nicht gefunden: $InputFile"
}

if (-not (Test-Path -LiteralPath $RegexFile)) {
    throw "Regex-Datei nicht gefunden: $RegexFile"
}

$sourceLines = Get-Content -Path $InputFile -ErrorAction Stop
$regexLines = Get-Content -Path $RegexFile -ErrorAction Stop

$patterns = @()

foreach ($line in $regexLines) {
    $trimmed = $line.Trim()

    if (-not $trimmed) { continue }
    if ($trimmed.StartsWith('#')) { continue }
    if ($trimmed.StartsWith('//')) { continue }

    if ($trimmed.StartsWith('/') -and $trimmed.Contains('/')) {
        $lastSlashIndex = $trimmed.LastIndexOf('/')
        if ($lastSlashIndex -gt 0) {
            $pattern = $trimmed.Substring(1, $lastSlashIndex - 1)
            $optionsText = $trimmed.Substring($lastSlashIndex + 1)

            $regexOptions = [System.Text.RegularExpressions.RegexOptions]::None
            if ($optionsText -match 'i') { $regexOptions = $regexOptions -bor [System.Text.RegularExpressions.RegexOptions]::IgnoreCase }
            if ($optionsText -match 'm') { $regexOptions = $regexOptions -bor [System.Text.RegularExpressions.RegexOptions]::Multiline }
            if ($optionsText -match 's') { $regexOptions = $regexOptions -bor [System.Text.RegularExpressions.RegexOptions]::Singleline }
            if ($optionsText -match 'x') { $regexOptions = $regexOptions -bor [System.Text.RegularExpressions.RegexOptions]::IgnorePatternWhitespace }

            $patterns += [PSCustomObject]@{
                Pattern     = $pattern
                Options     = $regexOptions
                RegexLine   = $line
            }
        }
    }
}

if ($patterns.Count -eq 0) {
    Write-Host "Keine gültigen Regex-Einträge in der Datei gefunden: $RegexFile" -ForegroundColor Yellow
    exit 1
}

$results = @()

foreach ($source in $sourceLines) {
    foreach ($entry in $patterns) {
        try {
            if ([regex]::IsMatch($source, $entry.Pattern, $entry.Options)) {
                $results += [PSCustomObject]@{
                    Source    = $source
                    Regex     = $entry.RegexLine
                    Pattern   = $entry.Pattern
                }

                if ($results.Count -ge $MaxMatches) {
                    break
                }
            }
        }
        catch {
            Write-Warning "Ungültiger Regex: $($entry.RegexLine)"
        }
    }

    if ($results.Count -ge $MaxMatches) {
        break
    }
}

if ($results.Count -eq 0) {
    Write-Host "Keine Treffer gefunden." -ForegroundColor Green
    exit 0
}

Write-Host "Treffer gefunden: $($results.Count)" -ForegroundColor Cyan
$results | Select-Object -First $MaxMatches | Format-Table -AutoSize Source, Regex

exit 0

<#+
Beispiel:
.
.\check-regexes.ps1 -InputFile .\test.txt -RegexFile .\maps.d\sender\en\sender.from.en.health.map
+
#>
