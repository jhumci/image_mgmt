# Set the paths for the directory containing the Markdown files and the images
$markdownDirectory = "\\MCIFS02\jlhuber$\Work\Vorlesungen\2023_WiSe_BioDataScience\docs"
$imageDirectory = "\\MCIFS02\jlhuber$\Work\Vorlesungen\2023_WiSe_BioDataScience\docs\images"

# Get all the image files in the image directory
$imageFiles = Get-ChildItem -Path $imageDirectory -Filter "*.jpg" -File

# Create a list to store the names of used image files
$usedImageNames = @()

# Loop through each Markdown file in the directory
foreach ($markdownFile in Get-ChildItem -Path $markdownDirectory -Filter "*.md" -File) {
    $markdownContent = Get-Content $markdownFile.FullName

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

                # Add the image name to the list of used images
                if ($imageName -notin $usedImageNames) {
                    $usedImageNames += $imageName
                }
            }
        }
    }
}

# Loop through all the image files and delete those that are not used
foreach ($imageFile in $imageFiles) {
    $imageName = $imageFile.Name
    if ($imageName -notin $usedImageNames) {
        $imageFileFullPath = Join-Path $imageDirectory $imageName
        Remove-Item -Path $imageFileFullPath -Force
        Write-Host "Deleted unused image: $imageFileFullPath"
    }
}
