# Set the paths for the source directory containing the Markdown file and the destination directory
$sourceDirectory = "\\MCIFS02\jlhuber$\Work\Vorlesungen\2023_SoSo_IoT_1\Slides\images"
$destinationDirectory = "\\MCIFS02\jlhuber$\Work\Vorlesungen\2023_WiSe_IoT2\docs\images"

# Set the path to the Markdown file you want to check for image links
$markdownFilePath = "\\MCIFS02\jlhuber$\Work\Vorlesungen\2023_WiSe_IoT2\docs\IoT_1_BA.md"

# Read the contents of the Markdown file
$markdownContent = Get-Content $markdownFilePath

# Regular expression pattern to match image links in Markdown format
$imageLinkPattern = '!\[.*?\]\((.*?)\)'

# Loop through each line in the Markdown file and search for image links
foreach ($line in $markdownContent) {
    $matches = [regex]::Matches($line, $imageLinkPattern)

    # Check if any image links are found in the line
    if ($matches.Count -gt 0) {
        foreach ($match in $matches) {
            $imageUrl = $match.Groups[1].Value

            # Extract the filename from the URL
            $imageName = [System.IO.Path]::GetFileName($imageUrl)

            # Combine the source directory path and the image filename
            $sourceImagePath = Join-Path $sourceDirectory $imageName

            # Combine the destination directory path and the image filename
            $destinationImagePath = Join-Path $destinationDirectory $imageName

            # Copy the image from the source directory to the destination directory
            Copy-Item -Path $sourceImagePath -Destination $destinationImagePath -Force
        }
    }
}
