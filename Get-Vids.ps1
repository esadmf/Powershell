# Define the base directory to search from
$baseDir = "C:\Users\david\dwhelper\CCP"

# Function to recursively search for .mp4 files
function Get-Mp4Files {
  param (
    [string]$dir
  )
  # Create an empty array to store the file paths
  $filePaths = @()
  # Recursively iterate through each subfolder in $dir
  Get-ChildItem -Path $dir -Recurse -File | Where-Object {$_.Extension -eq ".mp4"} |
  ForEach-Object {
    # Add the full path and filename of each .mp4 file to the array
    [PSCustomObject]@{
      Path = $_.FullName
      Filename = $_.Name
    }
  } | ForEach-Object {
    $filePaths += $_
  }
  return $filePaths
}

# Convert the array to CSV and output it
Get-Mp4Files -dir $baseDir | Export-Csv -Path "$($basedir)\mp4_files.csv" -NoTypeInformation -Encoding Default