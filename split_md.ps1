# Set the path for the Markdown file
$markdownFilePath = "\\mcifs02\jlhuber$\Work\Vorlesungen\2023_WiSe_BioDataScience\docs\Visualisierung und Datenbanken.md"

# Read the contents of the Markdown file
$markdownContent = Get-Content $markdownFilePath

# Regular expression pattern to match second-level headers (## Headername)
$headerPattern = '^## (.*)$'

# Initialize variables
$currentHeader = $null
$headerContent = @()

# Loop through each line in the Markdown file
foreach ($line in $markdownContent) {
    if ($line -match $headerPattern) {
        # If a new second-level header is found, save the previous header content to a file
        if ($currentHeader -ne $null) {
            $headerFileName = "$currentHeader.md"
            $headerFilePath = Join-Path (Get-Location) $headerFileName
            $headerContent | Set-Content -Path $headerFilePath
            Write-Host "Saved $headerFileName"
        }

        # Update current header and reset header content array
        $currentHeader = $matches[1]
        $headerContent = @()
    }

    # Add the line to the current header's content
    $headerContent += $line
}

# Save the last header's content to a file
if ($currentHeader -ne $null) {
    $headerFileName = "$currentHeader.md"
    $headerFilePath = Join-Path (Get-Location) $headerFileName
    $headerContent | Set-Content -Path $headerFilePath
    Write-Host "Saved $headerFileName"
}