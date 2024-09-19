# Define the root path where the shows are stored
$rootPath = "C:\Users\david\dwhelper\ECON"

# Recursively get all mp4 files in the root path and its subdirectories
$files = Get-ChildItem -Path $rootPath -Recurse -Filter *.mp4

foreach ($file in $files) {
    # Extract the title from the filename
    $fileName = $file.Name
    $title = $fileName -replace '.*S\d{2}E\d{2}\.(.*)\.mp4', '$1' -replace '\.', ' '

    # Construct the ffmpeg command to update the title
    $ffmpegCommand = "ffmpeg -i `"$($file.FullName)`" -metadata title=`"$title`" -codec copy `"$($file.DirectoryName)\$($file.BaseName)_new.mp4`""

    # Run the ffmpeg command
    Invoke-Expression $ffmpegCommand

    # Replace the old file with the new one (optional)
    Remove-Item $file.FullName
    Rename-Item "$($file.DirectoryName)\$($file.BaseName)_new.mp4" -NewName $file.Name

    Write-Output "Updated Title for $fileName to '$title'"
}
